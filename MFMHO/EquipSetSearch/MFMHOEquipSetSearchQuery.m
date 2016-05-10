//
//  EquipSetSearchQuery.m
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetSearchQuery.h"
#import "MFMHOEquipSetSearchResultModel.h"

@interface MFMHOEquipSetSearchQuery ()
@property (strong, nonatomic) NSMutableArray *resultSet;

@property (strong, nonatomic)   FMResultSet *set;

@property (nonatomic) NSInteger index;

@property (nonatomic)NSInteger resultCount;

@property (nonatomic)BOOL isStop;

@end

@implementation MFMHOEquipSetSearchQuery

- (instancetype)init{
    if (self =[super init]) {
        self.resultSet =[NSMutableArray array];
    }
    return self;
}

- (NSArray *)searchNextPage{
    self.isStop =NO;
    FMDatabase *db =[MFMHODatabase instance].db;
    NSMutableDictionary<NSString*,NSMutableArray*> * decos =[NSMutableDictionary dictionary];
    
    for (int i =0; i<self.skills.count; i++) {
        NSMutableArray<MFMHODecoModel *> * ar =[NSMutableArray array];
        [db executeStatements:[NSString stringWithFormat:@"select * from Deco where SkillRankID1 = %@ order by SkillRankPoint1 desc",self.skills[i].SkillRankID] withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            [ar addObject:[MFMHODecoModel objectWithKeyValues:resultsDictionary]];
            
            return 0;
        }];
        [decos setObject:ar forKey: self.skills[i].SkillRankID];
        
    }
    NSMutableArray * result =[NSMutableArray array];
    
    NSArray *equipModelNameKeys =@[@"arm",@"body",@"head",@"leg",@"wst"];
    if (!self.set){
    NSArray *equip_Name = @[@"Equip_Arm",@"Equip_Body",@"Equip_Head",@"Equip_Leg",@"Equip_Wst"];
    
    NSString * condition = @"";
    
    for (int i =0;i<equip_Name.count;i++) {
        
        NSString *equipName = equip_Name[i];
        
        NSString * condition2 = @"";
        
        for (int i2 =0;i2<self.skills.count;i2++) {
            NSString *skillID = [self.skills[i2].SkillRankID stringValue];
            NSString * or =@"";
            if (i2>0) {
                or =@" or ";
            }
            // OR %@.SlotNum = 3
            condition2 =[NSString stringWithFormat:@"%@%@((%@.SkillRankID1 = %@ and %@.SkillRankPoint1>0 ) OR (%@.SkillRankID2 = %@ and %@.SkillRankPoint2>0 ) OR (%@.SkillRankID3 =%@ and %@.SkillRankPoint3>0 ) OR (%@.SkillRankID4 =%@ and %@.SkillRankPoint4>0 )  OR (%@.SkillRankID5 =%@ and %@.SkillRankPoint5>0 ) OR %@.ID = %ld)",condition2,or,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,[self idOfEquipSlotNumThreeWithEquipType:equipName withOccupatant:self.occupatant]];
        }
        NSString * and =@"";
        if (i>0) {
            and =@" and ";
        }
        
        NSString *rareLevelCondition =@"";
        
        if (self.isPassElementary) {
            rareLevelCondition =[NSString stringWithFormat:@"and %@.RareLevel >1",equipName];
        }
        condition =[NSString stringWithFormat:@"%@%@((%@) and %@.Occupatant  =%@ %@)",condition,and,condition2,equipName,NUMBER_TO_STR(self.occupatant+1),rareLevelCondition];
    }
 
    NSString *columns =@"";
    
    for (int i =0; i<equip_Name.count; i++) {
        if (i>0) {
            columns =[NSString stringWithFormat:@"%@,",columns];
        }
        columns =[NSString stringWithFormat:@"%@ %@.ID,%@.Name,%@.SlotNum,%@.SkillRankID1,%@.SkillRankPoint1,%@.SkillRankID2,%@.SkillRankPoint2,%@.SkillRankID3,%@.SkillRankPoint3,%@.SkillRankID4,%@.SkillRankPoint4,%@.SkillRankID5,%@.SkillRankPoint5",columns,equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i]];
        
    }
    NSString * sql =[NSString stringWithFormat:@"SELECT %@ from Equip_Arm,Equip_Body,Equip_Head,Equip_Leg,Equip_Wst where %@",columns,condition];
        self.set = [db executeQuery:sql];

 }
    
   
    while ([self.set next]) {
        if (self.isStop) {
            return result;
        }
        NSArray<NSArray*> * resul = [self.set resultArrayIsFastWithCount:5];
        NSMutableArray<NSDictionary *> * slotVacant=[NSMutableArray array];
        //   EquipSetSearchResultModel * model = [[EquipSetSearchResultModel alloc] init];
     //   NSMutableDictionary * dic =[NSMutableDictionary dictionary];
     NSMutableArray * arr=[NSMutableArray array];
        for (int i =0; i<resul.count; i++) {
            NSArray* dictionary = resul[i];
            //[model setValue:[EquipModel objectWithKeyValues:dictionary] forKey:equipModelNameKeys[i]];
            //[dic setObject:dictionary forKey:equipModelNameKeys[i]];
            [arr addObject:dictionary];
            [slotVacant addObject:@{@"key":equipModelNameKeys[i],@"value":dictionary[2]}];
            
        }
        NSSortDescriptor *sortDescriptorSlotVacant = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:NO];
        NSArray *sortDescriptorSlotVacants = [[NSArray alloc] initWithObjects:&sortDescriptorSlotVacant count:1];
        [slotVacant sortUsingDescriptors:sortDescriptorSlotVacants];
        
        NSMutableArray * differenceskillRange = [NSMutableArray array];
        
        
        for (int o =0; o <self.skills.count; o++) {
            
            NSInteger skillValue =0;
            
            for (int i = 0; i<equipModelNameKeys.count; i++) {
//                NSArray *obj =[dic valueForKey:equipModelNameKeys[i]];
                NSArray *obj =arr[i];
                if ([obj[3] isEqualToNumber:self.skills[o].SkillRankID]) {
                    
                    skillValue += [obj[4] integerValue];
                    
                }
                else if ([obj[5] isEqualToNumber:self.skills[o].SkillRankID]) {
                    
                    skillValue += [obj[6] integerValue];
                    
                }else if ([obj[7] isEqualToNumber:self.skills[o].SkillRankID]) {
                    
                    skillValue += [obj[8] integerValue];
                    
                }else if ([obj[9] isEqualToNumber:self.skills[o].SkillRankID]) {
                    
                    skillValue += [obj[10] integerValue];
                    
                }else if ([obj[11] isEqualToNumber:self.skills[o].SkillRankID]) {
                    skillValue += [obj[12] integerValue];
                    
                    
                }else{
                    
                }
                
            }
            if ([self.skillStone.skill1.ID isEqualToNumber:self.skills[o].SkillRankID]) {
                skillValue +=self.skillStone.skillPoint1;
            }
            if ([self.skillStone.skill2.ID isEqualToNumber:self.skills[o].SkillRankID]){
                skillValue +=self.skillStone.skillPoint2;
                
            }
            
            //拿到技能点的差值
            
            
            
          //  [differenceskillRange addObject:[@{@"SkillID":self.skills[o].SkillRankID,@"SkillPoint":@([self.skills[o].SkillRankPoint integerValue]-skillValue)}mutableCopy]];
            [differenceskillRange addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.skills[o].SkillRankID,@"SkillID",@([self.skills[o].SkillRankPoint integerValue]-skillValue),@"SkillPoint", nil]];
            
            
            
            
        }
        
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"SkillPoint" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
        [differenceskillRange sortUsingDescriptors:sortDescriptors];
        NSArray * useDeco= [self test:slotVacant  skillPoint:differenceskillRange deco:decos useDeco:[NSMutableArray new]];
        if (useDeco.count>0) {
            MFMHOEquipSetSearchResultModel * model = [[MFMHOEquipSetSearchResultModel alloc] init];
            for (int i =0; i<resul.count; i++) {
                NSArray* dictionary = resul[i];
                MFMHOEquipModel * m =[[MFMHOEquipModel alloc] init];
                m.ID =dictionary[0];
                m.Name =dictionary[1];
                m.SlotNum =dictionary[2];
                NSArray * equiUseDeco =[useDeco filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"key = %@",equipModelNameKeys[i]]];
                [model setValue:equiUseDeco forKey:equipModelNameKeys[i]];
                NSMutableArray * useDecos =[NSMutableArray array];
                
                for (NSDictionary *obj in equiUseDeco) {
                    [useDecos addObject:obj[@"value"]];
                }
                m.useDecos =useDecos;

                [model setValue:m forKey:equipModelNameKeys[i]];
            }
            [result addObject:model];
            if (result.count >= EQUIPSETSEARCHPAGE_COUNT) {
                return result;
            }
        }
        
    }
    return result;
}

