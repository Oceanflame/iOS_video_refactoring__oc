//
//  player.h
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/16.
//

#ifndef player_h
#define player_h
#import <AVFoundation/AVFoundation.h>

@interface player :UIViewController

@property (nonatomic,strong) UIView *videoPlayUIView;
@property (nonatomic,strong) AVPlayer *videoplayer;
@property (nonatomic,strong) AVPlayerLayer *videoPlayerLayer;
@property (nonatomic,strong) AVPlayerItem *videoPlayerItem;
@property (nonatomic,strong) UIButton *playButton;
@property (nonatomic,strong) UIButton *stopButton;
@property (nonatomic,strong) UIButton *nextButton;
@property (nonatomic,strong) UIButton *aboveButton;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UILabel *totalTimeLabel;
@property (nonatomic,strong) UILabel *playTimeLabel;
@property (nonatomic,strong) UISlider *playerSlider;
@property (nonatomic,assign) BOOL playstatus;

@end

#endif /* player_h */
