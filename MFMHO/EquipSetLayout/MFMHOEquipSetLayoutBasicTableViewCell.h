//
//  EquipSetLayoutBasicTableViewCell.h
//  MHO
//
//  Created by feiquanqiu on 16/3/7.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFMHOEquipSetSearchResultModel.h"
@interface MFMHOEquipSetLayoutBasicTableViewCell : UITableViewCell
- (void)setup:(MFMHOEquipSetSearchResultModel *)result withIndex:(NSInteger)index;
@end
