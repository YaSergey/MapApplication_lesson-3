//
//  SingleTone.m
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 17.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import "SingleTone.h"

@implementation SingleTone


+ (SingleTone *) sharedSingleTone {

    static SingleTone * singleToneObject = nil;
    static dispatch_once_t onceToken;
    
    
    dispatch_once (&onceToken, ^ {
    
        singleToneObject = [[self alloc] init];
        singleToneObject.addressArray = [[NSMutableArray alloc] init];
        
    });
    
    return singleToneObject;
    
}



@end
