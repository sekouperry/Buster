//
//  BSDirectionsModel.m
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

#import "BSDirectionsModel.h"

#import "BSDirection.h"
#import "BSStop.h"

#import "BSMBTARequestOperation.h"
#import "MBTAQueryStringBuilder.h"

#import "SMXMLDocument.h"

@interface BSDirectionsModel ()

- (void)unloadStopList;
- (NSString *)archivePathForStop:(NSString *)stop;

@end

@implementation BSDirectionsModel

- (id)init {
	if ((self = [super init])) {
        //
    }
	
    return self;
}

- (NSUInteger)countOfStops {
	return [self.stops count];
}

- (id)objectInStopsAtIndex:(NSUInteger)index {
	return [self.stops objectAtIndex:index];
}

- (void)getStops:(__unsafe_unretained id *)objects range:(NSRange)range {
	[self.stops getObjects:objects range:range];
}

- (void)requestDirectionsList:(NSString *)stop {
    // TODO: implement stops caching
    
    if (self.stops == nil) {
        NSLog(@"loading stops from the intertubes...");
        
        MBTAQueryStringBuilder *builder = [MBTAQueryStringBuilder sharedInstance];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[builder buildRouteConfigQuery:stop]]];
        
        BSMBTARequestOperation *operation = [BSMBTARequestOperation MBTARequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id object) {
            NSError *error = nil;
            SMXMLDocument *xml = [[SMXMLDocument alloc] initWithData:object error:&error];
            
            if (!error) {
                // a list of route stops will be passed back and stored into the model
                NSMutableDictionary *stopsList = [NSMutableDictionary dictionaryWithCapacity:20];
                NSMutableArray *directionsList = [NSMutableArray arrayWithCapacity:20];
                NSMutableArray *tagsList = [NSMutableArray arrayWithCapacity:3];
                NSMutableArray *titlesList = [NSMutableArray arrayWithCapacity:3];
                // NSMutableArray *pathsList = [NSMutableArray arrayWithCapacity:20];
                
                SMXMLElement *routeElement = [xml.root childNamed:@"route"];
                
                for (SMXMLElement *stopElement in [routeElement childrenNamed:@"stop"]) {
                    BSStop *stop = [[BSStop alloc] init];
                    stop.title = [stopElement attributeNamed:@"title"];
                    stop.tag = [stopElement attributeNamed:@"tag"];
                    stop.latitude = [stopElement attributeNamed:@"lat"];
                    stop.longitude = [stopElement attributeNamed:@"lon"];
                    
                    [stopsList setObject:stop forKey:stop.tag];
                }
                
                for (SMXMLElement *directionElement in [routeElement childrenNamed:@"direction"]) {
                    BSDirection *direction = [[BSDirection alloc] init];
                    direction.title = [directionElement attributeNamed:@"title"];
                    direction.tag = [directionElement attributeNamed:@"tag"];
                    direction.name = [directionElement attributeNamed:@"name"];
                    
                    NSMutableArray *stops = [NSMutableArray arrayWithCapacity:10];
                    for (SMXMLElement *directionStopElement in [directionElement childrenNamed:@"stop"]) {
                        [stops addObject:[stopsList objectForKey:[directionStopElement attributeNamed:@"tag"]]];
                    }
                    
                    direction.stops = stops;
                    
                    [directionsList addObject:direction];
                }
                
                NSMutableArray *pathPoints = [NSMutableArray arrayWithCapacity:10];
                for (SMXMLElement *pathElement in [routeElement childrenNamed:@"path"]) {
                    for (SMXMLElement *pointOnPath in [pathElement childrenNamed:@"point"]) {
                        
                        NSString *lat = [pointOnPath attributeNamed:@"lat"];
                        NSString *lon = [pointOnPath attributeNamed:@"lon"];
                        NSDictionary *point = @{@"lat": lat, @"lon": lon};
                        
                        [pathPoints addObject:point];
                    }
                }
                
                // basically a unneeded loop.  refactor and improve this.
                for (BSDirection *direction in directionsList) {
                    [tagsList addObject:direction.tag];
                    [titlesList addObject:direction.title];
                }
                
                // we don't need to stopsList anymore since we have
                // built a list of stops based on the direction of travel
                stopsList = nil;
                
                self.directions = directionsList;
                self.tags = tagsList;
                self.titles = titlesList;
            }
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            // TODO: handle failure
        }];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperation:operation];
    }
}

- (void)unloadStopList {
	self.stops = nil;
}

- (void)loadStopsForDirection:(NSUInteger)directionIndex {
    NSArray *stops = [(BSDirection *)[self.directions objectAtIndex:directionIndex] stops];
    NSMutableArray *mStops = [NSMutableArray arrayWithCapacity:20];
    
    for (NSDictionary *stop in stops) {
        BSDirection *aStop = [[BSDirection alloc] init];
        [aStop setTag:[stop valueForKey:@"tag"]];
        [aStop setTitle:[stop valueForKey:@"title"]];
        
        [mStops addObject:aStop];
    }
    
    self.stops = [NSArray arrayWithArray:mStops];
    self.title = [(BSDirection *)[self.directions objectAtIndex:directionIndex] title];
}

#pragma mark - Disk Access
- (NSString *)pathInDocumentDirectory:(NSString *)aPath {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoryPath = [documentPaths objectAtIndex:0];
    return [documentDirectoryPath stringByAppendingPathComponent:aPath];
}

- (NSString *)archivePathForStop:(NSString *)stop {
    NSString *filename = [NSString stringWithFormat:@"stops_%@.data", stop];
    return [self pathInDocumentDirectory:filename];
}

@end
