//
//  WeatherForecastViewController.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 25..
//  Copyright © 2017년 com. All rights reserved.
//

#import "WeatherForecastViewController.h"
#import "WeatherForecastTableViewCell.h"
#import "ActivityView.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "WeatherDetailViewController.h"
#import "WeatherInfoDialogViewController.h"
#import "OceanTableViewCell.h"
#import "MarineDetailViewController.h"
@interface WeatherForecastViewController () <UITableViewDelegate, UITableViewDataSource, APIManagerListener, MKMapViewDelegate>
{
    NSArray *weatherArr;
    NSArray *marineArr;
    AppDelegate *appDelegate;
    int selectedOceanIndex;
    NSMutableArray *annotArr;
    int tabIndex;
    int oceanViewType;
}
@end

@implementation WeatherForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureDesign];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    weatherArr = [[NSMutableArray alloc] init];
    selectedOceanIndex = 0;
    tabIndex = 0;
    oceanViewType = 0;
    //-----Test value for design
    
    [appDelegate showLoadDialog:@"Getting weather list.." viewController:self.mainTabVC];
    [[APIManager sharedInstance] getWeatherForecast:self];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppOpenTask:) name:@"AppOpened" object:nil];
}

- (void)updateMap {
    NSMutableDictionary *firstMarineDict = [marineArr objectAtIndex:0];
    double lat = [[firstMarineDict objectForKey:@"lat"] doubleValue];
    double lon = [[firstMarineDict objectForKey:@"lon"] doubleValue];
    
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = lat;
    mapRegion.center.longitude = lon;
    mapRegion.span.latitudeDelta = 100;
    mapRegion.span.longitudeDelta = 100;
    [self.mapView setRegion:mapRegion animated:NO];
    [self addAnnotations];
}

- (void)addAnnotations {
    annotArr = [[NSMutableArray alloc] init];
    for(int i = 0; i < marineArr.count; i++) {
        NSMutableDictionary *weatherDict = [marineArr objectAtIndex:i];
        double lat = [[weatherDict objectForKey:@"lat"] doubleValue];
        double lon = [[weatherDict objectForKey:@"lon"] doubleValue];
        MKPointAnnotation *locAnnot = [[MKPointAnnotation alloc] init];
        locAnnot.coordinate = CLLocationCoordinate2DMake(lat, lon);
        locAnnot.title = [weatherDict objectForKey:@"name"];
        locAnnot.subtitle = [NSString stringWithFormat:@"%d", i];
        [self.mapView addAnnotation:locAnnot];
        [annotArr addObject:locAnnot];
    }
    
    /*for(int i = 3; i < 6; i++) {
        NSMutableDictionary *weatherDict = [marineArr objectAtIndex:i];
        double lat = [[weatherDict objectForKey:@"lat"] doubleValue];
        double lon = [[weatherDict objectForKey:@"lon"] doubleValue];
        MKPointAnnotation *locAnnot = [[MKPointAnnotation alloc] init];
        locAnnot.coordinate = CLLocationCoordinate2DMake(lat, lon);
        locAnnot.title = @"yellow";
        locAnnot.subtitle = [NSString stringWithFormat:@"%d", i];
        [self.mapView addAnnotation:locAnnot];
        [annotArr addObject:locAnnot];
    }*/
}

- (void)configureDesign {
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.undLbWidthConst setConstant:self.view.frame.size.width / 2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AppOpenTask:(NSNotification *)notification {
    weatherArr = [[NSMutableArray alloc] init];
    [appDelegate showLoadDialog:@"Getting weather list.." viewController:self.mainTabVC];
    [[APIManager sharedInstance] getWeatherForecast:self];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    NSString *pinImageName;
    MKPointAnnotation *annot = (MKPointAnnotation*)annotation;
    NSString *subTitle = annotation.subtitle;
    int index = [subTitle intValue];
    if(annot.title) {
        if(index == selectedOceanIndex) {
            pinImageName = @"red_pin_select";
        }
        else {
            pinImageName = @"red_pin";
        }
    }
    if([annot.title isEqualToString:@"yellow"]) {
        if(index == selectedOceanIndex) {
            pinImageName = @"yellow_pin_select";
        }
        else {
            pinImageName = @"yellow_pin";
        }
    }
    
    static NSString *SFAnnotationIdentifier = @"SFAnnotationIdentifier";
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:SFAnnotationIdentifier] ;
    UIImage *flagImage = [UIImage imageNamed:pinImageName];
    annotationView.image = flagImage;
    CGRect frame = annotationView.frame;
    frame.size = CGSizeMake(40.0, 40.0);
    annotationView.frame = frame;
    annotationView.centerOffset = CGPointMake(0, 0);
    
    CGFloat yAxis = (index == selectedOceanIndex) ? 38 : 34;
    
    UILabel* label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1];
    label.text = annotation.title;
    label.numberOfLines = 0;
    [label sizeToFit];
    [label setFrame:CGRectMake(-((label.frame.size.width - 40) / 2), yAxis, label.frame.size.width, label.frame.size.height)];
    [label setFont:[label.font fontWithSize: 10]];
    [annotationView addSubview:label];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    MKPointAnnotation *annot = view.annotation;
    NSString *subTitle = annot.subtitle;
    selectedOceanIndex = [subTitle intValue];
    [self.mapView removeAnnotations:annotArr];
    [self addAnnotations];
    //[self showWeatherInfoDialog];
    [self showWeatherFullInfoView];
}

