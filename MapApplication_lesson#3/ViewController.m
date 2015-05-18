//
//  ViewController.m
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 12.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//


//NSLocationAlwaysUsageDescription - свойство котороее запрашивает согласие пользователя на использование его геоданных


#import "ViewController.h"
#import <UIKit/UIKit.h>




BOOL isCurrentLocation;


@interface ViewController ()


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic, strong) NSMutableArray* addressArray;

//@property (nonatomic, weak) UIView *imageAnnotation;
//@property (nonatomic, weak) UIImageView *avatarImage;


- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender;
- (IBAction)clearTableView:(id)sender;
- (IBAction)savePoint:(id)sender;


- (IBAction)nextViewOne:(id)sender;


@end

@implementation ViewController


- (void) firstLunch {
    NSString * systemVersion = [[UIDevice currentDevice]systemVersion];
    
    // проверка первого запуска приложения и запрос авторизации
    if ([systemVersion intValue] <=8 ) {
        [self.locationManager requestAlwaysAuthorization];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLunch"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    SingleTone *addressArrayVar = [SingleTone sharedSingleTone];
//
//    [addressArrayVar makeAddressArray];

  
    isCurrentLocation = NO;
    

    self.addressArray = [[NSMutableArray alloc] init];
    
    self.mapView.showsUserLocation = YES; // показывать местоположение пользователя
    self.locationManager = [[CLLocationManager alloc] init]; // отслеживание текущего местоположения
    self.locationManager.delegate = self;
    
    BOOL isFirstLunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLunch"];
    
    // проверка условия: первый запуск? если нет то запускаем firstLunch
    if (!isFirstLunch) {
        [self firstLunch];
    }
}


#pragma mark MKMapViewDelegate

// метод позволяет показывать карту после того как она полностью загрузится

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    
    if (fullyRendered) {
         [self.locationManager startUpdatingLocation];
        // обновляем локализацию после того как карта загружена
    }
}

- (void) setupMapView: (CLLocationCoordinate2D) coord {
    
    // карта из общего вида опустится когда до пользователя будет 1500м
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 1500, 1500);

    [self.mapView setRegion:region animated:YES];

}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if (![annotation isKindOfClass:MKUserLocation.class]) {
        MKAnnotationView * annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Annotation"];
        
        annView.canShowCallout = NO;
        annView.image = [UIImage imageNamed:@"RedButtonDefault.png"];
        // присваиваем маркеру на карте кастомный маркер
        
        [annView addSubview:[self getCallOutView:annotation.title]];
        return annView;
    }
    return nil;
}

- (UIView *) getCallOutView: (NSString *) title {

    UIView * callView = [[UIView alloc] initWithFrame:CGRectMake(-100,-105, 180, 50)];
    callView.backgroundColor = [UIColor orangeColor];
    
    callView.tag = 1000;
    callView.alpha = 0.8;
    callView.layer.borderWidth = 0.5; // оконтовка callView
//    callView.layer.shadowOpacity = [UIColor lightGrayColor];
    callView.layer.cornerRadius = 25.0;
    
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(46, 1, 140, 45)];
    
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentNatural;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName: @"Optima" size: 12.0];
    label.text = title;
    
    [callView addSubview:label];
    
    
    // добавление аватарки на аннотацию =============
    
    
    UIImage * avatarImage = [UIImage imageNamed:@"blueEyes.jpg"];


    UIImageView * imageAnnotation = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    
    imageAnnotation.image = avatarImage;
    
    // скругление аватарки
    imageAnnotation.layer.cornerRadius = imageAnnotation.frame.size.width / 2;
    imageAnnotation.clipsToBounds = YES;
    
    [callView addSubview:imageAnnotation];
    
    

    return callView;
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // метод анимации при нажатии на вью - показывает (меняем альфу до 1)
    if (! [view.annotation isKindOfClass:MKUserLocation.class]) {
        for (UIView * subView in view.subviews) {
            if (subView.tag == 1000) {
                subView.alpha = 1.0;
            }
        }
    }

}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    // метод анимации при нажатии на вью - скрываем (меняем альфу до 0)
        for (UIView * subView in view.subviews) {
            if (subView.tag == 1000) {
                subView.alpha = 0.0;
            }
        }
    }

#pragma mark CLLocationManagerDelegate

