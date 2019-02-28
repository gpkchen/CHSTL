//
//  ZHCheckBox.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/6.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHCheckBox.h"

@implementation ZHCheckBox

- (instancetype) initWithNormalImage:(UIImage *)normalImg selectedImage:(UIImage *)selectedImg{
    if(self = [super init]){
        self.normalImage = normalImg;
        self.selectedImage = selectedImg;
        
        [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - setter
- (void)setNormalImage:(UIImage *)normalImage{
    _normalImage = normalImage;
    if(normalImage){
        [self setImage:normalImage forState:UIControlStateNormal];
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    if(selectedImage){
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
}

#pragma mark - 点击事件
- (void) action:(UIButton *)button{
    self.selected = !self.isSelected;
}

@end
