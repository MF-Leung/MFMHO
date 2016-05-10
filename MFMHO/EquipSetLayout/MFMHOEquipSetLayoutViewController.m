//
//  EquipSetLayoutViewController.m
//  MHO
//
//  Created by feiquanqiu on 16/3/7.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetLayoutViewController.h"
#import "MFMHOEquipSetLayoutBasicTableViewCell.h"
#import "MFMHOEquipSetLayoutSkillTableViewCell.h"
#import "MFMHOEquipSetLayoutSkillDetailTableViewCell.h"
#import "MFMHOEquipSetLayoutSkillLaunchedTableViewCell.h"
#import "MFMHOEquipSetSearchSelectedSkillStoneTableViewCell.h"
#define KVOCONTEXTKEY nil

@interface MFMHOEquipSetLayoutViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)MFMHOEquipSetSearchResultModel *result;
@property (strong,nonatomic)MFMHOSkillStoneModel *skillStone;
@property (strong,nonatomic)NSArray<MFMHOEquipSetLayoutSkillDetailModel*> *skillDetails;
@property (strong,nonatomic)NSArray<MFMHOSkillModel*> *skillLauncheds;
@end

@implementation MFMHOEquipSetLayoutViewController

+ (MFMHOEquipSetLayoutViewController*)instantiateViewControllerWithEquipSetSearchResult:(MFMHOEquipSetSearchResultModel*)result withSkillStone:(MFMHOSkillStoneModel*)skillStone{
    MFMHOEquipSetLayoutViewController *vc =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EquipSetLayoutViewController"];
    
    
    
    vc.skillStone =skillStone;

    vc.result =result;
    
    return vc;
    
}

- (void)setup:(MFMHOEquipSetLayoutViewController *)vc{
    vc.tableView.delegate =vc;
    
    vc.tableView.dataSource =vc;

    
    [vc addObserver:vc forKeyPath:@"result" options:(NSKeyValueObservingOptionNew) context:nil];
    
    [vc addObserver:vc.result forKeyPath:@"head" options:(NSKeyValueObservingOptionNew) context:KVOCONTEXTKEY];
    
    [vc addObserver:vc.result forKeyPath:@"body" options:(NSKeyValueObservingOptionNew) context:KVOCONTEXTKEY];
    
    [vc addObserver:vc.result forKeyPath:@"arm" options:(NSKeyValueObservingOptionNew) context:KVOCONTEXTKEY];
    
    [vc addObserver:vc.result forKeyPath:@"wst" options:(NSKeyValueObservingOptionNew) context:KVOCONTEXTKEY];
    
    [vc addObserver:vc.result forKeyPath:@"leg" options:(NSKeyValueObservingOptionNew) context:KVOCONTEXTKEY];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([object isEqual:self]) {
        
    
    self.skillDetails =[MFMHOEquipSetLayoutSkillDetailModel initWithEquipSetSearchResult:self.result withSkillStone:self.skillStone];
    self.skillLauncheds =[self skillForLaunch];
    [self.tableView reloadData];
        
    }else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"配装";
    
    [self setup:self];
    
    
    
    [self observeValueForKeyPath:nil ofObject:self change:nil context:nil];
    // Do any additional setup after loading the view.
}


- (NSArray*)skillForLaunch{
    FMDatabase *db =[MFMHODatabase instance].db;
    NSMutableArray *skills =[NSMutableArray array];
    for (MFMHOEquipSetLayoutSkillDetailModel *obj in self.skillDetails) {
        __block MFMHOSkillModel *skill =nil;
        //
        [db executeStatements:[NSString stringWithFormat:@"SELECT * FROM Skill where SkillRankID = %@ order by SkillRankPoint asc",obj.skillRank.ID] withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            if (obj.totalPoint>=0) {
                if (obj.totalPoint >= [resultsDictionary[@"SkillRankPoint"] integerValue]&&[resultsDictionary[@"SkillRankPoint"] integerValue]>=0 ) {
                    skill =[MFMHOSkillModel objectWithKeyValues:resultsDictionary];
                    
                }
            }else{
                if (obj.totalPoint < [resultsDictionary[@"SkillRankPoint"] integerValue]&&[resultsDictionary[@"SkillRankPoint"] integerValue]<0 ) {
                    skill =[MFMHOSkillModel objectWithKeyValues:resultsDictionary];
                    
                }
            }
           
            return 0;
        }];
        if (skill !=nil) {
            [skills addObject:skill];
        }
    }
    return skills;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 1;
            break;
        
        case 2:
            return 2+self.skillDetails.count;
            break;
        default:
            return 0;
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 44.f;
            break;
        case 1:
            return 44.f;
            break;
       
        case 2:
            if (indexPath.row==0) {
                [self tableView:tableView cellForRowAtIndexPath:indexPath];
                return UITableViewAutomaticDimension;
            }else
            return 32.f;
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *basicCellIdentifier =@"BasicCell";
    
    static NSString *skillStoneCellIdentifier =@"SkillStoneCell";

    static NSString *skillHeadCellIdentifier =@"SkillHeadCell";

    static NSString *skillDetailCellIdentifier =@"SkillDetailCell";

    static NSString *skillLaunchedCellIdentifier =@"SkillLaunchedCell";

    UITableViewCell *cell ;
    
    if (indexPath.section==0){
        
        cell =[tableView dequeueReusableCellWithIdentifier:basicCellIdentifier];
        [(MFMHOEquipSetLayoutBasicTableViewCell*)cell setup:self.result withIndex:indexPath.row];
        
    }else if (indexPath.section == 1){
        cell =[tableView dequeueReusableCellWithIdentifier:skillStoneCellIdentifier];
        [(MFMHOEquipSetSearchSelectedSkillStoneTableViewCell*)cell setup:self.skillStone];
    }
    else if (indexPath.section == 2){
        if (indexPath.row==0) {
            cell =[tableView dequeueReusableCellWithIdentifier:skillLaunchedCellIdentifier];
            [(MFMHOEquipSetLayoutSkillLaunchedTableViewCell*)cell setup:self.skillLauncheds];
        }else if (indexPath.row==1) {
            cell =[tableView dequeueReusableCellWithIdentifier:skillHeadCellIdentifier];

        }else{
            cell =[tableView dequeueReusableCellWithIdentifier:skillDetailCellIdentifier];
            [(MFMHOEquipSetLayoutSkillDetailTableViewCell*)cell setup:self.skillDetails[indexPath.row-2]];
        }
    
    }
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc{
    [self removeObserver:self forKeyPath:@"result" context:KVOCONTEXTKEY];
    
    [self removeObserver:self.result forKeyPath:@"head" context:KVOCONTEXTKEY];
    
    [self removeObserver:self.result forKeyPath:@"body" context:KVOCONTEXTKEY];
    
    [self removeObserver:self.result forKeyPath:@"arm" context:KVOCONTEXTKEY];
    
    [self removeObserver:self.result forKeyPath:@"wst" context:KVOCONTEXTKEY];
    
    [self removeObserver:self.result forKeyPath:@"leg" context:KVOCONTEXTKEY];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
