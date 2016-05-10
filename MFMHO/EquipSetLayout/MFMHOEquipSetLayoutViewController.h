//
//  EquipSetLayoutViewController.h
//  MHO
//
//  Created by feiquanqiu on 16/3/7.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFMHOEquipSetSearchResultModel.h"
#import "MFMHOSkillStoneModel.h"
@interface MFMHOEquipSetLayoutViewController : UIViewController
+ (MFMHOEquipSetLayoutViewController*)instantiateViewControllerWithEquipSetSearchResult:(MFMHOEquipSetSearchResultModel*)result withSkillStone:(MFMHOSkillStoneModel*)skillStone;
@end
