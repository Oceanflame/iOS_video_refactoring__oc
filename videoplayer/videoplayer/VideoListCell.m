//
//  VideoListCell.m
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/16.
//

#import "VideoListCell.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
//#import <CoreMedia/CoreMedia.h>

@implementation VideoListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)[self setupView];
    return self;
}

-(void)setupView
{
    
    _videoImageView = [[UIImageView alloc]init];//初始化
    [self.contentView addSubview:_videoImageView];
    
//videoImageView布局
    [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(10);//父视图左侧偏移10
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);//横轴定位
        make.right.mas_equalTo(-200);
     
    }];

    _videoNameLabel = [[UILabel alloc]init];//初始化
    _videoNameLabel.font = [UIFont boldSystemFontOfSize:14];//字体大小
    [self.contentView addSubview:_videoNameLabel];
//videoNameLabel布局
    [_videoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(100);//横轴定位
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);//纵轴定位
    }];
    
}

+ (NSString *)reuseIdentifier {
    return @"VideoListCell";
}


@end
