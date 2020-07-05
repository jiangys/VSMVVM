//
//  MiddleCellModel.h
//  MVVMTest
//
//  Created by yongsheng on 2020/6/18.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSTableCellModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MiddleCellModel : NSObject<VSTableCellModelProtocol>

@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