- (void)showWeatherInfoDialog {
    NSMutableDictionary *oceanDict = [marineArr objectAtIndex:selectedOceanIndex];
    UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WeatherInfoDialogViewController *infoDialogVC = [mainBoard instantiateViewControllerWithIdentifier:@"WeatherInfoDialogVC"];
    infoDialogVC.oceanDict = oceanDict;
    [self.mainTabVC addChildViewController:infoDialogVC];
    infoDialogVC.view.frame = self.mainTabVC.view.frame;
    [self.mainTabVC.view addSubview:infoDialogVC.view];
    infoDialogVC.view.alpha = 0;
    [infoDialogVC didMoveToParentViewController:self.mainTabVC];
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        infoDialogVC.view.alpha = 1;
    }completion:nil];
}

-(void)showWeatherFullInfoView {
    NSMutableDictionary *oceanDict = [marineArr objectAtIndex:selectedOceanIndex];
    UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MarineDetailViewController *marineDetailVC = [mainBoard instantiateViewControllerWithIdentifier:@"MarineDetailVC"];
    marineDetailVC.oceanDict = oceanDict;
    [self presentViewController:marineDetailVC animated:YES completion:nil];
}

- (IBAction)cityTabClicked:(id)sender {
    tabIndex = 0;
    oceanViewType = 0;
    [self.undLbLeftConst setConstant:0];
    [self.tableView setHidden:NO];
    [self.mapView setHidden:YES];
    [self.cityTabBt setTitleColor:[UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1] forState:UIControlStateNormal];
    [self.oceanTabBt setTitleColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1] forState:UIControlStateNormal];
    [self.switchBt setHidden:YES];
    [self.tableView reloadData];
}

- (IBAction)oceanTabClicked:(id)sender {
    tabIndex = 1;
    [self.undLbLeftConst setConstant:self.view.frame.size.width / 2];
    [self.tableView setHidden:YES];
    [self.mapView setHidden:NO];
    [self.oceanTabBt setTitleColor:[UIColor colorWithRed:0.903512 green:0.258715 blue:0.263742 alpha:1] forState:UIControlStateNormal];
    [self.cityTabBt setTitleColor:[UIColor colorWithRed:0.13 green:0.22 blue:0.4 alpha:1] forState:UIControlStateNormal];
    [self.switchBt setHidden:NO];
    [self.tableView reloadData];
}
- (IBAction)switchClicked:(id)sender {
    if(oceanViewType == 0) {
        oceanViewType = 1;
        [self.mapView setHidden:YES];
        [self.tableView setHidden:NO];
    }
    else {
        oceanViewType = 0;
        [self.mapView setHidden:NO];
        [self.tableView setHidden:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tabIndex == 0) {
        return weatherArr.count;
    }
    else {
        return marineArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tabIndex == 0) {
        return 145;
    }
    else {
        return 100;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tabIndex == 0) {
        WeatherForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherForecastTVC"];
        NSMutableDictionary *weatherDict = [weatherArr objectAtIndex:indexPath.row];
        cell.weatherDict = weatherDict;
        return cell;
    }
    else {
        OceanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OceanTVC"];
        NSMutableDictionary *oceanDict = [marineArr objectAtIndex:indexPath.row];
        cell.oceanDict = oceanDict;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tabIndex == 0) {
        NSMutableDictionary *weatherDict = [weatherArr objectAtIndex:indexPath.row];
        UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WeatherDetailViewController *weatherDetailVC = [mainBoard instantiateViewControllerWithIdentifier:@"WeatherDetailVC"];
        weatherDetailVC.weatherDict = weatherDict;
        [self presentViewController:weatherDetailVC animated:YES completion:nil];
    }
    else {
        NSMutableDictionary *oceanDict = [marineArr objectAtIndex:indexPath.row];
        UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MarineDetailViewController *marineDetailVC = [mainBoard instantiateViewControllerWithIdentifier:@"MarineDetailVC"];
        marineDetailVC.oceanDict = oceanDict;
        [self presentViewController:marineDetailVC animated:YES completion:nil];
    }
}

- (void)httpSuccess:(NSData *)data {
    [appDelegate hideLoadDialog];
    NSError *error;
    NSDictionary *weatherMarineDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    weatherArr = [weatherMarineDict objectForKey:@"weather"];
    if(weatherArr == nil) {
        weatherArr = [[NSArray alloc] init];
    }
    marineArr = [weatherMarineDict objectForKey:@"marine"];
    if(marineArr == nil) {
        marineArr = [[NSArray alloc] init];
    }
    [self updateMap];
    [self.tableView reloadData];
}

- (void)httpError:(NSError *)error {
    [appDelegate hideLoadDialog];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
