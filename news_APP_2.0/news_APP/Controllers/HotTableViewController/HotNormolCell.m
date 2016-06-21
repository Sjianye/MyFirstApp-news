//
//  HotNormolCell.m
//  news_APP
//
//  Created by qingyun on 16/6/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HotNormolCell.h"
#import "UIImageView+WebCache.h"

@interface HotNormolCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *source;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thumbnailWidth;

@end

@implementation HotNormolCell

-(void)setModel:(ItemModel *)model{
    _model = model;
    [_thumbnail sd_setImageWithURL:[NSURL URLWithString:model.newsThumbnail] placeholderImage:nil];
    if ([model.newsThumbnail isEqualToString:@""]) {//只有标题没有缩略图
        _thumbnailWidth.constant = 0;
    }
    _title.text = model.title;
    _title.textColor = [UIColor colorWithRed:0.01 green:0.01 blue:0.44 alpha:1];
    
    NSString *sourceStr = model.hotName;
    if(sourceStr){
        _source.text = [NSString stringWithFormat:@" %@ ",sourceStr];
        _source.textColor = [UIColor colorWithRed:0.01 green:0.01 blue:0.44 alpha:1];
        _source.layer.borderColor = [UIColor grayColor].CGColor;
        _source.layer.borderWidth = 1.0;
        _source.layer.cornerRadius = 7;
    }
    _thumbnail.layer.borderWidth = 1;//给imageView添加一个浅灰色边框
    _thumbnail.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
