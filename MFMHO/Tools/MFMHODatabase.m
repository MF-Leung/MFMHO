//
//  MHODatabase.m
//  MHO
//
//  Created by feiquanqiu on 16/2/3.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHODatabase.h"
static MFMHODatabase *database;

@implementation MFMHODatabase
+(MFMHODatabase*)instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database = [[MFMHODatabase alloc] init];
        database.db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"db"]];
        [database.db open];

    });
    return database;
}
@end
