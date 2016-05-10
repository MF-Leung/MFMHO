//
//  SkillStoneModel.m
//  MHO
//
//  Created by feiquanqiu on 16/2/6.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOSkillStoneModel.h"

@implementation MFMHOSkillStoneModel
- (instancetype)init{
    if (self =[super init]) {
        FMDatabase *db =[MFMHODatabase instance].db;
        
        [db executeStatements:@"SELECT * FROM SkillRank WHERE ID = 1 OR ID = 2" withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            MFMHOSkillRankModel * skillRankModel =[MFMHOSkillRankModel objectWithKeyValues:resultsDictionary];
            
            if (!self.skill1) {
                self.skill1 =skillRankModel;
            }else if (!self.skill2){
                self.skill2 =skillRankModel;
            }
            
            return 0;
        }];
        
        self.type =SkillStoneTypeDragon;
        
    }
    return self;
}
- (void)setType:(SkillStoneType)type{
    _type =type;
    _name =[MFMHOSkillStoneModel skillStoneNameWithType:type];
   // [self setValue:name forKey:@"name"];
}

+ (NSString* )skillStoneNameWithType:(SkillStoneType)type{
    switch (type) {
        case 0:
            return @"龙之护石";
            break;
        case 1:
            return @"女王护石";
            break;
        case 2:
            return @"骑士护石";
            break;
        case 3:
            return @"斗士护石";
            break;
        case 4:
            return @"士兵护石";
            break;
        default:
            return @"";
            break;
    }
}
@end
