//
//  ZHContactUtils.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/3.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZHContactUtilsPickBlock)(NSString *givenName,NSString *familyName,NSString *phone);


/**联系人模型*/
@interface ZHContact : NSObject

@property (nonatomic , copy) NSString *firstName;
@property (nonatomic , copy) NSString *middleName;
@property (nonatomic , copy) NSString *lastName;
@property (nonatomic , strong) NSArray *phones;

@end



/**联系人管理工具*/
@interface ZHContactUtils : NSObject

/**单例*/
+ (instancetype) utils;

/**检测通讯录权限*/
+ (BOOL)isAuthAddressBookWithRequire:(BOOL)should success:(void(^)(void))success;

/**显示选择界面*/
- (void) showWithViewController:(UIViewController *)viewController pickBlock:(ZHContactUtilsPickBlock)block;
/**遍历所有联系人信息*/
- (void) enumerateAllContactInfo:(void(^)(ZHContact *contact))block;

@end
