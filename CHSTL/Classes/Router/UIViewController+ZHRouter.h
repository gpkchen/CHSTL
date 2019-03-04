//
//  UIViewController+ZHRouter.h
//  Finance
//
//  Created by Apple on 2017/9/29.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZHRouter)

/**
 present跳转控制器

 @param viewController 目标控制器
 @param animated 是否显示动画
 @param completion 完成回调
 */
- (void)zh_presentViewController:(UIViewController *)viewController
                        animated:(BOOL)animated
                      completion:(void (^)())completion;



/**
 present返回上级控制器

 @param animated 是否显示动画
 @param completion 完成回调
 */
- (void)zh_dismissViewControllerAnimated:(BOOL)animated
                              completion:(void (^)())completion;


/**
 present返回根控制器

 @param animated 是否显示动画
 @param completion 完成回调
 */
- (void)zh_dismissToRootViewControllerAnimated:(BOOL)animated
                                    completion:(void (^)())completion;


/**
 接收返回时回传的值

 @param ParamsDic 参数
 */
- (void)zh_receivePreviousControllerWithParamsDic:(NSDictionary *)ParamsDic;

@end
