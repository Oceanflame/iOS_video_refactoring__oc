//
//  player.m
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/16.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import <Masonry/Masonry.h>
#import "player.h"

@interface player ()

@end

@implementation player

-(void)viewDidLoad
{
    [super viewDidLoad];
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
    [_playerSlider addTarget:self action:@selector(tapslider) forControlEvents:UIControlEventValueChanged];
    [_playerSlider addTarget:self action:@selector(tapsliderend) forControlEvents:UIControlEventTouchUpInside];
    [_playerSlider addTarget:self action:@selector(tapsliderdown) forControlEvents:UIControlEventTouchDown];
    
}

-(void)tapButton:(UIButton *)sender//按钮事件响应函数
{
    if(sender == _stopButton)
    {
        if(_playstatus)
        {
            _playstatus = false;
            [_videoplayer pause];
        }
        else
        {
            _playstatus = true;
            [_videoplayer play];
        }
    }
    else if(sender == _nextButton)
    {
        
    }
    else if(sender == _aboveButton)
    {
        
    }
}

-(void)tapslider:(UISlider *)sender
{
    
}

@end
