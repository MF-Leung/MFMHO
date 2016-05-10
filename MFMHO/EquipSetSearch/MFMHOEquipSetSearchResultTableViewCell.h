//
//  EquipSetSearchResultTableViewCell.h
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
# import "MFMHOEquipSetSearchResultModel.h"
@interface MFMHOEquipSetSearchResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbHead;

@property (weak, nonatomic) IBOutlet UILabel *lbBody;

@property (weak, nonatomic) IBOutlet UILabel *lbArm;

@property (weak, nonatomic) IBOutlet UILabel *lbWst;

@property (weak, nonatomic) IBOutlet UILabel *lbLeg;

@property (weak, nonatomic) IBOutlet UILabel *lbVacantSlot;
- (void)setup:(MFMHOEquipSetSearchResultModel*)result;
@end
