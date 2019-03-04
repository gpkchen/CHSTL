//
//  ZHRouterManager.m
//  Finance
//
//  Created by Apple on 2017/9/29.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHRouterManager.h"
#import "ZHRouter.h"

static ZHRouterManager *sharedRouter = nil;

@implementation ZHRouterManager

+ (instancetype)router{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRouter = [[self alloc] init];
    });
    
    return sharedRouter;
}

// 寻找当前push、pop需要的导航控制器
- (UINavigationController *)navigationController{
    if(self.viewController && [self.viewController isKindOfClass:[UINavigationController class]]){
        return (UINavigationController *)self.viewController;
    }
    if(self.viewController && [self.viewController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tbc = (UITabBarController *)self.viewController;
        UIViewController *vc = [tbc.viewControllers objectAtIndex:tbc.selectedIndex];
        if([vc isKindOfClass:[UINavigationController class]]){
            return (UINavigationController *)vc;
        }
        return vc.navigationController;
    }
    if(self.viewController && [self.viewController isKindOfClass:[UIViewController class]]){
        return self.viewController.navigationController;
    }
    return nil;
}

#pragma mark - getter
- (UIViewController *)viewController{
    UIViewController *topVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    while (topVC.presentedViewController && ([topVC.presentedViewController isKindOfClass:[UIViewController class]] || [topVC.presentedViewController isKindOfClass:[UINavigationController class]])) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

#pragma mark - push模式
- (void)push:(NSString *)viewController
    animated:(BOOL)animated{
    
    [self push:viewController animated:animated callBack:nil paramsDic:nil isHiddenTabbarWhenPush:NO completion:nil];
}

- (void)push:(NSString *)viewController
    animated:(BOOL)animated
    callBack:(id)callBack{
    
    [self push:viewController animated:animated  callBack:callBack paramsDic:nil isHiddenTabbarWhenPush:NO completion:nil];
}

- (void)push:(NSString *)viewController
    animated:(BOOL)animated
    callBack:(id)callBack
   paramsDic:(NSDictionary *)paramsDic{
    
    [self push:viewController animated:animated  callBack:callBack paramsDic:paramsDic isHiddenTabbarWhenPush:NO completion:nil];
}

- (void)push:(NSString *)viewController
    animated:(BOOL)animated
    callBack:(id)callBack
   paramsDic:(NSDictionary *)paramsDic
isHiddenTabbarWhenPush:(BOOL)isHiddenTabbarWhenPush{
    
    [self push:viewController animated:animated  callBack:callBack paramsDic:paramsDic isHiddenTabbarWhenPush:isHiddenTabbarWhenPush completion:nil];
    
}

- (void)push:(NSString *)viewController
    animated:(BOOL)animated
    callBack:(id)callBack
   paramsDic:(NSDictionary *)paramsDic
isHiddenTabbarWhenPush:(BOOL)isHiddenTabbarWhenPush
  completion:(void(^)())completion{
    
    BOOL isExistClass = [self dynamicCheckIsExistClassWithviewController:viewController];
    if (isExistClass) {
        
        Class newClass =  NSClassFromString(viewController);
        // 动态生成对象
        UIViewController *vc = [[newClass alloc] init];
        vc.callBack = callBack;
        // 动态传递数据
        [self dynamicDeliverWithViewController:vc dic:paramsDic];
        
        // 调用push
        [self.navigationController zh_PushViewController:vc animated:animated isHiddenTabbarWhenPush:isHiddenTabbarWhenPush completion:completion];
    }
}

#pragma mark - pop模式
// pop回上一级
- (void)popViewControllerAnimated:(BOOL)animated{
    
    [self popViewControllerAnimated:animated paramsDic:nil completion:nil];
}

- (void)popViewControllerAnimated:(BOOL)animated
                        paramsDic:(NSDictionary *)paramsDic{
    
    [self popViewControllerAnimated:animated paramsDic:paramsDic completion:nil];
}

- (void)popViewControllerAnimated:(BOOL)animated
                        paramsDic:(NSDictionary *)paramsDic
                       completion:(void(^)())completion{
    
    NSInteger vcCounts = self.navigationController.viewControllers.count;
    UIViewController *vc = self.navigationController.viewControllers[vcCounts - 2];
    if ([vc respondsToSelector:@selector(zh_receivePreviousControllerWithParamsDic:)]) {
        [vc zh_receivePreviousControllerWithParamsDic:paramsDic];
    }
    [self.navigationController zh_popViewController:animated completion:completion];
}

// pop到指定vc
- (void)popToViewController:(NSString *)viewController animated:(BOOL)animated{
    
    [self popToViewController:viewController animated:animated paramsDic:nil completion:nil];
}

- (void)popToViewController:(NSString *)viewController
                   animated:(BOOL)animated
                  paramsDic:(NSDictionary *)paramsDic{
    
    [self popToViewController:viewController animated:animated paramsDic:paramsDic completion:nil];
}

- (void)popToViewController:(NSString *)viewController
                   animated:(BOOL)animated
                  paramsDic:(NSDictionary *)paramsDic
                 completion:(void(^)())completion{
    
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([viewController isEqualToString:NSStringFromClass([vc class])]) {
            
            if ([vc respondsToSelector:@selector(zh_receivePreviousControllerWithParamsDic:)]) {
                [vc zh_receivePreviousControllerWithParamsDic:paramsDic];
            }
            [self.navigationController zh_popToViewController:vc animated:animated completion:completion];
            return;
        }
        else if (self.navigationController.viewControllers.count == idx+1){
            
            @throw [NSException exceptionWithName:@"路由错误" reason:@"该viewController不在该导航的栈结构中" userInfo:nil];
        }
    }];
}

