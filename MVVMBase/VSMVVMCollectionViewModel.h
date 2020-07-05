//
//  VSMVVMCollectionViewModel.h
//  MVVMTest
//
//  Created by yongsheng on 2020/6/4.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class VSMVVMCollectionViewSectionModel;

typedef void(^VSShowLoadingBlock)(BOOL isShow);

@interface VSMVVMCollectionViewModel : NSObject

/// 更新界面的回调,刷新界面数据
@property (copy, nonatomic) dispatch_block_t reloadDataBlock;

/// 是否显示网络请求标记，显示-YES，隐藏—NO
@property (copy, nonatomic) VSShowLoadingBlock showLoadingView;

/// tableView的section们的数据
@property (strong, nonatomic, readonly) NSMutableArray<__kindof VSMVVMCollectionViewSectionModel *> *sectionModels;

/// 重新载入数据
- (void)reloadSectionModels;

/// 返回传入section位置的sectionModel
/// @param index section的索引
- (__kindof VSMVVMCollectionViewSectionModel *)sectionModelAtIndex:(NSInteger)index;

/// 返回总共有多少个section
- (NSInteger)numberOfSections;

/// 返回section有多少个cellModel
/// @param section section的索引
- (NSInteger)numberOfCellModelsInSection:(NSInteger)section;

/// 返回section中的第index个cell的cellModel
/// @param index cell在section中的位置
/// @param section section的索引
- (id)cellModelAtIndex:(NSInteger)index inSection:(NSInteger)section;

///// 返回第section的headerViewModel
///// @param section section的索引
//- (id)headerViewModelAtSection:(NSInteger)section;
//
///// 返回第section的footerViewModel
///// @param section section的索引
//- (id)footerViewModelAtSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
