//
//  Common.h
//  ShareSomething
//
//  Created by dev on 14-10-14.
//  Copyright (c) 2014年 Today. All rights reserved.
/*
 Appkey: 3cfed812616c
 
 App Secret: c82efd18ff9225a2b74bd7fb0f7c74bc
 */

#import <Foundation/Foundation.h>
#import "UIView+Common.h"

#define SHARE_APPKEY    @"3cfed812616c"

#define BUNDLE_NAME @"Resource"

#define IMAGE_NAME @"sharesdk_img"
#define IMAGE_EXT @"jpg"

#define IOS6                        (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
#define SCREEN_HEIGHT               (([UIScreen mainScreen].bounds.size.height) - (IOS6?20:0))    //屏幕高度
#define SCREEN_WIDTH                ([UIScreen mainScreen].bounds.size.width)                      //屏幕宽度
#define SharedDelegate              ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define SCREEN_OFFSET_Y             ([[[UIDevice currentDevice] systemVersion] floatValue] < 7 ?0:20)
#define IOS7                        ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ?YES:NO)



@interface Common : NSObject



+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
