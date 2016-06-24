//
//  UIScrollView+TopOrFoot.h
//  UISrollViewTopAndFoot
//
//  Created by lhy on 16/6/20.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (TopOrFoot)

- (void)scrollToTopWithAnimated:(BOOL)animated;

- (void)scrollToFootWithAnimated:(BOOL)animated;

@end
