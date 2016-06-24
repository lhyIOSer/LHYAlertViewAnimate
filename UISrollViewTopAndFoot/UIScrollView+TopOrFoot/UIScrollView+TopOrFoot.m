//
//  UIScrollView+TopOrFoot.m
//  UISrollViewTopAndFoot
//
//  Created by lhy on 16/6/20.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "UIScrollView+TopOrFoot.h"

@implementation UIScrollView (TopOrFoot)

- (void)scrollToTopWithAnimated:(BOOL)animated {
    [self setContentOffset:CGPointMake(0, 0) animated:animated];
}

- (void)scrollToFootWithAnimated:(BOOL)animated {
    [self setContentOffset:CGPointMake(0, self.contentSize.height - self.bounds.size.height) animated:animated];
}

@end
