//
//  FloatView.m
//  FloatButton
//
//  Created by wenHao Qiu on 2018/3/23.
//  Copyright © 2018年 文豪. All rights reserved.
//  github下载地址 https://github.com/QiuWenHao/FloatButton
//  QQ：664952091
//

#import "FloatView.h"

@interface FloatView ()

@property (nonatomic, strong) UIButton *userManagerBtn;

@property (nonatomic, strong) UIButton *hideBtn;

@end

@implementation FloatView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.cornerRadius = frame.size.height/2;
        
        self.closeStateWidth = frame.size.height;
        
        if (self.openStateWidth == 0) {
            
            self.openStateWidth = 3 * self.closeStateWidth;
        }
        
        if (frame.origin.x > [UIScreen mainScreen].bounds.size.width) {
            
            self.isOnLeft = NO;
        }
        
        else {
            
            self.isOnLeft = YES;
        }
        
        _userManagerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _userManagerBtn.alpha = 0;
        
        _userManagerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _userManagerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [_userManagerBtn setTitle:@"账号管理" forState:UIControlStateNormal];
        
        _userManagerBtn.frame = CGRectMake(0, (frame.size.height - 30)/2, 60, 30);
        
        [_userManagerBtn setTitleColor:[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [_userManagerBtn addTarget:self action:@selector(userManagerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        _hideBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        
        _hideBtn.alpha = 0;
        
        _hideBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_hideBtn setTitle:@"隐藏" forState:UIControlStateNormal];
        
        _hideBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _hideBtn.frame = CGRectMake(0, (frame.size.height - 30)/2, 40, 30);
        
        [_hideBtn setTitleColor:[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [_hideBtn addTarget:self action:@selector(hideBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        _floatBtn = [[FloatButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
        
        _floatBtn.layer.cornerRadius = frame.size.height/2;
        
        _floatBtn.layer.masksToBounds = YES;
        
        UIImage *image = [UIImage imageNamed:@"floatImage"];
        
        [_floatBtn setImage:image forState:UIControlStateNormal];
        
        [_floatBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_userManagerBtn];
        
        [self addSubview:_hideBtn];
        
        [self addSubview:_floatBtn];
    }
    
    return self;
}

- (void)btnClick:(UIButton *)btn {
    
    btn.userInteractionEnabled = NO;
    
    btn.selected = !btn.selected;
    
    CGRect frame = self.frame;
    
    CGRect btnFrame = btn.frame;
    
    CGRect userManagerBtnFrame = _userManagerBtn.frame;
    
    CGRect hideBtnFrame = _hideBtn.frame;
    
    CGFloat addWidth = self.openStateWidth - self.closeStateWidth;
    
    if (btn.selected) {
        
        if (self.isOnLeft == YES) {
            
            self.openStyle = ZJGameViewOpenStyleRight;
        }
        else {
            
            self.openStyle = ZJGameViewOpenStyleLeft;
        }
        
        if (self.openStyle == ZJGameViewOpenStyleLeft) {
            
            frame.origin.x -= addWidth;
            
            btnFrame.origin.x += addWidth;
            
            userManagerBtnFrame.origin.x += self.openStateWidth - 57 - userManagerBtnFrame.size.width;
            
            hideBtnFrame.origin.x += self.openStateWidth - 127 - hideBtnFrame.size.width;
        }
        else {
            
            userManagerBtnFrame.origin.x += 57;
            
            hideBtnFrame.origin.x += 127;
        }
        
        frame.size.width = self.openStateWidth;
    }
    else {
        
        if (self.openStyle == ZJGameViewOpenStyleLeft) {
            
            frame.origin.x += addWidth;
            
            btnFrame.origin.x -= addWidth;
            
            userManagerBtnFrame.origin.x -= self.openStateWidth - 57 - userManagerBtnFrame.size.width;
            
            hideBtnFrame.origin.x -= self.openStateWidth - 127 - hideBtnFrame.size.width;
        }
        else {
            
            userManagerBtnFrame.origin.x -= 57;
            
            hideBtnFrame.origin.x -= 127;
        }
        
        frame.size.width = self.closeStateWidth;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        if (btn.selected) {
            
            _isOpen = YES;
            
            _userManagerBtn.alpha = 1;
            
            _hideBtn.alpha = 1;
            
            self.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
        }
        else {
            
            _isOpen = NO;
            
            _userManagerBtn.alpha = 0;
            
            _hideBtn.alpha = 0;
            
            self.backgroundColor = [UIColor clearColor];
        }
        
        self.frame = frame;
        
        btn.frame = btnFrame;
        
        _userManagerBtn.frame = userManagerBtnFrame;
        
        _hideBtn.frame = hideBtnFrame;
        
    } completion:^(BOOL finished) {
        
        btn.userInteractionEnabled = YES;
    }];
}

- (void)hideBtnClicked {
    
    [self removeFromSuperview];
    
    NSLog(@"移除按钮");
}

- (void)userManagerBtnClicked {
    
    //关闭floatView
    [self btnClick:_floatBtn];
    
    NSLog(@"账号管理");
}

@end
