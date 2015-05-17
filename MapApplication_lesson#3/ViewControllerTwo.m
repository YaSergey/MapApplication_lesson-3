//
//  ViewControllerTwo.m
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 17.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "Object.h"


@interface ViewControllerTwo ()
@property (weak, nonatomic) IBOutlet MKMapView *mapViewTwo;

@property (weak, nonatomic) IBOutlet UIButton *nextViewSecond;

@property (weak, nonatomic) IBOutlet UILabel *textLabelTwo;

@property (nonatomic, strong) NSMutableArray* makeAddressArray;


- (IBAction)nextVeiwTwo:(id)sender;

- (IBAction)addObjectToSecondMap:(id)sender;

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.makeAddressArray = [[NSMutableArray alloc] init];

    
    SingleTone * sing = [SingleTone sharedSingleTone];
    
    NSLog(@"someString ViewControllerTwo%@", sing.someString);

    self.textLabelTwo.text = self.someString;
    

    sing.someString = @"Какая то другая новая строка";
    
    

    Object * obj1 = [Object new];
    Object * obj2 = [Object new];
    Object * obj3 = [Object new];

    obj1.name = @"obj1";
    obj2.name = @"obj2";
    obj3.name = @"obj3";

    
    SingleTone *sing1 = [SingleTone sharedSingleTone];
    SingleTone *sing2 = [SingleTone sharedSingleTone];
    SingleTone *sing3 = [SingleTone sharedSingleTone];

//    инициализация массива
    [sing1 makeAddressArray];
    [sing1.addressArray addObject:@"Array string sing3"];
    
    
//    sing1.someString = @"sing1";
//    sing2.someString = @"sing2";
//    sing3.someString = @"sing3";
    
    NSLog(@"obj1 - %@", obj1.name);
    NSLog(@"obj2 - %@", obj2.name);
    NSLog(@"obj3 - %@", obj3.name);
    
    NSLog(@"obj1 - %@", sing1.someString);
    NSLog(@"obj2 - %@", sing2.someString);
    NSLog(@"obj3 - %@", sing3.someString);



    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    NSLog(@"someString %@", self.someString);



}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextVeiwTwo:(id)sender {
    
    UIViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewThree"];
    
    [self.navigationController pushViewController:controller animated: YES];


}

- (IBAction)addObjectToSecondMap:(id)sender {
    
    NSLog(@".Second View !!! makeAddressArray %lu", (unsigned long)self.makeAddressArray.count);
}
@end
