//
//  ZHBaseSheet.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/6/19.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHBaseSheet.h"
#import "UIView+Extension.h"
#import "ZHMacro.h"

@interface ZHBaseSheet ()<UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIView *patchView;
@property (nonatomic , assign) CGFloat heightForFromNavBottomType;

@end

@implementation ZHBaseSheet

- (instancetype) init{
    if(self = [super init]){
        [self initSelf];
    }
    return self;
}

- (void)initSelf{
    _shouldTapToDismiss = YES;
    _showType = ZHBaseSheetPanelViewShowTypeFromBottom;
    
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    _patchView = [[UIView alloc] init];
    _patchView.frame = self.bounds;
    _patchView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    _patchView.tag = 100;
    [self addSubview:_patchView];
    __weak __typeof__(self) weakSelf = self;
    [_patchView tapped:^(UITapGestureRecognizer * _Nonnull gesture) {
        if(weakSelf.shouldTapToDismiss){
            [weakSelf dismiss:nil];
        }
    } delegate:self];
}

- (void)show{
    if (!_panelView)
        return;
    if (!_panelView.superview)
        [self addSubview:_panelView];
    [self initViewsPostion];
    [SCREEN addSubview:self];
    [UIView animateWithDuration:0.3
                     animations:^{
                         _patchView.alpha = 1;
                         switch (_showType) {
                             case ZHBaseSheetPanelViewShowTypeFromBottom:{
                                 _panelView.top = SCREEN_HEIGHT - _panelView.height;
                             }
                                 break;
                             case ZHBaseSheetPanelViewShowTypeFromTop:{
                                 _panelView.top = 0;
                             }
                                 break;
                             case ZHBaseSheetPanelViewShowTypeFromRight:{
                                 _panelView.left = SCREEN_WIDTH - _panelView.width;
                             }
                                 break;
                             case ZHBaseSheetPanelViewShowTypeFromLeft:{
                                 _panelView.left = 0;
                             }
                                 break;
                             case ZHBaseSheetPanelViewShowTypeFromNavBottom:{
                                 _panelView.height = _heightForFromNavBottomType;
                             }
                                 break;
                             default:
                                 break;
                         }
                     } completion:^(BOOL finished){
                         
                     }];
}

- (void)dismiss:(void(^)(void))finish{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self initViewsPostion];
                     }completion:^(BOOL finished){
                         [self removeFromSuperview];
                         !finish ? : finish();
                     }];
}

- (void)setPanelView:(UIView *)panelView{
    _panelView = panelView;
    _heightForFromNavBottomType = panelView.height;
}

- (void)initViewsPostion{
    _patchView.alpha = 0;
    
    switch (self.showType) {
        case ZHBaseSheetPanelViewShowTypeFromBottom:{
            _panelView.top = SCREEN_HEIGHT;
            _panelView.left = 0;
        }
            break;
        case ZHBaseSheetPanelViewShowTypeFromTop:{
            _panelView.bottom = 0;
            _panelView.left = 0;
        }
            break;
        case ZHBaseSheetPanelViewShowTypeFromRight:{
            _panelView.left = SCREEN_WIDTH;
            _panelView.centerY = self.height / 2;
        }
            break;
        case ZHBaseSheetPanelViewShowTypeFromLeft:{
            _panelView.left = -SCREEN_WIDTH;
            _panelView.centerY = self.height / 2;
        }
            break;
        case ZHBaseSheetPanelViewShowTypeFromNavBottom:{
            _panelView.height = 0;
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if(touch.view.tag == 100){
        return YES;
    }
    return NO;
}


@end
