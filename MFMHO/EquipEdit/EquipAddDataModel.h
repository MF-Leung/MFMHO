//
//  EquipAddDataModel.h
//  MFMHO
//
//  Created by 梁文辉 on 16/5/15.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipAddDataModel : NSObject

@property (copy, nonatomic)NSString *title;

@property (copy, nonatomic)NSString *text;

@property (copy, nonatomic)NSString *placeholder;

@property (copy, nonatomic)NSString *type;

@property (nonatomic)BOOL isTable;

+ (instancetype)equipAddDataModelwithTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withType:(id)type;
+ (instancetype)equipAddDataModelwithTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withType:(id)type withIsTable:(BOOL)isTable;
@end
