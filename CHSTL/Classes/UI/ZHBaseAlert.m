//
//  ZHBaseAlert.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/29.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHBaseAlert.h"
#import "POP.h"
#import "UIView+Extension.h"
#import "ZHMacro.h"

@interface ZHBaseAlert ()<UIGestureRecognizerDelegate>

@property (nonatomic , copy) ZHBaseAlertDismissBlock dismissBlock; //消失回调

@property (nonatomic , strong) UIView *back; //背景视图

@end

@implementation ZHBaseAlert

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if(self){
        [self _initBaseWidgets];
    }
    return self;
}

#pragma mark - 初始化控件
- (void)_initBaseWidgets{
    self.backgroundColor = [UIColor clearColor];
    _shouldTapToDissmiss = YES;
    
    __weak __typeof__(self) weakSelf = self;
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _back.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4];
    _back.tag = 100;
    [_back tapped:^(UITapGestureRecognizer * _Nonnull gesture) {
        if(weakSelf.shouldTapToDissmiss){
            [weakSelf dismiss];
        }
    } delegate:self];
    [self addSubview:_back];
    
    _panel = [[UIView alloc]init];
    _panel.backgroundColor = [UIColor clearColor];
    [self addSubview:_panel];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if(touch.view.tag == 100){
        return YES;
    }
    return NO;
}

#pragma mark - public
- (void)showWithPanelView:(UIView *)panel{
    if(!(panel.superview && [panel.superview isEqual:_panel])){
        _panel.frame = CGRectMake((SCREEN_WIDTH - panel.width) / 2,
                                  (SCREEN_HEIGHT - panel.height) / 2,
                                  panel.width,
                                  panel.height);
        _panel.backgroundColor = [UIColor clearColor];
        [_panel addSubview:panel];
    }
    
    _back.alpha = 0;
    _panel.alpha = 0;
    [SCREEN addSubview:self];
    [UIView animateWithDuration:0.3
                     animations:^{
                         _back.alpha = 1;
                         _panel.alpha = 1;
                     }];
    [self animateWithView:_panel isShow:YES];
}

- (void)dismiss{
    [self dismissWithBlock:nil];
}

- (void)dismissWithBlock:(ZHBaseAlertDismissBlock)block{
    _dismissBlock = block;
    [UIView animateWithDuration:0.3
                     animations:^{
                         _back.alpha = 0;
                         _panel.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         !_dismissBlock ? : _dismissBlock();
                     }];
    [self animateWithView:_panel isShow:NO];
}

#pragma mark - private
- (void)animateWithView:(UIView *)view isShow:(BOOL)is{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    animation.removedOnCompletion = YES;
    animation.additive = NO;
    if(is){
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    }else{
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
    }
    animation.springBounciness = 10;
    [view.layer pop_addAnimation:animation forKey:@"MSODZoom"];
}

@end
