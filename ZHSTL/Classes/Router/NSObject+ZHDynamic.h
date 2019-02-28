//
//  NSObject+ZHDynamic.h
//  Finance
//
//  Created by Apple on 2017/9/29.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@interface NSObject (ZHDynamic)


/** 跳转后控制器能拿到的参数*/
@property (nonatomic , strong) NSDictionary *dicParam;
/** 跳转后控制器能拿到的回调*/
@property (nonatomic , strong) id callBack;
/** 唯一标识*/
@property (nonatomic , strong) NSString *identifier;

// 检测，project中是否含有viewController类
- (BOOL)dynamicCheckIsExistClassWithviewController:(NSString *)viewController;

// 传递数据
- (void)dynamicDeliverWithViewController:(UIViewController *)viewController
                                     dic:(NSDictionary *)dic;

// 检测对象里面是否存在propertyName属性
- (BOOL)dynamicCheckIsExistProperty:(NSString *)propertyName;


NS_ASSUME_NONNULL_END
@end
