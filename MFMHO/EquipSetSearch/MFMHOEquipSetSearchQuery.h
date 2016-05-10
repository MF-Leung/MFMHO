//
//  EquipSetSearchQuery.h
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFMHOSkillStoneModel.h"
#import "MFMHOEquipSetSearchResultModel.h"
#define EQUIPSETSEARCHPAGE_COUNT 10

typedef NS_ENUM(NSInteger,EquipSetSearchQueryOccupatant){
    EquipSetSearchQueryOccupatantMelee =0,
    EquipSetSearchQueryOccupatantRange =1
};

@interface MFMHOEquipSetSearchQuery : NSObject

- (void)stop;
@property (strong, nonatomic)NSArray<MFMHOSkillModel *> *skills;

@property (strong, nonatomic)MFMHOSkillStoneModel *skillStone;

@property (nonatomic)BOOL isPassElementary;

@property (nonatomic)EquipSetSearchQueryOccupatant occupatant;

- (void)searchWithHandle:(void(^)(MFMHOEquipSetSearchResultModel* model))handle nextBlock:(void(^)(NSInteger resultIndex,NSInteger resultCount))nextBlock;

@property (strong, nonatomic,readonly) NSMutableArray *resultSet;

- (NSArray *)searchNextPage;
@end
