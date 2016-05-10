//
//  EquipSetSearchResultViewController.m
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetSearchResultViewController.h"
#import "MFMHOEquipSetSearchResultTableViewCell.h"
#import "MFMHOEquipSetSearchResultModel.h"
#import "MFMHOEquipSetLayoutViewController.h"

@interface MFMHOEquipSetSearchResultViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<MFMHOEquipSetSearchResultModel *> *datas;
@property (strong, nonatomic) MFMHOEquipSetSearchQuery *query;
@property (weak, nonatomic) IBOutlet UIProgressView *searchProgress;
@end

@implementation MFMHOEquipSetSearchResultViewController

+ (MFMHOEquipSetSearchResultViewController *)instantiateViewControllerWithEquipSetSearchQuery:(MFMHOEquipSetSearchQuery *)query{
   MFMHOEquipSetSearchResultViewController * vc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MFMHOEquipSetSearchResultViewController"];
    vc.query =query;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"搜索结果";

    self.searchProgress.progress =0;

    self.datas =[NSMutableArray array];
    
    self.tableView.delegate =self;
    
    self.tableView.dataSource =self;
    
    self.tableView.tableFooterView =[UIView new];
    
    [SVProgressHUD showWithMaskType:(SVProgressHUDMaskTypeClear)];
    
    [self performSelector:@selector(startQuery) withObject:nil afterDelay:1];
   
   
    // Do any additional setup after loading the view.
}

- (void)startQuery{
    
//    
    NSArray *result=[self.query searchNextPage];
    
    
    [SVProgressHUD dismiss];
    
    self.datas =[NSMutableArray arrayWithArray:result];
    
    [self.tableView reloadData];
    
//    self.searchProgress.progress =0;
//    
//    self.searchProgress.hidden =NO;
////
//    [self.query searchWithHandle:^(EquipSetSearchResultModel *model) {
//        [self.datas addObject:model];
//        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datas.count-1 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
//    } nextBlock:^(NSInteger resultIndex, NSInteger resultCount) {
//        [self.searchProgress setProgress:(float)resultIndex/(float)resultCount animated:YES];
//        if (resultIndex==resultCount) {
//            
//            [self performSelector:@selector(searchEnd) withObject:nil afterDelay:1];
//        }
//    }];
}

- (void)searchEnd{
    self.searchProgress.hidden =YES;
  //  self.title =@"搜索完成";

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MFMHOEquipSetSearchResultTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setup:self.datas[indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FMDatabase *db =[MFMHODatabase instance].db;
    
    NSArray *equipModelNameKeys =@[@"arm",@"body",@"head",@"leg",@"wst"];
    NSArray *equipTableNameKeys =@[@"Equip_Arm",@"Equip_Body",@"Equip_Head",@"Equip_Leg",@"Equip_Wst"];
    
  MFMHOEquipSetSearchResultModel *result =self.datas[indexPath.row];
    
    for (int i= 0;i<5;i++) {
        NSString *key = equipModelNameKeys[i];
        [db executeStatements:[NSString stringWithFormat:@"SELECT * FROM %@ where ID = %@",equipTableNameKeys[i],[[result valueForKey:key] ID]] withResultBlock:^int(NSDictionary *resultsDictionary) {
            MFMHOEquipModel *equip =[result valueForKey:key];
            [equip setKeyValues:resultsDictionary];
            return 1;
        }];
    }

    
    MFMHOEquipSetLayoutViewController *vc =[MFMHOEquipSetLayoutViewController instantiateViewControllerWithEquipSetSearchResult:result withSkillStone:self.query.skillStone];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.query stop];
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
