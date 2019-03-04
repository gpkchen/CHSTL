//
//  UIViewController+ZHRouter.m
//  Finance
//
//  Created by Apple on 2017/9/29.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "UIViewController+ZHRouter.h"

@implementation UIViewController (ZHRouter)

// present
- (void)zh_presentViewController:(UIViewController *)viewController
                        animated:(BOOL)animated
                      completion:(void (^)())completion{
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self presentViewController:viewController animated:animated completion:completion];
    [CATransaction commit];
}


// dismiss
- (void)zh_dismissViewControllerAnimated:(BOOL)animated
                              completion:(void (^)())completion{
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self dismissViewControllerAnimated:YES completion:nil];
    [CATransaction commit];
}

// dismiss到第一个present的控制器
- (void)zh_dismissToRootViewControllerAnimated:(BOOL)animated
                                    completion:(void (^)())completion{
    
    /**
     1、注意区分presentedViewController与presentingViewController
     2、通过present，A->B
     3、A.presentedViewController 是B
     4、B.presentingViewController 是A
     */
    
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [vc dismissViewControllerAnimated:YES completion:nil];
    [CATransaction commit];
}

// 接受pop、dismiss回传的值
- (void)zh_receivePreviousControllerWithParamsDic:(NSDictionary *)ParamsDic{
    
}
@end
