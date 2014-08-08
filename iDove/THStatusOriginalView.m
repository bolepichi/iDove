//
//  THStatusOriginalView.m
//  iDove
//
//  Created by apple on 14-8-6.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "THStatusOriginalView.h"

#import "THPhotoesView.h"

#import <UIImageView+WebCache.h>

#import "HtmlString.h"






@interface THStatusOriginalView () <UIWebViewDelegate>

//头像
@property (nonatomic, strong) UIImageView *iconView;

//vip
@property (nonatomic, strong) UIImageView *vipView;


//昵称
@property (nonatomic, strong) UILabel *nameLabel;

//时间
@property (nonatomic, strong) UILabel *timeLabel;

//来源
@property (nonatomic, strong) UILabel *sourceLabel;

//内容
@property (nonatomic, strong) UIWebView *contentWebView;

//内容 (用来约束可恶的webView frame)
@property (nonatomic, strong) UILabel *contentLabel;

//照片
@property (nonatomic, strong) THPhotoesView *photoesView;

@property (nonatomic, strong) LHStatus *status;

@end



@implementation THStatusOriginalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        /** 1.头像 */
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];

        /** 2.会员图标 */
        _vipView = [[UIImageView alloc]init];
        [self addSubview:_vipView];

        /** 3.昵称 */
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = LHNameFont;
        [self addSubview:_nameLabel];

        /** 4.时间 */
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = LHTimeFont;
        [self addSubview:_timeLabel];
        
        /** 5.来源 */
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.font = LHSourceFont;
        [self addSubview:_sourceLabel];
        
        /** 6.正文\内容 */
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
        _contentLabel.font = LHContentFont;
        _contentLabel.userInteractionEnabled = YES;
        [self addSubview:_contentLabel];
        
        
        _contentWebView = [[UIWebView alloc]init];
        _contentWebView.delegate = self;
        _contentWebView.scrollView.scrollEnabled = NO;
        _contentWebView.backgroundColor = [UIColor clearColor];
        _contentWebView.opaque = NO;
        [_contentLabel addSubview:_contentWebView];
        
        
        /** 7.配图 */
        _photoesView = [[THPhotoesView alloc]init];
        [self addSubview:_photoesView];

    }
    return self;
}

-(void)setStatusFrame:(LHStatusFrame *)statusFrame
{
    
    _statusFrame = statusFrame;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置frame
    [self setupFrame];
    
}

- (void)setupFrame
{
    
    
    self.frame = self.statusFrame.originalViewF;
    
    /** 1.头像 */
    self.iconView.frame = self.statusFrame.iconViewF;
    
    /** 2.会员图标 */
    self.vipView.frame = self.statusFrame.vipViewF;

    /** 3.昵称 */
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    /** 4.时间 */
    NSString *timeStr = [NSString stringWithFormat:@"%ld",_status.created_At];
    CGSize timeFrame = [timeStr sizeWithAttributes:@{NSFontAttributeName:LHTimeFont}];
    self.timeLabel.frame = (CGRect){{self.nameLabel.frame.origin.x, CGRectGetMaxY(self.nameLabel.frame) + LHCellPadding * 0.5},timeFrame};
    
    /** 5.来源 */
    CGSize sourceFrame = [_status.source sizeWithAttributes:@{NSFontAttributeName:LHSourceFont}];
    self.sourceLabel.frame = (CGRect){{CGRectGetMaxX(self.timeLabel.frame) + LHCellPadding, self.timeLabel.frame.origin.y},sourceFrame};
    
    /** 6.正文\内容 */
    _contentLabel.frame = self.statusFrame.contentLabelF;

    self.contentWebView.frame = CGRectMake(-8, -8, 312, _contentLabel.frame.size.height+10);
    
    

    
    /** 7.配图 */
    self.photoesView.frame = self.statusFrame.photosViewF;
    
}



/**
 *  设置数据
 */
- (void)setupData
{
    
    /** 1.头像 */
    
    _status = _statusFrame.status;
    
    NSURL *iconUrl = [NSURL URLWithString:_status.user.profileImageUrl];
    [self.iconView sd_setImageWithURL:iconUrl];
    
//    /** 2.会员图标 */
//    if ([user isVip]) {
//        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
//        self.vipView.image = [UIImage imageWithName:imageName];
//        self.vipView.hidden = NO;
//        
//        self.nameLabel.textColor = [UIColor orangeColor];
//    } else {
//        self.vipView.hidden = YES;
//        
//        self.nameLabel.textColor = [UIColor blackColor];
//    }
    
    /** 3.昵称 */
    self.nameLabel.text = _status.user.name;
    
    /** 4.时间 */
    self.timeLabel.text = [_status statusTimeString];
    
    /** 5.来源 */
    self.sourceLabel.text = _status.source;
    
    /** 6.正文\内容 */

    
    [self.contentWebView loadHTMLString:[HtmlString transformString:_status.text] baseURL:nil];
    
    
//    self.contentLabel.text = [HtmlString transformText:_status.text];
    
    /** 7.配图 */
    self.photoesView.photoes = _status.images;
}


#pragma mark - UIWebViewDelegate

#pragma mark - UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        [webView stopLoading];
        
        NSString *str = [[request URL].absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *result;
        
        if ([str rangeOfString:@"#"].location != NSNotFound) {
            
            result = [str substringWithRange:NSMakeRange([str rangeOfString:@"#"].location + 1, str.length - [str rangeOfString:@"#"].location - 2)];
            
        } else if ([str rangeOfString:@"@"].location != NSNotFound) {
            
            result = [str substringFromIndex:[str rangeOfString:@"@"].location +1];
            
        } else {
            
            result = str;
            
        }
        
        NSLog(@"%@",result);
        
        
        
    }
    
    return YES;
}


@end
