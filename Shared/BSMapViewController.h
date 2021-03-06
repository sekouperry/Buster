//
//  BSMapViewController.h
//  Buster
//
//  Created by andyshep on 12/15/10.
//
//  Copyright (c) 2010 Andrew Shepard
// 
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
// 
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
// 
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "BSVehicleLocationModel.h"
#import "BSVehicleLocationAnnotation.h"

@protocol BSMapViewControllerDelegate <NSObject>

- (void)loadPredictionsForVehicle:(NSString *)vehicle runningRoute:(NSString *)route atEpochTime:(NSString *)time;

@end

@interface BSMapViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, MKMapViewDelegate> {
	UIPopoverController *popoverController;
    UIToolbar *toolbar;
	
	NSString *vehicle;
	NSString *route;
	NSString *time;
	
	MKMapView *mapView;
    
    BSVehicleLocationModel *model_;
}

@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;

@property (nonatomic, strong) NSString *vehicle;
@property (nonatomic, strong) NSString *route;
@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) UIPopoverController *popoverController;

- (void)dropPinForLocation;
- (void)configureView;

@end
