//
//  SkillStonePickerView.h
//  MHO
//
//  Created by feiquanqiu on 16/2/15.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MFMHOSkillStonePickerView;
typedef void(^SkillStonePickerViewDoneSelected)(MFMHOSkillStonePickerView* ,BOOL isDone);

@interface MFMHOSkillStonePickerView : UIView

@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic)SkillStonePickerViewDoneSelected doneSelectedCallback;

- (void)show:(SkillStonePickerViewDoneSelected)doneSelectedCallback;

@end