// popToRoot
- (void)popToRootViewControllerAnimated:(BOOL)animated{
    
    [self popToRootViewControllerAnimated:animated paramsDic:nil completion:nil];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
                              paramsDic:(NSDictionary *)paramsDic{
    
    [self popToRootViewControllerAnimated:animated paramsDic:paramsDic completion:nil];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
                              paramsDic:(NSDictionary *)paramsDic
                             completion:(void(^)())completion{
    
    // 获取导航的Root控制器、传递paramsDic
    UIViewController *navRootVC = [self.navigationController.viewControllers firstObject];
    if ([navRootVC respondsToSelector:@selector(zh_receivePreviousControllerWithParamsDic:)]) {
        [navRootVC zh_receivePreviousControllerWithParamsDic:paramsDic];
    }
    [self.navigationController zh_popToRootViewController:animated completion:completion];
}

#pragma mark - present模式
- (void)present:(NSString *)viewController animated:(BOOL)animated{
    
    [self present:viewController animated:animated callBack:nil paramsDic:nil completion:nil];
}

- (void)present:(NSString *)viewController
       animated:(BOOL)animated
      paramsDic:(NSDictionary *)paramsDic{
    
    [self present:viewController animated:animated callBack:nil paramsDic:paramsDic completion:nil];
}

- (void)present:(NSString *)viewController
       animated:(BOOL)animated
       callBack:(id)callBack
      paramsDic:(NSDictionary *)paramsDic
     completion:(void(^)())completion{
    
    BOOL isExistClass = [self dynamicCheckIsExistClassWithviewController:viewController];
    if (isExistClass) {
        
        Class newClass =  NSClassFromString(viewController);
        // 动态生成对象
        UIViewController *vc = [[newClass alloc] init];
        vc.callBack = callBack;
        // 动态传递数据给下一个控制器
        [self dynamicDeliverWithViewController:vc dic:paramsDic];
        if([ZHRouter router].nc){
            UINavigationController *unc = [[[ZHRouter router].nc alloc]initWithRootViewController:vc];
            [self.navigationController.topViewController zh_presentViewController:unc animated:animated completion:completion];
        }else{
            [self.navigationController.topViewController zh_presentViewController:vc animated:animated completion:completion];
        }
    }
}

@end
