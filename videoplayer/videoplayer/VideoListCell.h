//
//  VideoListCell.h
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoListCell : UITableViewCell

@property (nonatomic,strong) NSString *upSidePathString;//文件夹路径
@property (nonatomic,strong) UIImageView *videoImageView;//视频缩略图
@property (nonatomic,strong) UILabel *videoNameLabel;//用于显示文件名的标签
@property (nonatomic,strong) NSString *videoNameString;//文件名

+ (NSString *)reuseIdentifier; //重用ID

@end

NS_ASSUME_NONNULL_END
