//
//  UIView+AddLine.h
//  ViewLine
//
//  给UIView增加上下分割线
//
//  Created by lhy on 16/5/25.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddLine)

///设置分割线颜色
- (void)setLineColor:(UIColor *)color;

///设置上分割线颜色
- (void)setTopLineColor:(UIColor *)color;

///设置下分割线颜色
- (void)setBottomLineColor:(UIColor *)color;

///隐藏分割线
- (void)hiddenLine:(BOOL)hidden;

///隐藏上分割线
- (void)hiddenTopLine:(BOOL)hidden;

///隐藏下分割线
- (void)hiddenBottomLine:(BOOL)hidden;

///增加上分割线
- (void)addTopLineWithLeftEdge:(CGFloat)leftEdge
                 withRightEdge:(CGFloat)rightEdge;

///增加下分割线
- (void)addBottomLineWithLeftEdge:(CGFloat)leftEdge
                    withRightEdge:(CGFloat)rightEdge;
@end
