//
//  EquipSetLayoutSkillDetailModel.h
//  MHO
//
//  Created by feiquanqiu on 16/3/7.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFMHOEquipSetSearchResultModel.h"
#import "MFMHOSkillStoneModel.h"
@interface MFMHOEquipSetLayoutSkillDetailModel : NSObject

//@property (copy, nonatomic) NSString *skillName;
//
//@property (copy, nonatomic) NSNumber *skillRankID;

@property (strong, nonatomic) MFMHOSkillRankModel *skillRank;

@property ( nonatomic) NSInteger bodyPoint;
@property ( nonatomic) NSInteger armPoint;
@property ( nonatomic) NSInteger headPoint;
@property ( nonatomic) NSInteger legPoint;
@property ( nonatomic) NSInteger wstPoint;
@property ( nonatomic) NSInteger skillStonePoint;
@property ( nonatomic) NSInteger totalPoint;
+ (NSArray<MFMHOEquipSetLayoutSkillDetailModel*> *)initWithEquipSetSearchResult:(MFMHOEquipSetSearchResultModel*)result withSkillStone:(MFMHOSkillStoneModel*)skillStone;
@end
