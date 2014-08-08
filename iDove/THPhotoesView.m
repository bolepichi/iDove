//
//  THPhotoesView.m
//  iDove
//
//  Created by apple on 14-8-6.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "THPhotoesView.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "THPhotoView.h"


@implementation THPhotoesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.userInteractionEnabled = YES;
        
        for (int i = 0; i < 9; i ++) {
            
            THPhotoView *photoView = [[THPhotoView alloc]init];
            
            photoView.tag = i;
            
            [self addSubview:photoView];
            
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTap:)]];
        
        }
    
    }
    return self;
}


-(void)photoTap:(UITapGestureRecognizer *)tap
{
    // 1.创建浏览器对象
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置浏览器对象的所有图片
    NSMutableArray *mjphotos = [NSMutableArray array];
    for (int i = 0; i<self.photoes.count; i++) {
        
        // 创建MJPhoto模型
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        // 设置图片的url
        
        NSString *imageURL = [self.photoes[i] objectForKey:@"thumbnail_pic"];
        
        
        
        mjphoto.url = [NSURL URLWithString:[imageURL stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"]];
        // 设置图片的来源view
        mjphoto.srcImageView = self.subviews[i];
        [mjphotos addObject:mjphoto];
    }
    browser.photos = mjphotos;
    
    // 3.设置浏览器默认显示的图片位置
    browser.currentPhotoIndex = tap.view.tag;
    
    // 4.显示浏览器
    [browser show];
    
}
- (void)setPhotoes:(NSArray *)photoes
{
    _photoes = photoes;
    
    // 0.可见的控件
    int photosCount = photoes.count;
    
    if (photosCount == 0) {
        self.hidden = YES;
        return;
    } else {
        self.hidden = NO;
    }
    
    // 1.给图片控件显示图片(遍历所有的子控件)
    for (int i = 0; i < 9; i++) {
        
        THPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // i <photosCount 显示图片
            photoView.hidden = NO;
            photoView.photo = photoes[i];
            
        } else { // i >= photosCount 隐藏
            photoView.hidden = YES;  // 还在父控件的subviews数组中移除(还在内存中)
        }
        //        [photoView removeFromSuperview]; // 从父控件的subviews数组中移除(从内存中移除)
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.photoes.count;
    
    for (int i = 0; i < count; i++) {
        
        // 取出子控件
        THPhotoView *photoView = self.subviews[i];
        
        // 一行最多的列数
        int maxCols = LHPhotosMaxCols(count);
        
        // x 取决于 列数
        int col = i % maxCols;
        
        // y 取决于 行数
        int row = i / maxCols;
        
        if (self.photoes.count != 1) {

            // 设置frame
            photoView.frame = CGRectMake(col *(LHPhotoW + LHPhotoMargin), row * (LHPhotoH + LHPhotoMargin), LHPhotoW, LHPhotoH);

        } else  {
            
            photoView.frame = CGRectMake(col *(LHPhotoW + LHPhotoMargin), row * (LHPhotoH + LHPhotoMargin), self.frame.size.width, self.frame.size.height);
            
        }
        
       
        
    }
}

@end
