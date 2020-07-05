//
//  GoodsListViewController.m
//  MVVMTest
//
//  Created by yongsheng on 2020/5/8.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsListViewModel.h"
#import "GoodsListCellModel.h"
#import "GoodsListTableViewCell.h"


@interface GoodsListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GoodsListViewModel *viewModel;
@end

@implementation GoodsListViewController

- (instancetype)initWithViewModel:(GoodsListViewModel *)viewModel {
    if(self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupUI];
    [self registerBlocks];
    [self.viewModel requestDataList];
}


- (void)setupUI {
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - registerBlocks

- (void)registerBlocks {
    //@weakify(self);
    [self.viewModel registerReloadDataBlock:^{
        //@strongify(self);
        [self reloadTableView];
    }];
    
    // 请求loading框
    [self.viewModel registerShowLoadingBlock:^(BOOL isShow) {
        //@strongify(self)
    }];
    
    // toast提示框
    [self.viewModel registerShowMessageBlock:^(NSString *msg) {
        //@strongify(self)
        //[self showMessage:msg];
    }];
}

- (void)reloadTableView {
    [self.tableView reloadData];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
}

- (UITableViewCell<VSTableCellProtocol> *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<VSTableCellModelProtocol> cellModel = [self.viewModel cellForRowAtIndexPath:indexPath];
    UITableViewCell<VSTableCellProtocol> *cell = [[cellModel cellClass] cellWithTableView:tableView];
    [cell updateWithCellModel:cellModel];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end


