//
//  PageViewController.m
//  testmi
//
//  Created by Sandra Zollner on 11.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import "PageViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "PickerViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController
@synthesize pageController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   //  self.view.backgroundColor=[UIColor colorWithRed:(180.0/255.0) green:(205.0/255.0) blue:(180.0/255.0) alpha:.5];
    //self.view.backgroundColor=[UIColor colorWithRed:0.02 green:0.768 blue:0.45 alpha:1];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"green4.jpg"] ];
    
    NSDictionary *options =
    [NSDictionary dictionaryWithObject:
     [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                forKey: UIPageViewControllerOptionSpineLocationKey];
    
    self.pageController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           options: options];
    
    pageController.dataSource = self;
    [[pageController view] setFrame:[[self view] bounds]];
    
    ViewController1 *initialViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"view1"];
    pageindex = 0;
    
    NSArray *viewControllers =
    [NSArray arrayWithObject:initialViewController];
    
    [pageController setViewControllers:viewControllers
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:nil];
    
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
    [pageController didMoveToParentViewController:self];
  // self.view.backgroundColor=[UIColor colorWithRed:(155.0/255.0) green:(205.0/255.0) blue:(155.0/255.0) alpha:.8];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (pageindex == 0) {
        // Create view controller
         ViewController1 *ViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"view1"];
        return ViewController;
    }
    if (pageindex == 1) {
        UIViewController *ViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"view2"];
        return ViewController;
    }
   /* if (pageindex == 2) {
    UIViewController *ViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"view3"];
        return ViewController;
    }*/
    else return nil;
    

}

- (NSInteger)indexOfViewController:(UIViewController *)viewController
{
    return pageindex;

}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerBeforeViewController:
(UIViewController *)viewController
{
    
    if ([viewController isKindOfClass: [PickerViewController class]]) {
        pageindex = 1;
        return [self viewControllerAtIndex:pageindex];
    }
    
    if ([viewController isKindOfClass: [ViewController2 class]]) {
        pageindex = 0;
        return [self viewControllerAtIndex:pageindex];
    }
   
   /* if ([viewController isKindOfClass: [ViewController1 class]]) {
        pageindex = 2;
        return [self viewControllerAtIndex:pageindex];
    }*/

        else {
            
            return nil;
;
        
    }
    
}


- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass: [ViewController1 class]]) {
        pageindex = 1;
        return [self viewControllerAtIndex:pageindex];
    }
    if ([viewController isKindOfClass: [PickerViewController class]]) {
        pageindex =0;
        return [self viewControllerAtIndex:pageindex];
    }
   /* if ([viewController isKindOfClass: [ViewController2 class]]) {
        pageindex = 2;
        return [self viewControllerAtIndex:pageindex];
    }*/
else {
        return nil;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return pageindex;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
