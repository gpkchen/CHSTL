//
//  ZHBaseNC.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/24.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**导航栏基类*/
@interface ZHBaseNC : UINavigationController

/**透明度*/
@property (nonatomic , assign) CGFloat alpha;
/**背景色*/
@property (nonatomic , strong) UIColor *backgroundColor;
/**标题属性*/
@property (nonatomic , strong) NSDictionary *titleTextAttributes;

@end
