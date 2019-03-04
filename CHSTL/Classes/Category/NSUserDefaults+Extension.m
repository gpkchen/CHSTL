//
//  NSUserDefaults+Extension.m
//
//  Created by 李明伟 on 16/6/2.
//  Copyright © 2016年 李明伟. All rights reserved.
//

#import "NSUserDefaults+Extension.h"

@implementation NSUserDefaults (Extension)

+ (void)writeWithObject:(id)object
                 forKey:(NSString *)key{
    //    id obj = [self readObjectWithKey:key];
    //    if(obj)
    [self removeObjectForKey:key];
    
    NSUserDefaults *userDefault = [self standardUserDefaults];
    
    //transform data
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [userDefault setObject:data
                    forKey:key];
    [userDefault synchronize];
}

+ (id)readObjectWithKey:(NSString *)key{
    NSUserDefaults *userDefault = [self standardUserDefaults];
    id obj = [userDefault objectForKey:key];
    //transform object
    if (obj) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    } else {
        return nil;
    }
}

+ (void)removeObjectForKey:(NSString *)key{
    NSUserDefaults *userDefault = [self standardUserDefaults];
    [userDefault removeObjectForKey:key];
    [userDefault synchronize];
}


@end
