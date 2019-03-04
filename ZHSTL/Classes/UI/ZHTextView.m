//
//  ZHTextView.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/3.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHTextView.h"

@interface ZHTextView ()<UITextViewDelegate>

@end

@implementation ZHTextView

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if(_wordLimitNum > 0){
        if(textView.text.length >= _wordLimitNum){
            textView.text = [textView.text substringToIndex:_wordLimitNum];
        }
    }
    
    if([_c_delegate respondsToSelector:@selector(textViewDidChange:)]){
        [_c_delegate textViewDidChange:textView];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([_c_delegate respondsToSelector:@selector(textViewDidBeginEditing:)]){
        [_c_delegate textViewDidBeginEditing:textView];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if([_c_delegate respondsToSelector:@selector(textViewDidEndEditing:)]){
        [_c_delegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([_c_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]){
        return [_c_delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

#pragma mark - Setters

- (void)setPlaceholder:(NSString *)placeholder {
    if([placeholder isEqualToString:_placeholder]) {
        return;
    }
    
    if(_maxNumOfWordOfPlacehold){
        if([placeholder length] > _maxNumOfWordOfPlacehold) {
            placeholder = [placeholder substringToIndex:_maxNumOfWordOfPlacehold];
            placeholder = [[placeholder stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByAppendingFormat:@"..."];
        }
    }
    
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    if([placeholderTextColor isEqual:_placeholderTextColor]) {
        return;
    }
    
    _placeholderTextColor = placeholderTextColor;
    [self setNeedsDisplay];
}

#pragma mark - Text view overrides
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark - Notifications

- (void)didReceiveTextDidChangeNotification:(NSNotification *)notification {
    [self setNeedsDisplay];
}

#pragma mark - Life cycle

- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextDidChangeNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    _placeholderTextColor = [UIColor lightGrayColor];
    
    //    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f);
    self.contentInset = UIEdgeInsetsZero;
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.userInteractionEnabled = YES;
    self.font = [UIFont systemFontOfSize:16.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    self.textAlignment = NSTextAlignmentLeft;
    self.delegate = self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc {
    _placeholder = nil;
    _placeholderTextColor = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if([self.text length] == 0 && self.placeholder){
        CGRect placeHolderRect = CGRectMake(10.0f,10.0f,rect.size.width - 20,rect.size.height - 20);
        
        [self.placeholderTextColor set];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = self.textAlignment;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        
        [self.placeholder drawInRect:placeHolderRect
                      withAttributes:@{ NSFontAttributeName : self.font,
                                        NSForegroundColorAttributeName : self.placeholderTextColor,
                                        NSParagraphStyleAttributeName : paragraphStyle }];
    }
}


@end
