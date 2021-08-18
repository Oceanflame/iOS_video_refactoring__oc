//
//  player.m
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/16.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import <Masonry/Masonry.h>
#import "player.h"
#import "playerData.h"

static NSString *const kSSZStatusKeyPath = @"status";

@interface player ()

@end

@implementation player


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initvideo:_data];
    
    _playstatus = true;
    self.view.backgroundColor = UIColor.blackColor;
    
    _stopButton = [[UIButton alloc] init];//暂停按钮
    [self.view.layer addSublayer:_stopButton.layer];
    [self.view addSubview:_stopButton];
    [_stopButton setImage:[UIImage imageNamed:@"播放-暂停.png"] forState:UIControlStateNormal];
    [_stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-0.10*(self.view.frame.size.height));
        make.centerX.equalTo(self.view.mas_left).offset(0.50*(self.view.frame.size.width));
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _nextButton = [[UIButton alloc] init];//下一个
    [self.view addSubview:_nextButton];
    [_nextButton setImage:[UIImage imageNamed:@"上一个1.png"] forState:UIControlStateNormal];
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_stopButton.mas_right).offset(20);
        make.bottom.equalTo(_stopButton.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _aboveButton = [[UIButton alloc] init];//上一个
    [self.view addSubview:_aboveButton];
    [_aboveButton setImage:[UIImage imageNamed:@"下一个1.png"] forState:UIControlStateNormal];
    [_aboveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_stopButton.mas_left).offset(-20);
        make.bottom.equalTo(_stopButton.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _playerSlider = [[UISlider alloc] init];//进度条
    [self.view addSubview:_playerSlider];
    [_playerSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_stopButton.mas_top).offset(-10);
        make.centerX.equalTo(_stopButton.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(300,30));
    }];
