//
//  THTabBarController.m
//  iDove
//
//  Created by Taagoo'iMac on 14-7-24.
//  Copyright (c) 2014年 Taagoo. All rights reserved.
//

#import "THTabBarController.h"
#import "LHStatuseTableViewController.h"
#import "THSearchViewController.h"
#import "THUserCenterViewController.h"


@interface THTabBarController ()


@property(nonatomic, assign) NSInteger lastIndex;


@property(nonatomic, strong) UIView *tabbarview;

@end

@implementation THTabBarController


-(id)init{
    self = [super init];
    if (self) {
        
        

        
    }
    return self;
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        LHStatuseTableViewController *statusVC = [[LHStatuseTableViewController alloc]
                                                  initWithNibName:@"LHStatuseTableViewController"
                                                  bundle:nil];
        THSearchViewController *searchVC = [[THSearchViewController alloc]
                                            initWithNibName:@"THSearchViewController"
                                            bundle:nil];
        THUserCenterViewController *usercenterVC = [[THUserCenterViewController alloc]
                                                    initWithNibName:@"THUserCenterViewController"
                                                    bundle:nil];
        UINavigationController *navC1 = [[UINavigationController alloc] initWithRootViewController:statusVC];
        navC1.navigationBarHidden =YES;
        UINavigationController *navC2 = [[UINavigationController alloc] initWithRootViewController:searchVC];
        navC2.navigationBarHidden =YES;
        UINavigationController *navC3 = [[UINavigationController alloc] initWithRootViewController:usercenterVC];
        navC3.navigationBarHidden =YES;
        self.viewControllers = [[NSArray alloc] initWithObjects:navC1,navC2,navC3 ,nil];

        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden =YES;
    // Do any additional setup after loading the view from its nib.
    
    
    if (self.tabbarview == nil) {
        
        
        CGRect screen =[[UIScreen mainScreen] bounds];
        
        UIView *tabbarbackview = [[UIView alloc] initWithFrame:CGRectMake(0, screen.size.height-49, screen.size.width, 49)];
        
        [self.view addSubview:tabbarbackview];
        
        self.lastIndex = 1;
        
        for (int i=1; i<=4; i++) {
            
            UIButton *tab_button = [self creattabbarButtonWithIndex:i];
            
            tab_button.tag = i;
            
            [tabbarbackview addSubview:tab_button];
            
            tab_button.enabled = i == 1?NO:YES;
            
        }
        
        self.tabbarview = tabbarbackview;
        
    }
    
 

}


-(UIButton*)creattabbarButtonWithIndex:(int)index{
    
    UIButton *tab_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [tab_button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabimage%d",index]] forState:UIControlStateNormal];
    [tab_button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabimageselect%d",index]] forState:UIControlStateDisabled];
    [tab_button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    
    float x = (index-1)*80.0f;
    
    [tab_button setFrame:CGRectMake(x, 0, 80, 49)];
    
    return tab_button;
}


-(void)changeViewController:(UIButton*)sender
{
    
    
    NSInteger tag = sender.tag;
    
    if (tag<4) {
        sender.enabled = NO;
        
        UIButton *button = (UIButton*)[self.tabbarview viewWithTag:self.lastIndex];
        
        button.enabled = YES;
        
        self.lastIndex = sender.tag;
        
        self.selectedIndex = tag-1;
    }
    
    
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
