//
//  GoodsListCellModel.h
//  MVVMTest
//
//  Created by yongsheng on 2020/5/9.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSTableCellModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN


@interface GoodsListCellModel : NSObject <VSTableCellModelProtocol>
/** 标题 */
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
