//
//  LHStatusFrame.h
//  iDove
//
//  Created by apple on 14-8-5.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LHStatus.h"

@interface LHStatusFrame : NSObject<UIWebViewDelegate>

@property (strong, nonatomic) LHStatus *status;

/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;

/** 原创微博的view */
@property (nonatomic, assign, readonly) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photosViewF;

/** 底部的工具条 */
@property (nonatomic, assign, readonly) CGRect toolbarF;

/** 被转发微博的view */
@property (nonatomic, assign, readonly) CGRect repostedViewF;
/** 被转发微博的昵称 */
@property (nonatomic, assign, readonly) CGRect repostedNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect repostedContentLabelF;
/** 被发微博的配图 */
@property (nonatomic, assign, readonly) CGRect repostedPhotosViewF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) UIWebView *webView;



@end
