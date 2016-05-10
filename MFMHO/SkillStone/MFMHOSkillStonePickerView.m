//
//  SkillStonePickerView.m
//  MHO
//
//  Created by feiquanqiu on 16/2/15.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOSkillStonePickerView.h"

#define PICKERVIEW_HEIGHT 200.f
#define TOOLVIEW_HEIGHT 50.f
@interface MFMHOSkillStonePickerView ()

@property (strong, nonatomic) UIView *backgroundView;

@property (strong ,nonatomic) NSLayoutConstraint *lcTop;
@end

@implementation MFMHOSkillStonePickerView

- (void)drawRect:(CGRect)rect {
    [self layoutIfNeeded];
}
- (void)show:(SkillStonePickerViewDoneSelected)doneSelectedCallback{
   // SkillStonePickerView *view =[[SkillStonePickerView alloc] init];
    self.doneSelectedCallback =doneSelectedCallback;
    
    UIWindow *keyWindow =[[UIApplication sharedApplication] keyWindow];
    
//   __block CGRect viewRect =self.frame;
//    
//    viewRect.origin.y =-kWinSize.height;
//    
//    self.frame =viewRect;
    
 //   self.lcTop.constant =0;
    
    if ([self superview]) {
        [self removeFromSuperview];
    }
    
    [keyWindow addSubview:self];

    self.alpha =0;
    
    self.lcTop.constant =- PICKERVIEW_HEIGHT - TOOLVIEW_HEIGHT;
    
    [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        
//        viewRect.origin.y =kWinSize.height - PICKERVIEW_HEIGHT;
//        
//        self.frame =viewRect;
        [self layoutIfNeeded];
        

    } completion:^(BOOL finished) {
        
    }];

    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        

        
        self.alpha =1;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismiss{
    
    self.alpha =1;
    
    self.lcTop.constant =0;
    
    [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        
        [self layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {

    }];

    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        
        
        
        self.alpha =0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

- (instancetype)init{
    if (self =[super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundView =[[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].bounds];
        
        [self addSubview:self.backgroundView];
        
        self.backgroundView.backgroundColor =[UIColor colorWithWhite:0 alpha:0.1];
        
        self.backgroundColor =[UIColor clearColor];
        
        [self seutpPickerView];
        
    }
    return self;
}
//- (void)updateConstraintsIfNeeded{
//
//}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundView =[[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].bounds];
        
        [self addSubview:self.backgroundView];
        
        self.backgroundView.backgroundColor =[UIColor colorWithWhite:0 alpha:0.1];
        
        self.backgroundColor =[UIColor clearColor];
        
        [self seutpPickerView];
    }
    return self;
}

- (void)seutpPickerView{
    self.pickerView =[[UIPickerView alloc] init];
    
    self.pickerView.backgroundColor =[UIColor whiteColor];
    
    [self addSubview:self.pickerView];
    
    [self.pickerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerView attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeLeft) multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerView attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeRight) multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerView attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:PICKERVIEW_HEIGHT]];
    
    UIView * toolView =[[UIView alloc] init];
    
    toolView.backgroundColor =[UIColor whiteColor];
    
    [self addSubview:toolView];
    
    [toolView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerView attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:toolView attribute:(NSLayoutAttributeBottom) multiplier:1 constant:0]];

    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:toolView attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeLeft) multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:toolView attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeRight) multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:toolView attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:TOOLVIEW_HEIGHT]];

    self.lcTop =[NSLayoutConstraint constraintWithItem:toolView attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeBottom) multiplier:1 constant:0];

    [self addConstraint:self.lcTop];
    
    UIButton * done =[UIButton buttonWithType:(UIButtonTypeSystem)];
    
  //  [done setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    
    [done setTitle:@"确定" forState:(UIControlStateNormal)];
    
   // [done setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 16)];
    
    [done addTarget:self action:@selector(done:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [toolView addSubview:done];
    
    [done setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [toolView addConstraint:[NSLayoutConstraint constraintWithItem:done attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:toolView attribute:(NSLayoutAttributeTop) multiplier:1 constant:0]];
    
    [toolView addConstraint:[NSLayoutConstraint constraintWithItem:done attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:toolView attribute:(NSLayoutAttributeRight) multiplier:1 constant:0]];
    
    [toolView addConstraint:[NSLayoutConstraint constraintWithItem:done attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:toolView attribute:NSLayoutAttributeWidth multiplier:0 constant:90.f]];
    
    [toolView addConstraint:[NSLayoutConstraint constraintWithItem:done attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:toolView attribute:(NSLayoutAttributeBottom) multiplier:1 constant:0]];
    
    UIButton * cancel =[UIButton buttonWithType:(UIButtonTypeSystem)];
    
   // [cancel setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
    
    [cancel setTitle:@"取消" forState:(UIControlStateNormal)];
    
  //  [done setTitleEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];

    
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [toolView addSubview:cancel];
    
    [cancel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [toolView addConstraint:[NSLayoutConstraint constraintWithItem:cancel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:toolView attribute:(NSLayoutAttributeTop) multiplier:1 constant:0]];
    
    [toolView addConstraint:[NSLayoutConstraint constraintWithItem:cancel attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:toolView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:0]];
    
    [toolView addConstraint:[NSLayoutConstraint constraintWithItem:cancel attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:toolView attribute:NSLayoutAttributeWidth multiplier:0 constant:90.f]];
    
    [toolView addConstraint:[NSLayoutConstraint constraintWithItem:cancel attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:toolView attribute:(NSLayoutAttributeBottom) multiplier:1 constant:0]];
    
    [toolView layoutIfNeeded];
    
    [self layoutIfNeeded];


}

- (void)done:(id)sender{
    if (self.doneSelectedCallback) {
        self.doneSelectedCallback(self,YES);
    }
    [self dismiss];

}

- (void)cancel:(id)sender{
    if (self.doneSelectedCallback) {
        self.doneSelectedCallback(self,NO);
    }
    [self dismiss];
}
@end
