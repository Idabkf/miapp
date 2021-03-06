//
//  AppDelegate.m
//  testmi
//
//  Created by danqing liu on 13-6-10.
//  Copyright (c) 2013年 danqing liu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController1.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
    
    NSUserDefaults *mydefaut = [NSUserDefaults standardUserDefaults];
    NSString *imageName = @"wood1.jpg";
    [mydefaut setObject:imageName forKey:@"BildName"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    UIViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"view4"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    self.tmp = [[NSMutableString alloc] init];
    
    self.semestersdicParser = [[NSMutableDictionary alloc] init];
    
    /*
    //0: KW
    //1: MMI
    //2: MG
    //3: BWL
    [self fetchEntriesWithUrlId:1];
     
    
    [NSThread sleepForTimeInterval:2];
     */
    
    
    //  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = mainViewController;
    
}else{
    
}
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

-(void)createPList{
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.plistLocation = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    [self.semestersdicParser writeToFile:self.plistLocation atomically: YES];
    
    NSLog(@"WRITE TO FILE: %@", self.plistLocation);
    NSLog(@"WRITE: %@", documentsDirectory);
    
    NSPropertyListFormat format;
    NSString *errorDesc = nil;
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:self.plistLocation];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    
    NSLog(@"  plist: %@",   temp);
    
    
    /*//NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
     
     // NSString *plistPath = [rootPath stringByAppendingPathComponent:@"lecture.plist"];
     
     NSString *folderPath = [[NSBundle mainBundle] pathForResource:@"lecture2" ofType:@"plist"];
     //NSString *documentsDirectory = [folderPath objectAtIndex:0];
     NSString *plistPath = [folderPath stringByAppendingPathComponent:@"lecture2.plist"];
     
     //NSString *test= @"test";
     BOOL succesful = [self.semestersdic writeToFile:plistPath atomically:YES];
     //[test writeToFile:plistPath atomically:YES];
     
     
     NSLog(@"WRITE TO FILE: %c", succesful);
     */
    /*
     NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:self.semestersdic];
     id plist = [NSPropertyListSerialization propertyListWithData:myData options:NSPropertyListMutableContainersAndLeaves format:nil error:&error];
     NSLog(@"PLIST: %@", plist);
     */
    
    /*
     NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.semestersdic
     format:NSPropertyListXMLFormat_v1_0
     errorDescription:&error];
     
     if(plistData) {
     
     }
     else {
     NSLog(@"%@", error);
     }
     */
}

- (void) setUngradedLectures{
    
    NSString *path= [[NSBundle mainBundle] pathForResource:@"Ungraded" ofType:@"plist"];
    NSMutableDictionary *ungradedNotesDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    for (int i = 1; i<7; i++) {
        NSMutableDictionary *currentSemester = [self.semestersdicParser objectForKey:[NSString stringWithFormat:@"%i",i]];
        NSMutableArray *currentLectures = [currentSemester objectForKey:@"lectures"];
        
        for (int i = 0; i<currentLectures.count; i++) {
            
            for (int j = 0; j<ungradedNotesDic.count; j++) {
                NSString *titleUngraded = [ungradedNotesDic objectForKey:[NSString stringWithFormat:@"%i", j]];
                NSString *titleLecture = [currentLectures objectAtIndex:i] [@"title"];
                //titleLecture = [titleLecture stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                //NSLog(@"############# TITLE ungraded: %@ and TITLE lecture: %@", title, [currentLectures objectAtIndex:i] [@"title"]);
                if ([titleLecture hasPrefix:titleUngraded] ||
                    [[currentLectures objectAtIndex:i] [@"tmpAttending"]hasPrefix:titleUngraded]) {
                    [[currentLectures objectAtIndex:i] setValue:@"NO" forKey:@"graded"];
                }
            }
        }
        
        [currentSemester setValue:currentLectures forKey:@"lectures"];
        [self.semestersdicParser setValue:currentSemester forKey:[NSString stringWithFormat:@"%i",i]];
    }
}

