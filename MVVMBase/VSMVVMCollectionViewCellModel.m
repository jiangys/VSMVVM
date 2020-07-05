//
//  VSMVVMCollectionViewCellModel.m
//  MVVMTest
//
//  Created by yongsheng on 2020/6/5.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "VSMVVMCollectionViewCellModel.h"

@implementation VSMVVMCollectionViewCellModel

- (Class)cellClass
{
    @throw [NSException exceptionWithName:@"请重写此方法" reason:@"每个cellModel必须对应实现一个cell" userInfo:nil];
}

@end
