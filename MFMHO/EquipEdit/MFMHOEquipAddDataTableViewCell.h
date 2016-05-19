//
//  EquipAddDataMainCell.h
//  MFMHO
//
//  Created by 梁文辉 on 16/5/15.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFMHOEquipAddDataModel.h"
@interface MFMHOEquipAddDataTableViewCell : UITableViewCell
- (void)setup:(MFMHOEquipAddDataModel *)obj;
@property (weak, nonatomic) IBOutlet UITextField *tfContent;

@end
