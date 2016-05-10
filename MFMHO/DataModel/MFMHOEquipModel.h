//
//  EquipModel.h
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFMHOEquipModel : NSObject
@property (copy,nonatomic)NSNumber *ID;

@property (copy,nonatomic)NSString *Name;

@property (copy,nonatomic)NSNumber *UseSex;

@property (copy,nonatomic)NSNumber *RareLevel;

@property (copy,nonatomic)NSNumber *SlotNum;

@property (copy,nonatomic)NSNumber *TimeGet;

@property (copy,nonatomic)NSNumber *OriginDef;

@property (copy,nonatomic)NSNumber *FinalDef;

@property (copy,nonatomic)NSNumber *ResFire;

@property (copy,nonatomic)NSNumber *ResWater;

@property (copy,nonatomic)NSNumber *ResBold;

@property (copy,nonatomic)NSNumber *ResIce;

@property (copy,nonatomic)NSNumber *ResDragon;

@property (copy,nonatomic)NSNumber *SkillRankID1;

@property (copy,nonatomic)NSNumber *SkillRankPoint1;

@property (copy,nonatomic)NSNumber *SkillRankID2;

@property (copy,nonatomic)NSNumber *SkillRankPoint2;

@property (copy,nonatomic)NSNumber *SkillRankID3;

@property (copy,nonatomic)NSNumber *SkillRankPoint3;

@property (copy,nonatomic)NSNumber *SkillRankID4;

@property (copy,nonatomic)NSNumber *SkillRankPoint4;

@property (copy,nonatomic)NSNumber *SkillRankID5;

@property (copy,nonatomic)NSNumber *SkillRankPoint5;

@property (copy,nonatomic)NSNumber *MaterialID1;

@property (copy,nonatomic)NSNumber *MaterialNum1;

@property (copy,nonatomic)NSNumber *MaterialID2;

@property (copy,nonatomic)NSNumber *MaterialNum2;

@property (copy,nonatomic)NSNumber *MaterialID3;

@property (copy,nonatomic)NSNumber *MaterialNum3;

@property (copy,nonatomic)NSNumber *MaterialID4;

@property (copy,nonatomic)NSNumber *MaterialNum4;

@property (copy,nonatomic)NSNumber *Occupatant;

@property (strong, nonatomic)NSArray<MFMHODecoModel *> *useDecos;

@end
