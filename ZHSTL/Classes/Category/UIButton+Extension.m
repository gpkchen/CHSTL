//
//  UIButton+Extension.m
//  BuOne
//
//  Created by 李明伟 on 16/6/7.
//  Copyright © 2016年 Zhi2Bu1. All rights reserved.
//

#import "UIButton+Extension.h"
#import "UIButton+WebCache.h"
#import <objc/runtime.h>
#import "UIImage+Extension.h"
#import "ZHMacro.h"

static char kButtonActionKey;

@implementation UIButton (Extension)

- (void) setFont:(UIFont *)font{
    self.titleLabel.font = font;
}

- (UIFont *) font{
    return self.titleLabel.font;
}

- (void)clickAction:(void (^)(UIButton * _Nonnull))clickAction{
    objc_setAssociatedObject(self, &kButtonActionKey, clickAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(clicked:)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadImage:(NSString *_Nullable)url{
    [self loadImage:url placeholder:nil];
}

- (void)loadImage:(NSString *_Nullable)url placeholder:(UIImage *_Nullable)placeholder{
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:UIControlStateNormal
            placeholderImage:placeholder
                     options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

- (void)loadBackgroundImage:(NSString *_Nullable)url{
    [self loadBackgroundImage:url placeholder:nil];
}

- (void)loadBackgroundImage:(NSString *_Nullable)url placeholder:(UIImage *_Nullable)placeholder{
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:url]
                              forState:UIControlStateNormal
                      placeholderImage:placeholder
                               options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state{
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:state];
}

#pragma mark - 点击事件
- (void)clicked:(UIButton *)button{
    void (^action)(UIButton *) = objc_getAssociatedObject(self, &kButtonActionKey);
    if(action){
        action(button);
    }
}

@end
