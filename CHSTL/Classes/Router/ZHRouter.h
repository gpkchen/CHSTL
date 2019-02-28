//
//  ZHRouter.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/10.
//  Copyright © 2017年 fintechzh. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ZHProtocol.h"
#import "NSObject+ZHDynamic.h"

/**路由规则代理*/
@protocol ZHRouterRole <NSObject>

@required
/**执行规则*/
- (void)redirect:(ZHProtocol *)protocol;
/**目标集合*/
- (NSArray *)targets;

@end

/**路由调度*/
@interface ZHRouter : NSObject


/**获取单例*/
+ (instancetype)router;

/**协议头*/
@property (nonatomic , copy) NSString *protocolHead;
/**协议加解密Key*/
@property (nonatomic , copy) NSString *protocolEncodeKey;
/**导航控制器类*/
@property (nonatomic , strong) Class nc;


/**检测协议合法性*/
+ (BOOL) checkUrl:(NSString *)url;

/**添加路由规则*/
- (void) addRule:(id<ZHRouterRole>)rule;

//外部协议操作方法
- (ZHProtocol *)go:(NSString *)url;
- (ZHProtocol *)go:(NSString *)url withCallBack:(id)callBack;
- (ZHProtocol *)go:(NSString *)url withCallBack:(id)callBack isPush:(BOOL)isPush;

//内部协议操作方法
- (ZHProtocol *)goWithoutHead:(NSString *)url;
- (ZHProtocol *)goWithoutHead:(NSString *)url withCallBack:(id)callBack;
- (ZHProtocol *)goWithoutHead:(NSString *)url withCallBack:(id)callBack isPush:(BOOL)isPush;

//内部控制器操作方法
- (ZHProtocol *)goVC:(NSString *)url;
- (ZHProtocol *)goVC:(NSString *)url withCallBack:(id)callBack;
- (ZHProtocol *)goVC:(NSString *)url withCallBack:(id)callBack isPush:(BOOL)isPush;

//协议对象操作方法
- (void)goProtocol:(ZHProtocol *)protocol;
- (void)goProtocol:(ZHProtocol *)protocol withCallBack:(id)callBack;
- (void)goProtocol:(ZHProtocol *)protocol withCallBack:(id)callBack isPush:(BOOL)isPush;

//界面跳转方法
- (void)push:(UIViewController *)vc;
- (void)push:(UIViewController *)vc completion:(void(^)(void))completion;
- (void)present:(UIViewController *)vc;
- (void)present:(UIViewController *)vc completion:(void(^)(void))completion;
- (void)present:(UIViewController *)vc completion:(void(^)(void))completion identifier:(NSString *)identifier;

@end