- (void)fetchEntriesWithUrlId:(int) urlId
{
    // Create a new data container for the stuff that comes back from the service
    
    xmlData = [[NSMutableData alloc] init];
    
    // Construct a URL that will ask the service for what you want -
    // note we can concatenate literal strings together on multiple
    // lines in this way - this results in a single NSString instance
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.medien.ifi.lmu.de/studierende/semesterplanung/bachelor/mediengestaltung/index.xhtml.de"];
    //0: KW
    //1: MMI
    //2: MG
    //3: BWL
    if (urlId == 0) {
        url = [NSURL URLWithString:@"http://www.medien.ifi.lmu.de/studierende/semesterplanung/bachelor/medienwirkung/index.xhtml.de"];
    }
    else if (urlId == 1) {
        url = [NSURL URLWithString:@"http://www.medien.ifi.lmu.de/studierende/semesterplanung/bachelor/mmi/index.xhtml.de"];
    }
    else if (urlId == 2) {
        url = [NSURL URLWithString:@"http://www.medien.ifi.lmu.de/studierende/semesterplanung/bachelor/mediengestaltung/index.xhtml.de"];
    }
    else if (urlId == 3) {
        url = [NSURL URLWithString:@"http://www.medien.ifi.lmu.de/studierende/semesterplanung/bachelor/medienwirtschaft/index.xhtml.de"];
    }
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    // Add the incoming chunk of data to the container we are keeping
    // The data always comes in the correct order
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    // Create the parser object with the data received from the web service
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    // Give it a delegate
    [parser setDelegate:self];
    
    // Tell it to start parsing - the document will be parsed and
    // the delegate of NSXMLParser will get all of its delegate messages
    // sent to it before this line finishes execution - it is blocking
    [parser parse];
    
    [self setUngradedLectures];
    
    [self createPList];
    
    NSString *notificationName = @"finishedLoadingData";
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
    
    // Get rid of the XML data as we no longer need it
    xmlData = nil;
    
    // Get rid of the connection, no longer need it
    connection = nil;
    
    // Reload the table.. for now, the table will be empty.
    //[[self tableView] reloadData];
    
    //NSLog(@"%@\n %@\n %@\n", channel, [channel title], [channel infoString]);
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error
{
    // Release the connection object, we're done with it
    connection = nil;
    
    // Release the xmlData object, we're done with it
    xmlData = nil;
    
    // Grab the description of the error object passed to us
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",
                             [error localizedDescription]];
    NSString *message = [NSString stringWithFormat:@"Bitte verbinde dich mit dem Internet."];
    
    // Create and show an alert view with this error displayed
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Fehler"
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
}




- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    //[self.tmp setString:@""];
    self.tmp = [[NSMutableString alloc] init];
    
    if ([elementName isEqual:@"h2"]) {
        
        
        for (int i = 1; i<7; i++) {
            
            NSString *idAttr = @"id";
            
            //wir prüfen auf ids, da hier unsere semester beginnen
            NSString *idIs = [attributeDict objectForKey:idAttr];
            
            if ([idIs isEqual:[NSString stringWithFormat:@"id-%i.-semester", i ]]) {
                
                /*
                 Semester *s_local = [[Semester alloc] init];
                 s_local.level = i;
                 s_local.lectures = [[NSMutableDictionary alloc]init];
                 */
                
                NSMutableDictionary *semesterNew = [[NSMutableDictionary alloc] init];
                
                NSMutableArray *lectures = [[NSMutableArray alloc] init];
                [semesterNew setObject:lectures forKey:@"lectures"];
                
                [self.semestersdicParser setObject: semesterNew forKey:[NSString stringWithFormat:@"%i", i]];
                self.level = i;
                
                
                if (i==6) {
                    for (int k = 7; k<10; k++) {
                        
                        
                        
                        NSMutableDictionary *semesterNew = [[NSMutableDictionary alloc] init];
                        
                        NSMutableArray *lectures = [[NSMutableArray alloc] init];
                        [semesterNew setObject:lectures forKey:@"lectures"];
                        
                        [self.semestersdicParser setObject: semesterNew forKey:[NSString stringWithFormat:@"%i", k]];
                        //self.level = k;
                    }
                    
                }
                
            }
        }
    }
    
    if ([elementName isEqual:@"tr"]) {
        if (attributeDict.count <1) {
            self.tr = true;
            self.td = 1;
        }
    }
    
    if ([elementName isEqual:@"td"]) {
        self.inTd = true;
    }
    if ([elementName isEqual:@"a"]) {
        self.inA = true;
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [self.tmp appendString:string];
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if(self.inA){
        self.inA = false;
        return;
    }
    
    if (self.inTd) {
        if (self.td == 1) {
            
            self.currentLecture1 = [[NSMutableDictionary alloc] init];
            [self.currentLecture1 setObject:self.tmp forKey:@"title"];
            self.td++;
            
            /*
             self.currentLecture = [[Lecture alloc] init];
             self.currentLecture.title = self.tmp;
             self.td++;
             */
        }
        else if (self.td == 2){
            [self.currentLecture1 setObject:self.tmp forKey:@"kind"];
            //self.currentLecture.kind = self.tmp;
            self.td++;
        }
        else if (self.td == 3){
            //self.currentLecture.sws = self.tmp;
            [self.currentLecture1 setObject:self.tmp forKey:@"sws"];
            self.td++;
        }
        else if (self.td == 4) {
            //self.currentLecture.ects = self.tmp;
            [self.currentLecture1 setObject:self.tmp forKey:@"ects"];
            
            if([[self.currentLecture1 objectForKey:@"title"] isEqualToString: @"Soziale und persönliche Kompetenz\n"] ||
               [[self.currentLecture1 objectForKey:@"title"] isEqualToString: @"Ethik und Recht in der Informatik\n"] ||
               [[self.currentLecture1 objectForKey:@"title"] isEqualToString: @"Projektkompetenz Multimedia\n"] ||
               [[self.currentLecture1 objectForKey:@"title"] isEqualToString: @"Sprachkurs ComComp\n"] ){

               [self.currentLecture1 setObject:[self.currentLecture1 objectForKey:@"title"] forKey:@"tmpAttending"];
               [self.currentLecture1 setObject:@"Fachübergreifende Kompetenzen" forKey:@"title"];
            } else {
                [self.currentLecture1 setObject:@"" forKey:@"tmpAttending"];
            }
            
            [self.currentLecture1 setObject:@"" forKey:@"tmpTitle"];
            [self.currentLecture1 setObject:@"" forKey:@"tmpTitle2"];
            [self.currentLecture1 setObject:@"" forKey:@"tmpAttending2"];
            [self.currentLecture1 setObject:@"" forKey:@"grade"];
            [self.currentLecture1 setObject:@"" forKey:@"otherGrade"];
            [self.currentLecture1 setObject:@"NO" forKey:@"passed"];
            [self.currentLecture1 setObject:@"YES" forKey:@"graded"];
            [self.currentLecture1 setObject:@"NO" forKey:@"attending"];
            
            /*
             //semester objekt anhand von dic erstellt aber hier sitzt doch nur ein array
             Semester *semester = [self.semestersdic objectForKey:[NSString stringWithFormat:@"%i",self.level]];
             [semester.lectures setObject:self.currentLecture forKey:self.currentLecture.title];
             */
            self.td = 0;
            self.inTd = false;
            
            NSMutableDictionary *currentSemester = [self.semestersdicParser objectForKey:[NSString stringWithFormat:@"%i",self.level]];
            NSMutableArray *currentLectures = [currentSemester objectForKey:@"lectures"];
            [currentLectures addObject:self.currentLecture1];
            
            
            
            
            NSLog(@"Im Semester: %i", self.level );
            NSLog(@"TITEL: %@", [self.currentLecture1 objectForKey:@"title"]);
            
            NSLog(@"SWS: %@",  [self.currentLecture1 objectForKey:@"sws"]);
            NSLog(@"KIND: %@",  [self.currentLecture1 objectForKey:@"kind"]);
            
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
