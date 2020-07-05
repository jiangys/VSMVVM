//
//  VSMVVMCollectionViewController.h
//  MVVMTest
//
//  Created by yongsheng on 2020/6/4.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class VSMVVMCollectionViewModel;

@interface VSMVVMCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/// viewController对应的ViewModel，需要子类自己实现
@property (strong, nonatomic, readonly) __kindof VSMVVMCollectionViewModel *viewModel;

@property (strong, nonatomic, readonly) UICollectionView *collectionView;

/// 加载子view们
- (void)loadSubviews;

/// 调用collectionVie的reloadData方法
/// ⚠️单品流需使用WaterfallFlowLayout，故需调用该方法
- (void)reloadData;

/// 更新子view们的布局
- (void)updateSubviewsFrame;

@end

NS_ASSUME_NONNULL_END
