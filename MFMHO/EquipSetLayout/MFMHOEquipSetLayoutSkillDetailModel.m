//
//  EquipSetLayoutSkillDetailModel.m
//  MHO
//
//  Created by feiquanqiu on 16/3/7.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOEquipSetLayoutSkillDetailModel.h"

@implementation MFMHOEquipSetLayoutSkillDetailModel

+ (MFMHOEquipSetLayoutSkillDetailModel *)extracted_method:(NSNumber *)skillRankID skillDetails:(NSMutableArray *)skillDetails {
    MFMHOEquipSetLayoutSkillDetailModel *skillDetail;
    for (MFMHOEquipSetLayoutSkillDetailModel*skillDetail_f in skillDetails) {
        if ([skillDetail_f.skillRank.ID isEqualToNumber:skillRankID]) {
            skillDetail =skillDetail_f;
            break;
            
        }
        
    }
    
    if (!skillDetail&&skillRankID.integerValue>0) {
        skillDetail =[[MFMHOEquipSetLayoutSkillDetailModel alloc] init];
        
        FMDatabase *db =[MFMHODatabase instance].db;
        
        [db executeStatements:[NSString stringWithFormat:@"SELECT * FROM SkillRank where ID = %@",skillRankID] withResultBlock:^int(NSDictionary *resultsDictionary) {
            
            skillDetail.skillRank =[MFMHOSkillRankModel objectWithKeyValues:resultsDictionary];
            
            return 1;
        }];
        
        [skillDetails addObject:skillDetail];
        
    }
    return skillDetail;
}

+ (NSArray<MFMHOEquipSetLayoutSkillDetailModel*> *)initWithEquipSetSearchResult:(MFMHOEquipSetSearchResultModel*)result withSkillStone:(MFMHOSkillStoneModel *)skillStone{
    
    NSMutableArray *skillDetails =[NSMutableArray array];
    
    NSArray *equipModelNameKeys =NSARRAY_EQUIP_MODEL_NAME_KEYS;

    for (int equip_i =0; equip_i<equipModelNameKeys.count; equip_i++) {
        NSString *key= equipModelNameKeys[equip_i];
        MFMHOEquipModel *equip =[result valueForKey:key];
    
        for (int skillRank_i =1; skillRank_i<=5; skillRank_i++) {
            
            NSInteger point =[[equip valueForKey:[NSString stringWithFormat:@"SkillRankPoint%d",skillRank_i]] integerValue];
            NSNumber *skillRankID =[equip valueForKey:[NSString stringWithFormat:@"SkillRankID%d",skillRank_i]];
            
            MFMHOEquipSetLayoutSkillDetailModel *skillDetail;
            skillDetail = [self extracted_method:skillRankID skillDetails:skillDetails];
            switch (equip_i) {
                case 0:
                    skillDetail.armPoint +=point;
                    break;
                case 1:
                    skillDetail.bodyPoint +=point;

                    break;
                case 2:
                    skillDetail.headPoint +=point;

                    break;
                case 3:
                    skillDetail.legPoint +=point;

                    break;
                case 4:
                    skillDetail.wstPoint +=point;

                    break;
                default:
                    break;
            }
           
        }
        
        for (MFMHODecoModel *deco in equip.useDecos) {
            for (int i =1; i<=2; i++) {
                NSNumber *skillRankID =[deco valueForKey:[NSString stringWithFormat:@"SkillRankID%d",i]];
                MFMHOEquipSetLayoutSkillDetailModel *skillDetail =[self extracted_method:skillRankID skillDetails:skillDetails];
                switch (equip_i) {
                    case 0:
                        skillDetail.armPoint +=[self decoPoint:deco skillRankID:skillRankID];
                        break;
                    case 1:
                        skillDetail.bodyPoint +=[self decoPoint:deco skillRankID:skillRankID];
                        
                        break;
                    case 2:
                        skillDetail.headPoint +=[self decoPoint:deco skillRankID:skillRankID];
                        
                        break;
                    case 3:
                        skillDetail.legPoint +=[self decoPoint:deco skillRankID:skillRankID];
                        
                        break;
                    case 4:
                        skillDetail.wstPoint +=[self decoPoint:deco skillRankID:skillRankID];
                        
                        break;
                    default:
                        break;
                }
            }
          
        }
        
    }
    
    for (MFMHOEquipSetLayoutSkillDetailModel *skillDetail in skillDetails) {
        skillDetail.totalPoint =skillDetail.armPoint+skillDetail.bodyPoint+skillDetail.headPoint+skillDetail.legPoint+skillDetail.wstPoint;
        
       
        
        if ([skillDetail.skillRank.ID isEqualToNumber:skillStone.skill1.ID]) {
            skillDetail.skillStonePoint +=skillStone.skillPoint1;
            skillDetail.totalPoint +=skillDetail.skillStonePoint;
        }
        if ([skillDetail.skillRank.ID isEqualToNumber:skillStone.skill2.ID]) {
            skillDetail.skillStonePoint +=skillStone.skillPoint2;
            skillDetail.totalPoint +=skillDetail.skillStonePoint;

        }
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"totalPoint" ascending:NO];
    [skillDetails sortUsingDescriptors:@[sortDescriptor]];
    return [NSArray arrayWithArray:skillDetails];
}

+ (NSInteger)decoPoint:(MFMHODecoModel *)deco skillRankID:(NSNumber*)skillRankID{
    NSInteger point =0;
    if (!skillRankID) {
        return 0;
    }

        if ([deco.SkillRankID1 isEqualToNumber:skillRankID]) {
            point +=[deco.SkillRankPoint1 integerValue];
        }else if ([deco.SkillRankID2 isEqualToNumber:skillRankID]){
            point +=[deco.SkillRankPoint2 integerValue];
            
        }
    
    return point;
}
@end
