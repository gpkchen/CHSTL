//
//  ZHElasticButton.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/25.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**0可伸缩动画的按钮*/
@interface ZHElasticButton : UIButton

/**禁用动画开关(默认YES)*/
@property (nonatomic , assign) BOOL shouldAnimate;
/**是否需要圆角*/
@property (nonatomic , assign) BOOL shouldRound;

@end
