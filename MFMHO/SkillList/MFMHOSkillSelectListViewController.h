//
//  SkillSelectListViewController.h
//  MHO
//
//  Created by feiquanqiu on 16/2/3.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^SkillSelectCallBackBlock)(SkillModel *model);

@interface MFMHOSkillSelectListViewController : UIViewController
@property (strong, nonatomic)void(^callBackBlock)(MFMHOSkillModel *) ;
+ (MFMHOSkillSelectListViewController*)instantiateViewController;
@end
