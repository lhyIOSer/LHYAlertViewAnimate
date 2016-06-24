//
//  ViewController.m
//  UISrollViewTopAndFoot
//
//  Created by lhy on 16/6/20.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UIScrollView+TopOrFoot.h"
#import "NSString+AttributedString.h"
#import "LHYTableviewCell.h"
#import "LHYAlertView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSourceMArr;

@end

static NSString  * const kCellReuseIdentifier = @"CellReuseIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [LHYAlertView showWithTitl:@"提示" withMessage:@"123我的地方的发送到发送到是范德萨发水电费水电费水电费等所发生的的方式放水电费水电费等所发生的发送到发送到发送到发送到45644" cancelButtonTitle:@"取消" okButtonTitle:@"确定" withCompletionBlock:^(BOOL cancelled, NSInteger buttonIndex) {
        NSLog(@"%@", @(cancelled));
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceMArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHYTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.cellType = LHYTableViewCellViewTitleTips;
    cell.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    return cell;
}

#pragma mark - CreateUI 
- (void)createUI {
    [self.view addSubview:self.tableView];
    [self layoutUI];
}

#pragma mark - LayoutUI
- (void)layoutUI {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}

#pragma mark - Init
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LHYTableviewCell class] forCellReuseIdentifier:kCellReuseIdentifier];
    }
    
    return _tableView;
}

- (NSMutableArray *)dataSourceMArr {
    if (!_dataSourceMArr) {
        _dataSourceMArr = [NSMutableArray array];
        for (NSInteger i = 0; i < 15; i++) {
            [_dataSourceMArr addObject:@(i)];
        }
    }
    
    return _dataSourceMArr;
}

@end
