//
//  ZHRouterManager.h
//  Finance
//
//  Created by Apple on 2017/9/29.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ZHDynamic.h"
#import "UINavigationController+ZHRouter.h"
#import "UIViewController+ZHRouter.h"

/**
 1、需要考虑delegate或者block的情况，最好把需要切换的对象 暴露出去，push、pop等方法，直接返回对象
 
 */
@interface ZHRouterManager : NSObject

/**当前最上层导航器*/
@property(nonatomic,strong)UINavigationController *navigationController;
/**当前激活的视图控制器*/
@property (nonatomic , strong , readonly) UIViewController *viewController;

+ (instancetype)router;

//push
- (void)push:(NSString *)viewController
    animated:(BOOL)animated;
- (void)push:(NSString *)viewController
    animated:(BOOL)animated
    callBack:(id)callBack;
- (void)push:(NSString *)viewController
    animated:(BOOL)animated
    callBack:(id)callBack
   paramsDic:(NSDictionary *)paramsDic;
- (void)push:(NSString *)viewController
    animated:(BOOL)animated
    callBack:(id)callBack
   paramsDic:(NSDictionary *)paramsDic
isHiddenTabbarWhenPush:(BOOL)isHiddenTabbarWhenPush;
- (void)push:(NSString *)viewController
    animated:(BOOL)animated
    callBack:(id)callBack
   paramsDic:(NSDictionary *)paramsDic
isHiddenTabbarWhenPush:(BOOL)isHiddenTabbarWhenPush
  completion:(void(^)())completion;

/// pop模式
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated
                        paramsDic:(NSDictionary *)paramsDic;
- (void)popViewControllerAnimated:(BOOL)animated
                        paramsDic:(NSDictionary *)paramsDic
                       completion:(void(^)())completion;

/// pop到指定vc
- (void)popToViewController:(NSString *)viewController
                   animated:(BOOL)animated;
- (void)popToViewController:(NSString *)viewController
                   animated:(BOOL)animated
                  paramsDic:(NSDictionary *)paramsDic;
- (void)popToViewController:(NSString *)viewController
                   animated:(BOOL)animated
                  paramsDic:(NSDictionary *)paramsDic
                 completion:(void(^)())completion;

/// popToRoot模式
- (void)popToRootViewControllerAnimated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated
                              paramsDic:(NSDictionary *)paramsDic
                             completion:(void(^)())completion;

#pragma mark - present、dismiss
- (void)present:(NSString *)viewController
       animated:(BOOL)animated
       callBack:(id)callBack
      paramsDic:(NSDictionary *)paramsDic
     completion:(void(^)())completion;

@end
