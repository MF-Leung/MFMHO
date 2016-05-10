//
//  EquipSetSearchResultTableViewCell.m
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetSearchResultTableViewCell.h"

@implementation MFMHOEquipSetSearchResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
 
    // Configure the view for the selected state
}
- (void)setup:(MFMHOEquipSetSearchResultModel *)result{
    self.lbArm.text =result.arm.Name;
    
    self.lbBody.text =result.body.Name;
    
    self.lbHead.text =result.head.Name;

    self.lbLeg.text =result.leg.Name;

    self.lbWst.text =result.wst.Name;

    __block  NSInteger useSlotNum = 0;
    NSArray *equipModelNameKeys =@[@"arm",@"body",@"head",@"leg",@"wst"];
    
    for (int i =0; i<equipModelNameKeys.count; i++) {
        
        [[[result valueForKey:equipModelNameKeys[i]] useDecos] enumerateObjectsUsingBlock:^(MFMHODecoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            useSlotNum += [obj.SlotNum integerValue];
            
        }];
        
    }
    
    
    self.lbVacantSlot.text =NUMBER_TO_STR([result.arm.SlotNum integerValue] + [result.body.SlotNum integerValue] + [result.head.SlotNum integerValue] + [result.leg.SlotNum integerValue] + [result.wst.SlotNum integerValue] - useSlotNum);
    
}
@end
