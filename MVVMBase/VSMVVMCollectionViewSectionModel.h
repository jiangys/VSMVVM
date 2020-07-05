//
//  VSMVVMCollectionViewSectionModel.h
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class VSMVVMCollectionViewCellModel;

@interface VSMVVMCollectionViewSectionModel : NSObject

/// 分组之间顶部的间距，默认12
@property (assign, nonatomic) CGFloat sectionTopMargin;

@property (assign, nonatomic) UIEdgeInsets sectionInset;
@property (assign, nonatomic) CGFloat minimumLineSpacing;
@property (assign, nonatomic) CGFloat minimumInteritemSpacing;

- (void)addCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel;
- (void)deleteCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel;

- (NSInteger)numberOfCellModels;
- (nullable __kindof VSMVVMCollectionViewCellModel *)cellModelAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
