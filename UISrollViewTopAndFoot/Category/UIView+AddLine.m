//
//  UIView+AddLine.m
//  ViewLine
//
//  Created by lhy on 16/5/25.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "UIView+AddLine.h"
#import "Masonry.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

#define kViewWidth self.frame.size.width
#define kViewHeight self.frame.size.height

static NSInteger const topLineTag = 1008611321;
static NSInteger const bottomLineTag = 1008611322;

@implementation UIView (AddLine)

#pragma mark - 设置分割线颜色
///设置分割线颜色
- (void)setLineColor:(UIColor *)color {
    [self setTopLineColor:color];
    [self setBottomLineColor:color];
}

///设置上分割线颜色
- (void)setTopLineColor:(UIColor *)color {
    UIView *view = [self viewWithTag:topLineTag];
    if (!view) {
        return;
    }
    
    view.backgroundColor = color;
}

///设置下分割线颜色
- (void)setBottomLineColor:(UIColor *)color {
    UIView *view = [self viewWithTag:bottomLineTag];
    if (!view) {
        return;
    }

    view.backgroundColor = color;
}

#pragma mark - 隐藏分割线
///隐藏分割线
- (void)hiddenLine:(BOOL)hidden {
    [self hiddenTopLine:hidden];
    [self hiddenBottomLine:hidden];
}

///隐藏上分割线
- (void)hiddenTopLine:(BOOL)hidden {
    UIView *view = [self viewWithTag:topLineTag];
    if (!view || view.hidden == hidden) {
        return;
    }
    
    view.hidden = hidden;
}

///隐藏下分割线
- (void)hiddenBottomLine:(BOOL)hidden {
    UIView *view = [self viewWithTag:bottomLineTag];
    if (!view || view.hidden == hidden) {
        return;
    }
    
    view.hidden = hidden;
}

#pragma mark - 显示分割线
///增加上分割线
- (void)addTopLineWithLeftEdge:(CGFloat)leftEdge
                 withRightEdge:(CGFloat)rightEdge {
    UIView *view = [self viewWithTag:topLineTag];
    if (!view) {
        view = [[UIView alloc] init];
        view.tag = topLineTag;
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
    }
    
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(0.5);
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(leftEdge);
        make.right.equalTo(self.mas_right).offset(-rightEdge);
    }];
    
    [self addLineEvent:view];
}

///增加下分割线
- (void)addBottomLineWithLeftEdge:(CGFloat)leftEdge
                    withRightEdge:(CGFloat)rightEdge {
    UIView *view = [self viewWithTag:bottomLineTag];
    if (!view) {
        view = [[UIView alloc] init];
        view.tag = bottomLineTag;
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
    }
    
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(0.5);
        make.left.equalTo(self.mas_left).offset(leftEdge);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(-rightEdge);
    }];
    
    [self addLineEvent:view];
}

- (void)addLineEvent:(UIView *)view {
    [self bringSubviewToFront:view];
    view.hidden = NO;
}

@end
