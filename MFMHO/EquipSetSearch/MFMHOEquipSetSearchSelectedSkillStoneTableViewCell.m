//
//  EquipSetSearchSelectedSkillStoneTableViewCell.m
//  MHO
//
//  Created by feiquanqiu on 16/2/17.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetSearchSelectedSkillStoneTableViewCell.h"

@interface MFMHOEquipSetSearchSelectedSkillStoneTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStoneName;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStoneSkill1;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStoneSkill2;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStonePoint1;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStonePoint2;
@end

@implementation MFMHOEquipSetSearchSelectedSkillStoneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setup:(MFMHOSkillStoneModel *)skillStone{
    self.lbSkillStoneName.text =skillStone.name;
    
    self.lbSkillStoneSkill1.text =skillStone.skill1.Name;
    
    self.lbSkillStoneSkill2.text =skillStone.skill2.Name;
    
    self.lbSkillStonePoint1.text =[NSString stringWithFormat:@"+%ld",(long)skillStone.skillPoint1];
    
    self.lbSkillStonePoint2.text =[NSString stringWithFormat:@"+%ld",(long)(long)skillStone.skillPoint2];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
