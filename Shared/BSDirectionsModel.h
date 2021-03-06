//
//  BSDirectionsModel.h
//  Buster
//
//  Created by andyshep on 12/30/10.
//
//  Copyright (c) 2010-2011 Andrew Shepard
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

@interface BSDirectionsModel : NSObject 

@property (nonatomic, copy) NSArray *stops;
@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, copy) NSArray *directions;
@property (nonatomic, copy) NSError *error;
@property (nonatomic, copy) NSString *title;

- (void)requestDirectionsList:(NSString *)stop;
- (void)loadStopsForDirection:(NSUInteger)directionIndex;

- (NSUInteger)countOfStops;
- (id)objectInStopsAtIndex:(NSUInteger)index;
- (void)getStops:(__unsafe_unretained id *)objects range:(NSRange)range;

@end
