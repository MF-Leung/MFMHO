//
//  EquipSetSearchResultModel.h
//  MHO
//
//  Created by feiquanqiu on 16/2/5.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFMHOEquipSetSearchResultModel : NSObject

@property(strong, nonatomic)MFMHOEquipModel *head;

@property(strong, nonatomic)MFMHOEquipModel *body;

@property(strong, nonatomic)MFMHOEquipModel *arm;

@property(strong, nonatomic)MFMHOEquipModel *wst;

@property(strong, nonatomic)MFMHOEquipModel *leg;

//@property(strong, nonatomic)NSArray<DecoModel *> *useDecos;

@end

