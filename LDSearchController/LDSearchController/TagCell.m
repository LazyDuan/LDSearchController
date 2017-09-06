//
//  TagCell.m
//  LDRecordDemo
//
//  Created by 段乾磊 on 16/6/13.
//  Copyright © 2016年 LazyDuan. All rights reserved.
//

#import "TagCell.h"

@implementation TagCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithWhite:0.957 alpha:1.000];
        self.layer.borderColor = [UIColor colorWithWhite:0.92 alpha:1.000].CGColor;
        self.layer.borderWidth = 1;
        _contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(5, 5, self.bounds.size.width-10, self.bounds.size.height-10);
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.contentLabel.text = @"";
}


@end
