//
//  ZHBaseNC.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/24.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHBaseNC.h"
#import "ZHBaseVC.h"
#import "UIImage+Extension.h"

@interface ZHBaseNC ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic , assign) id systemPanTarget; //系统侧滑返回代理对象
@property (nonatomic , assign) SEL systemPanHandler; //系统侧滑返回回调

@property (nonatomic , strong) ZHBaseVC *curVC; //用于记录侧滑返回的当前视图控制器
@property (nonatomic , strong) ZHBaseVC *preVC; //用于记录侧滑返回的前一个视图控制器

@property (nonatomic, getter=isPushing) BOOL pushing; //记录push状态，防止多次push

@end

@implementation ZHBaseNC

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self initWidgets];
    [self overrideSwipeToBack];
}

#pragma mark - 重写系统侧滑返回
- (void)overrideSwipeToBack{
    _systemPanTarget  = self.interactivePopGestureRecognizer.delegate;
    _systemPanHandler = NSSelectorFromString(@"handleNavigationTransition:");
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    //  创建pan手势 作用范围是全屏
    UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(backPanHandler:)];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
}

#pragma mark - 侧滑返回手势
- (void)backPanHandler:(UIPanGestureRecognizer *)pan{
    if(_systemPanTarget && _systemPanHandler){
        
        CGFloat process = [pan translationInView:pan.view].x/(pan.view.bounds.size.width * 0.5);
        process = MIN(1.0, MAX(0.0, process));
        
        if(pan.state == UIGestureRecognizerStateBegan){
            UIViewController *tmpCurVC = [self.viewControllers lastObject];
            UIViewController *tmpPreVC = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
            _curVC = [tmpCurVC isKindOfClass:[ZHBaseVC class]] ? (ZHBaseVC *)tmpCurVC : nil;
            _preVC = [tmpPreVC isKindOfClass:[ZHBaseVC class]] ? (ZHBaseVC *)tmpPreVC : nil;
            
        }else if(pan.state == UIGestureRecognizerStateEnded ||pan.state == UIGestureRecognizerStateCancelled){
            // 手势结束时，若进度大于0.5就完成pop动画，否则取消
            if(!_curVC || !_preVC){
                return;
            }
            if([pan translationInView:pan.view].x/pan.view.bounds.size.width > 0.5){
                [UIView animateWithDuration:(1 - process) * 0.25
                                 animations:^{
                                     self.alpha = _preVC.navigationBarAlpha;
                                 }];
            }else{
                [UIView animateWithDuration:(1 - process) * 0.25
                                 animations:^{
                                     self.alpha = _curVC.navigationBarAlpha;
                                 }];
            }
        }else{
            if(_curVC && _preVC){
                self.alpha = _curVC.navigationBarAlpha + (_preVC.navigationBarAlpha - _curVC.navigationBarAlpha) * process;
            }
        }
        
        IMP imp = [_systemPanTarget methodForSelector:_systemPanHandler];
        void (*func)(id, SEL, UIPanGestureRecognizer *) = (void *)imp;
        func(_systemPanTarget, _systemPanHandler, pan);
    }
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    _pushing = NO;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    //解决与左滑手势冲突
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    if(self.viewControllers.count == 1){
        return NO;
    }
    UIViewController *lastVC = [self.viewControllers lastObject];
    if([lastVC isKindOfClass:[ZHBaseVC class]]){
        ZHBaseVC *vc = (ZHBaseVC *)lastVC;
        if(!vc.shouldSwipeToBack){
            return NO;
        }
    }else{
        return NO;
    }
    return YES;
}

#pragma mark - override
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if (_pushing) {
        return;
    } else {
        _pushing = YES;
    }
    UIViewController *lastVC = self.viewControllers.lastObject;
    if([lastVC isKindOfClass:[ZHBaseVC class]]){
        ZHBaseVC *lvc = (ZHBaseVC *)lastVC;
        self.alpha = lvc.navigationBarAlpha;
        if(viewController && [viewController isKindOfClass:[ZHBaseVC class]]){
            ZHBaseVC *vc = (ZHBaseVC *)viewController;
            [UIView animateWithDuration:UINavigationControllerHideShowBarDuration
                             animations:^{
                                 self.alpha = vc.navigationBarAlpha;
                             }];
        }
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if(self.viewControllers.count > 1){
        UIViewController *lastVC = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
        if([lastVC isKindOfClass:[ZHBaseVC class]]){
            ZHBaseVC *vc = (ZHBaseVC *)lastVC;
            [UIView animateWithDuration:UINavigationControllerHideShowBarDuration
                             animations:^{
                                 self.alpha = vc.navigationBarAlpha;
                             }];
        }
    }
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if([viewController isKindOfClass:[ZHBaseVC class]]){
        ZHBaseVC *vc = (ZHBaseVC *)viewController;
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration
                         animations:^{
                             self.alpha = vc.navigationBarAlpha;
                         }];
    }
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    UIViewController *lastVC = self.viewControllers.firstObject;
    if([lastVC isKindOfClass:[ZHBaseVC class]]){
        ZHBaseVC *vc = (ZHBaseVC *)lastVC;
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration
                         animations:^{
                             self.alpha = vc.navigationBarAlpha;
                         }];
    }
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark - 初始化各控件样式
- (void)initWidgets{
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.translucent = YES;
    self.navigationBar.tintColor = [UIColor whiteColor];
    //    self.navigationBar.translucent = YES; //导航栏半透明
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage new]];
    if(_backgroundColor){
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:_backgroundColor] forBarMetrics:UIBarMetricsDefault];
    }
    if(_titleTextAttributes){
        [self.navigationBar setTitleTextAttributes:_titleTextAttributes];
    }
}

#pragma mark - 设置透明度
- (void)setAlpha:(CGFloat)alpha{
    _alpha = alpha;
//#ifdef __IPHONE_11_0
    self.navigationBar.alpha = alpha;
//#else
//    NSArray *leftItems = self.navigationItem.leftBarButtonItems;
//    NSArray *rightItems = self.navigationItem.rightBarButtonItems;
//    for(UIBarButtonItem *item in leftItems){
//        if(item.customView){
//            item.customView.alpha = alpha;
//        }
//    }
//    for(UIBarButtonItem *item in rightItems){
//        if(item.customView){
//            item.customView.alpha = alpha;
//        }
//    }
//
//    NSArray *subviews = [self.navigationBar subviews];
//    UIView *barBackgroundView = [subviews objectAtIndex:0];// _UIBarBackground
//    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];// UIImageView
//    if (self.navigationBar.isTranslucent) {
//        if (backgroundImageView != nil && backgroundImageView.image != nil) {
//            barBackgroundView.alpha = alpha;
//        } else {
//            if(barBackgroundView.subviews.count > 1){
//                UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
//                if (backgroundEffectView != nil) {
//                    backgroundEffectView.alpha = alpha;
//                }
//            }
//        }
//    } else {
//        barBackgroundView.alpha = alpha;
//    }
//#endif
}

#pragma mark - 设置背景色
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    if(backgroundColor){
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:backgroundColor]
                                 forBarMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - 设置标题属性
- (void) setTitleTextAttributes:(NSDictionary *)titleTextAttributes{
    _titleTextAttributes = titleTextAttributes;
    if(titleTextAttributes){
        [self.navigationBar setTitleTextAttributes:titleTextAttributes];
    }
}

@end