- (void)searchWithHandle:(void (^)(MFMHOEquipSetSearchResultModel* model))handle nextBlock:(void (^)(NSInteger, NSInteger))nextBlock{
    self.isStop =NO;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    FMDatabase *db =[MFMHODatabase instance].db;
    NSMutableDictionary<NSString*,NSMutableArray*> * decos =[NSMutableDictionary dictionary];
    
    for (int i =0; i<self.skills.count; i++) {
        NSMutableArray<MFMHODecoModel *> * ar =[NSMutableArray array];
        [db executeStatements:[NSString stringWithFormat:@"select * from Deco where SkillRankID1 = %@ order by SkillRankPoint1 desc",self.skills[i].SkillRankID] withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            [ar addObject:[MFMHODecoModel objectWithKeyValues:resultsDictionary]];
            
            return 0;
        }];
        [decos setObject:ar forKey: self.skills[i].SkillRankID];
        
    }
    
    NSArray *equip_Name = @[@"Equip_Arm",@"Equip_Body",@"Equip_Head",@"Equip_Leg",@"Equip_Wst"];
    
    NSString * condition = @"";
    
    for (int i =0;i<equip_Name.count;i++) {
        
        NSString *equipName = equip_Name[i];
        
        NSString * condition2 = @"";
        
        for (int i2 =0;i2<self.skills.count;i2++) {
            NSString *skillID = [self.skills[i2].SkillRankID stringValue];
            NSString * or =@"";
            if (i2>0) {
                or =@" or ";
            }
            condition2 =[NSString stringWithFormat:@"%@%@((%@.SkillRankID1 = %@ and %@.SkillRankPoint1>0 ) OR (%@.SkillRankID2 = %@ and %@.SkillRankPoint2>0 ) OR (%@.SkillRankID3 =%@ and %@.SkillRankPoint3>0 ) OR (%@.SkillRankID4 =%@ and %@.SkillRankPoint4>0 )  OR (%@.SkillRankID5 =%@ and %@.SkillRankPoint5>0 ) OR %@.SlotNum = 3)",condition2,or,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName];
        }
        NSString * and =@"";
        if (i>0) {
            and =@" and ";
        }
        
        NSString *rareLevelCondition =@"";
        
        if (self.isPassElementary) {
            rareLevelCondition =[NSString stringWithFormat:@"and %@.RareLevel >1",equipName];
        }
        condition =[NSString stringWithFormat:@"%@%@((%@) and %@.Occupatant  =%@ %@)",condition,and,condition2,equipName,NUMBER_TO_STR(self.occupatant+1),rareLevelCondition];
    }