//添加事件
    [_stopButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [_nextButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [_aboveButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [_playerSlider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [_playerSlider addTarget:self action:@selector(sliderDidEnd:) forControlEvents:UIControlEventTouchUpInside];
    _playerSlider.continuous = YES;
    //[_playerSlider addTarget:self action:@selector(didTapSlider:) forControlEvents:UIControlEventTouchDown];
    [_playerSlider addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSlider:)]];
    
    
}

-(void)initvideo:(playerData *)predata
{
    _data = predata;
    _videoPlayerItem = [[AVPlayerItem alloc] initWithURL:_data.videoPlayStartURL];
    _videoplayer = [[AVPlayer alloc] initWithPlayerItem:_videoPlayerItem];
    _videoPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_videoplayer];
    _videoPlayerLayer.frame = CGRectMake(0,0, self.view.frame.size.width , self.view.frame.size.height );
    [self.view.layer addSublayer:_videoPlayerLayer];
    [_videoplayer play];
    [_videoplayer.currentItem addObserver:self forKeyPath:kSSZStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [self addPeriodicTimeObserver];//kvo注册观察者
}


//按钮事件响应函数
-(void)tapButton:(UIButton *)sender
{
    if(sender == _stopButton)//播放暂停
    {
        if(_playstatus)
        {
            _playstatus = false;
            [_stopButton setImage:[UIImage imageNamed:@"暂停1.png"] forState:UIControlStateNormal];
            [_videoplayer pause];
        }
        else
        {
            _playstatus = true;
            [_stopButton setImage:[UIImage imageNamed:@"播放-暂停.png"] forState:UIControlStateNormal];
            [_videoplayer play];
        }
    }
    else if(sender == _nextButton)//下一个
    {
        if(_data.indexPathrow + 1< _data.videoFileListURLMutableArray.count)
        {
            _data.indexPathrow++;
            [_stopButton setImage:[UIImage imageNamed:@"播放-暂停.png"] forState:UIControlStateNormal];
            AVPlayerItem *newit =[[AVPlayerItem alloc] initWithURL:[_data.videoFileListURLMutableArray objectAtIndex:_data.indexPathrow]];
            [_videoplayer replaceCurrentItemWithPlayerItem:newit];
            _playstatus = true;
            [_videoplayer play];
        }
        else
        {
            _data.indexPathrow = 0;
            [_stopButton setImage:[UIImage imageNamed:@"播放-暂停.png"] forState:UIControlStateNormal];
            AVPlayerItem *newit =[[AVPlayerItem alloc] initWithURL:[_data.videoFileListURLMutableArray objectAtIndex:_data.indexPathrow]];
            [_videoplayer replaceCurrentItemWithPlayerItem:newit];
            _playstatus = true;
            [_videoplayer play];
        }
    }
    else if(sender == _aboveButton)//上一个
    {
        if(_data.indexPathrow - 1 < 0)
        {
            _data.indexPathrow = _data.videoFileListURLMutableArray.count - 1;
            [_stopButton setImage:[UIImage imageNamed:@"播放-暂停.png"] forState:UIControlStateNormal];
            AVPlayerItem *newit =[[AVPlayerItem alloc] initWithURL:[_data.videoFileListURLMutableArray objectAtIndex:_data.indexPathrow]];
            [_videoplayer replaceCurrentItemWithPlayerItem:newit];
            _playstatus = true;
            [_videoplayer play];
        }
        else
        {
            _data.indexPathrow--;
            [_stopButton setImage:[UIImage imageNamed:@"播放-暂停.png"] forState:UIControlStateNormal];
            AVPlayerItem *newit =[[AVPlayerItem alloc] initWithURL:[_data.videoFileListURLMutableArray objectAtIndex:_data.indexPathrow]];
            [_videoplayer replaceCurrentItemWithPlayerItem:newit];
            _playstatus = true;
            [_videoplayer play];
        }
    }
}
//注册kvo
- (void)addPeriodicTimeObserver {
    __weak __typeof(self) weakSelf = self;
    _timeObserver = [_videoplayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time)
    {
        //如果进度条正在拖动，不进行播放进度的更新
        if (weakSelf.isDragging) {
            return;
        }
        // 当前播放时间
        NSTimeInterval currentTime = CMTimeGetSeconds(time);
        // 视频总时间
        NSTimeInterval totalTime = CMTimeGetSeconds(weakSelf.videoplayer.currentItem.duration);
        //slider滑动进度
        weakSelf.playerSlider.value = currentTime / totalTime;
//        NSString *currentTimeString = [weakSelf formatTimeWithTimeInterVal:currentTime];
//        weakSelf.playTimeLabel.text = [NSString stringWithFormat:@"%@  /",currentTimeString];
    }];
}
//移除kvo
- (void)removePeriodicTimeObserver {
    if (self.timeObserver) {
        [_videoplayer removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
    }
}
- (void)dealloc {
    [self removePeriodicTimeObserver];
}

// 添加属性观察
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:kSSZStatusKeyPath]) {
        AVPlayerStatus status = (AVPlayerStatus)[[change objectForKey:NSKeyValueChangeNewKey] intValue];
                switch (status) {
                        case AVPlayerStatusReadyToPlay: {
                        // 获取视频长度
//                        self.totalTimeLabel.text = [self formatTimeWithTimeInterVal:CMTimeGetSeconds(_videoplayer.currentItem.duration)];
                        // 开始播放视频
                        break;
                    }
                        // 视频加载失败，点击重新加载
                        case AVPlayerStatusFailed: {
                            NSLog(@"资源加载失败");
                        break;
                    }
                        // 视频加载遇到未知问题
                        case AVPlayerStatusUnknown: {
                        NSLog(@"加载遇到未知问题:AVPlayerStatusUnknown");
                        break;
                    }
                        default:
                        break;
                    }
    }
}

- (void)sliderDidEnd:(UISlider *)slider
{
    if(_videoplayer.status == AVPlayerStatusReadyToPlay) {
        NSTimeInterval playTime = _playerSlider.value * CMTimeGetSeconds(_videoplayer.currentItem.duration);
        CMTime seekTime = CMTimeMake(playTime, 1);
        [_videoplayer seekToTime:seekTime completionHandler:^(BOOL finished) {
            if (finished) {
                self.playstatus = true;
                [self.stopButton setImage:[UIImage imageNamed:@"播放-暂停.png"] forState:UIControlStateNormal];
                [self.videoplayer play];
            }
        }];
    }
    self.isDragging = NO;
}

- (void)sliderChange:(UISlider *)sender {
    _isDragging = YES;
    _playstatus = false;
    [_stopButton setImage:[UIImage imageNamed:@"暂停1.png"] forState:UIControlStateNormal];
    [_videoplayer pause];
}

- (void)didTapSlider:(UITapGestureRecognizer *)tapGesture {
    CGPoint touchPoint = [tapGesture locationInView:_playerSlider];
    CGFloat value = (_playerSlider.maximumValue - _playerSlider.minimumValue) * (touchPoint.x / _playerSlider.frame.size.width);
    NSTimeInterval playTime = value * CMTimeGetSeconds(_videoplayer.currentItem.duration);
    CMTime seekTime = CMTimeMake(playTime, 1);
    [_videoplayer seekToTime:seekTime completionHandler:^(BOOL finished) {
        
    }];
}



@end
