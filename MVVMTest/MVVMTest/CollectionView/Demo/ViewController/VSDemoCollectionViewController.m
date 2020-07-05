//
//  VSDemoCollectionViewController.m
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "VSDemoCollectionViewController.h"
#import "VSDemoCollectionViewModel.h"

@interface VSDemoCollectionViewController()

@property (strong, nonatomic) VSDemoCollectionViewModel *viewModel;

@end

@implementation VSDemoCollectionViewController
@synthesize viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[VSDemoCollectionViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self bindViewModel];
    
    [self.viewModel requestDataList];
}

- (void)bindViewModel {
    @weakify(self);
    
    self.viewModel.reloadDataBlock = ^{
        @strongify(self);
        [self reloadData];
    };
    
    self.viewModel.showLoadingView = ^(BOOL show) {
//        @strongify(self);
//        if (show) {
//            [[VSLoadingView sharedInstance] show:self.view];
//        } else {
//            [[VSLoadingView sharedInstance] hidden];
//        }
    };
    
    self.viewModel.toastMessage = ^(NSString * _Nonnull message) {
        //[VSMessageView showMessage:message];
    };
}

@end
