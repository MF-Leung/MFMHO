//
//  EquipAddDataModel.m
//  MFMHO
//
//  Created by 梁文辉 on 16/5/15.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "EquipAddDataModel.h"

@implementation EquipAddDataModel

+ (instancetype)equipAddDataModelwithTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withType:(id)type withKeyboardType:(UIKeyboardType)keyboardType{
    
    return [EquipAddDataModel equipAddDataModelwithTitle:title withPlaceholder:placeholder withType:type withIsTable:NO withKeyboardType:keyboardType];
    
   
}


+ (instancetype)equipAddDataModelwithTitle:(NSString *)title withPlaceholder:(NSString *)placeholder withType:(id)type withIsTable:(BOOL)isTable withKeyboardType:(UIKeyboardType)keyboardType{
    EquipAddDataModel *obj =[[EquipAddDataModel alloc] init];
    
    obj.title =title;
    
    obj.placeholder =placeholder;
    
    obj.type =type;
    
    obj.isTable =isTable;
    
    obj.keyboardType =keyboardType;
    
    return obj;
}

+ (BOOL)addModelsToDatabase:(NSArray <NSArray <EquipAddDataModel*>*>*)datas{

    
    
    FMDatabase *db =[MFMHODatabase instance].db;
    
    NSMutableString * sql =[NSMutableString string];
    
    
    __block  NSMutableString * sql1 =[NSMutableString string];
    
    NSMutableString *sql2 =[NSMutableString string];
    
    NSMutableString *sql3 =[NSMutableString stringWithFormat:@"VALUES "];
    
    __block BOOL b;
    
    [datas enumerateObjectsUsingBlock:^(NSArray<EquipAddDataModel *> * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        
        [obj1 enumerateObjectsUsingBlock:^(EquipAddDataModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
            
            if (obj2.text.length ==0) {
                
                
                b =YES;
                return ;
            }
            
            if (obj2.isTable) {
                
                [(NSArray *)obj2.type enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    
                    if ([dic[Title] isEqualToString:obj2.text]) {
                        sql1 = [NSMutableString stringWithFormat:@"INSERT INTO %@",dic[Value]];
                        *stop =YES;
                    }
                    
                } ];
                
                
            }else{
                
                if(sql2.length==0){
                    [sql2 appendString:@"("];
                    [sql3 appendString:@"("];
                }
                //  if (obj2.text.length>0) {
                
                
                [sql2 appendString:obj2.placeholder];
                
                if ([obj2.type isKindOfClass:[NSString class]]) {
                    if ([obj2.type isEqualToString:@"string"]) {
                        
                        [sql3 appendString:[NSString stringWithFormat:@"'%@'",obj2.text]];
                        
                    }else if ([obj2.type isEqualToString:@"int"]){
                        
                        [sql3 appendString:obj2.text];
                        
                    }
                }else if([obj2.type isKindOfClass:[NSArray class]]){
                    
                    [(NSArray *)obj2.type enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        
                        if ([dic[Title] isEqualToString:obj2.text]) {
                            [sql3 appendString:dic[Value]];
                            *stop =YES;
                        }
                        
                    } ];
                    
                }
                
                // }
                if (idx2==obj1.count-1 && idx1 == datas.count-1) {
                    [sql2 appendString:@")"];
                    [sql3 appendString:@")"];
                    
                    
                }
                else{
                    [sql2 appendString:@","];
                    
                    [sql3 appendString:@","];
                }
                
            }
            
        }];
        
        
        
    }];
    
   
    
    [sql appendString:sql1];
    [sql appendString:@" "];
    
    [sql appendString:sql2];
    [sql appendString:@" "];
    
    [sql appendString:sql3];
    
    return [db executeUpdate:sql];
    
    
    
    
}
@end


