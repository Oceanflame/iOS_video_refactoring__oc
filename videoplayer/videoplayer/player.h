//
//  player.h
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/16.
//

#ifndef player_h
#define player_h

#import "playerData.h"
#import <AVFoundation/AVFoundation.h>

@interface player :UIViewController

@property (nonatomic,strong) playerData *data;
@property (nonatomic,strong) AVPlayer *videoplayer;//播放器
@property (nonatomic,strong) AVPlayerLayer *videoPlayerLayer;//播放器显示
@property (nonatomic,strong) AVPlayerItem *videoPlayerItem;//播放插件
@property (nonatomic,strong) UIButton *stopButton;//播放暂停按钮
@property (nonatomic,strong) UIButton *nextButton;//下一个
@property (nonatomic,strong) UIButton *aboveButton;//上一个
@property (nonatomic,strong) UILabel *totalTimeLabel;
@property (nonatomic,strong) UILabel *playTimeLabel;
@property (nonatomic,strong) UISlider *playerSlider;//进度条
@property (nonatomic,strong) id timeObserver;
@property (nonatomic,assign) BOOL isDragging;
@property (nonatomic,assign) BOOL playstatus;

-(void)initvideo :(playerData *)predata;

@end

#endif /* player_h */
