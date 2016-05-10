//
//  EquipSetLayoutSkillDetailTableViewCell.m
//  MHO
//
//  Created by feiquanqiu on 16/3/8.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetLayoutSkillDetailTableViewCell.h"

@interface MFMHOEquipSetLayoutSkillDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbSkill;
@property (weak, nonatomic) IBOutlet UILabel *lbBodyPoint;
@property (weak, nonatomic) IBOutlet UILabel *lbArmPoint;
@property (weak, nonatomic) IBOutlet UILabel *lbHeadPoint;
@property (weak, nonatomic) IBOutlet UILabel *lbLegPoint;
@property (weak, nonatomic) IBOutlet UILabel *lbWstPoint;
@property (weak, nonatomic) IBOutlet UILabel *lbSkillStonePoint;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPoint;

@end

@implementation MFMHOEquipSetLayoutSkillDetailTableViewCell

- (void)setup:(MFMHOEquipSetLayoutSkillDetailModel*)skillDetail{
    self.lbSkill.text =skillDetail.skillRank.Name;
    
    self.lbBodyPoint.text =[self symbol:skillDetail.bodyPoint];
    
    self.lbHeadPoint.text =[self symbol:skillDetail.headPoint];
    
    self.lbLegPoint.text =[self symbol:skillDetail.legPoint];
    
    self.lbArmPoint.text =[self symbol:skillDetail.armPoint];
    
    self.lbWstPoint.text =[self symbol:skillDetail.wstPoint];
    
    self.lbTotalPoint.text =NUMBER_TO_STR(skillDetail.totalPoint);
    
    self.lbSkillStonePoint.text =[self symbol:skillDetail.skillStonePoint];
    
}


- (NSString*)symbol:(NSInteger)point{
    NSString *symbol =@"";
    
    if (point>=0) {
        symbol =@"+";
    }
    
    return [NSString stringWithFormat:@"%@%ld",symbol,point];
}
@end
