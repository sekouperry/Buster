//
//  StopListViewController.h
//  Buster
//
//  Created by andyshep on 8/9/10.
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

#import "StopListModel.h"
#import "PredictionsViewController.h"


@interface StopListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	NSString *stopTag;
	IBOutlet UITableView *tableView;
	
	IBOutlet UISegmentedControl *directionControl;
	IBOutlet UIToolbar *bottomToolbar;
}

@property (nonatomic, retain) NSString *stopTag;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *directionControl;
@property (nonatomic, retain) IBOutlet UIToolbar *bottomToolbar;

- (void)assembleRoutePath;

- (IBAction)switchDirection:(id)sender;

@end
