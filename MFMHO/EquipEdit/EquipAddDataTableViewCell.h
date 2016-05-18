//
//  EquipAddDataMainCell.h
//  MFMHO
//
//  Created by 梁文辉 on 16/5/15.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipAddDataModel.h"
@interface EquipAddDataTableViewCell : UITableViewCell
- (void)setup:(EquipAddDataModel *)obj;
@property (weak, nonatomic) IBOutlet UITextField *tfContent;

@end
