//
//  ViewController.m
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/12.
//

#import "ViewController.h"
#import "VideoListCell.h"
#import "Masonry.h"
#import "player.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property UITableView *videolistTableView;//列表
@property NSArray<NSString *> * firstpath;
@property NSString * filepath;//documnet路径
@property NSArray<NSString *> * filepathArray;//文件路径数组
@property NSMutableArray<NSString *> * videofilepathArray;//视频文件名数组
@property NSFileManager * fileManager;//文件管理器

-(NSMutableArray<NSString *> *)videofinder:(NSArray<NSString *> *)array;//文件筛选函数
-(UIImage *)getThumbnailImage:(NSString *)videoPath;//生成缩略图函数

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _videolistTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _videolistTableView.delegate = self;
    _videolistTableView.dataSource = self;
    _videolistTableView.separatorInset = UIEdgeInsetsZero;
    _videolistTableView.separatorColor = UIColor.darkTextColor;
    _videolistTableView.backgroundColor = UIColor.grayColor;
    _videolistTableView.tableFooterView = [[UIView alloc] init];
    _firstpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//找document域内的文件路径
    _filepath = [_firstpath objectAtIndex:0];//取出文件路径
    _fileManager = [NSFileManager defaultManager];
    _filepathArray = [_fileManager contentsOfDirectoryAtPath:_filepath error:nil];
    _videofilepathArray =[self videofinder:_filepathArray];//获取视频文件
    [self.view addSubview:_videolistTableView];//加入主视图
}

-(NSMutableArray<NSString*>*)videofinder:(NSArray<NSString *> *)array//文件筛选
{
    NSArray<NSString *> *videofilekinds = [[NSArray alloc] initWithObjects:@".mp4",@".mov",@".avi",@".mkv",@".wmv",@".rmvb",@".3gp",@".mgp",@".rm",@".xvid", nil];
    NSMutableArray<NSString *> *videofile = [[NSMutableArray alloc] init];
    NSEnumerator *file =[array objectEnumerator];
    id obj = nil;
    while((obj=[file nextObject])!=nil)
    {
        bool isvideo =false;
        for(NSInteger i = 0;i<videofilekinds.count;i++)
        {
            NSRange range = [obj rangeOfString:[videofilekinds objectAtIndex:i] options:NSBackwardsSearch];
            if(range.location!=NSNotFound)
            {
                isvideo = true;
                break;
            }
        }
        if(isvideo)[videofile addObject:obj];
    }
    return videofile;
}

-(UIImage *)getThumbnailImage:(NSString *)videoPath {
    if (videoPath) {
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath: videoPath] options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        // 设定缩略图的方向
        // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的
        gen.appliesPreferredTrackTransform = YES;
        // 设置图片的最大size(分辨率)
        gen.maximumSize = CGSizeMake(50, 50);
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _videofilepathArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *filepathforvideo = [_filepath stringByAppendingString:@"/"];
    filepathforvideo = [filepathforvideo stringByAppendingString:_videofilepathArray[indexPath.row]];
    
    VideoListCell *cell = (VideoListCell *)[tableView dequeueReusableCellWithIdentifier:[VideoListCell reuseIdentifier]];
    //这部分为复用，这是个函数，返回的是根据前一个cell的内容来服用新cell来优化
    if(cell == nil)cell =[[VideoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[VideoListCell reuseIdentifier]];
    cell.videoNameString = _videofilepathArray[indexPath.row];
    cell.videoImageView.image = [self getThumbnailImage:filepathforvideo];
    cell.videoNameLabel.text = _videofilepathArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDellegate

//点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fileroad = [_filepath stringByAppendingString:@"/"];
    fileroad =[fileroad stringByAppendingString:_videofilepathArray[indexPath.row]];
    NSURL *playUrl = [[NSURL alloc] initFileURLWithPath:fileroad];
    player *video = [[player alloc] init];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:playUrl];
    video.videoplayer = [[AVPlayer alloc] initWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:video.videoplayer];
    layer.frame = CGRectMake(0,0, self.view.frame.size.width , self.view.frame.size.height );
    [video.view.layer addSublayer:layer];
    [self presentViewController:video animated:YES completion:^{NSLog(@"切换视图");}];
    [video.videoplayer play];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    return 200;
}

@end
