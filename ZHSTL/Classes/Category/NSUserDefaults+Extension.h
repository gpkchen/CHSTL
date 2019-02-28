//
//  NSUserDefaults+Extension.h
//
//  Created by 李明伟 on 16/6/2.
//  Copyright © 2016年 李明伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)

/**
 存入自定义对象
 @param object 需要存入的自定义对象
 @param key 自定义对象对应的key
 */
+ (void)writeWithObject:(id)object
                 forKey:(NSString *)key;

/**
 获取自定义对象
 @param key 自定义对象对应的key
 @return 返回自定义对象
 */
+ (id)readObjectWithKey:(NSString *)key;

/**
 删除自定义对象
 @param key 自定义对象对应的key
 */
+ (void)removeObjectForKey:(NSString *)key;

@end