//    NSString * sql =[NSString stringWithFormat:@"SELECT Equip_Arm.*,Equip_Body.*,Equip_Head.*,Equip_Leg.*,Equip_Wst.* from Equip_Arm,Equip_Body,Equip_Head,Equip_Leg,Equip_Wst where %@",condition];
  //  NSString * sql =[NSString stringWithFormat:@"SELECT Equip_Arm.*,Equip_Body.*,Equip_Head.*,Equip_Leg.*,Equip_Wst.* from Equip_Arm,Equip_Body,Equip_Head,Equip_Leg,Equip_Wst where %@",condition];
    NSString *columns =@"";
    
    for (int i =0; i<equip_Name.count; i++) {
        if (i>0) {
            columns =[NSString stringWithFormat:@"%@,",columns];
        }
        columns =[NSString stringWithFormat:@"%@ %@.ID,%@.Name,%@.SlotNum,%@.SkillRankID1,%@.SkillRankPoint1,%@.SkillRankID2,%@.SkillRankPoint2,%@.SkillRankID3,%@.SkillRankPoint3,%@.SkillRankID4,%@.SkillRankPoint4,%@.SkillRankID5,%@.SkillRankPoint5",columns,equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i]];
        
    }
      __block  NSInteger resultCount =0;
        [db executeStatements:[NSString stringWithFormat:@"SELECT count(*) from Equip_Arm,Equip_Body,Equip_Head,Equip_Leg,Equip_Wst where %@",condition] withResultBlock:^int(NSDictionary *resultsDictionary) {
            resultCount =[resultsDictionary[@"count(*)"] integerValue];
            return 0;
        }];
        
    NSString * sql =[NSString stringWithFormat:@"SELECT %@ from Equip_Arm,Equip_Body,Equip_Head,Equip_Leg,Equip_Wst where %@",columns,condition];

  //  NSMutableArray * result =[NSMutableArray array];
    
    NSArray *equipModelNameKeys =@[@"arm",@"body",@"head",@"leg",@"wst"];
    NSInteger resultIndex =0;
    NSInteger returnCount =0;

    FMResultSet *set = [db executeQuery:sql];
    while ([set next]) {
        if (self.isStop) {
            return ;
        }
        NSArray<NSArray*> * resul = [set resultArrayIsFastWithCount:5];
        resultIndex++;
          
        
        NSMutableArray<NSDictionary *> * slotVacant=[NSMutableArray array];
     //   EquipSetSearchResultModel * model = [[EquipSetSearchResultModel alloc] init];
        NSMutableDictionary * dic =[NSMutableDictionary dictionary];
        for (int i =0; i<resul.count; i++) {
            NSArray* dictionary = resul[i];
            //[model setValue:[EquipModel objectWithKeyValues:dictionary] forKey:equipModelNameKeys[i]];
            [dic setObject:dictionary forKey:equipModelNameKeys[i]];
//            if ([equip_Name[i] isEqualToString:@"Equip_Arm"]) {
//                model.arm =[EquipModel objectWithKeyValues:dictionary];
//            }else if ([equip_Name[i] isEqualToString:@"Equip_Body"]) {
//                model.body =[EquipModel objectWithKeyValues:dictionary];
//            }else if ([equip_Name[i] isEqualToString:@"Equip_Head"]) {
//                model.head =[EquipModel objectWithKeyValues:dictionary];
//            }else if ([equip_Name[i] isEqualToString:@"Equip_Leg"]) {
//                model.leg =[EquipModel objectWithKeyValues:dictionary];
//            }else if ([equip_Name[i] isEqualToString:@"Equip_Wst"]) {
//                model.wst =[EquipModel objectWithKeyValues:dictionary];
//            }
            
            [slotVacant addObject:@{@"key":equipModelNameKeys[i],@"value":dictionary[2]}];
            
        }
        NSSortDescriptor *sortDescriptorSlotVacant = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:NO];
        NSArray *sortDescriptorSlotVacants = [[NSArray alloc] initWithObjects:&sortDescriptorSlotVacant count:1];
        [slotVacant sortUsingDescriptors:sortDescriptorSlotVacants];
        
        NSMutableArray * differenceskillRange = [NSMutableArray array];
       

        for (int o =0; o <self.skills.count; o++) {
            
            NSInteger skillValue =0;
            
            for (int i = 0; i<equipModelNameKeys.count; i++) {
                NSArray *obj =[dic valueForKey:equipModelNameKeys[i]];
                if ([obj[3] isEqualToNumber:self.skills[o].SkillRankID]) {
                    
                    skillValue += [obj[4] integerValue];
                    
                }else if ([obj[5] isEqualToNumber:self.skills[o].SkillRankID]) {
                    
                    skillValue += [obj[6] integerValue];
                    
                }else if ([obj[7] isEqualToNumber:self.skills[o].SkillRankID]) {
                    
                    skillValue += [obj[8] integerValue];
                    
                }else if ([obj[9] isEqualToNumber:self.skills[o].SkillRankID]) {
                    
                    skillValue += [obj[10] integerValue];
                    
                }else if ([obj[11] isEqualToNumber:self.skills[o].SkillRankID]) {
                    skillValue += [obj[12] integerValue];
                    
                    
                }else{
                    
                }
                
            }
            if ([self.skillStone.skill1.ID isEqualToNumber:self.skills[o].SkillRankID]) {
                skillValue +=self.skillStone.skillPoint1;
            }
            if ([self.skillStone.skill2.ID isEqualToNumber:self.skills[o].SkillRankID]){
                skillValue +=self.skillStone.skillPoint2;

            }
            
            //拿到技能点的差值
          
         
            
           // [differenceskillRange addObject:[@{@"SkillID":self.skills[o].SkillRankID,@"SkillPoint":@([self.skills[o].SkillRankPoint integerValue]-skillValue)}mutableCopy]];
          
            [differenceskillRange addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.skills[o].SkillRankID,@"SkillID",@([self.skills[o].SkillRankPoint integerValue]-skillValue),@"SkillPoint", nil]];

            
            
        }
        
    
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"SkillPoint" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
        [differenceskillRange sortUsingDescriptors:sortDescriptors];
        NSArray * useDeco= [self test:slotVacant  skillPoint:differenceskillRange deco:decos useDeco:[NSMutableArray new]];
        if (useDeco.count>0) {
               MFMHOEquipSetSearchResultModel * model = [[MFMHOEquipSetSearchResultModel alloc] init];
            for (int i =0; i<resul.count; i++) {
                NSArray* dictionary = resul[i];
                MFMHOEquipModel * m =[[MFMHOEquipModel alloc] init];
                m.ID =dictionary[0];
                m.Name =dictionary[1];
                m.SlotNum =dictionary[2];
                NSArray * equiUseDeco =[useDeco filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"key = %@",equipModelNameKeys[i]]];
                [model setValue:equiUseDeco forKey:equipModelNameKeys[i]];
                NSMutableArray * useDecos =[NSMutableArray array];
                
                for (NSDictionary *obj in equiUseDeco) {
                    [useDecos addObject:obj[@"value"]];
                }
                
                m.useDecos =useDecos;
                [model setValue:m forKey:equipModelNameKeys[i]];
                
                
            }
            
            returnCount++;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                handle(model);
            });
           // [result addObject:model];
            if (returnCount>100) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    nextBlock(1,1);
                });
                
                return;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
        nextBlock(resultIndex,resultCount);
        });
    }
    //return [NSArray arrayWithArray:result];
    });
}

