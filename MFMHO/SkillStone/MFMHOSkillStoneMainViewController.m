//
//  SkillStoneMainViewController.m
//  MHO
//
//  Created by feiquanqiu on 16/2/16.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOSkillStoneMainViewController.h"
#import "MFMHOSkillStonePickerView.h"
@interface MFMHOSkillStoneMainViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) NSMutableArray<MFMHOSkillRankModel*> *datas;

@property (strong, nonatomic) MFMHOSkillStoneModel *skillStone;

@property (strong, nonatomic) MFMHOSkillStonePickerView *skillStonePickerView;

@property (weak, nonatomic) IBOutlet UILabel *lbSkillStoneTypeName;

@property (weak, nonatomic) IBOutlet UILabel *lbSkillName1;

@property (weak, nonatomic) IBOutlet UILabel *lbSkillName2;

@property (weak, nonatomic) IBOutlet UILabel *lbSkillPoint1;

@property (weak, nonatomic) IBOutlet UILabel *lbSkillPoint2;

@property (strong, nonatomic)void(^callback)(MFMHOSkillStoneModel * skillStone);
@end

@implementation MFMHOSkillStoneMainViewController

+ (MFMHOSkillStoneMainViewController*)instantiateViewControllerWithSkillStone:(MFMHOSkillStoneModel *)skillStone withDoneCallback:(void (^)(MFMHOSkillStoneModel *))callback{
    MFMHOSkillStoneMainViewController * vc=  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SkillStoneMainViewController"];
    vc.skillStone =skillStone;
    vc.callback =callback;
    return vc;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self update];
    // Do any additional setup after loading the view.
}

- (void)setup{
    
    self.skillStonePickerView =[[MFMHOSkillStonePickerView alloc] init];
    
    self.skillStonePickerView.pickerView.delegate =self;
    
    self.skillStonePickerView.pickerView.dataSource =self;
    
    FMDatabase *db =[MFMHODatabase instance].db;
    
    self.datas =[NSMutableArray array];
    
    [db executeStatements:@"SELECT * FROM SkillRank" withResultBlock:^int(NSDictionary *resultsDictionary) {
        
        MFMHOSkillRankModel * skillRankModel =[MFMHOSkillRankModel objectWithKeyValues:resultsDictionary];
        
        [self.datas addObject:skillRankModel];
        
        return 0;
    }];
    
    
}

