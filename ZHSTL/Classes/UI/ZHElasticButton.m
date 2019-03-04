//
//  ZHElasticButton.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/25.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHElasticButton.h"
#import "POP.h"
#import "UIView+Extension.h"

@implementation ZHElasticButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initSelf];
    }
    return self;
}

- (void)initSelf{
    _shouldRound = NO;
    _shouldAnimate = YES;
    [self addTarget:self
             action:@selector(touchDown:)
   forControlEvents:UIControlEventTouchDown];
    [self addTarget:self
             action:@selector(touchUp:)
   forControlEvents:UIControlEventTouchUpInside|
     UIControlEventTouchUpOutside|
     UIControlEventTouchDragInside|
     UIControlEventTouchDragOutside|
     UIControlEventTouchCancel];
}

#pragma mark - 按下时候执行回调
- (void)touchDown:(UIButton*)sender{
    if(_shouldAnimate){
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        animation.springBounciness = 5;
        [sender.layer pop_addAnimation:animation forKey:@"ButtonZoomOutY"];
    }
}

#pragma mark - 按下抬起时执行回调
- (void)touchUp:(UIButton*)sender{
    if(_shouldAnimate){
        [sender.layer pop_removeAnimationForKey:@"ButtonZoomOutY"];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        animation.springBounciness = 5;
        [sender.layer pop_addAnimation:animation forKey:@"ButtonZoomOutYReverse"];
    }
}

#pragma mark - override
- (void) layoutSubviews{
    [super layoutSubviews];
    if(_shouldRound){
        self.clipsToBounds = YES;
        self.cornerRadius = self.height / 2;
    }
}

@end
