//
//  THStatusCell.h
//  iDove
//
//  Created by Taagoo'iMac on 14-7-24.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LHStatusFrame.h"

#import "THStatusOriginalView.h"

@interface THStatusCell : UITableViewCell <UIWebViewDelegate>

@property (nonatomic,strong)LHStatus *status;


@property (nonatomic, strong) LHStatusFrame *statusFrame;


@end
