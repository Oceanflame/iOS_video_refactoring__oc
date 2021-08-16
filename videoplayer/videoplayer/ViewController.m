//
//  ViewController.m
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/12.
//

#import "ViewController.h"
#import "VideoListCell.h"
#import "Masonry.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property UITableView *videolistTableView;//列表
@property NSArray<NSString *> * firstpath;
@property NSString * filepath;//documnet路径
@property NSArray<NSString *> * filepathArray;//文件路径数组
@property NSMutableArray<NSString *> * videofilepathArray;//视频文件名数组
@property NSFileManager * fileManager;//文件管理器

-(NSMutableArray<NSString *> *)videofinder:(NSArray<NSString *> *)array;//文件筛选函数

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
    NSArray<NSString *> *videofilekinds = [[NSArray alloc] initWithObjects:@".mp4",@".mov",@".avi",@".mkv",@".wmv",@".rmvb",@".3gp",@".mgp",@".rm",@".xvid",@".flv", nil];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _videofilepathArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoListCell *cell = (VideoListCell *)[tableView dequeueReusableCellWithIdentifier:[VideoListCell reuseIdentifier]];
    cell.videoNameString = _videofilepathArray[indexPath.row];
    if(cell == nil)cell =[[VideoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[VideoListCell reuseIdentifier]];
    return cell;
}

#pragma mark - UITableViewDellegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat
{
    
}

@end
