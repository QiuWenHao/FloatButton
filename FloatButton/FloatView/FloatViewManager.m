//
//  FloatViewManager.m
//  FloatButton
//
//  Created by wenHao Qiu on 2018/3/23.
//  Copyright © 2018年 文豪. All rights reserved.
//  github下载地址 https://github.com/QiuWenHao/FloatButton
//  QQ：664952091
//

#import "FloatViewManager.h"
#import "FloatView.h"

@interface FloatViewManager ()

@property (nonatomic, strong)  FloatView *floatView;

@end

@implementation FloatViewManager

static FloatViewManager *instance = nil;

+ (FloatViewManager *)shareManager {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[FloatViewManager alloc] init];
        
        instance.floatView = [[FloatView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
        
        instance.floatView.openStateWidth = 180;
    });
    
    return instance;
}

+ (void)showFloatView {
    
    [FloatViewManager shareManager];
    
    [[UIApplication sharedApplication].keyWindow addSubview:instance.floatView];
}

+ (void)hideFloatView {
    
    [instance.floatView removeFromSuperview];
}

@end
