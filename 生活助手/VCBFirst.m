//
//  VCBFirst.m
//  生活助手
//
//  Created by 杨晓鸣 on 16/9/19.
//  Copyright © 2016年 杨晓鸣. All rights reserved.
//

#import "VCBFirst.h"
#import "WeiXinModel.h"
#import "WXBaseCell.h"
#import "UIImageView+WebCache.h"

@interface VCBFirst ()

@end

@implementation VCBFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //创建一个导航栏按钮
    _navMore = [[UIBarButtonItem alloc]initWithTitle:@"加载更多" style:UIBarButtonItemStylePlain target:self action:@selector(pressMore)];
    self.navigationItem.rightBarButtonItem = _navMore;
    
    //创建刷新视图
    _refreshControl = [[UIRefreshControl alloc]init];
    _refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"松手更新数据.."];
    _refreshControl.tintColor = [UIColor redColor];
    [_refreshControl addTarget:self action:@selector(refreshUpdate) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    [self.view addSubview:_tableView];
    //创建数组对象
    _arrayData = [[NSMutableArray alloc]init];

    [self loadData];
    _refreshCount = 1;
    _isLoadMore = NO;
}

//启动加载更多数据事件
-(void)pressMore
{
    _isLoadMore = YES;
    _refreshCount++;
    [self loadData];
}


-(void) refreshUpdate
{
    _isLoadMore = NO;
    _refreshCount = 1;
    //清空之前所有的数据
    
    if (_isLoadMore != YES) {

    [_arrayData removeAllObjects];
    }
    
    [self loadData];
    //结束刷新
    [_refreshControl endRefreshing];
}

//加载网络数据 并且接卸
-(void) loadData
{

    
//    for (int i = 0; i<10; i++) {
//        [_arrayData addObject:@"数据"];
//    }
    
    //获取数据连接接口地址
    NSString* strURL = [NSString stringWithFormat:@"http://v.juhe.cn/weixin/query?pno=%ld&ps=10&dtype=&key=5f3929f345476a0aa18f9c930e5b214e",(long)_refreshCount];
    
    NSURL* url = [NSURL URLWithString:strURL];
    //创建一个网络请求
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //获取一个连接对象
    NSURLSession* session = [NSURLSession sharedSession];
    //通过网络请求建立连接
    //获取网络数据
    //P1:网络请求
    //P2:返回的block
    NSURLSessionTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        NSDictionary* dicRoot = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"dicRoot = %@",dicRoot);
        
        NSDictionary* dicResult = [dicRoot objectForKey:@"result"];
        NSLog(@"result = %@",dicResult);
        
        NSDictionary* arrayList = [dicResult objectForKey:@"list"];
        
        for (NSDictionary* dicData in arrayList)
        {
            WeiXinModel* model = [[WeiXinModel alloc]init];
            
            //解析微信文章的相关数据
            model.mFirstImg = [dicData objectForKey:@"firstImg"];
            model.mID = [dicData objectForKey:@"id"];
            model.mMark = [dicData objectForKey:@"mark"];
            model.mSource = [dicData objectForKey:@"source"];
            model.mTitle = [dicData objectForKey:@"title"];
            model.mURL = [dicData objectForKey:@"url"];
            
            [_arrayData addObject:model];
        }
        //刷新数据在主线程中
        [self performSelectorOnMainThread:@selector(updataUI) withObject:nil waitUntilDone:YES];
        

    }];
    //任务结束
    [task resume];
}

//在主线程中执行函数
-(void)updataUI
{
    [_tableView reloadData];
}

//返回数据的个数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
//返回数据的组数
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayData.count;
}


-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strID = @"ID";
    
    WXBaseCell* cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    
    //通过xib文件来加载创建单元格对象
    //P1:单元格资源名字
    //P2:资源拥有者的对象
    //P3:选择参数
    if (cell == nil)
    {
        cell = (WXBaseCell*) [[[NSBundle mainBundle] loadNibNamed:@"WXBaseCell" owner:self options:nil] lastObject];
    }
    
    //获得数据源中的数据
    WeiXinModel* model = [_arrayData objectAtIndex:indexPath.section];
    
    //标题赋值
    cell.mLBTitle.text = model.mTitle;
    //来源赋值
    cell.mLBSource.text = model.mSource;
    //加载网络数据
    //加载好数据后会自动更新单元格数据
    //P1:图片的网络地址
    //P2:可以用一个临时的图片替代
    [cell.mImageView sd_setImageWithURL:[NSURL URLWithString:model.mFirstImg] placeholderImage:nil];
    
    return cell;
}

//推出具体的文章细节页面
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取当前视图大小
    CGRect bounds = self.view.bounds;
    UIWebView* webView = [[UIWebView alloc]initWithFrame:bounds];
    
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    //webView.detectsPhoneNumbers = YES;//自动检测网页上的号码 单机可以选择拨打
    
    UIViewController* vcWeb = [[UIViewController alloc]init];
    [vcWeb.view addSubview:webView];
    //推出视图控制器
    [self.navigationController pushViewController:vcWeb animated:YES];
    //根据当前单元格的组数 获取数据
    WeiXinModel* model = [_arrayData objectAtIndex:indexPath.section];
    NSString* c = model.mURL;
    
    NSURL* url = [NSURL URLWithString:c];//创建url
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
}

/*
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //可复用单元格id
    NSString* strID = @"ID";
    //尝试获取可复用的单元格
    UITableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    WeiXinModel* model = [_arrayData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.mTitle;
    return cell;
}*/

-(CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiXinModel* model = [_arrayData objectAtIndex:indexPath.section];
    
    if ([model.mFirstImg isEqualToString:@""]) {
        return 80;
    }
    return 190;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
