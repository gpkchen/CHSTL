//
//  ZHBanner.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/7/10.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHBanner.h"
#import "UIView+Extension.h"
#import "ZHMacro.h"

@interface ZHBanner()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *baseScrollView; //banner可横向滚动

@property (nonatomic , assign) NSUInteger numOfCell;    //cell数
@property (nonatomic , strong) NSMutableArray *cellArr; //cell样式列表

@property (nonatomic , assign) NSUInteger currentPage;  //当前显示的页数
@property (nonatomic , strong) NSTimer *timer; //自动滚动的timmer

@property (nonatomic , strong) NSMutableArray *dots; //小点
@property (nonatomic , strong) UIView *cursor; //游标

@end

@implementation ZHBanner

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initParam];
        [self initWidgets];
    }
    return self;
}

#pragma mark - 初始化私有参数
- (void)initParam{
    [self removeAllSubviews];
    if([_dataSource respondsToSelector:@selector(numOfCellInBanner:)]){
        _numOfCell = [_dataSource numOfCellInBanner:self];
    }
    if(!_cellArr){
        _cellArr = [NSMutableArray array];
    }else{
        [_cellArr removeAllObjects];
    }
    if([_dataSource respondsToSelector:@selector(banner:viewForCellAtIndex:)]){
        for(int i=0;i<_numOfCell;++i){
            UIView *cell = [_dataSource banner:self viewForCellAtIndex:i];
            [_cellArr addObject:cell];
        }
    }
    if(_numOfCell > 1){
        UIView *lastCell = [_dataSource banner:self viewForCellAtIndex:_numOfCell - 1];
        UIView *firstCell = [_dataSource banner:self viewForCellAtIndex:0];
        [_cellArr insertObject:lastCell atIndex:0];
        [_cellArr addObject:firstCell];
        
        _currentPage = 1;
    }else{
        _currentPage = 0;
    }
}

#pragma mark - 初始化固有控件
- (void)initWidgets{
    
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    self.frame.size.width,
                                                                    self.frame.size.height)];
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        _baseScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    _baseScrollView.showsHorizontalScrollIndicator = YES;
    _baseScrollView.backgroundColor = [UIColor clearColor];
    _baseScrollView.pagingEnabled = YES;
    _baseScrollView.showsHorizontalScrollIndicator = NO;
    _baseScrollView.delegate = self;
    [self addSubview:_baseScrollView];
    
    for(int i=0;i<_cellArr.count;++i){
        UIView *cell = [_cellArr objectAtIndex:i];
        cell.userInteractionEnabled = YES;
        cell.frame = CGRectMake(i * self.frame.size.width,
                                0,
                                self.frame.size.width,
                                self.frame.size.height);
        cell.tag = 100 + i;
        [_baseScrollView addSubview:cell];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(cellDidClicked:)];
        [cell addGestureRecognizer:tap];
    }
    _baseScrollView.contentSize = CGSizeMake(self.frame.size.width * _cellArr.count,
                                             self.frame.size.height);
    if(_numOfCell > 1){
        [_baseScrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
        if(_timer){
            [_timer invalidate];
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                  target:self
                                                selector:@selector(aotoScrollBanner)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    //绘制pagecontroller
    if(_numOfCell > 1){
        if(!_dots){
            _dots = [NSMutableArray array];
        }else{
            for(UIView *dot in _dots){
                [dot removeFromSuperview];
            }
            [_dots removeAllObjects];
        }
        CGFloat x = (self.width - 5 * (_numOfCell + 1) - 8 * _numOfCell) / 2;
        CGFloat y = _pageControlY;
        UIView *lastDot = nil;
        for(int i=0;i<_numOfCell + 1;++i){
            UIView *dot = [[UIView alloc] initWithFrame:CGRectMake(lastDot ? lastDot.right + 8 : x, y, 5, 5)];
            dot.backgroundColor = HexRGB(0x9295aa);
            dot.cornerRadius = 2.5;
            [self addSubview:dot];
            [_dots addObject:dot];
            lastDot = dot;
        }
        _cursor = [[UIView alloc]initWithFrame:CGRectMake(x, y, 18, 5)];
        _cursor.cornerRadius = 2.5;
        _cursor.backgroundColor = [UIColor whiteColor];
        [self addSubview:_cursor];
    }else if(_dots.count){
        for(UIView *dot in _dots){
            [dot removeFromSuperview];
        }
        [_dots removeAllObjects];
    }
}

#pragma mark - 自动滚动
- (void)aotoScrollBanner{
    _currentPage ++;
    [_baseScrollView setContentOffset:CGPointMake(_currentPage * self.frame.size.width, 0) animated:YES];
    if(_currentPage == _numOfCell + 1){
        [_baseScrollView setContentOffset:CGPointMake(0, 0)];
        _currentPage = 1;
    }
    
    if(_numOfCell > 1){
        UIView *dot = [_dots objectAtIndex:_currentPage - 1];
        [UIView animateWithDuration:0.3 animations:^{
            _cursor.left = dot.left;
        }];
    }
}

#pragma mark - cell触摸事件
- (void)cellDidClicked:(UITapGestureRecognizer *)tap{
    NSUInteger index = tap.view.tag - 100;
    if(_numOfCell > 1){
        if(index > 0 && index <= _numOfCell){
            if([_delegate respondsToSelector:@selector(banner:didSelectCellAtIndex:)]){
                [_delegate banner:self
             didSelectCellAtIndex:index - 1];
            }
        }
    }else{
        if([_delegate respondsToSelector:@selector(banner:didSelectCellAtIndex:)]){
            [_delegate banner:self didSelectCellAtIndex:index];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self pauseTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    _currentPage = (int)(targetContentOffset -> x / self.frame.size.width);
    [self resumeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    if (_currentPage == 0) {
        [_baseScrollView setContentOffset:CGPointMake(_numOfCell * self.frame.size.width, 0)];
        _currentPage = _numOfCell;
    }
    if (_currentPage == _numOfCell + 1) {
        [_baseScrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
        _currentPage = 1;
    }
    
    if(_numOfCell > 1){
        UIView *dot = [_dots objectAtIndex:_currentPage - 1];
        [UIView animateWithDuration:0.3 animations:^{
            _cursor.left = dot.left;
        }];
    }
}

#pragma mark - timmer的暂停和恢复
-(void)pauseTimer{
    if (![_timer isValid]){
        return ;
    }
    [_timer setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer{
    if (![_timer isValid]){
        return ;
    }
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setSecond:3];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    [_timer setFireDate:newdate];
}

#pragma mark - public
- (void)reloadData{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - override
- (void) layoutSubviews{
    [super layoutSubviews];
    
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
    [self initParam];
    [self initWidgets];
}

@end
