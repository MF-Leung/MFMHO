//
//  EquipSetSearchMainViewController.m
//  MHO
//
//  Created by feiquanqiu on 16/2/3.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetSearchMainViewController.h"
#import "MFMHOSkillSelectListViewController.h"
#import "MFMHOSkillStoneMainViewController.h"
#import "MFMHOEquipSetSearchResultViewController.h"
@class SkillSelectListViewController;
@interface MFMHOEquipSetSearchMainViewController ()

@property (strong, nonatomic) NSMutableArray <MFMHOSkillModel *> *datas;

@property (weak, nonatomic) IBOutlet UISwitch *skillStoneSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *passElementarySwitch;

@property (strong, nonatomic) MFMHOSkillStoneModel *skillStone;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStoneName;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStoneSkill1;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStoneSkill2;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStonePoint1;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStonePoint2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *occupatantSegments;
@end

@implementation MFMHOEquipSetSearchMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas =[NSMutableArray array];
    
    self.skillStone =[[MFMHOSkillStoneModel alloc] init];
    
    [self updateSkillStoneTableCell];
    // Uncomment the following line to preserve selection between presentations.
   //  self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateSkillStoneTableCell{
    self.lbSkillStoneName.text =self.skillStone.name;
    
    self.lbSkillStoneSkill1.text =self.skillStone.skill1.Name;
    
    self.lbSkillStoneSkill2.text =self.skillStone.skill2.Name;
    
    self.lbSkillStonePoint1.text =[NSString stringWithFormat:@"+%ld",(long)self.skillStone.skillPoint1];
    
    self.lbSkillStonePoint2.text =[NSString stringWithFormat:@"+%ld",(long)(long)self.skillStone.skillPoint2];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        
        if (self.skillStoneSwitch.on) {
            return [super tableView:tableView numberOfRowsInSection:section];
        }else
            return 1;
        
    }else
    return [super tableView:tableView numberOfRowsInSection:section];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0 && indexPath.row !=0) {
        
        [self setupCellDataWithCell:cell withIndexPath:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row !=0){
        
    MFMHOSkillSelectListViewController *skillSelectListViewController = [MFMHOSkillSelectListViewController instantiateViewController];
    
    [skillSelectListViewController setCallBackBlock:^(MFMHOSkillModel *model) {
        UITableViewCell *cell ;

        if (indexPath.row-1 == self.datas.count) {
            [self.datas addObject:model];
            cell =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count inSection:0]];
            [self setupCellDataWithCell:cell withIndexPath:[NSIndexPath indexPathForRow:self.datas.count inSection:0]];

        }else if (indexPath.row>self.datas.count) {
            [self.datas addObject:model];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:self.datas.count+1 inSection:0]];
            cell =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count inSection:0]];
            [self setupCellDataWithCell:cell withIndexPath:[NSIndexPath indexPathForRow:self.datas.count inSection:0]];

        }else{
            self.datas[indexPath.row-1] = model;
            cell =[tableView cellForRowAtIndexPath:indexPath];
            [self setupCellDataWithCell:cell withIndexPath:indexPath];

        }
        
//        [self setupCellDataWithCell:cell withIndexPath:[NSIndexPath indexPathForRow:self.datas.count inSection:0]];
    }];
    
    [self.navigationController pushViewController:skillSelectListViewController animated:YES];
        
    }else if (indexPath.section ==1 && indexPath.row == 1){
        
        MFMHOSkillStoneMainViewController * skillStoneMainViewController = [MFMHOSkillStoneMainViewController instantiateViewControllerWithSkillStone:self.skillStone withDoneCallback:^(MFMHOSkillStoneModel *skillStone) {
            self.skillStone =skillStone;
            
            [self updateSkillStoneTableCell];

        }];
        
        [self.navigationController pushViewController:skillStoneMainViewController animated:YES];

        
    }else if (indexPath.section == 3 && indexPath.row == 0){
        MFMHOEquipSetSearchQuery *query =[[MFMHOEquipSetSearchQuery alloc] init];
        query.skills =[NSArray arrayWithArray:self.datas];
        query.skillStone =self.skillStone;
        query.isPassElementary = self.passElementarySwitch.on;
        query.occupatant =self.occupatantSegments.selectedSegmentIndex;
        MFMHOEquipSetSearchResultViewController * searchResultViewController =[MFMHOEquipSetSearchResultViewController instantiateViewControllerWithEquipSetSearchQuery:query];
        [self.navigationController pushViewController:searchResultViewController animated:YES];

    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return  indexPath.row > 0 && (indexPath.row<=self.datas.count);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView setEditing:NO animated:YES];
        if (indexPath.row==5) {
            [tableView setEditing:NO animated:YES];
            
            [self.datas removeLastObject];

            UITableViewCell *cell =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
            
            [self setupCellDataWithCell:cell withIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];

        }else{
            [tableView setEditing:NO animated:YES];

            UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];

            cell.textLabel.textColor =[UIColor lightGrayColor];
            
            cell.textLabel.text =@"选择技能";
            
            cell.detailTextLabel.text =@"";
            
            [self performSelector:@selector(moveRowAtIndexPathOfUpdate:) withObject:indexPath afterDelay:.5];
        }
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)moveRowAtIndexPathOfUpdate:(NSIndexPath *)indexPath{
    
    [self.datas removeLastObject];
    
    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];

    UITableViewCell *cell =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];

    [self setupCellDataWithCell:cell withIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];

}

- (void)setupCellDataWithCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);

    if (indexPath.row>self.datas.count) {
        
        cell.textLabel.textColor =[UIColor lightGrayColor];
        
        cell.textLabel.text =@"选择技能";
        
        cell.detailTextLabel.text =@"";
        
    }else{
        cell.textLabel.textColor =[UIColor blackColor];
        
        cell.textLabel.text =self.datas[indexPath.row-1].Name;
        
        FMDatabase *db =[MFMHODatabase instance].db;
        
        FMResultSet * set =[db executeQueryWithFormat:@"SELECT * FROM SkillRank WHERE ID=%@",self.datas[indexPath.row-1].SkillRankID];
        
        if ([set next]) {
            
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%@:%@",set.resultDictionary[@"Name"],self.datas[indexPath.row-1].SkillRankPoint];
            
        }
        
        
    }
}
- (IBAction)skillStoneSwitch:(UISwitch *)sender {
    if (!sender.on) {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:(UITableViewRowAnimationTop)];
    }else{
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationBottom];
 
    }
}
/*
// Override to support conditional editing of the table view.

*/

/*
// Override to support editing the table view.

*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
