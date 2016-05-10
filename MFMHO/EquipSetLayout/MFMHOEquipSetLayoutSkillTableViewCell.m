//
//  EquipSetLayoutSkillTableViewCell.m
//  MHO
//
//  Created by feiquanqiu on 16/3/7.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetLayoutSkillTableViewCell.h"
#import "MFMHOEquipSetLayoutSkillDetailTableViewCell.h"
@interface MFMHOEquipSetLayoutSkillTableViewCell ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView*tableView;
@property (weak, nonatomic) NSArray<MFMHOEquipSetLayoutSkillDetailModel*> *datas;
@end

@implementation MFMHOEquipSetLayoutSkillTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier =@"SkillDetailCell";
    
    MFMHOEquipSetLayoutSkillDetailTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [cell setup:self.datas[indexPath.row]];
    
    return cell;
}

- (void)setupWithResult:(MFMHOEquipSetSearchResultModel*)result withSkillStone:(MFMHOSkillStoneModel*)skillStone{
    
    self.datas =[MFMHOEquipSetLayoutSkillDetailModel initWithEquipSetSearchResult:result withSkillStone:skillStone];
    
    [self.tableView reloadData];
}
- (CGFloat)height{
    return self.datas.count*30+32;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



