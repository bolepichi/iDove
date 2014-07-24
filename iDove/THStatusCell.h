//
//  THStatusCell.h
//  iDove
//
//  Created by Taagoo'iMac on 14-7-24.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LHStatus.h"


@interface THStatusCell : UITableViewCell


@property (nonatomic,strong)LHStatus *status;

-(void)initWithDictionary:(NSDictionary*)dic;


@end
