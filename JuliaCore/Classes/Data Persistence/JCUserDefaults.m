//
//  JCUserDefaults.m
//  JuliaCoreFramework
//
//  Created by Jymn_Chen on 14-3-14.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import "JCUserDefaults.h"

@implementation JCUserDefaults

+ (id)objectForKey:(NSString *)aKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:aKey];
}

+ (void)setObject:(id)obj forKey:(NSString *)aKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:obj forKey:aKey];
    [userDefaults synchronize];
}

@end
