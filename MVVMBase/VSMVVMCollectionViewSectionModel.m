//
//  VSMVVMCollectionViewSectionModel.m
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "VSMVVMCollectionViewSectionModel.h"
#import "VSMVVMCollectionViewCellModel.h"

@interface VSMVVMCollectionViewSectionModel ()
@property (strong) NSMutableArray<__kindof VSMVVMCollectionViewCellModel *> *cellModels;
@end

@implementation VSMVVMCollectionViewSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionTopMargin = 12;
        self.cellModels = [NSMutableArray array];
    }
    return self;
}

- (void)addCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel
{
#if DEBUG
    NSAssert(cellModel != nil, @"cellModel不能为空");
#endif
    if (cellModel) {
        [self.cellModels addObject:cellModel];
    }
}

- (void)deleteCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel
{
#if DEBUG
    NSAssert(cellModel != nil, @"cellModel不能为空");
#endif
    if (cellModel) {
        [self.cellModels removeObject:cellModel];
    }
}

- (NSInteger)numberOfCellModels
{
    return self.cellModels.count;
}

- (nullable __kindof VSMVVMCollectionViewCellModel *)cellModelAtIndex:(NSInteger)index
{
    BOOL isValid = (index >= 0 && index < self.cellModels.count);
#if DEBUG
    NSAssert(isValid, @"index必须为有效值");
#endif
    if (isValid) {
        return self.cellModels[index];
    }
    return nil;
}

@end
