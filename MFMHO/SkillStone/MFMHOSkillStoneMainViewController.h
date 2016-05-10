//
//  SkillStoneMainViewController.h
//  MHO
//
//  Created by feiquanqiu on 16/2/16.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFMHOSkillStoneModel.h"

@interface MFMHOSkillStoneMainViewController : UITableViewController
+ (MFMHOSkillStoneMainViewController*)instantiateViewControllerWithSkillStone:(MFMHOSkillStoneModel *)skillStone withDoneCallback:(void(^)(MFMHOSkillStoneModel * skillStone))callback;
@end
