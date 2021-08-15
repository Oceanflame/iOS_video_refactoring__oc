//
//  ViewController.m
//  videoplayer
//
//  Created by 李雨泽 on 2021/8/12.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property UINavigationBar *videolistNavigationBar;
@property UITableView *videolistTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.videolistTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
}


@end
