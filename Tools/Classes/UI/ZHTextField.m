//
//  ZHTextField.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/3.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHTextField.h"

@implementation ZHTextField

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addTarget:self
                 action:@selector(selfEditChanged:)
       forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

#pragma mark - 输入框字数限制
- (void)selfEditChanged:(UITextField *)textField{
    if(_wordLimitNum > 0){
        NSString *text = textField.text;
        if(text.length >= _wordLimitNum){
            textField.text = [textField.text substringToIndex:_wordLimitNum];
        }
    }
}

#pragma mark - setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    if(self.placeholder && self.placeholder.length > 0){
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder
                                                                     attributes:@{NSForegroundColorAttributeName: _placeholderColor}];
    }
}

- (void)setPlaceholder:(NSString *)placeholder{
    [super setPlaceholder:placeholder];
    if(self.placeholder && self.placeholder.length > 0 && _placeholderColor){
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder
                                                                     attributes:@{NSForegroundColorAttributeName: _placeholderColor}];
    }
}


@end
