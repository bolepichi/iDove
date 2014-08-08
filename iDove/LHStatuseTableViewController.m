//
//  LHStatuseTableViewController.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-24.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "LHStatuseTableViewController.h"

#import "THStatusCell.h"

#import "LHWbAccount.h"

#import "RequestData.h"

#import <UIImageView+WebCache.h>

#import "HtmlString.h"

#import "LHStatusFrame.h"



@interface LHStatuseTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>



@property (strong, nonatomic) NSMutableArray *dataArray;


@property (strong, nonatomic) NSMutableArray *cellHeghtArray;

@end

@implementation LHStatuseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    [self requestData];
    
}


-(void)requestData
{
    if (!_dataArray || !_cellHeghtArray) {
        _dataArray = [[NSMutableArray alloc]init];
        _cellHeghtArray = [NSMutableArray array];
    }
    
    
    LHWbAccount *wbAccount = [LHWbAccount readUserInfoFromDocuments];
    
    NSDictionary *parameter = @{@"uid":wbAccount.userId,@"access_token":wbAccount.accessToken};
    
    [RequestData getRequest:parameter WithRequestUrlString:url_homeStatus message:^(NSDictionary *dict, NSString *success, NSString *failure) {
        
        NSArray *array = (NSArray *)[dict objectForKey:@"statuses"];
        
        for (int i = 0; i < array.count; i ++) {
            
            NSDictionary *dic  = array[i];
            
            LHStatus *status = [[LHStatus alloc]initWithJosnDictionary:dic];
            
            LHStatusFrame *frame = [[LHStatusFrame alloc]init];
            
            frame.status = status;
            
            [_cellHeghtArray addObject:frame];
            
            [_dataArray addObject:status];
            
            
        }
        [self.tableView reloadData];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return _dataArray.count;
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LHStatusFrame *frame = [[LHStatusFrame alloc]init];
    
    frame = _cellHeghtArray[indexPath.row];
    
    return frame.cellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"Cell";
    
    
    static BOOL nibsRegistered = NO;
    
    if (!nibsRegistered) {

        [tableView registerClass:[THStatusCell class] forCellReuseIdentifier:CustomCellIdentifier];
    }
    
    THStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    cell.selected = NO;
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    // Configure the cell...
    
//    cell.status = _dataArray[indexPath.row];
    
    cell.statusFrame = _cellHeghtArray[indexPath.row];
    

    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

@end
