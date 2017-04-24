//
//  TableViewCell.m
//  多线程
//
//  Created by 连京帅 on 2017/4/11.
//  Copyright © 2017年 chuang. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()

@end

@implementation TableViewCell

// cell 初始化方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)initView {
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, screen_width-40, 44)];
    _label.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_label];
}


@end
