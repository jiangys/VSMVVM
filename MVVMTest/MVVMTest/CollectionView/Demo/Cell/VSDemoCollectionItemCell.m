//
//  VSDemoCollectionItemCell.m
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "VSDemoCollectionItemCell.h"
#import "VSDemoCollectionItemCellModel.h"

@interface VSDemoCollectionItemCell()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation VSDemoCollectionItemCell

+ (CGSize)sizeForCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel collectionViewWidth:(NSInteger)collectionViewWidth
{
    return CGSizeMake(collectionViewWidth, 55);
}

- (void)loadSubviews
{
    if (self.titleLabel) {
        return;
    }
    UIColor *backgroundColor = [UIColor whiteColor];
    self.backgroundColor = backgroundColor;

    //self.customContentView.hidden = YES;
    self.customContentView.layer.masksToBounds = YES;
    //self.customContentView.layer.cornerRadius = 9.0;
    self.customContentView.backgroundColor = backgroundColor;
    
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = backgroundColor;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label;
    });
    [self.customContentView addSubview:self.titleLabel];
}

- (void)updateSubviewsFrame
{
    self.titleLabel.frame = ({
        [self.titleLabel sizeToFit];
        CGRect frame = self.titleLabel.frame;
        frame.origin.x = 15;
        frame.size.width = ceil(CGRectGetWidth(frame));
        frame.size.height = ceil(CGRectGetHeight(frame));
        frame.origin.y = ceil((CGRectGetHeight(self.contentView.bounds) - CGRectGetHeight(frame))/2.0);
        frame;
    });
}

- (void)updateWithCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel
{
    VSDemoCollectionItemCellModel *tempCellModel = (VSDemoCollectionItemCellModel *)cellModel;
    self.titleLabel.text = tempCellModel.title;
}

- (void)didSelectCellWithCellModel:(__kindof VSMVVMCollectionViewCellModel *)cellModel
{
    if (cellModel.didSelect) {
        cellModel.didSelect();
    }
}

@end
