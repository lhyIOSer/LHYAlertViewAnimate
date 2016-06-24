//
//  LHYAlertView.m
//  UISrollViewTopAndFoot
//
//  Created by lhy on 16/6/22.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "LHYAlertView.h"
#import "UIView+AddLine.h"
#import "NSString+CalcSize.h"
#import "Masonry.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

#define kMainWindow [[UIApplication sharedApplication] delegate].window

@interface LHYAlertView ()

@property (nonatomic, strong) LHYAlertMainView *mainView;

@end

@implementation LHYAlertView

#pragma mark - Lifecycle
+ (void)showWithTitl:(NSString *)title withMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle withCompletionBlock:(LHYAlertViewCompletionBlock) completionBlock {
    LHYAlertView *alterView = [[LHYAlertView alloc] init];
    [alterView.mainView configureWithTitl:title withMessage:message cancelButtonTitle:cancelTitle okButtonTitle:okTitle withCompletionBlock:completionBlock];
    [alterView show];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - Private
- (void)show {
    [kMainWindow addSubview:self];
    [self.mainView showAnimate];
}

#pragma mark - CreateUI
- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
    self.frame = [UIScreen mainScreen].bounds;
    
    [self addSubview:self.mainView];
    
    [self layoutUI];
}

#pragma mark - LayoutUI 
- (void)layoutUI {
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenWidth - 40);
        make.height.offset(self.mainView.alterViewHeight);
        
        make.centerX.equalTo(self.mas_centerX);
    }];
}

#pragma mark - Init
- (LHYAlertMainView *)mainView {
    if (!_mainView) {
        _mainView = [[LHYAlertMainView alloc] initWithFrame:CGRectZero];
    }
    
    return _mainView;
}

@end

#pragma mark - LHYAlertMainView
@interface LHYAlertMainView ()

@property (nonatomic, strong) UILabel  *titleLbl;

@property (nonatomic, strong) UILabel  *tipsLbl;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *okBtn;

@property (nonatomic, copy)LHYAlertViewCompletionBlock completionBlock;

@end

@implementation LHYAlertMainView

#pragma mark - Lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - Public
- (void)configureWithTitl:(NSString *)title withMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle withCompletionBlock:(LHYAlertViewCompletionBlock) completionBlock {
    _completionBlock = completionBlock;
    
    CGFloat txtHeigh = 30;
    if ([title isEmpty]) {
        txtHeigh = 0.0f;
    } else {
        self.titleLbl.text = title;
    }
    
    [self.titleLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(txtHeigh);
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
    if ([message isEmpty]) {
        txtHeigh = 0.0f;
    } else {
        txtHeigh = [message calcTextHeighttText:message withWidth:kScreenWidth - 30 withAttributes:@{NSFontAttributeName:self.tipsLbl.font}];
        txtHeigh = (txtHeigh<30 ? 30:txtHeigh);
        
        if (txtHeigh < 30) {
            txtHeigh = 30;
        } else {
            _alterViewHeight += (txtHeigh - 30);
        }
        
        self.tipsLbl.text = message;
    }
    
    [self.tipsLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(txtHeigh);
        make.top.equalTo(self.titleLbl.mas_bottom);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
}

- (void)showAnimate {
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.superview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(kScreenWidth - 40);
            make.height.offset(_alterViewHeight);
            make.center.equalTo(self.superview);
        }];
        
        //强制绘制
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            self.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void)hiddenAnimate {
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(kScreenWidth - 40);
            make.height.offset(_alterViewHeight);
            make.centerX.equalTo(self.superview.mas_centerX);
            make.top.equalTo(self.superview.mas_bottom);
        }];
        
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.superview removeFromSuperview];
        }
    }];
}

#pragma mark - IBActions
- (void)cancelClick:(UIButton *)sender {
    if (_completionBlock) {
        _completionBlock(YES, 0);
    }
    
    [self hiddenAnimate];
}

- (void)okClick:(UIButton *)sender {
    if (_completionBlock) {
        _completionBlock(NO, 1);
    }
    
    [self hiddenAnimate];
}

#pragma mark - CreateUI
- (void)createUI {
    _alterViewHeight = 100;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 10.f;
    self.transform = CGAffineTransformMakeRotation(-M_PI/100);
    
    [self addSubview:self.titleLbl];
    [self addSubview:self.tipsLbl];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.okBtn];
    
    [self layoutUI];
}

#pragma mark - LayoutUI
- (void)layoutUI {
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(30);
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
    [self.tipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(30);
        make.top.equalTo(self.titleLbl.mas_bottom);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.okBtn);
        make.top.equalTo(self.tipsLbl.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.okBtn.mas_left);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLbl.mas_bottom);
        make.left.equalTo(self.cancelBtn.mas_right);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - Init
- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont boldSystemFontOfSize:17];
        _titleLbl.text = @"提示";
    }
    
    return _titleLbl;
}

- (UILabel *)tipsLbl {
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipsLbl.textAlignment = NSTextAlignmentCenter;
        _tipsLbl.font = [UIFont systemFontOfSize:15];
        _tipsLbl.numberOfLines = 0;
        _tipsLbl.preferredMaxLayoutWidth = kScreenWidth - 20 - 10;
        [_tipsLbl addBottomLineWithLeftEdge:0 withRightEdge:0];
        _tipsLbl.text = @"哈哈哈";
    }
    
    return _tipsLbl;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addRightLineWithLeftEdge:0 withRightEdge:0];
        [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelBtn;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _okBtn;
}

@end

