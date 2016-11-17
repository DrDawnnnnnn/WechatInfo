//
//  WeiXinModel.h
//  生活助手
//
//  Created by 杨晓鸣 on 16/9/20.
//  Copyright © 2016年 杨晓鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

//微信精选的数据模型
@interface WeiXinModel : NSObject

//数据的ID，在服务器中的标识
@property(retain,nonatomic)NSString* mID;
//微信文章的图像地址
@property(retain,nonatomic)NSString* mFirstImg;
//文章的发布源
@property(retain,nonatomic)NSString* mSource;
//标记
@property(retain,nonatomic)NSString* mMark;
//文章的标题
@property(retain,nonatomic)NSString* mTitle;
//文章的具体链接
@property(retain,nonatomic)NSString* mURL;

@end
