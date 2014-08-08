//
//  LHStatusFrame.m
//  iDove
//
//  Created by apple on 14-8-5.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHStatusFrame.h"

#import "HtmlString.h"

#define LHCellWidth [UIScreen mainScreen].bounds.size.width



@implementation LHStatusFrame


- (void)setStatus:(LHStatus *)status
{
    _status = status;
    
    // 1.计算顶部控件的frame
    [self setupTopViewFrame];
    
    // 2.计算底部工具条的frame
    [self setupToolbarFrame];
    
    // 3.cell的高度
    _cellHeight = CGRectGetMaxY(_toolbarF);
    
    
    
}


/**
 *  计算顶部控件的frame
 */
- (void)setupTopViewFrame
{
    // 1.计算原创微博的frame
    [self setupOriginalViewFrame];
    
    // 2.计算转发微博的frame
    [self setupRepostedViewFrame];
    
    // 3.计算顶部控件的frame
    LHStatus *repostedStatus = self.status.retweetedStatus;
    CGFloat topViewH = 0;
    if (repostedStatus) { // 有转发微博
        topViewH = CGRectGetMaxY(_repostedViewF);
    } else { // 无转发微博
        topViewH = CGRectGetMaxY(_originalViewF);
    }
    CGFloat topViewW = LHCellWidth;
    CGFloat topViewX = 0;
    CGFloat topViewY = LHCellMargin;
    _topViewF = CGRectMake(topViewX, 0, topViewW, topViewH);
}




/**
 *  根据配图的个数计算配图的尺寸
 */
- (CGSize)photosSizeWithCount:(int)photosCount andWithStatus:(LHStatus *)status
{
    
    if (photosCount != 1) {
        // 一行最多的列数
        int maxCols = LHPhotosMaxCols(photosCount);
        
        // 列数
        int cols = (photosCount >= maxCols) ? maxCols : photosCount;
        
        // 行数
        int rows = photosCount / maxCols;
        
        if (photosCount % maxCols != 0) { // 不是maxCols的倍数
            rows++;
        }
        
        // 配图的宽度取决于图片的列数
        // 配图的宽度 == 列数 * LHPhotoW + (列数 - 1) * photoMargin
        CGFloat photosViewW = cols * LHPhotoW + (cols - 1) * LHPhotoMargin;
        
        // 配图的高度取决于图片的行数
        // 配图的高度 == 行数 * LHPhotoH + (行数 - 1) * photoMargin
        CGFloat photosViewH = rows * LHPhotoH + (rows - 1) * LHPhotoMargin;
        
        return CGSizeMake(photosViewW, photosViewH);
        
        
    } else {
        
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[status.images[0] objectForKey:@"thumbnail_pic"]]]];
        
        return CGSizeMake(image.size.width, image.size.height);
        
    }
}




/**
 *  计算原创微博的frame
 */
- (void)setupOriginalViewFrame
{
    // 1.头像
    CGFloat iconViewX = LHCellPadding;
    CGFloat iconViewY = LHCellPadding;
    CGFloat iconViewW = 35;
    CGFloat iconViewH = 35;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 2.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + LHCellPadding;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [self.status.user.name sizeWithAttributes: @{NSFontAttributeName:LHNameFont}];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 3.会员图标
    CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + LHCellPadding;
    CGFloat vipViewY = nameLabelY;
    CGFloat vipViewW = 14;
    CGFloat vipViewH = nameLabelSize.height;
    _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    
    // 4.正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF) + LHCellPadding;
    
    CGFloat contentLabelMaxW = LHCellWidth - 2 * LHCellPadding;
    
    NSDictionary *attribute = @{NSFontAttributeName: LHContentFont};
    CGSize contentLabelSize = [[HtmlString transformText:self.status.text] boundingRectWithSize:CGSizeMake(contentLabelMaxW, 0) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 5.配图
    int photosCount = self.status.images.count;
    CGFloat originalViewH = 0;
    if (photosCount) {
        CGFloat photosViewX = contentLabelX;
        CGFloat photosViewY = CGRectGetMaxY(_contentLabelF) + LHCellPadding;
        // 计算配图的尺寸
        CGSize photosViewSize = [self photosSizeWithCount:photosCount andWithStatus:self.status];
        _photosViewF = (CGRect){{photosViewX, photosViewY}, photosViewSize};
        
        originalViewH = CGRectGetMaxY(_photosViewF) + LHCellPadding;
    } else { // 没有配图
        originalViewH = CGRectGetMaxY(_contentLabelF) + LHCellPadding;
    }
    
    // 6.原创微博的整体
    CGFloat originalViewX = 0;
    CGFloat originalViewY = 0;
    CGFloat originalViewW = LHCellWidth;
    _originalViewF = CGRectMake(originalViewX, originalViewY, originalViewW, originalViewH);
}




/**
 *  计算转发微博的frame
 */
- (void)setupRepostedViewFrame
{
    LHStatus *repostedStatus = self.status.retweetedStatus;
    if (!repostedStatus) return;
    
    // 2.正文
    CGFloat repostedContentLabelX = LHCellPadding;
    CGFloat repostedContentLabelY = CGRectGetMaxY(_repostedNameLabelF);
    CGFloat repostedContentLabelMaxW = LHCellWidth - 2 * LHCellPadding;
    CGSize repostedContentLabelMaxSize = CGSizeMake(repostedContentLabelMaxW, MAXFLOAT);
    
    NSDictionary *attribute = @{NSFontAttributeName: LHContentFont};
    
    NSString *content = [NSString stringWithFormat:@"@%@:%@",repostedStatus.user.name,repostedStatus.text];
    
    CGSize repostedContentLabelSize = [[HtmlString transformText:content] boundingRectWithSize:repostedContentLabelMaxSize options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    _repostedContentLabelF = (CGRect){{repostedContentLabelX, repostedContentLabelY}, repostedContentLabelSize};
    
    // 3.配图
    int photosCount = self.status.retweetedStatus.images.count;
    CGFloat repostedViewH = 0;
    if (photosCount) { // 有配图
        CGFloat repostedPhotosViewX = repostedContentLabelX;
        CGFloat repostedPhotosViewY = CGRectGetMaxY(_repostedContentLabelF) + LHCellPadding;
        // 计算配图的尺寸
        CGSize repostedPhotosViewSize = [self photosSizeWithCount:photosCount andWithStatus:repostedStatus];
        _repostedPhotosViewF = (CGRect){{repostedPhotosViewX, repostedPhotosViewY}, repostedPhotosViewSize};
        
        repostedViewH = CGRectGetMaxY(_repostedPhotosViewF) + LHCellPadding;
    } else { // 没有配图
        repostedViewH = CGRectGetMaxY(_repostedContentLabelF) + LHCellPadding;
    }

    // 4.整体
    CGFloat repostedViewX = 0;
    CGFloat repostedViewY = CGRectGetMaxY(_originalViewF);
    CGFloat repostedViewW = LHCellWidth;
    _repostedViewF = CGRectMake(repostedViewX, repostedViewY, repostedViewW, repostedViewH);
}

/**
 *  计算底部工具条的frame
 */
- (void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(_topViewF);
    CGFloat toolbarW = LHCellWidth;
    CGFloat toolbarH = 35;
    _toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}



@end
