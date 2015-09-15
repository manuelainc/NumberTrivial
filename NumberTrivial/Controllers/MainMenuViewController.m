//
//  MainMenuViewController.m
//  NumberTrivial
//
//  Created by Sherpa on 9/9/15.
//  Copyright (c) 2015 manuelainc. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MenuTabBarViewController.h"


@interface MainMenuViewController ()

@property (nonatomic,strong) MenuTabBarViewController* menuTabBar;

@end

@implementation MainMenuViewController

- (void)viewDidLoad{
   
    [super viewDidLoad];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _menuTabBar = (MenuTabBarViewController*)[sb instantiateViewControllerWithIdentifier:@"TabBarViewController"];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            
            //            [view.layer setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y + (view.frame.size.height-view.frame.size.width)/2, view.frame.size.width, view.frame.size.width)];
            [view.layer setCornerRadius:view.frame.size.width/6];
        }
    }

    
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

    

}

- (IBAction)mathButton:(id)sender {

    [self.navigationController pushViewController:_menuTabBar animated:YES];
    _menuTabBar.title = [NSString stringWithFormat:@"%@", @"Math"];
    _menuTabBar.selectedIndex = 0;
    
}


- (IBAction)triviaButton:(id)sender {

    [self.navigationController pushViewController:_menuTabBar animated:YES];
    _menuTabBar.title = [NSString stringWithFormat:@"%@", @"Trivia"];
    _menuTabBar.selectedIndex = 1;

}


- (IBAction)dateButton:(id)sender {

    [self.navigationController pushViewController:_menuTabBar animated:YES];
    _menuTabBar.title = [NSString stringWithFormat:@"%@", @"Date"];
    _menuTabBar.selectedIndex = 2;

}


- (IBAction)yearButton:(id)sender {

    [self.navigationController pushViewController:_menuTabBar animated:YES];
    _menuTabBar.title = [NSString stringWithFormat:@"%@", @"Year"];
    _menuTabBar.selectedIndex = 3;

}

@end
