//
//  ZHCheckBox.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/6.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHElasticButton.h"

/**复选框*/
@interface ZHCheckBox : ZHElasticButton

/**正常图片*/
@property (nonatomic , strong) UIImage *normalImage;
/**选中图片*/
@property (nonatomic , strong) UIImage *selectedImage;

/**便利构造器*/
- (instancetype) initWithNormalImage:(UIImage *)normalImg selectedImage:(UIImage *)selectedImg;

@end
