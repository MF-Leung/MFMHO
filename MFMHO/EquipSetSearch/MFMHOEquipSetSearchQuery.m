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
    NSMutableArray<NSMutableArray*> * decos =[NSMutableArray array];
    
    for (int i =0; i<self.skills.count; i++) {
        NSMutableArray<MFMHODecoModel *> * ar =[NSMutableArray array];
        [db executeStatements:[NSString stringWithFormat:@"select * from Deco where SkillRankID1 = %@ order by SkillRankPoint1 desc",self.skills[i].SkillRankID] withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            [ar addObject:[MFMHODecoModel objectWithKeyValues:resultsDictionary]];
            
            return 0;
        }];
        [decos addObject:[@[ar]mutableCopy]];
        
    }
    NSMutableArray * result =[NSMutableArray array];
    
    NSArray *equipModelNameKeys =NSARRAY_EQUIP_MODEL_NAME_KEYS;
    if (!self.set){
        NSArray *equip_Name = NSARRAY_EQUIP_TABLE_NAME_KEYS;
        
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
                condition2 =[NSString stringWithFormat:@"%@%@((%@.SkillRankID1 = %@ and %@.SkillRankPoint1>0 ) OR (%@.SkillRankID2 = %@ and %@.SkillRankPoint2>0 ) OR (%@.SkillRankID3 =%@ and %@.SkillRankPoint3>0 ) OR (%@.SkillRankID4 =%@ and %@.SkillRankPoint4>0 )  OR (%@.SkillRankID5 =%@ and %@.SkillRankPoint5>0 ) OR %@.ID = %ld)",condition2,or,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,(long)[self idOfEquipSlotNumThreeWithEquipType:equipName withOccupatant:self.occupatant]];
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
        
        NSMutableArray<NSArray *> * slotVacant=[NSMutableArray array];
        
        NSMutableArray * arr=[NSMutableArray array];
          //NSArray *s=@[[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array]];
        for (int i =0; i<resul.count; i++) {
            
            NSArray* dictionary = resul[i];
            
            
            [arr addObject:dictionary];
            
//            [slotVacant addObject:@{@"key":equipModelNameKeys[i],@"value":dictionary[2]}];
            NSArray * arr =@[equipModelNameKeys[i],dictionary[2]];
            if (i==0) {
                [slotVacant addObject:arr];

            }else
            {
                int u =i;
               
                while (u>0&&[dictionary[2] integerValue]>[slotVacant[u-1][1] integerValue]) {
                    u--;
                }
                if (u<i) {
    
                [slotVacant insertObject:arr atIndex:u];
                }else
                    [slotVacant addObject:arr];

            }
            
           // [s[[dictionary[2] intValue]]addObject:arr];
        }
//        NSSortDescriptor *sortDescriptorSlotVacant = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:NO];
//        
//        NSArray *sortDescriptorSlotVacants = [[NSArray alloc] initWithObjects:&sortDescriptorSlotVacant count:1];
//        
//        [slotVacant sortUsingDescriptors:sortDescriptorSlotVacants];
        
//                NSMutableArray * ass =[NSMutableArray array];
//                for (int i = 3; i>=0 ; i--) {
//                    for (int j=1; j<=[s[i]count]; j++) {
//        
//                        [ass addObject:s[i][j-1]];
//                    }
//                }
//                slotVacant  =ass;
        NSMutableArray * differenceskillRange = [NSMutableArray array];
        
        for (int o =0; o <self.skills.count; o++) {
            
            NSInteger skillValue =0;
            
            for (int i = 0; i<equipModelNameKeys.count; i++) {
                
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
            
            NSInteger b =[self.skills[o].SkillRankPoint integerValue]-skillValue;
//            NSDictionary *dic =[NSMutableDictionary dictionaryWithObjectsAndKeys:self.skills[o].SkillRankID,@"SkillID",@(b),@"SkillPoint", nil];
            NSMutableArray *dic =[@[self.skills[o].SkillRankID,@(b)]mutableCopy];

            if (o==0) {
                [differenceskillRange addObject:dic];
                
            }else
            {
                int u =o;
                
                while (u>0&&b>[differenceskillRange[u-1][1] integerValue]) {
                    u--;
                }
                if (u<o) {
                    
                    [differenceskillRange insertObject:dic atIndex:u];
                }else
                    [differenceskillRange addObject:dic];
                
            }

            
            
            
        }
        
        
//        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"SkillPoint" ascending:NO];
//        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
//        [differenceskillRange sortUsingDescriptors:sortDescriptors];
        NSArray * useDeco= [self run:slotVacant  skillPoint:differenceskillRange deco:decos useDeco:[NSMutableArray new]];
        if (useDeco.count>0) {
            MFMHOEquipSetSearchResultModel * model = [[MFMHOEquipSetSearchResultModel alloc] init];
            for (int i =0; i<resul.count; i++) {
                NSArray* dictionary = resul[i];
                MFMHOEquipModel * m =[[MFMHOEquipModel alloc] init];
                m.ID =dictionary[0];
                m.Name =dictionary[1];
                m.SlotNum =dictionary[2];
//                NSArray * equiUseDeco =[useDeco filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"key = %@",equipModelNameKeys[i]]];
                NSMutableArray * equiUseDeco =[NSMutableArray array];
                for (NSArray *arr in useDeco) {
                    if ([equipModelNameKeys[i] isEqualToString:arr[0]]) {
                        [equiUseDeco addObject:arr];
                    }
                }
                [model setValue:equiUseDeco forKey:equipModelNameKeys[i]];
                NSMutableArray * useDecos =[NSMutableArray array];
                
                for (NSArray *obj in equiUseDeco) {
                    [useDecos addObject:obj[1]];
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



- (NSArray*)run:(NSMutableArray<NSArray*>*)slotVacant skillPoint:(NSMutableArray*)differenceskillRange deco:(NSMutableArray*)allDeco useDeco:(NSMutableArray<NSArray*>*)useDeco{
    
    if (slotVacant.count==0 && [differenceskillRange.firstObject[1] integerValue]>0) {
        return nil;
    }
    
    if ([[differenceskillRange.firstObject objectAtIndex:1] integerValue] == 0) {
        return useDeco;
    }
    NSArray * ar;
    for (NSArray *b in allDeco) {
        if ([[b.firstObject[0] SkillRankID1] isEqualToNumber:differenceskillRange.firstObject[0]]) {
            ar =b.firstObject;
            break;
        }
    }
    NSInteger count =[ar count];
    for (int i =0;i<count;i++){
        MFMHODecoModel *deco =[ar objectAtIndex:i];
        
        NSInteger skillPoint = [[differenceskillRange.firstObject objectAtIndex:1] integerValue];
        //point 是相差的point
        NSInteger point =skillPoint-[deco.SkillRankPoint1 integerValue];
        
        NSMutableArray *skillRankID2_dic =nil;
        for (NSMutableArray *obj in differenceskillRange) {
            
            if ([deco.SkillRankID2 isEqualToNumber:obj[0]]) {
                skillRankID2_dic= obj;
                break;
            }
        }
        
        if (point>=0  || i == count-1) {
            NSInteger removeIndex = -1;
            for (int i =0;i<slotVacant.count;i++) {
                NSNumber * stol= slotVacant[i][1];
                if ([stol isEqualToNumber:deco.SlotNum]) {
                    removeIndex = i;
                    break;
                }
            }
            
            if (removeIndex !=-1) {
                
                [useDeco addObject:@[slotVacant[removeIndex][0],deco]];
                
                [slotVacant removeObjectAtIndex:removeIndex];
                
                if (skillRankID2_dic) {
                    //point 是珠宝的第二技能点
                    NSInteger point2 =[[skillRankID2_dic objectAtIndex:1] integerValue]-[deco.SkillRankPoint2 integerValue];
//                    [skillRankID2_dic setObject:@(point2) forKey:@"SkillPoint"];
                    skillRankID2_dic[1] =@(point2);

//                    [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];
                    differenceskillRange.firstObject[1] =@(point);

                    [self swapWithData:differenceskillRange withKey:1 index1:0 index2:[differenceskillRange indexOfObject:skillRankID2_dic]];
                    
                }else{
//                    [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];
                    differenceskillRange.firstObject[1] =@(point);
                    [self swapWithData:differenceskillRange withKey:1];
                    
                }
                
                
                return [self run:slotVacant skillPoint:differenceskillRange deco:allDeco useDeco:useDeco];
                
            }else{
                NSInteger slotNum =-1;
                NSInteger removeIndex = 0;
                
                for (NSInteger i =slotVacant.count-1;i>=0;i--) {
                    NSNumber * stol= slotVacant[i][1];
                    NSInteger slotNum2 = [stol integerValue] - [deco.SlotNum integerValue];
                    if (slotNum2 >=0) {
                        slotNum = slotNum2;
                        removeIndex = i;
                        break;
                    }
                }
                if (slotNum>=0) {
                    NSString * key =slotVacant[removeIndex][0];
                    [slotVacant removeObjectAtIndex:removeIndex];
                    if (slotNum>0) {
                        [slotVacant addObject:@[key,[NSNumber numberWithLong:slotNum]]];
                        
                        [self swapWithData:slotVacant];
                    }
                    [useDeco addObject:@[key,deco]];
                    
                    if (skillRankID2_dic) {
                        //point 是珠宝的第二技能点
                        NSInteger point2 =[[skillRankID2_dic objectAtIndex:1] integerValue]-[deco.SkillRankPoint2 integerValue];
//                        [skillRankID2_dic setObject:@(point2) forKey:@"SkillPoint"];
                        skillRankID2_dic[1] =@(point2);
//                        [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];
                        differenceskillRange.firstObject[1] =@(point);
                        [self swapWithData:differenceskillRange withKey:1 index1:0 index2:[differenceskillRange indexOfObject:skillRankID2_dic]];
                        
                    }else{
//                        [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];
                        differenceskillRange.firstObject[1] =@(point);
                        [self swapWithData:differenceskillRange withKey:1];
                        
                    }
                    
                    
                    return [self run:slotVacant skillPoint:differenceskillRange deco:allDeco useDeco:useDeco];
                }
                
            }
        }
    }
    
    
    return nil;
}





- (void)swapWithData:(NSMutableArray *)aData withKey:(NSInteger)key {
    if (aData.count==1) {
        return;
    }
    
    
    NSInteger index1 =0;
    while (index1<aData.count-1) {
        NSMutableArray *obj1 =aData[index1];
        NSMutableArray *obj2 =aData[index1+1];
        
        if ([obj1[key] integerValue] < [obj2[key] integerValue]) {
            [aData exchangeObjectAtIndex:index1 withObjectAtIndex:index1+1];
            index1 ++;
        }else{
            return;
        }
    }
    
}
- (void)swapWithData:(NSMutableArray *)aData withKey:(NSInteger)key index1:(NSInteger)index1 index2:(NSInteger)index2{
    if (aData.count==1) {
        return;
    }
    
    
    
    while (index1<aData.count-1) {
        NSMutableArray *obj1 =aData[index1];
        NSMutableArray *obj2 =aData[index1+1];
        
        if ([obj1[key] integerValue] < [obj2[key] integerValue]) {
            [aData exchangeObjectAtIndex:index1 withObjectAtIndex:index1+1];
            index1 ++;
        }else{
            break;
        }
    }
    while (index2>0) {
        NSMutableArray *obj1 =aData[index2];
        NSMutableArray *obj2 =aData[index2-1];
        
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
        id obj1 =aData[index1][1];
        id obj2 =aData[index1-1][1];
        
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

@end
