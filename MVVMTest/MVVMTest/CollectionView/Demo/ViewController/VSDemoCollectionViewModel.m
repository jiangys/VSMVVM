//
//  VSDemoCollectionViewModel.m
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "VSDemoCollectionViewModel.h"
#import "VSDemoCollectionItemCell.h"
#import "VSMVVMCollectionViewSectionModel.h"
#import "VSDemoCollectionItemCellModel.h"

@interface VSDemoCollectionViewModel()
@property (nonatomic, strong) NSMutableArray<NSString *> *titleArray;
@end

@implementation VSDemoCollectionViewModel


- (NSMutableArray<NSString *> *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

// 请求接口
- (void)requestDataList {
    if (self.showLoadingView) {
        self.showLoadingView(NO);
    }
    
    @weakify(self);
    // Mock 请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        if (self.showLoadingView) {
            self.showLoadingView(YES);
        }
        
        for (int i = 0; i < 10; i++) {
            [self.titleArray addObject:[NSString stringWithFormat:@"这是测试数据-%d",i]];
        }
        
        [self reloadSectionModels];
    });
}

// 组装控制器的ViewModel需要的sectionModels数据
- (void)reloadSectionModels
{
    // 定义组
    NSMutableArray<VSMVVMCollectionViewSectionModel *> *sectionModels = [NSMutableArray array];
    
    // 定义组内每一个元素
    VSMVVMCollectionViewSectionModel *sectionModel = [[VSMVVMCollectionViewSectionModel alloc] init];
    [sectionModels addObject:sectionModel];
    sectionModel.sectionTopMargin = 10;
    
    {   // 标题数据
        for (NSString *title in self.titleArray) {
            VSDemoCollectionItemCellModel *cellModel = [[VSDemoCollectionItemCellModel alloc] init];
            cellModel.title = title;
            
            [sectionModel addCellModel:cellModel];
        }
    };
    
    {  // 定义第二Section组
        VSMVVMCollectionViewSectionModel *sectionModel2 = [[VSMVVMCollectionViewSectionModel alloc] init];
        [sectionModels addObject:sectionModel2];
        sectionModel2.sectionTopMargin = 10;
        
        VSDemoCollectionItemCellModel *cellModel = [[VSDemoCollectionItemCellModel alloc] init];
        cellModel.title = @"这是第二个标题Cell";
        
        [sectionModel2 addCellModel:cellModel];
    }
    

    {
        // 其它cell ......
    }
    
    [self.sectionModels setArray:sectionModels];
    
    if (self.reloadDataBlock) {
        self.reloadDataBlock();
    }
}

@end
