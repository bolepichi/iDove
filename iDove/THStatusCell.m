//
//  THStatusCell.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-24.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "THStatusCell.h"

#import "THStatusOriginalView.h"

#import "THStatusRepostedView.h"

#import "THStatusToolbar.h"

@interface THStatusCell()


@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) UIWebView *retweetedWebView;

@property (strong, nonatomic) UIImageView *contentImageView;


@property (strong, nonatomic) NSMutableArray *imageArray;

@property (assign, nonatomic) CGRect webFrame;


@end

@implementation THStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)setStatusFrame:(LHStatusFrame *)statusFrame
{
    
    _statusFrame = statusFrame;
    
    // 1.添加顶部的控件
    [self setupTopView];
    
    //2.添加转发
    [self setupRepostedView];
    
    //3.添加底部view
    [self setupToolBar];
    
}

/**
 *  添加顶部的控件
 */
- (void)setupTopView
{
    
    THStatusOriginalView *topView = [[THStatusOriginalView alloc] init];
    
    [topView setStatusFrame:_statusFrame];
    
    [self.contentView addSubview:topView];
}


/**
 *  添加转发微博的view
 */
- (void)setupRepostedView
{
    
    THStatusRepostedView *repostedView = [[THStatusRepostedView alloc]init];
    
    [repostedView setStatusFrame:_statusFrame];
    
    [self.contentView addSubview:repostedView];
    
    
}


-(void)setupToolBar
{
    
    THStatusToolbar *toolbar= [[THStatusToolbar alloc]init];
    
    toolbar.frame = _statusFrame.toolbarF;
    
    toolbar.status = _statusFrame.status;
    
    [self.contentView addSubview:toolbar];
    
}


- (void)awakeFromNib
{
    // Initialization cod
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:animated];
    
    // Configure the view for the selected state
}

@end
