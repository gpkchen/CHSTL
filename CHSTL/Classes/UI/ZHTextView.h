//
//  ZHTextView.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/3.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**完善系统的TextView，加入一些常用但是设置麻烦的属性*/
@interface ZHTextView : UITextView

/**字数限制*/
@property (nonatomic , assign) NSUInteger wordLimitNum;
/**代理*/
@property (nonatomic , strong) id<UITextViewDelegate> c_delegate;
/**placeholder的最大字数*/
@property (nonatomic , assign) int maxNumOfWordOfPlacehold;
/**提示用户输入的标语*/
@property (nonatomic, copy) NSString *placeholder;
/**标语文本的颜色*/
@property (nonatomic, strong) UIColor *placeholderTextColor;

@end
