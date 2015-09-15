//
//  MenuTabBarViewController.m
//  NumberTrivial
//
//  Created by Sherpa on 13/9/15.
//  Copyright (c) 2015 manuelainc. All rights reserved.
//

#import "MenuTabBarViewController.h"

@interface MenuTabBarViewController ()

@end

@implementation MenuTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = YES;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    

 
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    self.title = [NSString stringWithFormat:@"%@", viewController.title];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
