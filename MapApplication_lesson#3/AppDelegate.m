//
//  AppDelegate.m
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 12.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import "AppDelegate.h"

typedef void (^GlobalBlock)(void);


#define Text @"большой текст который предназанчен для описания большого текста при програмировании"



@interface AppDelegate ()

@property (copy,  nonatomic) GlobalBlock propertyBlock;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
 
/*    void(^blockName)(void);
    
    blockName = ^ {
        NSLog(@"blockName");
    
    };
    

    
    blockName();
    [self method1];
    [self method2];
    [self method3];

    
    
    NSString * (^blockWithArguments)(NSString *) = ^ (NSString *string) {
    [self methodWithArguments:@"Test"];
        
        
    return [NSString stringWithFormat:@"blockWithArguments@%", string];
    };
    
    blockWithArguments (@"Block String");
    
  [self methodWithArguments:@"Test"];
  
    NSString * str = [self methodWithArguments:@"Test"];
    NSString * strBlock = blockWithArguments(@"Block String");

    NSLog(@"str %@", str);
    NSLog(@"str %@", strBlock);
    

    
   __block NSString * string  = @"Test";
    
    [self methodWithBlockArgument:^{
        NSLog(@"string %@", string);
        
        string = @"Block Test";
        
    }];
    
    NSLog(@"string %@", string);

    
//    GlobalBlock test = ^ (NSString * str, int i, NSArray * array){
    
    
    };

//    test (@"test", 111, @[@"2222", @"ddff"]);

  */
    
    Object * sometingNameOfBlock = [Object new];
    
    sometingNameOfBlock.name = @"object";

    
    self.propertyBlock = ^ {
        
        NSLog(@"Object %@", sometingNameOfBlock.name);
    };
    
    self.propertyBlock ();
    

    
    return YES;

}





- (void) method1 {
    NSLog(@"metod1 =");

}

- (void) method2 {
    NSLog(@"metod2 =");
    
}

- (void) method3 {
    NSLog(@"metod3 =");
    
}


- (NSString *) methodWithArguments: (NSString *) string {
    
//    NSLog(@"methodWithArguments %@", string);


    return [NSString stringWithFormat:@"methodWithArguments%@", string];
    
}

- (void) methodWithBlockArgument: (void (^) (void)) blockArgument {
    

    blockArgument();
    

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
