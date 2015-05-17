//
//  ViewControllerThree.m
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 17.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import "ViewControllerThree.h"

@interface ViewControllerThree ()
- (IBAction)nextViewBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *textLabelThree;

@end

@implementation ViewControllerThree

- (void)viewDidLoad {
    [super viewDidLoad];

    
    SingleTone * sing = [SingleTone sharedSingleTone];
//    SingleTone * sing1 =[SingleTone sharedSingleTone];

    
    NSLog(@"Array ViewControllerThree%@", sing.addressArray);

    
    NSLog(@"someString ViewControllerThree %@", self.someString);
    
    self.textLabelThree.text = sing.someString;
//    self.textViewArr.text = sing.someArray;



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextViewBack:(id)sender {
    
    UIViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewFirst"];
    
    [self.navigationController pushViewController:controller animated: YES];
    

}
@end
