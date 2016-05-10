//
//  ViewController.m
//  MHO
//
//  Created by feiquanqiu on 16/2/3.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
/*
 //
 //  ViewController.m
 //  asdccc
 //
 //  Created by feiquanqiu on 15/12/24.
 //  Copyright © 2015年 feiquanqiu. All rights reserved.
 //
 
 #import "ViewController.h"
 #import "fmdb/FMDB.h"
 #include <mach/mach_time.h>
 #import "EquipSetModel.h"
 
 @interface ViewController ()
 @property(strong,nonatomic)NSMutableArray * arm;
 @property(strong,nonatomic)NSMutableArray * body;
 @property(strong,nonatomic)NSMutableArray * head;
 @property(strong,nonatomic)NSMutableArray * leg;
 @property(strong,nonatomic)NSMutableArray * wst;
 @property(strong,nonatomic)NSMutableArray * skill;
 @property(strong,nonatomic)NSMutableArray * deco;
 @property(strong,nonatomic)NSMutableArray * skillRank;
 @end
 
 @implementation ViewController
 double MachTimeToSecs(uint64_t time)
 {
 mach_timebase_info_data_t timebase;
 mach_timebase_info(&timebase);
 return (double)time * (double)timebase.numer /
 (double)timebase.denom / 1e9;
 }
 
 
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 
 
 
 
 NSMutableArray * dd =[NSMutableArray array];
 0.107866 s  for (long long i =0; i<2391092830; i++) {
 0.1247 s    for (id d in arr5) {
 for (long long i =0; i <48*48*48*48*48; i++) {
 [dd addObject:[@(i) stringValue]];
 }
 
 uint64_t begin = mach_absolute_time();
 for (NSString * s in dd) {
 NSInteger w = [s integerValue];
 }
 uint64_t end = mach_absolute_time();
 NSLog(@"Time taken to doSomething %g s",
 MachTimeToSecs(end - begin));
 
 
 
 NSMutableArray * arr1 =[NSMutableArray array];
 NSMutableArray * arr2 =[NSMutableArray array];
 NSMutableArray * arr3 =[NSMutableArray array];
 NSMutableArray * arr4 =[NSMutableArray array];
 NSMutableArray * arr5 =[NSMutableArray array];
 for (int i =0; i<48; i++) {
 [arr1 addObject:[@(i) stringValue]];
 }
 for (int i =0; i<48; i++) {
 [arr2 addObject:[@(i) stringValue]];
 }
 for (int i =0; i<48; i++) {
 [arr3 addObject:[@(i) stringValue]];
 }
 for (int i =0; i<48; i++) {
 [arr4 addObject:[@(i) stringValue]];
 }
 for (int i =0; i<48; i++) {
 [arr5 addObject:[@(i) stringValue]];
 }
 __block long long  i =0;
 
 for (id obj1 in arr1) {
 for (id obj2 in arr2) {
 for (id obj3 in arr3) {
 for (id obj4 in arr4) {
 for (id obj5 in arr5) {
 
 i = [obj1 integerValue] + [obj2 integerValue]+ [obj3 integerValue]+[obj4 integerValue]+[obj5 integerValue];
 
 }
 }
 }
 }
 }
 
 



[self test2];

// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[self serch:@"4"];//速食;
    
}
- (void)test{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"db"]];
    
    [db open];
    
    //    FMResultSet *s = [db executeQuery:@"select * from Equip_Arm INNER JOIN Equip_Body INNER JOIN Equip_Head on Equip_Arm.ID = Equip_Body.ID AND Equip_Body.ID = Equip_Head.ID AND Equip_Head.ID = 30 "];
    //    while ([s next]) {
    //      //NSDictionary *d=  [s resultDictionary];
    //       // NSLog(@"%@",d);
    //    }
    //select * from Equip_Arm INNER JOIN Equip_Body INNER JOIN Equip_Head on Equip_Arm.SkillRankPoint1 + Equip_Body.SkillRankPoint1 + Equip_Head.SkillRankPoint1 > 12
    //select * from Equip_Arm , Equip_Body , Equip_Head where Equip_Arm.SkillRankPoint1 + Equip_Body.SkillRankPoint1 + Equip_Head.SkillRankPoint1 > 12 AND Equip_Arm.ID != Equip_Body.ID != Equip_Head.ID GROUP BY Equip_Arm.Name
    //select Equip_Arm.Name,Equip_Body.Name,Equip_Head.Name from Equip_Arm,Equip_Body,Equip_Head where Equip_Arm.SkillRankID1 = Equip_Body.SkillRankID1 AND Equip_Body.SkillRankID1 = Equip_Head.SkillRankID1 AND Equip_Head.SkillRankID1 = 56 AND  Equip_Arm.Occupatant <> 2 AND Equip_Body.Occupatant <> 2 AND Equip_Head.Occupatant <> 2
    //select Equip_Arm.Name from Equip_Arm INNER JOIN  Equip_Body INNER JOIN  Equip_Head on Equip_Arm.SkillRankID1 = Equip_Body.SkillRankID1 AND Equip_Body.SkillRankID1 = Equip_Head.SkillRankID1 AND Equip_Head.SkillRankID1 = 56 AND  Equip_Arm.Occupatant <> 2 AND Equip_Body.Occupatant <> 2 AND Equip_Head.Occupatant <> 2
    NSMutableArray * ar2r =[NSMutableArray array];
    //select a,b from test05 union all --一个的
    // select t1.a+t2.a,t1.b+','+t2.b from test05 t1,test05 t2 where t1.a<>t2.a union all --二个的
    // select t1.a+t2.a+t3.a,t1.b+','+t2.b+','+t3.b from test05 t1,test05 t2,test05 t3  where t1.a<>t2.a and t1.a<>t3.a and t2.a<>t3.a--三个的
    //select Name from Equip_Arm union all select t1.Name+t2.Name from Equip_Arm t1,Equip_Body t2 where t1.Name<>t2.Name union all select t1.Name+t2.Name+t3.Name from Equip_Arm t1,Equip_Body t2,Equip_Head t3  where t1.Name<>t2.Name and t1.Name<>t3.Name and t2.Name<>t3.Name and t1.ID = t2.ID and t2.ID = t3.ID and t3.ID = 56 and t1.Occupatant <> 2 AND t2.Occupatant <> 2 AND t3.Occupatant <> 2
    
    //select Equip_Arm.Name||','||Equip_Body.Name||','||Equip_Head.Name from Equip_Arm INNER JOIN Equip_Body INNER JOIN Equip_Head on Equip_Arm.SkillRankID1 = Equip_Body.SkillRankID1 AND Equip_Body.SkillRankID1 = Equip_Head.SkillRankID1 AND Equip_Head.SkillRankID1 = 56 AND  Equip_Arm.Occupatant <> 2 AND Equip_Body.Occupatant <> 2 AND Equip_Head.Occupatant <> 2
    
    //dr id ==3
    //hxs i d=55
    NSArray * skill =@[@"62"];
    NSMutableArray * deco =[NSMutableArray array];
    
    for (int i =0; i<skill.count; i++) {
        NSMutableArray * ar =[NSMutableArray array];
        [db executeStatements:[NSString stringWithFormat:@"select * from Deco where SkillRankID1 = %@ order by SkillRankPoint1 desc",skill[i]] withResultBlock:^int(NSDictionary *resultsDictionary) {
            [ar addObject:resultsDictionary];
            
            return 0;
        }];
        [deco addObject:ar];
        
    }
    
    NSArray *equip_Name = @[@"Equip_Arm",@"Equip_Body",@"Equip_Head",@"Equip_Leg",@"Equip_Wst"];
    for (int i =0; i<equip_Name.count; i++) {
        //        [db executeStatements:[NSString stringWithFormat:@"DROP INDEX index_name_%d",i]];
        //        [db executeStatements:[NSString stringWithFormat:@"CREATE INDEX table_index_name_%d",i]];
        
        [db executeStatements:[NSString stringWithFormat:@"CREATE TABLE %@_Test (ID int NOT NULL PRIMARY KEY,SkillNum int DEFAULT 0,Name varchar(255))",equip_Name[i]]];
        //                [db executeStatements:[NSString stringWithFormat:@"CREATE INDEX index_name_%d on %@_Test ( SkillNum )",i,equip_Name[i]]];
        //                [db executeStatements:[NSString stringWithFormat:@"CREATE INDEX table_index_name_%d ON %@_Test",i,equip_Name[i]]];
        
        
        [db executeStatements:[NSString stringWithFormat:@"select * from %@ where %@.Occupatant <>2 and %@.SlotNum >0",equip_Name[i],equip_Name[i],equip_Name[i]] withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            NSMutableDictionary * slotNums =[NSMutableDictionary dictionary];
            for (int i =0;i<skill.count;i++) {
                [slotNums setObject:[NSNumber numberWithInteger:0] forKey:skill[i]];
            }
            
            
            for (NSArray * de in deco) {
                if (de.count>0) {
                    for (NSDictionary * fillDeco in [self fillEquipSlotNum:[NSArray array] currentEquipSlotNum:[resultsDictionary[@"SlotNum"] integerValue] deco:de]) {
                        
                    }
                    
                }
                
            }
            NSString * skillID =@"3";
            //            NSPredicate * p =[NSPredicate predicateWithFormat:@"SkillRankID1 == %@ ",skillID];
            //            NSArray * slot = [deco filteredArrayUsingPredicate:p];
            //            NSInteger slotNum = [slotNums[i] integerValue];
            //            if (slot.count>0) {
            //                NSDictionary *slotDic =slot.firstObject;
            //                    slotNum += [slotDic[@"SkillRankPoint1"] integerValue];
            //
            //                if ([skill containsObject:slotDic[@"SkillRankID2"]]){
            //                    NSInteger i2= [skill indexOfObject:slotDic[@"SkillRankID2"]];
            //
            //                    NSInteger slotNum2 = [slotNums[i2] integerValue];
            //                    slotNum2 += [slotDic[@"SkillRankPoint2"] integerValue];
            //                    slotNums[i2] = [NSNumber numberWithInteger:slotNum2];
            //
            //                }
            //            }
            //                slotNums[i] = [NSNumber numberWithInteger:slotNum];
            
            if ([resultsDictionary[@"SkillRankID1"] isEqualToString:skillID]>0) {
                
                [db executeStatements:[NSString stringWithFormat:@"INSERT INTO %@_Test VALUES (%@,%ld,'%@')",equip_Name[i],resultsDictionary[@"ID"],[resultsDictionary[@"SkillRankPoint1"] integerValue] ,resultsDictionary[@"Name"]]];
                
            }else if ([resultsDictionary[@"SkillRankID2"] isEqualToString:skillID]>0) {
                
                [db executeStatements:[NSString stringWithFormat:@"INSERT INTO %@_Test VALUES (%@,%ld,'%@')",equip_Name[i],resultsDictionary[@"ID"],[resultsDictionary[@"SkillRankPoint2"] integerValue] ,resultsDictionary[@"Name"]]];
                
            }else if ([resultsDictionary[@"SkillRankID3"] isEqualToString:skillID]>0) {
                
                [db executeStatements:[NSString stringWithFormat:@"INSERT INTO %@_Test VALUES (%@,%ld,'%@')",equip_Name[i],resultsDictionary[@"ID"],[resultsDictionary[@"SkillRankPoint3"] integerValue] ,resultsDictionary[@"Name"]]];
                
            }else if ([resultsDictionary[@"SkillRankID4"] isEqualToString:skillID]>0) {
                
                [db executeStatements:[NSString stringWithFormat:@"INSERT INTO %@_Test VALUES (%@,%ld,'%@')",equip_Name[i],resultsDictionary[@"ID"],[resultsDictionary[@"SkillRankPoint4"] integerValue] ,resultsDictionary[@"Name"]]];
                
            }else if ([resultsDictionary[@"SkillRankID5"] isEqualToString:skillID]>0) {
                
                [db executeStatements:[NSString stringWithFormat:@"INSERT INTO %@_Test VALUES (%@,%ld,'%@')",equip_Name[i],resultsDictionary[@"ID"],[resultsDictionary[@"SkillRankPoint5"] integerValue] ,resultsDictionary[@"Name"]]];
                
            }else{
                //   [db executeStatements:[NSString stringWithFormat:@"INSERT INTO %@_Test VALUES (%@,%@,'%@')",equip_Name[i],resultsDictionary[@"ID"],@"0",resultsDictionary[@"Name"]]];
                
            }
            
            return 0;
        }];
        
    }
    
    uint64_t begin = mach_absolute_time();
    
    [db executeStatements:@"select Equip_Arm_Test.Name||','||Equip_Body_Test.Name||','||Equip_Head_Test.Name||','||Equip_Leg_Test.Name||','||Equip_Wst_Test.Name from Equip_Arm_Test,Equip_Body_Test,Equip_Head_Test,Equip_Leg_Test,Equip_Wst_Test where (Equip_Arm_Test.SkillNum+Equip_Body_Test.SkillNum+Equip_Head_Test.SkillNum+Equip_Leg_Test.SkillNum+Equip_Wst_Test.SkillNum) >= 10" withResultBlock:^int(NSDictionary *dictionary) {
        // NSLog(@"%@,%@",dictionary[@"Name"],dictionary[@"SkillRankPoint1"]);
        [ar2r addObject:dictionary];
        return 0;
    }];
    NSLog(@"%ld",ar2r.count);
    
    uint64_t end = mach_absolute_time();
    NSLog(@"Time taken to doSomething %g s",
          MachTimeToSecs(end - begin));
    
    for (int i =0; i<equip_Name.count; i++) {
        [db executeStatements:[NSString stringWithFormat:@"DROP TABLE %@_Test",equip_Name[i]]];
    }
    self.arm =[NSMutableArray array];
    [db executeStatements:@"SELECT * FROM Equip_Arm" withResultBlock:^int(NSDictionary *dictionary) {
        NSMutableDictionary *d= [dictionary mutableCopy];
        [d setObject:@"1" forKey:@"Equip_Type"];
        [self.arm addObject:d];
        
        return 0;
    }];
    
    self.body =[NSMutableArray array];
    [db executeStatements:@"SELECT * FROM Equip_Body" withResultBlock:^int(NSDictionary *dictionary) {
        NSMutableDictionary *d= [dictionary mutableCopy];
        [d setObject:@"2" forKey:@"Equip_Type"];
        [self.body addObject:dictionary];
        
        return 0;
    }];
    
    self.head =[NSMutableArray array];
    [db executeStatements:@"SELECT * FROM Equip_Head" withResultBlock:^int(NSDictionary *dictionary) {
        NSMutableDictionary *d= [dictionary mutableCopy];
        [d setObject:@"3" forKey:@"Equip_Type"];
        [self.head addObject:dictionary];
        
        return 0;
    }];
    
    self.leg =[NSMutableArray array];
    [db executeStatements:@"SELECT * FROM Equip_Leg" withResultBlock:^int(NSDictionary *dictionary) {
        NSMutableDictionary *d= [dictionary mutableCopy];
        [d setObject:@"4" forKey:@"Equip_Type"];
        [self.leg addObject:dictionary];
        
        return 0;
    }];
    
    self.wst =[NSMutableArray array];
    [db executeStatements:@"SELECT * FROM Equip_Wst" withResultBlock:^int(NSDictionary *dictionary) {
        NSMutableDictionary *d= [dictionary mutableCopy];
        [d setObject:@"5" forKey:@"Equip_Type"];
        [self.wst addObject:dictionary];
        
        return 0;
    }];
    
    self.skill =[NSMutableArray array];
    [db executeStatements:@"SELECT * FROM Skill" withResultBlock:^int(NSDictionary *dictionary) {
        [self.skill addObject:dictionary];
        
        return 0;
    }];
    
    self.skillRank =[NSMutableArray array];
    [db executeStatements:@"SELECT * FROM SkillRank" withResultBlock:^int(NSDictionary *dictionary) {
        [self.skillRank addObject:dictionary];
        
        return 0;
    }];
    self.deco =[NSMutableArray array];
    [db executeStatements:@"SELECT * FROM Deco" withResultBlock:^int(NSDictionary *dictionary) {
        [self.deco addObject:dictionary];
        
        return 0;
    }];
    
    
    
}

- (NSArray*)fillEquipSlotNum:(NSArray*)currentSlotdeco currentEquipSlotNum:(NSInteger)currentEquipSlotNum deco:(NSArray*)deco{
    if (currentEquipSlotNum == 0) {
        return currentSlotdeco;
    }
    
    NSMutableArray * newCurrentSlotdeco  =[currentSlotdeco mutableCopy];
    for (NSDictionary * de in deco) {
        if (currentEquipSlotNum >= [de[@"SlotNum"] integerValue]) {
            [newCurrentSlotdeco addObject:de];
            return [self fillEquipSlotNum:newCurrentSlotdeco currentEquipSlotNum:currentEquipSlotNum-[de[@"SlotNum"] integerValue] deco:deco];
        }
    }
    
    
    
    return 0;
}

- (void)test2{
    
    NSArray * skill = @[@"3",@"208",@"94"];
    
    NSDictionary * extra =@{@"3":@"7",@"94":@"5"};
    
    FMDatabase *db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"db"]];
    
    [db open];
    //    FMResultSet *set = [db executeQuery:@"select Equip_Arm.*,Equip_Body.* from Equip_Arm , Equip_Body where Equip_Arm.ID = Equip_Body.ID"];
    //    if ([set next]) {
    //      NSArray * d = [set resultArrayWithCount:2];
    //        NSLog(@"%@",d);
    //    }
    //    NSString *searchText = @"Select Equip_Arm.*,Equip_Body.* From Equip_Arm , Equip_Body where Equip_Arm.ID = Equip_Body.ID";
    //    NSError *error = NULL;
    //    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^select(\\s|\\S)+from" options:NSRegularExpressionCaseInsensitive error:&error];
    //    NSTextCheckingResult *result2 = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    //    if (result2) {
    //        NSLog(@"%@\n", [searchText substringWithRange:result2.range]);
    //    }
    
    
    
    NSMutableArray * skillReques =[NSMutableArray array];
    
    for (int i =0; i<skill.count; i++) {
        FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"select * from Skill where ID = %@ ",skill[i]]];
        if ([set next]) {
            [skillReques addObject:set.resultDictionary];
        }
        
    }
    
    NSMutableDictionary * decos =[NSMutableDictionary dictionary];
    
    for (int i =0; i<skillReques.count; i++) {
        NSMutableArray * ar =[NSMutableArray array];
        [db executeStatements:[NSString stringWithFormat:@"select * from Deco where SkillRankID1 = %@ order by SkillRankPoint1 desc",skillReques[i][@"SkillRankID"]] withResultBlock:^int(NSDictionary *resultsDictionary) {
            [ar addObject:resultsDictionary];
            
            return 0;
        }];
        [decos setObject:ar forKey: skillReques[i][@"SkillRankID"]];
        
    }
    
    
    NSArray *equip_Name = @[@"Equip_Arm",@"Equip_Body",@"Equip_Head",@"Equip_Leg",@"Equip_Wst"];
    
    NSString * condition = @"";
    for (int i =0;i<equip_Name.count;i++) {
        NSString *equipName = equip_Name[i];
        
        
        NSString * condition2 = @"";
        
        for (int i2 =0;i2<skillReques.count;i2++) {
            NSString *skillID = skillReques[i2][@"SkillRankID"];
            NSString * or =@"";
            if (i2>0) {
                or =@" or ";
            }
            condition2 =[NSString stringWithFormat:@"%@%@((%@.SkillRankID1 = %@ and %@.SkillRankPoint1>0 ) OR (%@.SkillRankID2 = %@ and %@.SkillRankPoint2>0 ) OR (%@.SkillRankID3 =%@ and %@.SkillRankPoint3>0 ) OR (%@.SkillRankID4 =%@ and %@.SkillRankPoint4>0 )  OR (%@.SkillRankID5 =%@ and %@.SkillRankPoint5>0 ) )",condition2,or,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName,equipName,skillID,equipName];
        }
        NSString * and =@"";
        if (i>0) {
            and =@" and ";
        }
        
        condition =[NSString stringWithFormat:@"%@%@((%@) and %@.Occupatant  =1)",condition,and,condition2,equipName];
    }
    NSString * sql =[NSString stringWithFormat:@"SELECT Equip_Arm.*,Equip_Body.*,Equip_Head.*,Equip_Leg.*,Equip_Wst.* from Equip_Arm,Equip_Body,Equip_Head,Equip_Leg,Equip_Wst where %@",condition];
    
    NSMutableArray * result =[NSMutableArray array];
    
    //    NSArray *three = @[ @[@"3"] , @[@"1",@"2"] , @[@"1",@"1",@"1"] ];
    //    NSArray *two = @[ @[@"2"] , @[@"1",@"1"]  ];
    //    NSArray *one = @[ @[@"1"] ];
    
    
    
//     [db executeStatements:sql withResultBlock:^int(NSDictionary *dictionary) {
//     
//     NSArray * ids =[[dictionary allValues].lastObject componentsSeparatedByString:@","];
//     
//     NSMutableArray * slotVacant=[NSMutableArray array];
//     
//     EquipSetModel * model = [[EquipSetModel alloc] init];
//     for (int i =0; i<ids.count; i++) {
//     FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where ID = %@",equip_Name[i],ids[i]]];
//     if ([set next]) {
//     [model setValue:[set resultDictionary] forKey:equip_Name[i]];
//     [slotVacant addObject:[[set resultDictionary][@"SlotNum"]stringValue]];
//     }
//     
//     }
    
    
    //**********************
    FMResultSet *set = [db executeQuery:sql];
    while ([set next]) {
        
        NSArray * resul = [set resultArrayWithCount:5];
        NSMutableArray * slotVacant=[NSMutableArray array];
        EquipSetModel * model = [[EquipSetModel alloc] init];
        
        for (int i =0; i<resul.count; i++) {
            NSDictionary* dictionary = resul[i];
            
            [model setValue:dictionary forKey:equip_Name[i]];
            [slotVacant addObject:[dictionary[@"SlotNum"]stringValue]];
        }
        NSSortDescriptor *sortDescriptorSlotVacant = [[NSSortDescriptor alloc] initWithKey:@"" ascending:NO];
        NSArray *sortDescriptorSlotVacants = [[NSArray alloc] initWithObjects:&sortDescriptorSlotVacant count:1];
        [slotVacant sortUsingDescriptors:sortDescriptorSlotVacants];
        //**********************
        
        //        NSSortDescriptor *sortDescriptorSlotVacant = [[NSSortDescriptor alloc] initWithKey:@"" ascending:NO];
        //        NSArray *sortDescriptorSlotVacants = [[NSArray alloc] initWithObjects:&sortDescriptorSlotVacant count:1];
        //        [slotVacant sortUsingDescriptors:sortDescriptorSlotVacants];
        
        NSMutableArray * differenceskillRange = [NSMutableArray array];
        
        for (int o =0; o <skillReques.count; o++) {
            
            NSInteger skillValue =0;
            
            for (int i = 0; i<equip_Name.count; i++) {
                
                
                if ([[[model valueForKey:equip_Name[i]][@"SkillRankID1"]stringValue] isEqualToString:[skillReques[o][@"SkillRankID"]stringValue]]) {
                    
                    skillValue += [[model valueForKey:equip_Name[i]][@"SkillRankPoint1"] integerValue];
                    
                }else if ([[[model valueForKey:equip_Name[i]][@"SkillRankID2"]stringValue] isEqualToString:[skillReques[o][@"SkillRankID"]stringValue]]) {
                    
                    skillValue += [[model valueForKey:equip_Name[i]][@"SkillRankPoint2"] integerValue];
                    
                }else if ([[[model valueForKey:equip_Name[i]][@"SkillRankID3"]stringValue] isEqualToString:[skillReques[o][@"SkillRankID"]stringValue]]) {
                    
                    skillValue += [[model valueForKey:equip_Name[i]][@"SkillRankPoint3"] integerValue];
                    
                }else if ([[[model valueForKey:equip_Name[i]][@"SkillRankID4"]stringValue] isEqualToString:[skillReques[o][@"SkillRankID"]stringValue]]) {
                    
                    skillValue += [[model valueForKey:equip_Name[i]][@"SkillRankPoint4"] integerValue];
                    
                }else if ([[[model valueForKey:equip_Name[i]][@"SkillRankID5"]stringValue] isEqualToString:[skillReques[o][@"SkillRankID"]stringValue]]) {
                    skillValue += [[model valueForKey:equip_Name[i]][@"SkillRankPoint5"] integerValue];
                    
                    
                }else{
                    
                }
                
            }
            if (extra[[skillReques[o][@"ID"]stringValue]]) {
                skillValue +=[extra[[skillReques[o][@"ID"]stringValue]] integerValue];
            }
            
            //拿到技能点的差值
            // if (skillValue<[skillReques[o][@"SkillRankPoint"]integerValue]) {
            [differenceskillRange addObject:[@{@"SkillID":skillReques[o][@"SkillRankID"],@"SkillPoint":@([skillReques[o][@"SkillRankPoint"]integerValue]-skillValue)}mutableCopy]];
            //  }
            
            
            
        }
        
        
        //        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"SkillPoint" ascending:NO];
        //        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
        //        [differenceskillRange sortUsingDescriptors:sortDescriptors];
        //        if ([[model.Equip_Arm[@"ID"] stringValue] isEqualToString:@"106"]&&[[model.Equip_Body[@"ID"] stringValue] isEqualToString:@"120"]&&[[model.Equip_Head[@"ID"] stringValue] isEqualToString:@"120"]&&[[model.Equip_Leg[@"ID"] stringValue] isEqualToString:@"120"]&&[[model.Equip_Wst[@"ID"] stringValue] isEqualToString:@"106"]) {
        //
        //        }
        NSArray * useDeco= [self test:slotVacant  skillPoint:differenceskillRange deco:decos useDeco:[NSMutableArray new]];
        if (useDeco.count>0) {
            //            NSMutableDictionary * dic =[dictionary mutableCopy];
            //            [dic setObject:useDeco forKey:@"useDeco"];
            [result addObject:@{@"set":model,@"useDeco":useDeco}];
            
        }
        // return 0;
        //}];
    }
    
}
- (void)asda{
    //    000 -> {'3' ,'1,2','1,1,1' };
    //    00  -> {'2','1,1'};
    //    0   -> {'1'};
    //    00  -> {'2','1,1'};
}
- (NSArray*)test:(NSMutableArray*)slotVacant skillPoint:(NSMutableArray*)differenceskillRange deco:(NSDictionary*)allDeco useDeco:(NSMutableArray*)useDeco{
    //计算出所有deco中最大SlotNum的最小值
    
    //-- 000 00 00 000 6 2 4 1
    //-- --- 00 00 000 4 2 1 1
    //-- --- --- 00 000 2 1 1 1
    
    //-- 00 00 00 000 6 6 1
    //-- 00 00 00 --- 6 1 1
    //-- -- 00 00 --- 3 1 1
    //-- -- -- 00 --- 1 1
    
    
    //00 0 0 0 0   7
    
    
    if (slotVacant.count==0 && [differenceskillRange.firstObject[@"SkillPoint"] integerValue]>0) {
        return nil;
    }
    
    if ([[differenceskillRange.firstObject objectForKey:@"SkillPoint"] integerValue] == 0) {
        return useDeco;
    }
    
    NSArray * ar =allDeco[differenceskillRange.firstObject[@"SkillID"]];
    NSInteger count =[ar count];
    for (int i =0;i<count;i++){
        NSDictionary * deco =[ar objectAtIndex:i];
        
        //for (NSDictionary * deco in allDeco[differenceskillRange.firstObject[@"SkillID"]]) {
        NSInteger skillPoint = [[differenceskillRange.firstObject objectForKey:@"SkillPoint"] integerValue];
        //point 是相差的point
        NSInteger point =skillPoint-[deco[@"SkillRankPoint1"] integerValue];
        NSPredicate * p =[NSPredicate predicateWithFormat:@"SkillID == %ld ",[deco[@"SkillRankID2"] integerValue]];
        NSArray * skillRankID2 = [differenceskillRange filteredArrayUsingPredicate:p];
        
        if (point>=0) {
            if ([slotVacant containsObject:deco[@"SlotNum"]]) {
                //                [slotVacant removeObject:deco[@"SlotNum"]];
                NSInteger removeIndex = 0;
                for (int i =0;i<slotVacant.count;i++) {
                    NSString * str= slotVacant[i];
                    if ([str isEqualToString:deco[@"SlotNum"]]) {
                        removeIndex = i;
                        break;
                    }
                }
                [slotVacant removeObjectAtIndex:removeIndex];
                
                [useDeco addObject:deco];
                if (skillRankID2.count>0) {
                    //point 是珠宝的第二技能点
                    NSInteger point2 =[[skillRankID2.firstObject objectForKey:@"SkillPoint"] integerValue]-[deco[@"SkillRankPoint2"] integerValue];
                    [skillRankID2.firstObject setObject:@(point2) forKey:@"SkillPoint"];
                }
                
                [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];
                NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"SkillPoint" ascending:NO];
                NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
                [differenceskillRange sortUsingDescriptors:sortDescriptors];
                return [self test:slotVacant skillPoint:differenceskillRange deco:allDeco useDeco:useDeco];
                
            }else{
                NSInteger slotNum = [slotVacant.firstObject integerValue] - [deco[@"SlotNum"] integerValue];
                if (slotNum>=0) {
                    //  if ([slotVacant containsObject:deco[@"SlotNum"]]) {
                    [slotVacant removeObjectAtIndex:0];
                    if (slotNum>0) {
                        [slotVacant addObject:[NSString stringWithFormat:@"%ld",(long)slotNum]];
                        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"" ascending:NO];
                        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
                        [slotVacant sortUsingDescriptors:sortDescriptors];
                        
                    }
                    [useDeco addObject:deco];
                    if (skillRankID2.count>0) {
                        //point 是珠宝的第二技能点
                        NSInteger point2 =[[skillRankID2.firstObject objectForKey:@"SkillPoint"] integerValue]-[deco[@"SkillRankPoint2"] integerValue];
                        [skillRankID2.firstObject setObject:@(point2) forKey:@"SkillPoint"];
                    }
                    [differenceskillRange.firstObject setObject:@(point) forKey:@"SkillPoint"];
                    if (differenceskillRange.count>0) {
                        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"SkillPoint" ascending:NO];
                        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
                        [differenceskillRange sortUsingDescriptors:sortDescriptors];
                    }
                    
                    return [self test:slotVacant skillPoint:differenceskillRange deco:allDeco useDeco:useDeco];
                }
                
            }
        }
    }
    
    
    return 0;
}
- (void)serch:(NSString*)skillID{
    
    //  NSPredicate *skillRankPredicate =[NSPredicate predicateWithFormat:@"ID == %@",skillID];
    //NSArray * arr =[self.skillRank filteredArrayUsingPredicate:skillRankPredicate];
    
    //    NSMutableArray * arr =[NSMutableArray arrayWithArray:self.arm];
    //    [arr addObjectsFromArray:self.body];
    //    [arr addObjectsFromArray:self.head];
    //    [arr addObjectsFromArray:self.leg];
    //    [arr addObjectsFromArray:self.wst];
    //    NSPredicate *skillRankPredicate =[NSPredicate predicateWithFormat:@"ID == %@",skillID];
    //    NSArray * arr =[self.skillRank filteredArrayUsingPredicate:skillRankPredicate];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

 
 
 */