//
//  GoodsListViewModel.m
//  MVVMTest
//
//  Created by yongsheng on 2020/5/8.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "GoodsListViewModel.h"
#import "GoodsListCellModel.h"
#import "GoodsListInputParams.h"
#import "VSTableCellModelProtocol.h"
#import "VSTableCellProtocol.h"
#import "MiddleCell.h"
#import "MiddleCellModel.h"

typedef void(^VSShowLoadingBlock)(BOOL isShow);
typedef void(^VSShowMessageBlock)(NSString *msg);

@interface GoodsListViewModel()
@property (nonatomic, strong) NSMutableArray<id<VSTableCellModelProtocol>> *goodsListArray;
@property (nonatomic, strong) GoodsListInputParams *params;
@property (nonatomic, strong) NSMutableArray *cellHeightArray;

@property (nonatomic, copy) dispatch_block_t reloadDataBlock;
@property (nonatomic, copy) VSShowLoadingBlock showLoadingBlock;
@property (nonatomic, copy) VSShowMessageBlock showMessageBlock;
@end

@implementation GoodsListViewModel

- (void)dealloc {
    _reloadDataBlock = nil;
    _showLoadingBlock = nil;
    _showMessageBlock = nil;
}

- (instancetype)initWithInputParams:(GoodsListInputParams *)params {
    if(self = [super init]) {
        self.params = params;
        _goodsListArray = [NSMutableArray array];
        _cellHeightArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - registerBlock回调
- (void)registerReloadDataBlock:(dispatch_block_t)block {
    self.reloadDataBlock = block;
}

- (void)registerShowLoadingBlock:(void (^)(BOOL isShow))block {
    self.showLoadingBlock = block;
}

- (void)registerShowMessageBlock:(void (^)(NSString *msg))block {
    self.showMessageBlock = block;
}

#pragma mark - UITableView回调
- (NSUInteger)numberOfSections {
    return 1;
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section {
    return _goodsListArray.count;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (self.cellHeightArray.count>indexPath.row) {
        height = [self.cellHeightArray[indexPath.row] floatValue];
    }
    return height;
}

- (id<VSTableCellModelProtocol>)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _goodsListArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    id<VSTableCellModelProtocol> cellModel = _goodsListArray[indexPath.row];
    Class cellClass =  [cellModel cellClass];
    if ([cellClass respondsToSelector:@selector(estimatedCellHeightWithTableView:cellModel:)]) {
        height = [cellClass estimatedCellHeightWithTableView:tableView cellModel:cellModel];
        [self.cellHeightArray setObject:@(height) atIndexedSubscript:indexPath.row];
    }
    
    return height;
}

#pragma mark - 请求数据
- (void)requestDataList {
    for (int i = 0; i < 10; i++) {
        GoodsListCellModel *cellModel = [[GoodsListCellModel alloc] init];
        cellModel.title = [NSString stringWithFormat:@"这是标题 %d",i];
        
        [_goodsListArray addObject:cellModel];
    }
    
    { // 这时第二个cell，middleCell
        MiddleCellModel *cellModel = [[MiddleCellModel alloc] init];
        cellModel.title = @"这是MiddleCell新的Cell";
        [_goodsListArray addObject:cellModel];
    }
};

@end
