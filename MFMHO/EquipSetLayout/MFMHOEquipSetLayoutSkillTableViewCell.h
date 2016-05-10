//
//  EquipSetLayoutSkillTableViewCell.h
//  MHO
//
//  Created by feiquanqiu on 16/3/7.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFMHOEquipSetSearchResultModel.h"
#import "MFMHOEquipSetLayoutSkillDetailModel.h"

@interface MFMHOEquipSetLayoutSkillTableViewCell : UITableViewCell

- (CGFloat)height;

- (void)setupWithResult:(MFMHOEquipSetSearchResultModel*)result withSkillStone:(MFMHOSkillStoneModel*)skillStone;
@end


