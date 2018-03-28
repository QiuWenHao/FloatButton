//
//  FloatViewManager.h
//  FloatButton
//
//  Created by wenHao Qiu on 2018/3/23.
//  Copyright © 2018年 文豪. All rights reserved.
//  github下载地址 https://github.com/QiuWenHao/FloatButton
//  QQ：664952091
//

#import <Foundation/Foundation.h>

@interface FloatViewManager : NSObject

/*! @brief 显示悬浮按钮
 *
 * @attention 要在keyWindow初始化完成后调用
 */
+ (void)showFloatView;

/*! @brief 隐藏悬浮按钮
 *
 * @attention 隐藏通过FloatViewManager添加的悬浮按钮
 */
+ (void)hideFloatView;

@end
