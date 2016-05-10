//
//  EquipSetLayoutBasicTableViewCell.m
//  MHO
//
//  Created by feiquanqiu on 16/3/7.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetLayoutBasicTableViewCell.h"

@interface MFMHOEquipSetLayoutBasicTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lbDeco;

@end

@implementation MFMHOEquipSetLayoutBasicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setup:(MFMHOEquipSetSearchResultModel *)result withIndex:(NSInteger)index{
   

    switch (index) {
        case 0:
            self.lbName.text =result.head.Name;
            self.lbDeco.text=[self useDecoInfo:result.head];

            
            break;
        case 1:
            self.lbName.text =result.body.Name;
            self.lbDeco.text=[self useDecoInfo:result.body];

            break;
        case 2:
            self.lbName.text =result.arm.Name;
            self.lbDeco.text=[self useDecoInfo:result.arm];

            break;
        case 3:
            self.lbName.text =result.wst.Name;
            self.lbDeco.text=[self useDecoInfo:result.wst];

            break;
        case 4:
            self.lbName.text =result.leg.Name;
            self.lbDeco.text=[self useDecoInfo:result.leg];

            break;
        default:
            break;
    }
   

    

}

- (NSString *)useDecoInfo:(MFMHOEquipModel *)equip{
    NSMutableString *useDeco =[NSMutableString string];
    for (MFMHODecoModel *deco in equip.useDecos) {
        [useDeco appendString:deco.Name];
        
    }
    NSInteger equipSlotVacant =0;
    
    
    __block  NSInteger useSlotNum= 0;
    [[equip useDecos] enumerateObjectsUsingBlock:^(MFMHODecoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        useSlotNum += [obj.SlotNum integerValue];
        
    }];
    
    equipSlotVacant =[equip.SlotNum integerValue]-useSlotNum;
    
    
    if (equip.useDecos.count>0&& equipSlotVacant>0) {
        [useDeco appendFormat:@"剩余  %ld",equipSlotVacant];
    }else if(equipSlotVacant>0){
        for (int i =0; i<equipSlotVacant; i++) {
            [useDeco appendString:@"◇"];
        }
    }
    
    return useDeco;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