- (NSArray*)test:(NSMutableArray<NSDictionary*>*)slotVacant skillPoint:(NSMutableArray*)differenceskillRange deco:(NSDictionary*)allDeco useDeco:(NSMutableArray<NSDictionary*>*)useDeco{
    
    if (slotVacant.count==0 && [differenceskillRange.firstObject[@"SkillPoint"] integerValue]>0) {
        return nil;
    }
    
    if ([[differenceskillRange.firstObject objectForKey:@"SkillPoint"] integerValue] == 0) {
        return useDeco;
    }
    
    NSArray * ar =allDeco[differenceskillRange.firstObject[@"SkillID"]];
    NSInteger count =[ar count];
    for (int i =0;i<count;i++){
        MFMHODecoModel *deco =[ar objectAtIndex:i];
        
        NSInteger skillPoint = [[differenceskillRange.firstObject objectForKey:@"SkillPoint"] integerValue];
        //point 是相差的point
        NSInteger point =skillPoint-[deco.SkillRankPoint1 integerValue];
//        NSPredicate * p =[NSPredicate predicateWithFormat:@"SkillID = %@ ",deco.SkillRankID2];
//        NSArray * skillRankID2 = [differenceskillRange filteredArrayUsingPredicate:p];
        NSMutableDictionary *skillRankID2_dic =nil;
        for (NSMutableDictionary *obj in differenceskillRange) {
           
            if ([deco.SkillRankID2 isEqualToNumber:obj[@"SkillID"]]) {
                skillRankID2_dic= obj;
                break;
            }
        }
        
        if (point>=0  || i == count-1) {
            NSInteger removeIndex = -1;
            for (int i =0;i<slotVacant.count;i++) {
                NSNumber * stol= slotVacant[i][@"value"];
                if ([stol isEqualToNumber:deco.SlotNum]) {
                    removeIndex = i;
                    break;
                }
            }
            
            if (removeIndex !=-1) {
            
                [useDeco addObject:@{@"key":slotVacant[removeIndex][@"key"],@"value":deco}];

                [slotVacant removeObjectAtIndex:removeIndex];
                
                if (skillRankID2_dic) {
                    //point 是珠宝的第二技能点
                    NSInteger point2 =[[skillRankID2_dic objectForKey:@"SkillPoint"] integerValue]-[deco.SkillRankPoint2 integerValue];
                    [skillRankID2_dic setObject:@(point2) forKey:@"SkillPoint"];
                    [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];
                    [self swapWithData:differenceskillRange withKey:@"SkillPoint" index1:0 index2:[differenceskillRange indexOfObject:skillRankID2_dic]];

                }else{
                [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];
                    [self swapWithData:differenceskillRange withKey:@"SkillPoint"];

                }
                
//                NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"SkillPoint" ascending:NO];
//                NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
//                [differenceskillRange sortUsingDescriptors:sortDescriptors];
 //               [self quickSortWithArray:differenceskillRange left:0 right:differenceskillRange.count-1 key:@"SkillPoint"];
                return [self test:slotVacant skillPoint:differenceskillRange deco:allDeco useDeco:useDeco];
                
            }else{
                NSInteger slotNum =-1;
                NSInteger removeIndex = 0;

                for (NSInteger i =slotVacant.count-1;i>=0;i--) {
                    NSNumber * stol= slotVacant[i][@"value"];
                     NSInteger slotNum2 = [stol integerValue] - [deco.SlotNum integerValue];
                    if (slotNum2 >=0) {
                        slotNum = slotNum2;
                        removeIndex = i;
                        break;
                    }
                }
                
               // NSInteger slotNum = [slotVacant.firstObject integerValue] - [deco.SlotNum integerValue];
                if (slotNum>=0) {
                    //  if ([slotVacant containsObject:deco[@"SlotNum"]]) {
                    NSString * key =slotVacant[removeIndex][@"key"];
                    [slotVacant removeObjectAtIndex:removeIndex];
                    if (slotNum>0) {
                        [slotVacant addObject:@{@"key":key,@"value":[NSNumber numberWithLong:slotNum]}];
//                        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"" ascending:NO];
//                        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
//                        [slotVacant sortUsingDescriptors:sortDescriptors];
                        [self swapWithData:slotVacant];
                    }
                    [useDeco addObject:@{@"key":key,@"value":deco}];
                    if (skillRankID2_dic) {
                        //point 是珠宝的第二技能点
                        NSInteger point2 =[[skillRankID2_dic objectForKey:@"SkillPoint"] integerValue]-[deco.SkillRankPoint2 integerValue];
                        [skillRankID2_dic setObject:@(point2) forKey:@"SkillPoint"];
                        [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];

                        [self swapWithData:differenceskillRange withKey:@"SkillPoint" index1:0 index2:[differenceskillRange indexOfObject:skillRankID2_dic]];

                    }else{
                        [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];
                        [self swapWithData:differenceskillRange withKey:@"SkillPoint"];

                    }
//                    if (differenceskillRange.count>0) {
////                        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"SkillPoint" ascending:NO];
////                        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
////                        [differenceskillRange sortUsingDescriptors:sortDescriptors];
//                        [self swapWithData:differenceskillRange withKey:@"SkillPoint"];
//                    }
                    
                    return [self test:slotVacant skillPoint:differenceskillRange deco:allDeco useDeco:useDeco];
                }
                
            }
        }
    }
    
    
    return nil;
}

