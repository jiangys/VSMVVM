//
//  VSTableCellProtocol.h
//  MVVMTest
//
//  Created by yongsheng on 2020/6/17.
//  Copyright © 2020 jiangys. All rights reserved.
//

#ifndef VSTableCellProtocol_h
#define VSTableCellProtocol_h

@protocol VSTableCellModelProtocol;

@protocol VSTableCellProtocol <NSObject>

+ (CGFloat)estimatedCellHeightWithTableView:(UITableView *)tableView cellModel:(id<VSTableCellModelProtocol>)cellModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)updateWithCellModel:(__kindof id<VSTableCellModelProtocol>)cellModel;

@end

#endif /* VSTableCellProtocol_h */
