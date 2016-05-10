//
//  SkillStoneModel.h
//  MHO
//
//  Created by feiquanqiu on 16/2/6.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SkillStoneType){
     SkillStoneTypeDragon,
    SkillStoneTypeQueen,
    SkillStoneTypeKnight,
    SkillStoneTypeFighters,
    SkillStoneTypeSoldier
};

@interface MFMHOSkillStoneModel : NSObject

@property (strong, nonatomic)MFMHOSkillRankModel *skill1;

@property (strong, nonatomic)MFMHOSkillRankModel *skill2;

@property (nonatomic)NSInteger skillPoint1;

@property (nonatomic)NSInteger skillPoint2;

@property (copy, nonatomic,readonly)NSString *name;

@property (nonatomic)SkillStoneType type;

+ (NSString* )skillStoneNameWithType:(SkillStoneType)type;
@end
