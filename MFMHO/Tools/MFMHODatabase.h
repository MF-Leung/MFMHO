//
//  MHODatabase.h
//  MHO
//
//  Created by feiquanqiu on 16/2/3.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFMHODatabase : NSObject
+(MFMHODatabase*)instance;
@property (strong,nonatomic)FMDatabase *db;
@end
