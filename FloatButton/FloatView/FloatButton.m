//
//  FloatButton.m
//  FloatButton
//
//  Created by wenHao Qiu on 2018/3/23.
//  Copyright © 2018年 文豪. All rights reserved.
//  github下载地址 https://github.com/QiuWenHao/FloatButton
//  QQ：664952091
//

#import "FloatButton.h"
#import "FloatView.h"

@interface FloatButton()

/**记录原始Point*/
@property (nonatomic, assign) CGPoint oldPoint;

/**记录新Point*/
@property (nonatomic, assign) CGPoint newPoint;

/***屏幕状态是否改变***/
@property (nonatomic, assign) BOOL isStateChange;

/***记录张开放式***/
@property (nonatomic, assign) ZJGameViewOpenStyle openStyle;

/***弹出的view***/
@property (nonatomic, strong) FloatView *contentView;

@end

@implementation FloatButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        
        self.newPoint = frame.origin;
        
        [self addGestureRecognizer:pan];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
    return self;
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        _contentView = (FloatView *)self.superview;
        
        _openStyle = _contentView.openStyle;
        
        _oldPoint = self.superview.frame.origin;
    }
    
    CGPoint pt = [pan translationInView:self.superview.superview];
    
    _newPoint = CGPointMake(pt.x + self.oldPoint.x, pt.y + self.oldPoint.y);
    
    [self adjustBtnFrame];
}

- (void)adjustBtnFrame {
    
    //如果按钮的移动由屏幕旋转导致
    if (_isStateChange == YES) {
        
        _isStateChange = NO;
        
        _contentView = (FloatView *)self.superview;
        
        _openStyle = _contentView.openStyle;
        
        _oldPoint = self.superview.frame.origin;
        
        _newPoint = CGPointMake(self.oldPoint.x, self.oldPoint.y);
    }
    
    CGRect frame = self.superview.frame;
    
    frame.origin = _newPoint;
    
    if (_newPoint.x < 0) {
        
        frame.origin.x = 0;
    }
    
    if (_newPoint.x > [UIScreen mainScreen].bounds.size.width - frame.size.width) {
        
        frame.origin.x = [UIScreen mainScreen].bounds.size.width - frame.size.width;
    }
    
    if (_newPoint.y < 20) {
        
        frame.origin.y = 20;
    }
    
    if (_newPoint.y > [UIScreen mainScreen].bounds.size.height - frame.size.height) {
        
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    }
    
    //处于张开时需要考虑移动之前的openStyle，否则影响关闭
    if (_contentView.isOpen == YES) {
        
        //如果是向左张开的,此时frame.origin.x + _contentView.openStateWidth - _contentView.closeStateWidth/2为悬浮按钮中心位置
        if (_contentView.openStyle == ZJGameViewOpenStyleLeft) {
            
            if (frame.origin.x + _contentView.openStateWidth - _contentView.closeStateWidth/2 > [UIScreen mainScreen].bounds.size.width/2) {
                
                [self isOnRightAndDetermineStartMoveOpenStyle];
            }
            else {
                
                [self isOnLeftAndDetermineStartMoveOpenStyle];
            }
        }
        
        //如果是向右张开的,此时frame.origin.x + _contentView.closeStateWidth/2为悬浮按钮中心位置
        else {
            
            if (frame.origin.x + _contentView.closeStateWidth/2 > [UIScreen mainScreen].bounds.size.width/2) {
                
                [self isOnRightAndDetermineStartMoveOpenStyle];
            }
            else {
                
                [self isOnLeftAndDetermineStartMoveOpenStyle];
            }
        }
    }
    
    //处于关闭时无需考虑移动之前的openStyle
    else {
        
        if (_contentView.center.x > [UIScreen mainScreen].bounds.size.width/2) {
            
            [self isOnRight];
        }
        else {
            
            [self isOnLeft];
        }
    }
    
    [UIView animateWithDuration:.6
                          delay:.0
         usingSpringWithDamping:.2
          initialSpringVelocity:6
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         
                         _contentView.frame = frame;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)isOnLeft {
    
    _contentView.isOnLeft = YES;
    
    _contentView.openStyle = ZJGameViewOpenStyleRight;
}

- (void)isOnRight {
    
    _contentView.isOnLeft = NO;
    
    _contentView.openStyle = ZJGameViewOpenStyleLeft;
}

- (void)isOnLeftAndDetermineStartMoveOpenStyle {
    
    [self isOnLeft];
    
    //确定移动之前的openStyle
    if (_openStyle != _contentView.openStyle) {
        
        _contentView.openStyle = ZJGameViewOpenStyleLeft;
    }
}

- (void)isOnRightAndDetermineStartMoveOpenStyle {
    
    [self isOnRight];
    
    //确定移动之前的openStyle
    if (_openStyle != _contentView.openStyle) {
        
        _contentView.openStyle = ZJGameViewOpenStyleRight;
    }
}

- (void)statusBarOrientationChanged:(NSNotification *)notification {
    
    _isStateChange = YES;
    
    [self adjustBtnFrame];
}

@end
