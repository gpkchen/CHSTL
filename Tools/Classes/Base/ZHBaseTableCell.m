//
//  ZHBaseTableCell.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/27.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHBaseTableCell.h"
#import "Masonry.h"
#import "UIImage+Extension.h"
#import "ZHMacro.h"

@implementation ZHBaseTableCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _separator = [[UIImageView alloc]init];
        _separator.image = [UIImage imageWithColor:HexRGB(0xeeeeee)];
        _separator.hidden = YES;
        [self.contentView addSubview:_separator];
        [_separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(LINE_HEIGHT);
        }];
        
        _arrow = [UIImageView new];
        _arrow.hidden = YES;
        [self.contentView addSubview:_arrow];
        NSBundle *bundle = [NSBundle bundleForClass:[ZHBaseTableCell class]];
        _arrow.image = [UIImage imageNamed:@"zh_stl_cell_arrow_navy"
                                  inBundle:[NSBundle bundleWithURL:[bundle URLForResource:@"BASE_RES" withExtension:@"bundle"]]
             compatibleWithTraitCollection:nil];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).mas_offset(-10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(_arrow.image.size);
        }];
        
        UIView *view = [UIView new];
        view.backgroundColor = HexRGB(0xf0f0f0);
        self.selectedBackgroundView = view;
    }
    return self;
}

- (void) setArrowImg:(UIImage *)arrowImg{
    _arrowImg = arrowImg;
    _arrow.image = arrowImg;
    [_arrow mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(_arrow.image.size);
    }];
}

@end
