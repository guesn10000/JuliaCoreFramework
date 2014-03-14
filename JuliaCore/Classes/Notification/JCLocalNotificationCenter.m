//
//  JCLocalNotificationCenter.m
//  JuliaCoreFramework
//
//  Created by Jymn_Chen on 14-3-12.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import "JCLocalNotificationCenter.h"
#import "JCNotificationMarcos.h"
#import "JCTimer.h"

@implementation JCLocalNotificationCenter

#pragma mark - Singleton

+ (instancetype)defaultCenter {
    static JCLocalNotificationCenter *defaultCenter = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[super allocWithZone:NULL] init];
    });
    
    return defaultCenter;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self defaultCenter];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - Local Notifications

- (BOOL)isLocalNotificationScheduled:(NSDictionary *)notiUserInfo {
    NSString *notiID = notiUserInfo[kLocalNotificationIdentifier];
    
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *noti in notifications) {
        if ([notiUserInfo[kLocalNotificationIdentifier] isEqualToString:notiID]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - Add Local Notification

- (void)addLocalNotificationWithBody:(NSString *)aBody
                            FireDate:(NSDate *)aFireDate
                      RepeatInterval:(NSTimeInterval)aRepeatInterval
{
    NSString *currentTime = [[JCTimer sharedInstance] get_yyMMddhhmmss_StringOfCurrentTime];
    [self addLocalNotificationWithIdentifier:currentTime
                                        Body:aBody
                                    FireDate:aFireDate
                              RepeatInterval:aRepeatInterval];
}

- (void)addLocalNotificationWithIdentifier:(NSString *)aIdentifier
                                      Body:(NSString *)aBody
                                  FireDate:(NSDate *)aFireDate
                            RepeatInterval:(NSTimeInterval)aRepeatInterval
{
    // 初始化本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        // 设置通知的提醒时间
        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
        notification.fireDate = aFireDate;
        
        // 设置重复间隔
        notification.repeatInterval = aRepeatInterval;
        
        // 设置提醒的文字内容
        notification.alertBody = aBody;
        
        // 通知提示音 使用默认的
        notification.soundName= UILocalNotificationDefaultSoundName;
        
        // 设定通知的userInfo，用来标识该通知
        NSMutableDictionary *aUserInfo = [[NSMutableDictionary alloc] init];
        aUserInfo[kLocalNotificationIdentifier] = aIdentifier;
        notification.userInfo = aUserInfo;
        
        // 将通知添加到系统中
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

#pragma mark - Remove Notifications

- (void)removeAllLocalNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
