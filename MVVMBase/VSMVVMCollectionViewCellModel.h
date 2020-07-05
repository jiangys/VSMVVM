//
//  VSMVVMCollectionViewCellModel.h
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VSMVVMCollectionViewCellModel : NSObject

- (Class)cellClass;

/*
 * 选中cell的回调
 */
@property (copy, nonatomic) dispatch_block_t didSelect;

@end

NS_ASSUME_NONNULL_END
