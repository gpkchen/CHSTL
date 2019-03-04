//
//  ZHTextField.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/3.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**完善系统的TextField，加入一些常用但是设置麻烦的属性*/
@interface ZHTextField : UITextField

/**字数限制*/
@property (nonatomic , assign) NSUInteger wordLimitNum;
/**提示文字颜色*/
@property (nonatomic , strong) UIColor *placeholderColor;

@end
