//
//  playerData.m
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/18.
//
#import "playerData.h"
#import <Foundation/Foundation.h>

@implementation playerData

//初始化
-(id)init:(NSMutableArray<NSString *> *)list :(NSInteger)row :(NSString *)filepath
{
    if(self == [super init])
    {
        _videoFileListMutableArray = list;//字符串列表
        _indexPathrow = row;//传入点击的是第几个cell
        _videoFiledirectoryNameString = filepath;//传入文件夹的路径(带反斜杠)
        _videoFileListURLMutableArray = [[NSMutableArray alloc] init];
        //URL数组初始化
        for(NSInteger i = 0 ; i < list.count ; i++)
        {
            NSString *temp = [_videoFiledirectoryNameString stringByAppendingString:[_videoFileListMutableArray objectAtIndex:i]];
            [_videoFileListURLMutableArray addObject:[[NSURL alloc] initFileURLWithPath:temp]];
        }
        _videoPlayStartURL = [_videoFileListURLMutableArray objectAtIndex:row];//确定播放器起点
    }
    return self;
}

-(void)changerow:(NSInteger)row
{
    _indexPathrow = row;
    _videoPlayStartURL = [_videoFileListURLMutableArray objectAtIndex:row];
}

@end
