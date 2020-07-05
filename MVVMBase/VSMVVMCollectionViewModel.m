//
//  VSMVVMCollectionViewModel.m
//  MVVMTest
//
//  Created by yongsheng on 2020/6/4.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "VSMVVMCollectionViewModel.h"
#import "VSMVVMCollectionViewSectionModel.h"

@interface VSMVVMCollectionViewModel ()

@property (strong, nonatomic, readwrite) NSMutableArray<__kindof VSMVVMCollectionViewSectionModel *> *sectionModels;

@end

@implementation VSMVVMCollectionViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionModels = [NSMutableArray array];
    }
    return self;
}

/// 重新载入数据
- (void)reloadSectionModels
{
    
}


/// 返回传入section位置的sectionModel
/// @param index section的索引
- (__kindof VSMVVMCollectionViewSectionModel *)sectionModelAtIndex:(NSInteger)index
{
    BOOL isValid = (index >= 0 && index < self.sectionModels.count);
    if (isValid) {
        return self.sectionModels[index];
    }
    return nil;
}

/// 返回总共有多少个section
- (NSInteger)numberOfSections
{
    return self.sectionModels.count;
}

/// 返回section有多少个cellModel
/// @param section section的索引
- (NSInteger)numberOfCellModelsInSection:(NSInteger)section
{
    VSMVVMCollectionViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return [sectionModel numberOfCellModels];
}

/// 返回section中的第index个cell的cellModel
/// @param index cell在section中的位置
/// @param section section的索引
- (id)cellModelAtIndex:(NSInteger)index inSection:(NSInteger)section
{
    __kindof VSMVVMCollectionViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
    id cellModel = [sectionModel cellModelAtIndex:index];
    return cellModel;
}

/// 返回第section的headerViewModel
/// @param section section的索引
//- (id)headerViewModelAtSection:(NSInteger)section
//{
//    __kindof VSMVVMCollectionViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
//    return sectionModel.headerViewModel;
//}
//
///// 返回第section的footerViewModel
///// @param section section的索引
//- (id)footerViewModelAtSection:(NSInteger)section
//{
//    __kindof VSMVVMCollectionViewSectionModel *sectionModel = [self sectionModelAtIndex:section];
//    return sectionModel.footerViewModel;
//}


@end