// метод работает тогда когда позиция изменилась, соответсвенно выдает новую и старую локацию

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    if (!isCurrentLocation) { // если локация изменилась
        isCurrentLocation = YES; // то возвращаем текущую локацию
        
        [self setupMapView:newLocation.coordinate];
    }
}


- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateBegan) {
  
    // получем координаты точки долгого нажатия
        CLLocationCoordinate2D coordScreenPoint =
        [self.mapView convertPoint:
         [sender locationInView:self.mapView]
              toCoordinateFromView:self.mapView];
    
        CLGeocoder * geocoder = [[CLGeocoder alloc] init];
        
        CLLocation * tapLocation = [[CLLocation alloc] initWithLatitude:coordScreenPoint.latitude longitude:coordScreenPoint.longitude];
        
        [geocoder reverseGeocodeLocation:tapLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            
            
            CLPlacemark * place = [placemarks objectAtIndex:0];
            
//  NSLog(@"place %@", place.addressDictionary); // и выводим их в консоль
            
            
        NSString * addressString = [NSString stringWithFormat:
             @"Город - %@\nУлица - %@\nИндекс - %@",
        [place.addressDictionary valueForKey:@"City"],
        [place.addressDictionary valueForKey:@"Street"],
        [place.addressDictionary valueForKey:@"ZIP"]];
            
            NSLog(@"addressString %@", addressString);
            
//         NSLog(@"onlyCity %@", [NSString stringWithFormat: [place.addressDictionary valueForKey:@"Street"]]);
// вызываем сообщение на экране

            UIAlertView * alert =   [[UIAlertView alloc] initWithTitle: @"Address" message:addressString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];

            [alert show];
            
            MKPointAnnotation * annotation = [[MKPointAnnotation alloc] init];
            annotation.title = addressString;
            annotation.coordinate = coordScreenPoint;
            
    // добавление аннотации на карту
            [self.mapView addAnnotation:annotation];

            
    // добавляем данные после срабатывания метода в массив, а потом в таблицу
            
            NSMutableDictionary * addressDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            [place.addressDictionary valueForKey:@"City"], @"City",
            [place.addressDictionary valueForKey:@"Street"], @"Street",
            [place.addressDictionary valueForKey:@"ZIP"], @"ZIP",tapLocation, @"location", nil];
            
            [self.addressArray addObject: addressDict];
        
//            SingleTone * sing = [SingleTone sharedSingleTone];
//            sing.addressArray = self.addressArray;
        /*
        [sing1 makeAddressArray];
        [sing1.addressArray addObject:@"Array string sing3"];
        */
        
            NSLog(@"makeAddressArray %@", self.addressArray);
            
        }];
        
        NSLog(@"UIGestureRecognizerStateBegan");
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
    }
}


#pragma mark UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * simpleTaibleIndefir = @"Cell";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTaibleIndefir];
    
    cell.cityLabel.text =
    [[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"City"];
    cell.streetLabel.text =
    [[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"Street"];
    cell.zipCodeLabel.text =
    [[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"ZIP"];
    
    return cell;
    
}

//метод редактирования таблицы

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void) reloadTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    });
}

- (void) removeAllAnnotations { //метод убирает аннотации с карты
    id userAnnotation = self.mapView.userLocation;
    NSMutableArray*annotations = [NSMutableArray arrayWithArray:self.mapView.annotations];
    [annotations removeObject:userAnnotation];
    [self.mapView removeAnnotations:annotations];
    
}

- (IBAction)clearTableView:(id)sender {
    
    [self removeAllAnnotations];
}

- (IBAction)savePoint:(id)sender {
    
    [self reloadTableView]; // добавление выбрранного поинта в таблицу, путем перезагрузки таблицы

}


//  переход на второй ViewController
- (IBAction)nextViewOne:(id)sender {
    
    SingleTone * sing = [SingleTone sharedSingleTone];
    sing.addressArray = self.addressArray;
    
    ViewControllerTwo * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewTwo"];
    
//    controller.someString = @"Some Value999";
    // передаем значение NsString во второй вьюконтроллер, здесь может передаваться картинка массив дикшинари и т/п/

    [self.navigationController pushViewController:controller animated: YES];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //по индексу ячейки находим координаты в массиве self.makeAddressArray и устанавливаем данные координаты по центру карты
    NSDictionary * dict = [self.addressArray objectAtIndex:indexPath.row];
    CLLocation * newLocation = [[CLLocation alloc] init];
    newLocation = [dict objectForKey:@"location"];
    [self setupMapView:newLocation.coordinate];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
  