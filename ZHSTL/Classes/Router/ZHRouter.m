//
//  ZHRouter.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/10.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHRouter.h"
#import "ZHRouterManager.h"

@interface ZHRouter ()

@property (nonatomic , strong) NSMutableArray<id<ZHRouterRole>> *rules; //规则集合

@end

@implementation ZHRouter


+ (instancetype) router{
    static ZHRouter *_instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[ZHRouter alloc] init];
    });
    
    return _instance;
}


#pragma mark - 检测url合法性
+ (BOOL)checkUrl:(NSString *)url{
    if(!url){
        NSLog(@"协议“%@”不合法!",url);
        return NO;
    }
    if(![url hasPrefix:[ZHRouter router].protocolHead]){
        NSLog(@"协议“%@”不合法!",url);
        return NO;
    }
    NSLog(@"go:“%@”",url);
    return YES;
}

#pragma mark - 添加规则
- (void) addRule:(id<ZHRouterRole>)rule{
    if(!_rules){
        _rules = [NSMutableArray array];
    }
    if(rule){
        [_rules addObject:rule];
    }
}

#pragma mark - 执行外部协议
- (ZHProtocol *)go:(NSString *)url{
    return [self go:url withCallBack:nil isPush:YES];
}

- (ZHProtocol *)go:(NSString *)url withCallBack:(id)callBack{
    return [self go:url withCallBack:callBack isPush:YES];
}

- (ZHProtocol *)go:(NSString *)url withCallBack:(id)callBack isPush:(BOOL)isPush{
    if ([ZHRouter checkUrl:url]) {
        ZHProtocol *protocol   = [[ZHProtocol alloc]initWithOutUrl:url];
        protocol.isPush = isPush;
        protocol.actionType = ZHProtocolActionTypeUrl;
        protocol.callBack = callBack;
        [self redirect:protocol];
        return protocol;
    }
    return nil;
}

#pragma mark - 执行内部部协议
- (ZHProtocol *)goWithoutHead:(NSString *)url{
    return [self goWithoutHead:url withCallBack:nil isPush:YES];
}

- (ZHProtocol *)goWithoutHead:(NSString *)url withCallBack:(id)callBack{
    return [self goWithoutHead:url withCallBack:callBack isPush:YES];
}

- (ZHProtocol *)goWithoutHead:(NSString *)url withCallBack:(id)callBack isPush:(BOOL)isPush{
    url = [NSString stringWithFormat:@"%@%@",_protocolHead,url];
    if([ZHRouter checkUrl:url]){
        ZHProtocol *protocol = [[ZHProtocol alloc]initWithInnerUrl:url];
        protocol.isPush = isPush;
        protocol.actionType = ZHProtocolActionTypeUrl;
        protocol.callBack = callBack;
        [self redirect:protocol];
        return protocol;
    }
    return nil;
}

#pragma mark - 内部控制器操作
- (ZHProtocol *)goVC:(NSString *)url{
    return [self goVC:url withCallBack:nil isPush:YES];
}

- (ZHProtocol *)goVC:(NSString *)url withCallBack:(id)callBack{
    return [self goVC:url withCallBack:callBack isPush:YES];
}

- (ZHProtocol *)goVC:(NSString *)url withCallBack:(id)callBack isPush:(BOOL)isPush{
    url = [NSString stringWithFormat:@"%@%@",_protocolHead,url];
    if([ZHRouter checkUrl:url]){
        ZHProtocol *protocol = [[ZHProtocol alloc]initWithInnerUrl:url];
        protocol.isPush = isPush;
        protocol.actionType = ZHProtocolActionTypeUrl;
        protocol.callBack = callBack;
        [self redirect:protocol];
        return protocol;
    }
    return nil;
}

#pragma mark - 执行协议对象
- (void)goProtocol:(ZHProtocol *_Nullable)protocol{
    [self goProtocol:protocol withCallBack:nil isPush:YES];
}

- (void)goProtocol:(ZHProtocol *_Nullable)protocol withCallBack:(id _Nullable)callBack{
    [self goProtocol:protocol withCallBack:callBack isPush:YES];
}

- (void)goProtocol:(ZHProtocol *)protocol withCallBack:(id)callBack isPush:(BOOL)isPush{
    protocol.isPush = isPush;
    protocol.actionType = ZHProtocolActionTypeUrl;
    protocol.callBack = callBack;
    [self redirect:protocol];
}

#pragma mark - 执行协议以后路由做调整处理
- (void)redirect:(ZHProtocol *)protocol{
    __block id<ZHRouterRole> existedRole = nil;
    for(id<ZHRouterRole> role in _rules){
        if([role respondsToSelector:@selector(targets)]){
            NSArray *targets = [role targets];
            [targets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *target = (NSString *)obj;
                if([target isEqualToString:protocol.target]){
                    *stop = true;
                    existedRole = role;
                }
            }];
        }
        if(existedRole && [existedRole respondsToSelector:@selector(redirect:)]){
            [existedRole redirect:protocol];
            return;
        }
    }
    if (protocol.isPush) {
        [[ZHRouterManager router] push:protocol.target
                              animated:YES
                              callBack:protocol.callBack
                             paramsDic:protocol.params
                isHiddenTabbarWhenPush:YES
                            completion:nil];
    }else{
        [[ZHRouterManager router] present:protocol.target
                                 animated:YES
                                 callBack:protocol.callBack
                                paramsDic:protocol.params
                               completion:nil];
    }
}

#pragma mark - push vc
- (void)push:(UIViewController *)vc{
    [self push:vc completion:nil];
}

- (void)push:(UIViewController *)vc completion:(void(^)(void))completion{
    if([ZHRouterManager router].navigationController){
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        vc.hidesBottomBarWhenPushed = YES;
        [[ZHRouterManager router].navigationController pushViewController:vc animated:YES];
        [CATransaction commit];
    }
}

#pragma mark - present vc
- (void)present:(UIViewController *)vc{
    [self present:vc completion:nil identifier:nil];
}

- (void)present:(UIViewController *)vc completion:(void(^)(void))completion{
    [self present:vc completion:nil identifier:nil];
}

- (void)present:(UIViewController *)vc completion:(void(^)(void))completion identifier:(NSString *)identifier{
    UINavigationController *nc = [ZHRouterManager router].navigationController;
    if(identifier && [identifier isEqualToString:nc.identifier]){
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        vc.hidesBottomBarWhenPushed = YES;
        [[ZHRouterManager router].navigationController pushViewController:vc animated:YES];
        [CATransaction commit];
        return;
    }
    UINavigationController *navi = [[_nc alloc]initWithRootViewController:vc];
    navi.identifier = identifier;
    navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[ZHRouterManager router].viewController presentViewController:navi animated:YES completion:completion];
}

@end
