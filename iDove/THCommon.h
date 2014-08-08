//
//  THCommon.h
//  iDove
//
//  Created by apple on 14-8-7.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

// cell的内边距
#define LHCellPadding 10

// cell之间的间距
#define LHCellMargin 8

// 昵称的字体
#define LHNameFont [UIFont systemFontOfSize:14]
// 被转发昵称的字体
#define LHRepostedNameFont LHNameFont

// 时间的字体
#define LHTimeFont [UIFont systemFontOfSize:12]
// 来源的字体
#define LHSourceFont LHTimeFont
// 正文的字体
#define LHContentFont [UIFont systemFontOfSize:14]
// 被转发正文的字体
#define LHRepostedContentFont LHContentFont

// 配图
// 1张配图的宽度
#define LHPhotoW 70
// 1张配图的高度
#define LHPhotoH 70
// 配图之间的间距
#define LHPhotoMargin 10
// 返回最大列数
#define LHPhotosMaxCols(count) ((count == 4) ? 2 : 3)