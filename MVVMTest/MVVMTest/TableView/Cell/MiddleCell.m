//
//  MiddleCell.m
//  MVVMTest
//
//  Created by yongsheng on 2020/6/18.
//  Copyright © 2020 jiangys. All rights reserved.
//

#import "MiddleCell.h"
#import "MiddleCellModel.h"

@interface MiddleCell ()
@property(nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation MiddleCell

#pragma mark - Life Cycle

+ (CGFloat)estimatedCellHeightWithTableView:(UITableView *)tableView cellModel:(id<VSTableCellModelProtocol>)cellModel
{
    if ([cellModel isKindOfClass:[MiddleCellModel class]]) {
        MiddleCell *cell = [MiddleCell cellWithTableView:tableView];
        cell.frame = ({
            CGRect frame = cell.frame;
            frame.size.width = SCREEN_WIDTH;
            frame;
        });
        cell.contentView.frame = cell.bounds;
        [cell updateWithCellModel:cellModel];
        
        return cell.cellHeight;
    }
    
    return 0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor orangeColor];
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_titleLabel];
}

- (void)updateWithCellModel:(__kindof id<VSTableCellModelProtocol>)cellModel {
    MiddleCellModel *tempCellModel = (MiddleCellModel *)cellModel;
    self.titleLabel.text = tempCellModel.title;
    self.titleLabel.frame = CGRectMake(15, 0, 200, 50);
    
    self.cellHeight = MAX(CGRectGetMaxY(self.titleLabel.frame), 50);
}

#pragma mark - Public Methods
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    //static NSString *ID = @"GoodsListTableViewCell";
    NSString *ID = NSStringFromClass([MiddleCell class]);
    MiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MiddleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

@end
