//
//  EquipSetLayouSkillLaunchedTableViewCell.m
//  MHO
//
//  Created by feiquanqiu on 16/3/9.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetLayoutSkillLaunchedTableViewCell.h"
@interface MFMHOEquipSetLayoutSkillLaunchedTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;

@end

@implementation MFMHOEquipSetLayoutSkillLaunchedTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setup:(NSArray<MFMHOSkillModel*>*)skills{
    for (UIView *removeView in self.bgView.subviews) {
        [removeView removeFromSuperview];
    }
    
    CGFloat x =0;
    
    CGFloat y =0;
    
    for (MFMHOSkillModel *skill in skills) {
        
        UILabel *skillName =[[UILabel alloc] init];
        
        [skillName setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        skillName.text =skill.Name;
        
        skillName.textColor =[UIColor colorWithRed:137.f/255.f green:107.f/255.f blue:67.f/255.f alpha:1];
        
        skillName.font =[UIFont systemFontOfSize:15];
        
        CGSize size =[skillName.text boundingRectWithSize:CGSizeMake(200, 100) options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:skillName.font} context:nil].size;
        
        if (x+size.width>kWinSize.width-89-8) {
            x =0;
            y +=size.height +8;
        }
        
        [self.bgView addSubview:skillName];

        
        [self.bgView addConstraint:[NSLayoutConstraint constraintWithItem:skillName attribute:(NSLayoutAttributeLeft) relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:x]];
        
        [self.bgView addConstraint:[NSLayoutConstraint constraintWithItem:skillName attribute:(NSLayoutAttributeTop) relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:(NSLayoutAttributeTop) multiplier:1 constant:y]];
        
        [self.bgView addConstraint:[NSLayoutConstraint constraintWithItem:skillName attribute:(NSLayoutAttributeWidth) relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:(NSLayoutAttributeWidth) multiplier:0 constant:size.width]];
        
        [self.bgView addConstraint:[NSLayoutConstraint constraintWithItem:skillName attribute:(NSLayoutAttributeHeight) relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:(NSLayoutAttributeHeight) multiplier:0 constant:size.height]];
        

        x +=size.width+16;
        self.bgViewHeight.constant =y+size.height ;

        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
