//
//  SingleTone.h
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 17.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTone : NSObject

+ (SingleTone *) sharedSingleTone;

@property (nonatomic, weak) NSString * someString;
@property (nonatomic, strong) NSMutableArray * addressArray;



@end
