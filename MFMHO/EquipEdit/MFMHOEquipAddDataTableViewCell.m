//
//  EquipAddDataMainCell.m
//  MFMHO
//
//  Created by 梁文辉 on 16/5/15.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipAddDataTableViewCell.h"

@interface MFMHOEquipAddDataTableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (nonatomic)BOOL s;
@end

@implementation MFMHOEquipAddDataTableViewCell
- (void)awakeFromNib {
    // Initialization code

}
- (void)setup:(MFMHOEquipAddDataModel *)obj{
    self.lbTitle.text =obj.title;
    
    self.tfContent.text =obj.text;
    
    self.tfContent.placeholder =obj.placeholder;
    
    if ([obj.type isKindOfClass:[NSArray class]]) {
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        self.tfContent.userInteractionEnabled =NO;
        
    }else if([obj.type isKindOfClass:[NSString class]]){
        self.accessoryType =UITableViewCellAccessoryNone;
        self.tfContent.userInteractionEnabled =YES;
        
        self.tfContent.keyboardType =obj.keyboardType;
    

    }
    
    
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];


}



@end
