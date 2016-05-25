//
//  NormalTableViewCell.m
//  news_APP
//
//  Created by qingyun on 16/5/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NormalTableViewCell.h"

@interface NormalTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *updateTime;
@property (weak, nonatomic) IBOutlet UILabel *comments;


@end

@implementation NormalTableViewCell

-(void)setModel:(TextModel *)model{
    _model = model;
    _thumbnail.image = [UIImage imageNamed:model.thumbnail];
    _title.text = model.title;
    _updateTime.text = model.updateTime;
    _comments.text = model.comments;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
