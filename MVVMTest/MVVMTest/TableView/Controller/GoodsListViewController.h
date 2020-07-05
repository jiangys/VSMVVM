//
//  GoodsListViewController.h
//  MVVMTest
//
//  Created by yongsheng on 2020/5/8.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsListViewModel;
NS_ASSUME_NONNULL_BEGIN

@interface GoodsListViewController : UIViewController
- (instancetype)initWithViewModel:(GoodsListViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
