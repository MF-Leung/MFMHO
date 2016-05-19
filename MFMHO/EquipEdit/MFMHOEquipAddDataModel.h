//
//  EquipAddDataModel.h
//  MFMHO
//
//  Created by 梁文辉 on 16/5/15.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Title @"title"
#define Value @"table"
@interface MFMHOEquipAddDataModel : NSObject

@property (copy, nonatomic)NSString *title;

@property (copy, nonatomic)NSString *text;

@property (copy, nonatomic)NSString *placeholder;

@property (strong, nonatomic)id type;

@property (nonatomic)BOOL isTable;

@property (nonatomic)UIKeyboardType keyboardType;

+ (instancetype)equipAddDataModelwithTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withType:(id)type  withKeyboardType:(UIKeyboardType)keyboardType;
+ (instancetype)equipAddDataModelwithTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withType:(id)type withIsTable:(BOOL)isTable  withKeyboardType:(UIKeyboardType)keyboardType;


+ (BOOL)addModelsToDatabase:(NSArray <NSArray <EquipAddDataModel*>*>*)datas;
@end
