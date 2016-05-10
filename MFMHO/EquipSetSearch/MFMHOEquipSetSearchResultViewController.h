//
//  EquipSetSearchResultViewController.h
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFMHOEquipSetSearchQuery.h"
@interface MFMHOEquipSetSearchResultViewController : UIViewController
+ (MFMHOEquipSetSearchResultViewController *)instantiateViewControllerWithEquipSetSearchQuery:(MFMHOEquipSetSearchQuery *)query;
@end
