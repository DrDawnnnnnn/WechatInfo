//
//  VCBFirst.h
//  生活助手
//
//  Created by 杨晓鸣 on 16/9/19.
//  Copyright © 2016年 杨晓鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCBFirst : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tableView;
    NSMutableArray* _arrayData;
    //刷新视图数据对象
    //下拉刷新
    UIRefreshControl* _refreshControl;
    //刷新计数
    NSUInteger* _refreshCount;
    
    UIBarButtonItem* _navMore;
    
    //是否加载更多数据
    BOOL _isLoadMore;
    
}
@end
