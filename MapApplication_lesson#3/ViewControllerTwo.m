//
//  ViewControllerTwo.m
//  MapApplication_lesson#3
//
//  Created by Sergey Yasnetsky on 17.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "Object.h"

BOOL isCurrentLocation;


@interface ViewControllerTwo ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) NSMutableArray* addressArray;

@property (nonatomic, strong) CLLocationManager * locationManager;



- (IBAction)addObjectToSecondMap:(id)sender;

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isCurrentLocation = NO;
    
    self.mapView.showsUserLocation = YES;
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    
    SingleTone * sing = [SingleTone sharedSingleTone];
    self.addressArray = sing.addressArray;

   

/*
    NSLog(@"someString ViewControllerTwo%@", sing.someString);

    self.textLabelTwo.text = self.someString;

    sing.someString = @"Какая то другая новая строка";
*/
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
    
    UIView * callView = [[UIView alloc] initWithFrame:CGRectMake(-100,-105, 150, 50)];
    callView.backgroundColor = [UIColor orangeColor];
    
    callView.tag = 1000;
    callView.alpha = 0.8;
    callView.layer.borderWidth = 0.5; // оконтовка callView
    //    callView.layer.shadowOpacity = [UIColor lightGrayColor];
    callView.layer.cornerRadius = 10.0;
    
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 150, 90)];
    
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentNatural;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName: @"Optima" size: 12.0];
    label.text = title;
    
    [callView addSubview:label];
    
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

#pragma mark UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * simpleTaibleIndefir = @"Cell2";
    CustomTableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:simpleTaibleIndefir];
    
    cell2.cityLabel2.text =
    [[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"City"];
    cell2.streetLabel2.text =
    [[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"Street"];
    cell2.zipCodeLabel2.text =
    [[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"ZIP"];
    
    return cell2;
    
}

//метод редактирования таблицы

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self removeAllAnnotations]; //удаляем аннотацию при переходе на другую ячейку в таблице
}

// метод срабатывает по выбору табличной ячейки=================

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    //по индексу ячейки находим координаты в массиве self.arrayAdress и устанавливаем данные координаты по центру карты
    NSDictionary * dict = [self.addressArray objectAtIndex:indexPath.row];
    CLLocation * newLocation = [[CLLocation alloc] init];
    newLocation = [dict objectForKey:@"location"];
    [self setupMapView:newLocation.coordinate];
    
    
    //по полученным координатам устанавливаем аннотацию:
    CLGeocoder * geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * place = [placemarks objectAtIndex:0];
    //записывать адрес с индексом в строку NSString
        NSString * adressString = [[NSString alloc] initWithFormat:@"%@\n%@\nИндекс - %@", [place.addressDictionary valueForKey:@"City"], [place.addressDictionary valueForKey:@"Street"], [place.addressDictionary valueForKey:@"ZIP"]];
        
        MKPointAnnotation * annotation = [[MKPointAnnotation alloc]init];
        annotation.title = adressString;
        annotation.coordinate = newLocation.coordinate;
        
//     добавить аннотацию на карту
        [self.mapView addAnnotation:annotation];
    }];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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


@end
