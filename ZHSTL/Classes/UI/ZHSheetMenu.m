//
//  ZHSheetMenu.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/6/19.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHSheetMenu.h"
#import "UIView+Extension.h"
#import "ZHMacro.h"
#import "ZHElasticButton.h"
#import "UIButton+Extension.h"
#import "Masonry.h"
#import "UIImage+Extension.h"

const static CGFloat ZHSheetMenuCellHeight = 45; //cell高度

@interface ZHSheetMenu ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) ZHElasticButton *cancelBtn;

@property (nonatomic , copy) ZHSheetMenuSelectionAction selectionAction; //选择回调
@property (nonatomic , copy) ZHSheetMenuCancelAction cancelAction; //取消回调

@end

@implementation ZHSheetMenu

- (instancetype)init{
    self = [super init];
    if(self){
        [self initWidgets];
    }
    return self;
}

- (void)initWidgets{
    __weak __typeof__(self) weakSelf = self;
    _backView = [UIView new];
    _backView.backgroundColor = HexRGB(0xf3f6f6);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
#endif
    _tableView.backgroundColor = HexRGB(0xf3f6f6);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.frame = CGRectMake(0, self.height, self.width, 0);
    _tableView.bounces = NO;
    _tableView.delaysContentTouches = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_backView addSubview:_tableView];
    
    _cancelBtn = [ZHElasticButton new];
    _cancelBtn.backgroundColor = [UIColor whiteColor];
    _cancelBtn.font = FONT(14);
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:HexRGB(0x7f8a97) forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:HexRGB(0x7f8a97) forState:UIControlStateHighlighted];
    _cancelBtn.shouldAnimate = NO;
    [_cancelBtn clickAction:^(UIButton * _Nonnull button) {
        [weakSelf dismissWithCompletion:nil];
        !weakSelf.cancelAction? : weakSelf.cancelAction();
    }];
    [_backView addSubview:_cancelBtn];
}

#pragma mark - setter
- (void)setDateArr:(NSArray *)dateArr{
    _dateArr = dateArr;
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dateArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ZESheetMenuCell";
    ZHSheetMenuCell *cell = (ZHSheetMenuCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ZHSheetMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.separator.hidden = 0 == indexPath.row;
    cell.text = [_dateArr objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZHSheetMenuCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak __typeof__(self) weakSelf = self;
    [self dismissWithCompletion:^{
        if(weakSelf.selectionAction){
            weakSelf.selectionAction(indexPath.row);
        }
    }];
}

#pragma mark - public
- (void)show{
    NSInteger lineNum = _dateArr.count > 5 ? 5 : _dateArr.count;
    _backView.size = CGSizeMake(SCREEN_WIDTH,(lineNum + 1) * ZHSheetMenuCellHeight + 10);
    _tableView.frame = CGRectMake(0,
                                  0,
                                  _backView.width,
                                  lineNum * ZHSheetMenuCellHeight);
    _cancelBtn.frame = CGRectMake(0, _tableView.bottom + 10, _backView.width, ZHSheetMenuCellHeight);
    self.panelView = _backView;
    [super show];
}

- (void)dismissWithCompletion:(void(^)(void))completion{
    [super dismiss:completion];
}

- (void)selectionAction:(void(^_Nonnull)(NSUInteger index))action{
    _selectionAction = action;
}

- (void)cancelAction:(void(^_Nonnull)(void))action{
    _cancelAction = action;
}

@end





@interface ZHSheetMenuCell ()

@property (nonatomic , strong) UILabel *textLab;

@end

@implementation ZHSheetMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UIView *view = [UIView new];
        view.backgroundColor = HexRGB(0xf0f0f0);
        self.selectedBackgroundView = view;
        
        _separator = [[UIImageView alloc]init];
        _separator.image = [UIImage imageWithColor:HexRGB(0xeeeeee)];
        _separator.hidden = YES;
        [self.contentView addSubview:_separator];
        [_separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(LINE_HEIGHT);
        }];
        
        _textLab = [UILabel new];
        _textLab.font = FONT(14);
        _textLab.textAlignment = NSTextAlignmentCenter;
        _textLab.textColor = HexRGB(0x3b4a5a);
        [self.contentView addSubview:_textLab];
        [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = text;
    _textLab.text = text;
}

@end
