//
//  MJRefreshAutoGifFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshAutoGifFooter.h"

@interface MJRefreshAutoGifFooter()
@property (weak, nonatomic) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;

@property (weak, nonatomic) UIImageView *logo;

@end

@implementation MJRefreshAutoGifFooter
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        gifView.frame = CGRectMake(0, 0, 10, 10);
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}


#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_show_down"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    self.logo = logo;
    [self addSubview:logo];
    self.logo.frame = CGRectMake(0, 0, 20, 20);
    _logo.center = CGPointMake(self.center.x-50, self.center.y);
    
}




#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state
{
    [self setImages:images duration:images.count * 0.1 forState:state];
}

#pragma mark - 实现父类的方法
- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.gifView.frame = CGRectMake(0, 0, 20, 20);
    
    
    if (self.isRefreshingTitleHidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    } else {
//        self.gifView.contentMode = UIViewContentModeRight;
//        self.gifView.mj_w = self.mj_w * 0.5 - 90;

        _gifView.center = CGPointMake(self.center.x-50, self.center.y);
    }
    
    self.logo.bounds = CGRectMake(0, 0, 20, 20);
    
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    
    switch (state) {
        case MJRefreshStateIdle:{
            
            self.logo.hidden = NO;
            self.gifView.hidden = YES;
            
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.logo.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
            

            break;
        }
            
        case MJRefreshStatePulling:{
           
            self.logo.hidden = NO;
            self.gifView.hidden = YES;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.logo.transform = CGAffineTransformIdentity;
            }];

            break;
        }
            
        case MJRefreshStateRefreshing:{
           
            _logo.hidden = NO;
            
            NSArray *images = self.stateImages[@(state)];
            if (images.count == 0) return;
            [self.gifView stopAnimating];
            
            self.gifView.hidden = NO;
            if (images.count == 1) { // 单张图片
                self.gifView.image = [images lastObject];
            } else { // 多张图片
                self.gifView.animationImages = images;
                self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
                [self.gifView startAnimating];
            }
            
            break;
        }
            
        case MJRefreshStateWillRefresh:
            
            break;
            
        case MJRefreshStateNoMoreData:{
            
            [self.gifView stopAnimating];
            self.gifView.hidden = YES;
            
            break;
        }
            
        default:
            break;
    }
    
    
    
    
    
//    // 根据状态做事情
//    if (state == MJRefreshStateRefreshing) {
//
//        _logo.hidden = YES;
//        
//        NSArray *images = self.stateImages[@(state)];
//        if (images.count == 0) return;
//        [self.gifView stopAnimating];
//        
//        self.gifView.hidden = NO;
//        if (images.count == 1) { // 单张图片
//            self.gifView.image = [images lastObject];
//        } else { // 多张图片
//            self.gifView.animationImages = images;
//            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
//            [self.gifView startAnimating];
//        }
//    } else if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
//        [self.gifView stopAnimating];
//        self.gifView.hidden = YES;
//        
//    }else{
//    
//        //
//        switch (state) {
//            case MJRefreshStateIdle:{
//                
//                self.logo.hidden = NO;
//                self.gifView.hidden = YES;
//                
//                [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
//                    self.logo.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
//                }];
//                break;
//            }
//                
//            case MJRefreshStatePulling:{
//                
//                [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
//                    self.logo.transform = CGAffineTransformIdentity;
//                }];
//                
//                self.logo.hidden = NO;
//                self.gifView.hidden = YES;
//                
//                break;
//            }
//                
//            case MJRefreshStateRefreshing:{
//                
//                self.logo.hidden = YES;
//                NSArray *images = self.stateImages[@(state)];
//                if (images.count == 0) return;
//                
//                self.gifView.hidden = NO;
//                [self.gifView stopAnimating];
//                if (images.count == 1) { // 单张图片
//                    self.gifView.image = [images lastObject];
//                } else { // 多张图片
//                    self.gifView.animationImages = images;
//                    self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
//                    [self.gifView startAnimating];
//                }
//                
//                break;
//            }
//                
//            case MJRefreshStateWillRefresh:
//                
//                break;
//        }
//
//        
//    }
}
@end

