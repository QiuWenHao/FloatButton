//
//  FloatView.h
//  FloatButton
//
//  Created by wenHao Qiu on 2018/3/23.
//  Copyright © 2018年 文豪. All rights reserved.
//  github下载地址 https://github.com/QiuWenHao/FloatButton
//  QQ：664952091
//

#import <UIKit/UIKit.h>
#import "FloatButton.h"

typedef NS_ENUM(NSInteger,ZJGameViewOpenStyle) {
    
    ZJGameViewOpenStyleLeft = 0,
    ZJGameViewOpenStyleRight
};

@interface FloatView : UIView

/***悬浮按钮***/
@property (nonatomic, strong) FloatButton *floatBtn;

/***张开放式***/
@property (nonatomic, assign) ZJGameViewOpenStyle openStyle;

/***张开时的宽度***/
@property (nonatomic, assign) CGFloat openStateWidth;

/***关闭时的宽度***/
@property (nonatomic, assign) CGFloat closeStateWidth;

/***是否在展开状态***/
@property (nonatomic, assign) BOOL isOpen;

/***是否在左侧***/
@property (nonatomic, assign) BOOL isOnLeft;

- (void)btnClick:(UIButton *)btn;

@end
