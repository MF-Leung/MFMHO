//
//  SkillStoneListViewController.h
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFMHOSkillStoneModel.h"
@interface MFMHOSkillStoneListViewController : UIViewController
+ (MFMHOSkillStoneListViewController*)instantiateViewControllerWithSelectedSkillStone:(MFMHOSkillStoneModel*)model;
@end
