//
//  AppDelegate.m
//  MHO
//
//  Created by feiquanqiu on 16/2/3.
//  Copyright © 2016年 feiquanqiu. All rights reserved.
//

#import "MFMHOAppDelegate.h"

@interface MFMHOAppDelegate ()
@end

@implementation MFMHOAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    NSMutableArray * arr =[NSMutableArray array];
    
    [arr addObject:@{@"a":@5}];
    [arr addObject:@{@"a":@2}];
    [arr addObject:@{@"a":@3}];
    [arr addObject:@{@"a":@3}];
    [arr addObject:@{@"a":@1}];

    [self quickSortWithArray:arr left:0 right:4 key:@"a"];
    
       
        // Override point for customization after application launch.
    return YES;
}
-(void)quickSortWithArray:(NSMutableArray *)aData left:(NSInteger)left right:(NSInteger)right key:(NSString*)key{
    if (right > left) {
        NSInteger i = left;
        NSInteger j = right + 1;
        while (true) {
            while (i+1 < [aData count] && [[aData objectAtIndex:++i][key] integerValue] < [[aData objectAtIndex:left][key]integerValue]) ;
            while (j-1 > -1 && [[aData objectAtIndex:--j][key]integerValue] > [[aData objectAtIndex:left][key]integerValue]) ;
            if (i >= j) {
                break;
            }
            [self swapWithData:aData index1:i index2:j];
        }
        [self swapWithData:aData index1:left index2:j];
        [self quickSortWithArray:aData left:left right:j-1 key:key];
        [self quickSortWithArray:aData left:j+1 right:right key:key];
    }
}
-(void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2{
    id tmp = [aData objectAtIndex:index1];
    [aData replaceObjectAtIndex:index1 withObject:[aData objectAtIndex:index2]];
    [aData replaceObjectAtIndex:index2 withObject:tmp];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
