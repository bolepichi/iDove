//
//  THPhotoView.m
//  iDove
//
//  Created by apple on 14-8-6./Users/taagoomacmini/Desktop/未命名文件夹/iDove/iDove/HtmlString.h
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "THPhotoView.h"

#import <UIImageView+WebCache.h>

@interface THPhotoView()

@property (nonatomic, strong) UIImageView *gifView;

@end


@implementation THPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        self.clipsToBounds = YES;
        
        
        _gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        
        [self addSubview:_gifView];
        
        
    }
    return self;
}


-(void)setPhoto:(THPhotoView *)photo
{
    
    _photo = photo;
    
    NSURL *photoURL = [NSURL URLWithString:[(NSDictionary *)photo objectForKey:@"thumbnail_pic"]];
    
    [self sd_setImageWithURL:photoURL placeholderImage:nil];
    
    if ([[photoURL absoluteString].lowercaseString hasSuffix:@"gif"]) {
        
        self.gifView.hidden = NO;
        
    } else {
        
        self.gifView.hidden = YES;
    }

    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.frame = CGRectMake(self.frame.size.width - self.gifView.frame.size.width, self.frame.size.height - self.gifView.frame.size.height, self.gifView.frame.size.width, self.gifView.frame.size.height);

}

@end
