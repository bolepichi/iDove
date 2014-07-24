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
        UINavigationController *navC2 = [[UINavigationController alloc] initWithRootViewController:searchVC];
        UINavigationController *navC3 = [[UINavigationController alloc] initWithRootViewController:usercenterVC];
        
        self.viewControllers = [[NSArray alloc] initWithObjects:navC1,navC2,navC3 ,nil];

        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden =YES;
    // Do any additional setup after loading the view from its nib.
    
    
   CGRect screen =[[UIScreen mainScreen] bounds];
    
    UIView *tabbarbackview = [[UIView alloc] initWithFrame:CGRectMake(0, screen.size.height-49, screen.size.width, 49)];
    
    for (int i=0; i<self.viewControllers.count+1; i++) {
        
        UIButton *tab_button = [self creattabbarButtonWithIndex:i];
        
        [tabbarbackview addSubview:tab_button];
    }
    
    
    

}


-(UIButton*)creattabbarButtonWithIndex:(NSInteger)index{
    
    UIButton *tab_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [tab_button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabaimage%d",(int)index]] forState:UIControlStateNormal];
    [tab_button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabaimageselect%d",(int)index]] forState:UIControlStateNormal];
    tab_button.tag = index;
    
    [tab_button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [tab_button setFrame:CGRectMake(0*(int)index, 0, 320/4, 49)];
    
    return tab_button;
}


-(void)changeViewController:(UIButton*)sender
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
