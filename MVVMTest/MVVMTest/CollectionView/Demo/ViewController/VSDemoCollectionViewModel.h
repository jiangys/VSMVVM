//
//  VSDemoCollectionViewModel.h
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSMVVMCollectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VSDemoCollectionViewModel : VSMVVMCollectionViewModel

/// 是否显示网络请求标记，显示-YES，隐藏—NO
@property (copy, nonatomic) void(^showLoadingView)(BOOL show);

/// 显示网络失败重新加载页面
@property (copy, nonatomic) void(^showReloadView)(BOOL show, NSError * _Nullable error);

/// 更新确定按钮状态
@property (copy, nonatomic) void(^updateConfirmButton)(BOOL enable);

/// toast提示
@property (copy, nonatomic) void(^toastMessage)(NSString *message);

// 请求数据及相关方法
- (void)requestDataList;


@end

NS_ASSUME_NONNULL_END
