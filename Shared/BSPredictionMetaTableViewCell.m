//
//  BSPredictionMetaTableViewCell.m
//  Buster
//
//  Created by andyshep on 8/23/11.
//
//  Copyright (c) 2010-2013 Andrew Shepard
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

#import "BSPredictionMetaTableViewCell.h"

@implementation BSPredictionMetaTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.routeNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_routeNumberLabel setBackgroundColor:[UIColor clearColor]];
        
        self.routeDirectionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_routeDirectionLabel setBackgroundColor:[UIColor clearColor]];
        [_routeDirectionLabel setAdjustsFontSizeToFitWidth:YES];
        
        self.stopNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_stopNameLabel setBackgroundColor:[UIColor clearColor]];
        [_stopNameLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self.contentView addSubview:_routeNumberLabel];
        [self.contentView addSubview:_routeDirectionLabel];
        [self.contentView addSubview:_stopNameLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_routeNumberLabel setFrame:CGRectMake(20.0f, 5.0f, 40.0f, 25.0f)];
    [_routeDirectionLabel setFrame:CGRectMake(20.0f, 30.0f, 270.0f, 25.0f)];
    [_stopNameLabel setFrame:CGRectMake(20.0f, 55.0f, 270.0f, 25.0f)];
}

@end