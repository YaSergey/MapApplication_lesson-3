//
//  ViewController.h
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 12.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CustomTableViewCell.h"

#import "ViewControllerTwo.h"

#import "SingleTone.h"



@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>



@end


