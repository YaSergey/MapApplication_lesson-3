//
//  MakeArrays.h
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 15.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MakeArraysDelegate;

@interface MakeArrays : NSObject

- (void) makeAddressArray;

@property (weak, nonatomic) id <MakeArraysDelegate> delegate;

@end


@protocol MakeArraysDelegate <NSObject>


@required

-(void) makeAddressArrayReady : (MakeArrays *) makeArray DrinksArray: (NSMutableArray *) drinksArray;



@end