- (void)instancesResultSet{
    FMDatabase *db =[MFMHODatabase instance].db;
    
    
    NSArray *equip_Name = @[@"Equip_Arm",@"Equip_Body",@"Equip_Head",@"Equip_Leg",@"Equip_Wst"];
    
    NSString * condition = @"";
    
    for (int i =0;i<equip_Name.count;i++) {
        
        NSString *equipName = equip_Name[i];
        
        NSString * condition2 = @"";
        
        for (int i2 =0;i2<self.skills.count;i2++) {
            NSString *skillID = [self.skills[i2].SkillRankID stringValue];
            NSString * or =@"";
            if (i2>0) {
                or =@" or ";
            }
            condition2 =[NSString stringWithFormat:@"%@%@((%@.SkillRankID1 = %@ and %@.SkillRankPoint1>0 ) OR (%@.SkillRankID2 = %@ and %@.SkillRankPoint2>0 ) OR (%@.SkillRankID3 =%@ and %@.SkillRankPoint3>0 ) OR (%@.SkillRankID4 =%@ and %@.SkillRankPoint4>0 )  OR (%@.SkillRankID5 =%@ and %@.SkillRankPoint5>0 ) OR %@.SlotNum = 3)",condition2,or,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName];
        }
        NSString * and =@"";
        if (i>0) {
            and =@" and ";
        }
        
        NSString *rareLevelCondition =@"";
        
        if (self.isPassElementary) {
            rareLevelCondition =[NSString stringWithFormat:@"and %@.RareLevel >1",equipName];
        }
        condition =[NSString stringWithFormat:@"%@%@((%@) and %@.Occupatant  =1 %@)",condition,and,condition2,equipName,rareLevelCondition];
    }
    //    NSString * sql =[NSString stringWithFormat:@"SELECT Equip_Arm.*,Equip_Body.*,Equip_Head.*,Equip_Leg.*,Equip_Wst.* from Equip_Arm,Equip_Body,Equip_Head,Equip_Leg,Equip_Wst where %@",condition];
    
    NSString *columns =@"";
    
    for (int i =0; i<equip_Name.count; i++) {
        if (i>0) {
        columns =[NSString stringWithFormat:@"%@,",columns];
        }
        columns =[NSString stringWithFormat:@"%@ %@.ID,%@.Name,%@.SlotNum,%@.SkillRankID1,%@.SkillRankPoint1,%@.SkillRankID2,%@.SkillRankPoint2,%@.SkillRankID3,%@.SkillRankPoint3,%@.SkillRankID4,%@.SkillRankPoint4,%@.SkillRankID5,%@.SkillRankPoint5",columns,equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i],equip_Name[i]];
        
    }
    NSString * sql =[NSString stringWithFormat:@"SELECT %@ from Equip_Arm,Equip_Body,Equip_Head,Equip_Leg,Equip_Wst where %@",columns,condition];
    
    
    FMResultSet *set = [db executeQuery:sql];
    while ([set next]) {
        
        NSArray * resul = [set resultArrayWithCount:5];
        [self.resultSet addObject:resul];
    }
}

