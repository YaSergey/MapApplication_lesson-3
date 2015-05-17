//
//  CustomTableViewCell.h
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 15.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipCodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *zipCodeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel2;
@property (weak, nonatomic) IBOutlet UILabel *streetLabel2;

@end
