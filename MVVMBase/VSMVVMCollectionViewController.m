//
//  VSMVVMCollectionViewController.m
//  MVVMTest
//
//  Created by yongsheng on 2020/6/4.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "VSMVVMCollectionViewController.h"
#import "VSMVVMCollectionViewModel.h"
#import "VSMVVMCollectionViewCellModel.h"
#import "VSMVVMCollectionViewSectionModel.h"
#import "VSMVVMCollectionViewCell.h"

static NSString * const VSMVVMCollectionViewDefaultCellReuseIdentifier = @"VSMVVMCollectionViewDefaultCellReuseIdentifier";
static NSString * const VSMVVMCollectionViewDefaultHeaderViewReuseIdentifier = @"VSMVVMCollectionViewDefaultHeaderViewReuseIdentifier";
static NSString * const VSMVVMCollectionViewDefaultFooterViewReuseIdentifier = @"VSMVVMCollectionViewDefaultFooterViewReuseIdentifier";

@interface VSMVVMCollectionViewController ()
@property (strong, nonatomic, readwrite) UICollectionView *collectionView;
@end

@implementation VSMVVMCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *backgroundColor = [UIColor groupTableViewBackgroundColor];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    self.collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [backgroundColor copy];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.alwaysBounceVertical = YES;
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:VSMVVMCollectionViewDefaultHeaderViewReuseIdentifier];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:VSMVVMCollectionViewDefaultFooterViewReuseIdentifier];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:VSMVVMCollectionViewDefaultCellReuseIdentifier];
        if (@available(iOS 11.0, *)) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        collectionView;
    });
    [self.view addSubview:self.collectionView];

    [self loadSubviews];
}

- (void)loadSubviews {
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self updateSubviewsFrame];
}

- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    
    [self updateSubviewsFrame];
}

/// 更新子view们的布局
- (void)updateSubviewsFrame
{
    self.collectionView.frame = ({
        CGRect frame = self.view.bounds;
        if (!self.navigationController.isNavigationBarHidden) {
            frame.origin.y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        }
        frame.size.height = CGRectGetHeight(frame) - CGRectGetMinY(frame);
        frame;
    });
}

- (void)reloadData
{
    // 给所有的Cell进行注册
    NSInteger numberOfSections = [self.viewModel numberOfSections];
    for (NSInteger section = 0; section < numberOfSections; section++) {
        VSMVVMCollectionViewSectionModel *sectionModel = [self.viewModel sectionModelAtIndex:section];
        NSInteger numberOfCellModels = [sectionModel numberOfCellModels];
        for (NSInteger row = 0; row < numberOfCellModels; row++) {
            id cellModel = [sectionModel cellModelAtIndex:row];
            if ([cellModel isKindOfClass:[VSMVVMCollectionViewCellModel class]]) {
                Class cellClass = [cellModel cellClass];
                [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
            }
        }
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.viewModel numberOfSections];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numberOfItems = [self.viewModel numberOfCellModelsInSection:section];
    return numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cellModel = [self.viewModel cellModelAtIndex:indexPath.item inSection:indexPath.section];
    UICollectionViewCell *cell = nil;
    if ([cellModel isKindOfClass:[VSMVVMCollectionViewCellModel class]]) {
        Class cellClass = [cellModel cellClass];
        NSString *reuseIdentifier = NSStringFromClass(cellClass);
        VSMVVMCollectionViewCell *orderCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [orderCollectionViewCell updateWithCellModel:cellModel];
        
        cell = orderCollectionViewCell;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reuseIdentifier = VSMVVMCollectionViewDefaultHeaderViewReuseIdentifier;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reuseIdentifier = VSMVVMCollectionViewDefaultFooterViewReuseIdentifier;
    }
    UICollectionReusableView *reusableView = nil;
    if (reuseIdentifier) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        reusableView.backgroundColor = collectionView.backgroundColor;
        [reusableView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }

    return reusableView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id cellModel = [self.viewModel cellModelAtIndex:indexPath.item inSection:indexPath.section];
    if ([cellModel isKindOfClass:[VSMVVMCollectionViewCellModel class]]) {
        VSMVVMCollectionViewCell *cell = (VSMVVMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell didSelectCellWithCellModel:cellModel];
    }
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cellModel = [self.viewModel cellModelAtIndex:indexPath.item inSection:indexPath.section];
    
    if ([cellModel isKindOfClass:[VSMVVMCollectionViewCellModel class]]) {
        Class cellClass = [cellModel cellClass];
        CGSize size = [cellClass sizeForCellModel:cellModel collectionViewWidth:CGRectGetWidth(collectionView.bounds)];
        return size;
    }
    
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    VSMVVMCollectionViewSectionModel *sectionModel = [self.viewModel sectionModelAtIndex:section];
    return sectionModel.sectionInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    VSMVVMCollectionViewSectionModel *sectionModel = [self.viewModel sectionModelAtIndex:section];
    return sectionModel.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    VSMVVMCollectionViewSectionModel *sectionModel = [self.viewModel sectionModelAtIndex:section];
    return sectionModel.minimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    VSMVVMCollectionViewSectionModel *sectionModel = [self.viewModel sectionModelAtIndex:section];
    NSInteger height = sectionModel.sectionTopMargin;
    
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    NSInteger height = CGFLOAT_MIN;
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), height);
}


@end
