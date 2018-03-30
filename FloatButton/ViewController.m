//
//  ViewController.m
//  FloatButton
//
//  Created by wenHao Qiu on 2018/3/23.
//  Copyright © 2018年 文豪. All rights reserved.
//

#import "ViewController.h"
#import "FloatViewManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    
    /***要在keyWindow初始化完成后调用[FloatViewManager showFloatView]，这时候才能添加**/
    [FloatViewManager showFloatView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
