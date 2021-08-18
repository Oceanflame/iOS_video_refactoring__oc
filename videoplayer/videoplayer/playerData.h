//
//  playerData.h
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/18.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface playerData : NSObject

@property (nonatomic,strong) NSString *videoFiledirectoryNameString;//文件夹路径
@property (nonatomic,strong) NSURL *videoPlayStartURL;//文件路径
@property (nonatomic,strong) NSMutableArray<NSString *> *videoFileListMutableArray;//文件名列表
@property (nonatomic,strong) NSMutableArray<NSURL *> *videoFileListURLMutableArray;//文件URL列表
@property (nonatomic,assign) NSInteger indexPathrow;//点击的cell位置

-(id)init:(NSMutableArray<NSString *> *)list :(NSInteger)row :(NSString *)filepath;
-(void)changerow:(NSInteger)row;

@end
