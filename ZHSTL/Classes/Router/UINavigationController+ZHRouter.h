//
//  UINavigationController+ZHRouter.h
//  Finance
//
//  Created by Apple on 2017/9/29.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (ZHRouter)

/**
 push跳转

 @param viewController 目标控制器
 @param animated 是否动画条状
 @param isHiddenTabbarWhenPush 是否隐藏tabbar
 @param completion 完成回调
 */
- (void)zh_PushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
       isHiddenTabbarWhenPush:(BOOL)isHiddenTabbarWhenPush
                   completion:(void(^)())completion;


/**
 push返回上级控制器

 @param animated 是否显示动画
 @param completion 完成回调
 */
- (void)zh_popViewController:(BOOL)animated
                  completion:(void (^)())completion;


/**
 push返回制定控制器

 @param viewController 目标控制器
 @param animated 是否显示动画
 @param completion 完成回调
 */
- (void)zh_popToViewController:(UIViewController *)viewController
                      animated:(BOOL)animated
                    completion:(void (^)())completion;


/**
 返回根控制器

 @param animated 是否显示动画
 @param completion 完成回调
 */
- (void)zh_popToRootViewController:(BOOL)animated
                        completion:(void(^)())completion;

@end
