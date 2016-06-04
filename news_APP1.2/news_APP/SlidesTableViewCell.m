//
//  SlidesTableViewCell.m
//  news_APP
//
//  Created by qingyun on 16/6/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SlidesTableViewCell.h"
#import "UIImageView+WebCache.h"

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
    _comments.text = model.commentsall;
    _updateTime.text = model.updateTime;
    [_firstImage sd_setImageWithURL:[NSURL URLWithString:model.slideImages[0]] placeholderImage:nil];
    [_secondImage sd_setImageWithURL:[NSURL URLWithString:model.slideImages[1]] placeholderImage:nil];
    [_thirdImage sd_setImageWithURL:[NSURL URLWithString:model.slideImages[2]] placeholderImage:nil];
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
