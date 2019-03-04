//
//  ZHToast.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/9.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHToast.h"
#import "ZHMacro.h"
#import "UIView+Extension.h"
#import "Masonry.h"

@interface ZHToast ()

@property (nonatomic , strong) UILabel *titleLab;

@end

@implementation ZHToast

- (instancetype)init{
    self = [super init];
    if(self){
        self.windowLevel = powf(10, 7);
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        _titleLab = [UILabel new];
        _titleLab.font = FONT(15);
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.layer.masksToBounds = YES;
        _titleLab.numberOfLines = 0;
        _titleLab.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_titleLab];
    }
    return self;
}

+ (void)showWithTitle:(NSString *)title centerY:(CGFloat)centerY completion:(void(^)(void))completion{
    ZHToast *toast = [ZHToast new];
    toast.titleLab.text = title;
    CGSize size = [toast.titleLab sizeThatFits:CGSizeMake(SCREEN_WIDTH - 20 - 30, CGFLOAT_MAX)];
    toast.size = CGSizeMake(size.width + 30,size.height + 25);
    toast.titleLab.frame = CGRectMake(15, 12.5, size.width,size.height);
    toast.center = CGPointMake(SCREEN_WIDTH / 2, centerY);
    toast.alpha = 0;
    [toast makeVisibleWindow];
    [UIView animateWithDuration:0.3
                     animations:^{
                         toast.alpha = 1;
                     }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3
                         animations:^{
                             toast.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             toast.hidden = YES;
                             if(completion){
                                 completion();
                             }
                         }];
    });
}

+ (void)showWithTitle:(NSString *)title completion:(void(^)(void))completion{
    [self showWithTitle:title centerY:SCREEN_HEIGHT / 2 completion:completion];
}

+ (void)showWithTitle:(NSString *)title centerY:(CGFloat)centerY{
    [self showWithTitle:title centerY:centerY completion:nil];
}

+ (void)showWithTitle:(NSString *)title{
    [self showWithTitle:title centerY:SCREEN_HEIGHT / 2 completion:nil];
}

#pragma mark - 显示window
- (void)makeVisibleWindow {
    UIWindow *keyWindows = [UIApplication sharedApplication].keyWindow;
    [self makeKeyAndVisible];
    if (keyWindows) {
        [keyWindows makeKeyWindow];
    }
}


@end
