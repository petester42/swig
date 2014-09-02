//
//  SWAppDelegate.m
//  Swig
//
//  Created by CocoaPods on 09/01/2014.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

#import "SWAppDelegate.h"
#import <Swig.h>

@implementation SWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self configureEndpoint];
    
    return YES;
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

-(void)configureEndpoint {
    
    SWTransportConfiguration *tcp = [SWTransportConfiguration configurationWithTransportType:SWTransportTypeTCP];
    SWTransportConfiguration *udp = [SWTransportConfiguration configurationWithTransportType:SWTransportTypeUDP];
    
    SWEndpointConfiguration *endpointConfiguration = [SWEndpointConfiguration configurationWithTransportConfigurations:@[udp,tcp]];
    endpointConfiguration.logConsoleLevel = 0;
    endpointConfiguration.logLevel = 0;
    
    SWEndpoint *endpoint = [SWEndpoint sharedEndpoint];
    
    [endpoint configure:endpointConfiguration completionHandler:^(NSError *error) {
        
        if (error) {
            
            NSLog(@"%@", [error description]);
            
            [endpoint reset:^(NSError *error) {
                if(error) NSLog(@"%@", [error description]);
            }];
        }
    }];
    
    [endpoint setIncomingCallBlock:^(SWAccount *account, SWCall *call) {
        
        NSLog(@"\n\nIncoming Call : %d\n\n", (int)call.callId);
        
        //        [call answer:^(NSError *error) {
        //
        //            NSLog(@"%@",[error description]);
        //        }];
    }];
    
    [endpoint setAccountStateChangeBlock:^(SWAccount *account) {
        
        NSLog(@"\n\nAccount State : %ld\n\n", (long)account.accountState);
    }];
    
    [endpoint setCallStateChangeBlock:^(SWAccount *account, SWCall *call) {
        
        NSLog(@"\n\nCall State : %ld\n\n", (long)call.callState);
    }];
    
    [endpoint setCallMediaStateChangeBlock:^(SWAccount *account, SWCall *call) {
        
        NSLog(@"\n\nMedia State Changed\n\n");
    }];
}
@end
