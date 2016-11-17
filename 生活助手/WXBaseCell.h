//
//  WXBaseCell.h
//  生活助手
//
//  Created by 杨晓鸣 on 16/9/20.
//  Copyright © 2016年 杨晓鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXBaseCell : UITableViewCell
//标题
@property (weak, nonatomic) IBOutlet UILabel *mLBTitle;
//标题图片
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
//来源
@property (weak, nonatomic) IBOutlet UILabel *mLBSource;

@end
