//
//  ViewController.m
//  MVVMTest
//
//  Created by yongsheng on 2020/5/8.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "ViewController.h"
#import "GoodsListViewController.h"
#import "GoodsListViewModel.h"
#import "VSDemoCollectionViewController.h"

static NSArray<NSString *> *DemoTableViewCellTextArray;
static NSArray<NSString *> *DemoTableViewCellActionArray;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

/**  */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

+ (void)load {
    DemoTableViewCellTextArray = @[
        @"TableView测试",
        @"Collection测试"
    ];
    DemoTableViewCellActionArray = @[
        NSStringFromSelector(@selector(tableViewMVVM)),
        NSStringFromSelector(@selector(collectionMVVM))
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
}

- (void)setupTableView
{
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DemoTableViewCellTextArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = DemoTableViewCellTextArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row > DemoTableViewCellActionArray.count) {
        return;
    }
    SEL selector = NSSelectorFromString(DemoTableViewCellActionArray[indexPath.row]);
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector];
#pragma clang diagnostic pop
    }
}

- (void)tableViewMVVM {
    GoodsListInputParams *parmas = [[GoodsListInputParams alloc] init];
    GoodsListViewModel *viewModel = [[GoodsListViewModel alloc] initWithInputParams:parmas];
    GoodsListViewController *vc = [[GoodsListViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectionMVVM {
    VSDemoCollectionViewController *vc = [[VSDemoCollectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
