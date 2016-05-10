
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define NUMBER_TO_STR(num) [@(num) stringValue]
#define kWinSize [UIScreen mainScreen].bounds.size