-(void)quickSortWithArray:(NSMutableArray *)aData left:(NSInteger)left right:(NSInteger)right key:(NSString*)key{
    if (right > left) {
        NSInteger i = left;
        NSInteger j = right + 1;
        while (true) {
            while (i+1 < [aData count] && [[aData objectAtIndex:++i][key] integerValue] < [[aData objectAtIndex:left][key]integerValue]) ;
            while (j-1 > -1 && [[aData objectAtIndex:--j][key]integerValue] > [[aData objectAtIndex:left][key]integerValue]) ;
            if (i >= j) {
                break;
            }
            [self swapWithData:aData index1:i index2:j];
        }
        [self swapWithData:aData index1:left index2:j];
        [self quickSortWithArray:aData left:left right:j-1 key:key];
        [self quickSortWithArray:aData left:j+1 right:right key:key];
    }
}
-(void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2{
    id tmp = [aData objectAtIndex:index1];
    [aData replaceObjectAtIndex:index1 withObject:[aData objectAtIndex:index2]];
    [aData replaceObjectAtIndex:index2 withObject:tmp];
}

- (void)swapWithData:(NSMutableArray *)aData withKey:(NSString*)key {
    if (aData.count==1) {
        return;
    }
    
    
    NSInteger index1 =0;
    while (index1<aData.count-1) {
        NSMutableDictionary *obj1 =aData[index1];
        NSMutableDictionary *obj2 =aData[index1+1];
        
        if ([obj1[key] integerValue] < [obj2[key] integerValue]) {
            [aData exchangeObjectAtIndex:index1 withObjectAtIndex:index1+1];
            index1 ++;
        }else{
            return;
        }
    }
    
}
- (void)swapWithData:(NSMutableArray *)aData withKey:(NSString*)key index1:(NSInteger)index1 index2:(NSInteger)index2{
    if (aData.count==1) {
        return;
    }
    
    
    
    while (index1<aData.count-1) {
        NSMutableDictionary *obj1 =aData[index1];
        NSMutableDictionary *obj2 =aData[index1+1];

        if ([obj1[key] integerValue] < [obj2[key] integerValue]) {
            [aData exchangeObjectAtIndex:index1 withObjectAtIndex:index1+1];
            index1 ++;
        }else{
            break;
        }
    }
    while (index2>0) {
        NSMutableDictionary *obj1 =aData[index2];
        NSMutableDictionary *obj2 =aData[index2-1];
        
        if ([obj1[key] integerValue] > [obj2[key] integerValue]) {
            [aData exchangeObjectAtIndex:index2 withObjectAtIndex:index2-1];
            index2 --;
        }else{
            return;
        }
    }
}
- (void)swapWithData:(NSMutableArray *)aData {
    if (aData.count==1) {
        return;
    }
    
    
    NSInteger index1 =aData.count-1;
    while (index1>0) {
        id obj1 =aData[index1][@"value"];
        id obj2 =aData[index1-1][@"value"];
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            [aData exchangeObjectAtIndex:index1 withObjectAtIndex:index1-1];
            index1 --;
        }else{
            return;
        }
    }
    
}
- (NSInteger)idOfEquipSlotNumThreeWithEquipType:(NSString*)equipType withOccupatant:(NSInteger)occupatant{
   

    NSDictionary * equipSlotNumThree =@{@"Equip_Arm":@"110",@"Equip_Body":@"122",@"Equip_Head":@"117",@"Equip_Leg":@"122",@"Equip_Wst":@"122"};
    
    return [[equipSlotNumThree objectForKey:equipType] integerValue] + occupatant;
}
- (void)stop{
    self.isStop =YES;
}
//2 0 0
//1 0 1
//1 1 0
//0 2 0
//2 0 0
//
//
//3 3 2 2 1
//3 2 2 1 2
@end
