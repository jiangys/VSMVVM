//
//  VSMVVMCollectionViewCell.h
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class VSMVVMCollectionViewCellModel;

@interface VSMVVMCollectionViewCell : UICollectionViewCell

/// 自定义的内容view
/// 若需要圆角，请将所有subView添加至本view上
/// 若不需要圆角，请设置该view.hidden=YES，请将所有subView添加至contentView上
@property (strong, nonatomic, readonly) UIView *customContentView;

/// 根据内容计算高度
/// @param cellModel 数据
/// @param collectionViewWidth cell的宽度
+ (CGSize)sizeForCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel collectionViewWidth:(NSInteger)collectionViewWidth;

/// 供子类用的初始化方法 - ⚠️⚠️⚠️默认实现抛出异常，必须重写该方法
/// 创建各种子view，请写在这个方法里
- (void)loadSubviews;

/// 供子类用的布局方法 - ⚠️⚠️⚠️默认实现抛出异常，必须重写该方法
/// 请将所有子view.frame相关的设置写在这个方法中
- (void)updateSubviewsFrame;

/// 供子类用的更新cell的方法 - 默认空实现，供子类重写
/// @param cellModel cell的viewModel
- (void)updateWithCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel;

/// 供子类用的选中cell的方法 - 默认空实现，供子类重写
/// @param cellModel cell的viewModel
- (void)didSelectCellWithCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel;

@end

NS_ASSUME_NONNULL_END
