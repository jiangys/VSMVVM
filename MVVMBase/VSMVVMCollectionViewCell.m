//
//  VSMVVMCollectionViewCell.m
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "VSMVVMCollectionViewCell.h"
#import "VSMVVMCollectionViewCellModel.h"

static UIEdgeInsets const kMVVMCellPadding = {0, 8, 0, 8};

@interface VSMVVMCollectionViewCell ()
/*
 * 自定义的内容view，请将所有subView添加至本view上
 * 这样方便做一些圆角，间距等共同特性的处理
 */
@property (strong, nonatomic, readwrite) UIView *customContentView;

@end


@implementation VSMVVMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self private_loadSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //更新布局
    [self private_updateSubviewsFrame];
}

/// 先初始化基类后，再调用子类初始化方法
- (void)private_loadSubviews
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.contentView.backgroundColor = self.backgroundColor;
    
    self.customContentView = ({
        UIView *view = [[UIView alloc] initWithFrame:self.contentView.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self.contentView addSubview:self.customContentView];
    
    [self loadSubviews];
}

/*
* 初始化方法 - ⚠️⚠️⚠️默认实现抛出异常，必须重写该方法
* 创建各种子view，请写在这个方法里
*/
- (void)loadSubviews
{
    @throw [NSException exceptionWithName:@"请使用此方法初始化界面" reason:@"保持统一性" userInfo:nil];
}

/// 先更新基类view的布局后，再调用子类的布局方法
- (void)private_updateSubviewsFrame
{
    self.customContentView.frame = ({
        CGRect frame = CGRectZero;
        frame.origin.x = kMVVMCellPadding.left;
        frame.size.width = CGRectGetWidth(self.contentView.bounds) - kMVVMCellPadding.right - CGRectGetMinX(frame);
        frame.size.height = CGRectGetHeight(self.contentView.bounds);
        frame;
    });
    
    [self updateSubviewsFrame];
}

/*
* 布局方法 - ⚠️⚠️⚠️默认实现抛出异常，必须重写该方法
* 请将所有子view.frame相关的设置写在这个方法中
*/
- (void)updateSubviewsFrame
{
    @throw [NSException exceptionWithName:@"请使用此方法布局" reason:@"保持统一性" userInfo:nil];
}

/// 根据内容计算高度
/// @param cellModel 数据
/// @param collectionViewWidth cell的宽度
+ (CGSize)sizeForCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel collectionViewWidth:(NSInteger)collectionViewWidth
{
    @throw [NSException exceptionWithName:@"请重写此方法" reason:@"每个cell应该返回自己的高度" userInfo:nil];
}

/*
 * 根据内容更新cell - 默认空实现，供子类重写
 */
- (void)updateWithCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel
{
    
}

/*
 * 选中cell的方法 - 默认空实现，供子类重写
 */
- (void)didSelectCellWithCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel
{
    
}


@end
    
