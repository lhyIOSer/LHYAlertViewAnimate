//
//  LHYAlertView.h
//  UISrollViewTopAndFoot
//
//  Created by lhy on 16/6/22.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LHYAlertViewCompletionBlock)(BOOL cancelled, NSInteger buttonIndex);

@interface LHYAlertView : UIView

+ (void)showWithTitl:(NSString *)title withMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle withCompletionBlock:(LHYAlertViewCompletionBlock) completionBlock;

@end


@interface LHYAlertMainView : UIView

@property (nonatomic, assign) CGFloat alterViewHeight;

- (void)configureWithTitl:(NSString *)title withMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle withCompletionBlock:(LHYAlertViewCompletionBlock) completionBlock;

- (void)showAnimate;

- (void)hiddenAnimate;

@end