- (void)update{
    
    self.lbSkillStoneTypeName.text =self.skillStone.name;
    
    self.lbSkillName1.text =self.skillStone.skill1.Name;
    
    self.lbSkillName2.text =self.skillStone.skill2.Name;
    
    switch (self.skillStone.type) {
        case 0:
            if (self.skillStone.skillPoint1 > [self.skillStone.skill1.SkillStoneMaxNum5 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum5 integerValue];
            }else if (self.skillStone.skillPoint2 > [self.skillStone.skill2.SkillStoneMaxNum5 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum5 integerValue];
            }
            break;
        case 1:
            if (self.skillStone.skillPoint1 > [self.skillStone.skill1.SkillStoneMaxNum4 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum4 integerValue];
            }else if (self.skillStone.skillPoint2 > [self.skillStone.skill2.SkillStoneMaxNum4 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum4 integerValue];
            }
            
            break;
        case 2:
            if (self.skillStone.skillPoint1 > [self.skillStone.skill1.SkillStoneMaxNum3 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum3 integerValue];
            }else if (self.skillStone.skillPoint2 > [self.skillStone.skill2.SkillStoneMaxNum3 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum3 integerValue];
            }
            
            break;
        case 3:
            if (self.skillStone.skillPoint1 > [self.skillStone.skill1.SkillStoneMaxNum2 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum2 integerValue];
            }else if (self.skillStone.skillPoint2 > [self.skillStone.skill2.SkillStoneMaxNum2 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum2 integerValue];
            }
            
            break;
        case 4:
            if (self.skillStone.skillPoint1 > [self.skillStone.skill1.SkillStoneMaxNum1 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum1 integerValue];
            }else if (self.skillStone.skillPoint2 > [self.skillStone.skill2.SkillStoneMaxNum1 integerValue]) {
                self.skillStone.skillPoint1 = [self.skillStone.skill1.SkillStoneMaxNum1 integerValue];
            }
            
            break;
            
        default:
            
            break;
    }
    
    self.lbSkillPoint1.text =[NSString stringWithFormat:@"+%ld",(long)self.skillStone.skillPoint1];
    
    self.lbSkillPoint2.text =[NSString stringWithFormat:@"+%ld",(long)self.skillStone.skillPoint2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (self.tableView.indexPathForSelectedRow.section == 0) {
        return 1;
    }else
        return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (self.tableView.indexPathForSelectedRow.section == 0) {
        return 5;
    }else{
        if (component == 0) {
            return self.datas.count;
        }else{
            NSInteger  selectedRow1 =[pickerView selectedRowInComponent:0];
            if (selectedRow1<0) {
                selectedRow1 =0;
            }
            
            MFMHOSkillRankModel *skillRank =self.datas[selectedRow1];
            
            switch (self.skillStone.type) {
                case 0:
                    return [skillRank.SkillStoneMaxNum5 integerValue]+1;
                    break;
                case 1:
                    return [skillRank.SkillStoneMaxNum4 integerValue]+1;
                    
                    break;
                case 2:
                    return [skillRank.SkillStoneMaxNum3 integerValue]+1;
                    
                    break;
                case 3:
                    return [skillRank.SkillStoneMaxNum2 integerValue]+1;
                    
                    break;
                case 4:
                    return [skillRank.SkillStoneMaxNum1 integerValue]+1;
                    
                    break;
                    
                default:
                    return 0;
                    
                    break;
            }
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.tableView.indexPathForSelectedRow.section == 0) {
        return [MFMHOSkillStoneModel skillStoneNameWithType:row];
    }else{
        if (component == 0) {
            return self.datas[row].Name;
        }else{
            {
                NSInteger  selectedRow1 =[pickerView selectedRowInComponent:0];
                if (selectedRow1<0) {
                    selectedRow1 =0;
                }
                
                MFMHOSkillRankModel *skillRank =self.datas[selectedRow1];
                
                
                switch (self.skillStone.type) {
                    case 0:
                        
                        return [NSString stringWithFormat:@"+%ld",(long)[skillRank.SkillStoneMaxNum5 integerValue]-row];
                        break;
                    case 1:
                        return [NSString stringWithFormat:@"+%ld",(long)[skillRank.SkillStoneMaxNum4 integerValue]-row];
                        
                        break;
                    case 2:
                        return [NSString stringWithFormat:@"+%ld",(long)[skillRank.SkillStoneMaxNum3 integerValue]-row];
                        
                        break;
                    case 3:
                        return [NSString stringWithFormat:@"+%ld",(long)[skillRank.SkillStoneMaxNum2 integerValue]-row];
                        
                        break;
                    case 4:
                        return [NSString stringWithFormat:@"+%ld",(long)[skillRank.SkillStoneMaxNum1 integerValue]-row];
                        
                        break;
                        
                    default:
                        return @"";
                        
                        break;
                }
            }
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.tableView.indexPathForSelectedRow.section == 0) {

    }else
        [self.skillStonePickerView.pickerView reloadComponent:1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.skillStonePickerView.pickerView reloadAllComponents];
    
    __block MFMHOSkillStoneMainViewController *__self =self;
    
    if (indexPath.section == 0) {
        
        [self.skillStonePickerView.pickerView selectRow:self.skillStone.type inComponent:0 animated:NO];
        
        [self.skillStonePickerView show:^(MFMHOSkillStonePickerView *skillStonePickerView,BOOL isDone) {
            if (isDone) {
                
                NSInteger  selectedRow =[skillStonePickerView.pickerView selectedRowInComponent:0];
                if (selectedRow<0) {
                    selectedRow =0;
                }
                __self.skillStone.type =selectedRow;
                
                [__self update];
                
                [__self.tableView deselectRowAtIndexPath:indexPath animated:YES];
                
            }
        }];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        [self.skillStonePickerView.pickerView selectRow:[self.datas indexOfObject:[self.datas filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"ID = %@",self.skillStone.skill1.ID]].firstObject] inComponent:0 animated:NO];
        [self.skillStonePickerView.pickerView reloadAllComponents];

        [self.skillStonePickerView.pickerView selectRow:[self.skillStonePickerView.pickerView numberOfRowsInComponent:1]-self.skillStone.skillPoint1-1 inComponent:1 animated:NO];
        
        [self.skillStonePickerView show:^(MFMHOSkillStonePickerView *skillStonePickerView,BOOL isDone) {
            NSInteger  selectedRow =[skillStonePickerView.pickerView selectedRowInComponent:0];
            if (isDone) {
                
                if (selectedRow<0) {
                    selectedRow =0;
                }
                __self.skillStone.skill1 =__self.datas[selectedRow];
                
                selectedRow =[skillStonePickerView.pickerView selectedRowInComponent:1];
                
                if (selectedRow<0) {
                    selectedRow =0;
                }
                
                __self.skillStone.skillPoint1 =[[[self pickerView:skillStonePickerView.pickerView titleForRow:selectedRow forComponent:1] stringByReplacingOccurrencesOfString:@"+" withString:@""] integerValue];
                
                [__self update];
            }
            [__self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            
        }];
        
    }else if (indexPath.section == 1 && indexPath.row == 1){
        
        [self.skillStonePickerView.pickerView selectRow:[self.datas indexOfObject:[self.datas filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"ID = %@",self.skillStone.skill2.ID]].firstObject] inComponent:0 animated:NO];
        [self.skillStonePickerView.pickerView reloadAllComponents];

        [self.skillStonePickerView.pickerView selectRow:[self.skillStonePickerView.pickerView numberOfRowsInComponent:1]-self.skillStone.skillPoint2-1 inComponent:1 animated:NO];
        
        [self.skillStonePickerView show:^(MFMHOSkillStonePickerView *skillStonePickerView,BOOL isDone) {
            if (isDone) {
                
                NSInteger  selectedRow =[skillStonePickerView.pickerView selectedRowInComponent:0];
                
                if (selectedRow<0) {
                    selectedRow =0;
                }
                __self.skillStone.skill2 =__self.datas[selectedRow];
                
                selectedRow =[skillStonePickerView.pickerView selectedRowInComponent:1];
                
                if (selectedRow<0) {
                    selectedRow =0;
                }
                
                __self.skillStone.skillPoint2 =[[[self pickerView:skillStonePickerView.pickerView titleForRow:selectedRow forComponent:1] stringByReplacingOccurrencesOfString:@"+" withString:@""] integerValue];
                
                [__self update];
            }
            [__self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            
        }];
        
    }
    
}

- (IBAction)done:(UIButton *)sender {
    if (self.callback) {
        self.callback(self.skillStone);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
