//
//  EquipAddDataModel.m
//  MFMHO
//
//  Created by 梁文辉 on 16/5/15.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "EquipAddDataModel.h"

@implementation EquipAddDataModel

+ (instancetype)equipAddDataModelwithTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withType:(id)type{
    
    return [EquipAddDataModel equipAddDataModelwithTitle:title withPlaceholder:placeholder withType:type withIsTable:NO];
    
   
}

+ (instancetype)equipAddDataModelwithTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withType:(id)type withIsTable:(BOOL)isTable{
    EquipAddDataModel *obj =[[EquipAddDataModel alloc] init];
    
    obj.title =title;
    
    obj.placeholder =placeholder;
    
    obj.type =type;
    
    obj.isTable =isTable;
    
    return obj;
}

@end


