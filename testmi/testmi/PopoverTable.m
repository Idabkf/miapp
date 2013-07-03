//
//  PopoverTable.m
//  testmi
//
//  Created by Sandra Zollner on 17.06.13.
//  Copyright (c) 2013 danqing liu. All rights reserved.
//

#import "PopoverTable.h"
#import "DetailPopoverViewController.h"
#import "FPPopoverController.h"

@interface PopoverTable ()

@end

@implementation PopoverTable
@synthesize titleLabel, plist, titleString, lectures, chosenLecture;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    NSLog(@"Checking orientation %d", interfaceOrientation);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleLabel.text = self.titleString;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont fontWithName:@"Georgia" size:20.0];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    NSLog(self.titleLabel.text);
    
    NSLog(@"TITLESTRING IN POPOVER TABLE : %@", self.titleString);

    NSString *path= [[NSBundle mainBundle] pathForResource:@"optionsList" ofType:@"plist"];
    plist = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
   
    
    
    NSArray *templist = [[NSUserDefaults standardUserDefaults] objectForKey:@"newlist"];
    
    if (templist) {
        
        lectures = [templist mutableCopy];
        
    }else {
        lectures = plist [titleString];
        
    }

    self.TextField.backgroundColor = [UIColor whiteColor];
    self.TextField.hidden = YES;
    self.save.hidden = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //sets background picture
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    NSString *image = [mydefault stringForKey:@"BildName"];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:image] ];
    self.backg.image = [UIImage imageNamed:image];

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
    return [lectures count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellPopover";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    

    // Configure the cell...
    if ( cell ==nil ){
        cell =[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
     cell.opaque = NO;

    
    
    cell.textLabel.text = [lectures objectAtIndex:[indexPath row]][@"lecture"];
    cell.textLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];


    if([cell.textLabel.text isEqualToString: chosenLecture]){
        // cell.contentView.backgroundColor=[UIColor colorWithRed:0.02 green:0.768 blue:0.45 alpha:1];
        cell.backgroundColor = [UIColor colorWithRed:(102.0/255.0) green:(205.0/255.0) blue:(170.0/255.0) alpha:.5];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    } else {
        cell.backgroundColor=[UIColor colorWithRed:(224.0/255.0) green:(238.0/255.0) blue:(224.0/255.0) alpha:.15];
        //cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}



#pragma mark - Table view delegate

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //popover
    
    DetailPopoverViewController *viewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"popover"];

    
    viewController.title = nil;
    viewController.titleString = [lectures objectAtIndex:[indexPath row]][@"lecture"];
    viewController.seminarTitle = titleString;
    viewController.modulFlag = self.modulFlag;
    viewController.delegate2 = self;
    //e[viewController.titleLabel setText:title];
    
    popover = [[FPPopoverController alloc] initWithViewController:viewController];
    popover.delegate = self;
    popover.tint = FPPopoverDefaultTint;
    popover.border = NO;
    //popover.tint = FPPopoverWhiteTint;
    
    popover.contentSize = CGSizeMake(290, 380);
    
    popover.arrowDirection = FPPopoverNoArrow;
    [popover presentPopoverFromPoint: CGPointMake(self.view.center.x, self.view.center.y - 20 - popover.contentSize.height/2) ];

}

- (void) dismissPopover
{
    [self.tableView reloadData];
    [popover dismissPopoverAnimated:YES];
}

- (IBAction)addAction:(id)sender {
    [self.TextField.layer setCornerRadius:10];
    self.TextField.hidden = NO;
    self.TextField.frame = CGRectMake(5, 245, 312, 32);
   // UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(260, 245, 20, 32)];
    //self.save.frame =CGRectMake(260, 245, 20, 32) ;

    self.save.hidden = NO;
   // [self.save setBackgroundImage:[UIImage imageNamed:@"icon6.png" ]forState:UIControlStateSelected] ;
    // self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"green4.jpg"] ];
    self.TextField.textColor = [UIColor blackColor];
    
    self.TextField.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    
    self.TextField.delegate = self;
    
    self.TextField.backgroundColor = [UIColor whiteColor];
    
    
    self.TextField.returnKeyType = UIReturnKeyDefault;
    
    //self.TextView.keyboardType = UIKeyboardAppearanceDefault;
    
    self.TextField.scrollEnabled = YES;
    self.TextField.text = @"";
    
    
    self.TextField.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.TextField becomeFirstResponder];

}
#pragma mark - UITextView Delegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
         self.TextField.frame = CGRectMake(5, 428, 312, 32);
        
        return NO;
        
    }
    
    
    return YES;
    
}
- (IBAction)SaveAction:(id)sender {
    //self.save .hidden = NO;
     NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    NSString *text =self.TextField.text;
    [mydefault setObject:text forKey:@"Newtext"];
    
    NSString *path= [[NSBundle mainBundle] pathForResource:@"optionsList" ofType:@"plist"];
    plist = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSMutableDictionary *lnew = [[NSMutableDictionary alloc] init];
    [lnew setObject:text forKey:@"lecture"];
    [lnew setObject:@"" forKey:@"grade"];
    [lnew setObject:@"0" forKey:@"passed"];
    [lnew setObject:@"3" forKey:@"ects"];
    lectures = nil;
    NSArray *templist = [[NSUserDefaults standardUserDefaults] objectForKey:@"newlist"];
    
    if (templist) {
        
        lectures = [templist mutableCopy];
        
    }else {
        lectures = plist [titleString];
        
    }
    
    [lectures insertObject:lnew atIndex:[lectures count]];
    [mydefault setObject:lectures forKey:@"newlist"];
    
    [mydefault setInteger:lectures.count forKey:@"newcount"];
    [mydefault synchronize];
    
       NSLog(@"%@",lectures);
    NSLog(@"%d",lectures.count);
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:lectures.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];
    
    
    self.TextField.hidden = YES;
    
    self.save .hidden =YES;
    

    
    
}
@end
