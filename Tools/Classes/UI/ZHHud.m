//
//  ZHHud.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/8.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHHud.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "ZHMacro.h"
#import "UIView+Extension.h"
#import "Masonry.h"

@interface ZHHud ()

@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) UIImageView *loadingIV;

@end

@implementation ZHHud

- (instancetype)init{
    self = [super init];
    if(self){
        [self initWidgets];
    }
    return self;
}

- (void)initWidgets{
    self.backgroundColor = [UIColor clearColor];
    
    _backView = [UIView new];
    _backView.cornerRadius = 10;
    [_backView layerShadow:HexRGB(0x3b4a5a) opacity:0.1 radius:5 offset:CGSizeMake(0, 0)];
    _backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.center.equalTo(self);
    }];
    
    /*
    _loadingIV = [FLAnimatedImageView new];
    _loadingIV.contentMode = UIViewContentModeScaleAspectFit;
    [_backView addSubview:_loadingIV];
    __weak __typeof__(self) Weakself = self;
    [_loadingIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Weakself.backView);
    }];
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle bundleForClass:[ZHHud class]]
                                                URLForResource:@"UI_RES"
                                                withExtension:@"bundle"]];
    NSString  *filePath = [bundle  pathForResource:@"zh_stl_loading" ofType:@"gif"];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    _loadingIV.backgroundColor = [UIColor clearColor];
    _loadingIV.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    */
    
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle bundleForClass:[ZHHud class]]
                                                URLForResource:@"BASE_RES"
                                                withExtension:@"bundle"]];
    NSString  *filePath = [bundle  pathForResource:@"loading" ofType:@"png"];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    
    _loadingIV = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
    _loadingIV.contentMode = UIViewContentModeScaleAspectFit;
    _loadingIV.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_loadingIV];
    [_loadingIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backView);
        make.top.mas_equalTo(self.backView).mas_offset(13);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation.duration = 2.2;
    basicAnimation.fromValue = 0 ;//可以不设置，默认为图层初始
    basicAnimation.toValue = @(2*M_PI);
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.repeatCount = HUGE_VALF;//无限循环
    [_loadingIV.layer addAnimation:basicAnimation forKey:@"basic"];
    

    
    NSString  *center_filePath = [bundle  pathForResource:@"loading_center" ofType:@"png"];
    NSData  *center_imageData = [NSData dataWithContentsOfFile:center_filePath];
    
    UIImageView *centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:center_imageData]];
    centerImageView.backgroundColor = [UIColor clearColor];
    centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_backView addSubview:centerImageView];
    [centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.loadingIV);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    UILabel *loadingLabel = [[UILabel alloc] init];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.font = [UIFont systemFontOfSize:10];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.text = @"正在加载...";
    [_backView addSubview:loadingLabel];
    [loadingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backView);
        make.top.mas_equalTo(self.loadingIV.mas_bottom).mas_offset(11);
    }];
    
    
}

#pragma mark - public
- (void)show{
    [self showInView:nil];
}

- (void)showInView:(UIView * _Nullable)view{
    if(!view){
        view = SCREEN;
    }
    _isShowing = YES;
    [view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [_loadingIV startAnimating];
    _loadingIV.alpha = 0;
    __weak __typeof__(self) Weakself = self;

    [UIView animateWithDuration:0.3
                     animations:^{
                         Weakself.loadingIV.alpha = 1;
                     }];
}

- (void)dismiss{
    _isShowing = NO;
    __weak __typeof__(self) Weakself = self;
    [UIView animateWithDuration:0.3
                     animations:^{
                         Weakself.loadingIV.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [Weakself.loadingIV stopAnimating];
                     }];
}


@end
