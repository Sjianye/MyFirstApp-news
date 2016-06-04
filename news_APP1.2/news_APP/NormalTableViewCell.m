//
//  NormalTableViewCell.m
//  news_APP
//
//  Created by qingyun on 16/5/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NormalTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface NormalTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *updateTime;
@property (weak, nonatomic) IBOutlet UILabel *comments;


@end

@implementation NormalTableViewCell

-(void)setModel:(ItemModel *)model{
    _model = model;
    [_thumbnail sd_setImageWithURL:[NSURL URLWithString:model.newsThumbnail] placeholderImage:nil];
    _title.text = model.title;
    _comments.text = model.commentsall;
    if ([model.type isEqualToString:@"topic2"]) {
        _updateTime.text = @"专题";
        _updateTime.backgroundColor = [UIColor redColor];
        _updateTime.textColor = [UIColor whiteColor];
    }else{
        _updateTime.backgroundColor = [UIColor clearColor];
        _updateTime.text = model.updateTime;
    }
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
