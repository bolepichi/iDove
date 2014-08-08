//
//  THStatusRepostedView.m
//  iDove
//
//  Created by apple on 14-8-6.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "THStatusRepostedView.h"

#import "THPhotoesView.h"

#import "HtmlString.h"



@interface THStatusRepostedView() <UIWebViewDelegate>

//webView
@property (nonatomic, strong) UIWebView *contentWebView;


//
@property (nonatomic, strong) UILabel *contentLabel;


//
@property (nonatomic, strong) THPhotoesView *photoesView;

@end

@implementation THStatusRepostedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    
        /** 1.正文\内容 */
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
        

        
        /** 2.配图 */
        _photoesView = [[THPhotoesView alloc]init];
        [self addSubview:_photoesView];
        
        self.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0];
        
    }
    return self;
}

-(void)setStatusFrame:(LHStatusFrame *)statusFrame
{
    
    _statusFrame = statusFrame;
    
    if (_statusFrame.status.retweetedStatus) {
        
        self.hidden = NO;
        self.frame = statusFrame.repostedViewF;
        
    } else {
        
        self.hidden = YES;
        return;
        
    }
    
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置frame
    [self setupFrame];
    
}

-(void)setupFrame
{
    
    self.contentLabel.frame = self.statusFrame.repostedContentLabelF;
    
    
    
    self.contentWebView.frame = CGRectMake(-8, -7, 313, self.statusFrame.repostedContentLabelF.size.height+10);
    
    /** 2.配图 */
    self.photoesView.frame = self.statusFrame.repostedPhotosViewF;

}


/**
 *  设置数据
 */
- (void)setupData
{

    /** 6.正文\内容 */
    
    NSString *content = [NSString stringWithFormat:@"@%@:%@",_statusFrame.status.retweetedStatus.user.name,_statusFrame.status.retweetedStatus.text];
    
    [self.contentWebView loadHTMLString:[HtmlString transformString:content] baseURL:nil];
    
    
//    self.contentLabel.text = [HtmlString transformText:content];
    
    /** 7.配图 */
    self.photoesView.photoes = _statusFrame.status.retweetedStatus.images;
}



#pragma mark - UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        
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
        
        [webView stopLoading];
        
    }
    
    return YES;
}


@end
