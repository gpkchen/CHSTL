//
//  ZHDeviceUtils.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/12.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHDeviceUtils : NSObject

/**获取设备标识码*/
@property (nonatomic , copy , readonly) NSString * uuidForDevice;

/**单例*/
+ (instancetype) utils;

@end
