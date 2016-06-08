//
//  SlidesTableViewCell.m
//  news_APP
//
//  Created by qingyun on 16/6/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//


#import "ThisPageVCHeader.h"


@interface SlidesTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@property (weak, nonatomic) IBOutlet UILabel *updateTime;
@property (weak, nonatomic) IBOutlet UILabel *comments;


@end

@implementation SlidesTableViewCell




-(void)setModel:(ItemModel *)model{
    _model = model;
    _title.text = model.title;
    _title.textColor = [UIColor colorWithRed:0.01 green:0.01 blue:0.44 alpha:1];
    _comments.text = model.commentsall;
    _comments.textColor = [UIColor grayColor];
    _updateTime.text = model.updateTime;
    _updateTime.textColor = [UIColor grayColor];
    [_firstImage sd_setImageWithURL:[NSURL URLWithString:model.slideImages[0]] placeholderImage:nil];
    [_secondImage sd_setImageWithURL:[NSURL URLWithString:model.slideImages[1]] placeholderImage:nil];
    [_thirdImage sd_setImageWithURL:[NSURL URLWithString:model.slideImages[2]] placeholderImage:nil];
    [self addBorderWidth:_firstImage];
    [self addBorderWidth:_secondImage];
    [self addBorderWidth:_thirdImage];
}

-(void)addBorderWidth:(UIImageView *)imageView{
    imageView.layer.borderWidth = 1;//给imageView添加一个浅灰色边框
    imageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
