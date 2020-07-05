//
//  GoodsListViewModel.h
//  MVVMTest
//
//  Created by yongsheng on 2020/5/8.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GoodsListInputParams.h"

@class GoodsListCellModel;
@protocol VSTableCellModelProtocol;

@interface GoodsListViewModel : NSObject
// 对外的属性，View或者ViewController使用
@property (nonatomic, assign) BOOL isLastPage;

// 外面调用控制器需要传过来的参数，没有参数，该字段可删除
- (instancetype)initWithInputParams:(GoodsListInputParams *)params;

// 回调的所有Block
- (void)registerReloadDataBlock:(dispatch_block_t)block;
- (void)registerShowLoadingBlock:(void (^)(BOOL isShow))block; // 加载框
- (void)registerShowMessageBlock:(void (^)(NSString *msg))block; // toast提示


- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (id<VSTableCellModelProtocol>)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

// 请求数据及相关方法
- (void)requestDataList;

@end

