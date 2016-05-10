
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define NUMBER_TO_STR(num) [@(num) stringValue]
#define kWinSize [UIScreen mainScreen].bounds.size

#define NSARRAY_EQUIP_MODEL_NAME_KEYS [NSArray arrayWithObjects: @"arm",@"body",@"head",@"leg",@"wst", nil];

#define NSARRAY_EQUIP_TABLE_NAME_KEYS [NSArray arrayWithObjects: @"Equip_Arm",@"Equip_Body",@"Equip_Head",@"Equip_Leg",@"Equip_Wst", nil]
