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
    return  self;
}

-(void)setupView
{
    NSArray<NSString*> *firstpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _upSidePathString = [firstpath objectAtIndex:0];
    _upSidePathString = [_upSidePathString stringByAppendingString:@"/"];
    NSString *filepath = [_upSidePathString stringByAppendingString:_videoNameString];
    
    _videoImageView = [[UIImageView alloc]init];//初始化
    UIImage *videopic = [self getThumbnailImage:filepath];//生成缩略图
    _videoImageView.image = videopic;//为视图赋值
    [self.contentView addSubview:_videoImageView];
    
//videoImageView布局
    [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(10);//父视图左侧偏移10
        make.centerX.mas_equalTo(self.contentView.mas_centerX);//横轴定位
    }];

    _videoNameLabel = [[UILabel alloc]init];//初始化
    _videoNameLabel.font = [UIFont boldSystemFontOfSize:14];//字体大小
    _videoNameLabel.text = _videoNameString;//文字赋值
    [self.contentView addSubview:_videoNameLabel];
//videoNameLabel布局
    [_videoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);//横轴定位
        make.centerY.mas_equalTo(self.contentView.mas_centerY);//纵轴定位
    }];
    
}

-(UIImage *)getThumbnailImage:(NSString *)videoPath {
    if (videoPath) {
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath: videoPath] options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        // 设定缩略图的方向
        // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的
        gen.appliesPreferredTrackTransform = YES;
        // 设置图片的最大size(分辨率)
        gen.maximumSize = CGSizeMake(300, 169);
        CMTime time = CMTimeMakeWithSeconds(5.0, 600); //取第5秒，一秒钟600帧
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        if (error) {
            UIImage *placeHoldImg = [UIImage imageNamed:@"posters_default_horizontal"];
            return placeHoldImg;
        }
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        return thumb;
    } else {
         UIImage *placeHoldImg = [UIImage imageNamed:@"posters_default_horizontal"];
        return placeHoldImg;
    }
}

+ (NSString *)reuseIdentifier {
    return @"VideoListCell";
}


@end
