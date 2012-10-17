//
//  LineChartDataSource.m
//  LineChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//
/*
 *
 * Provider Resilience
 *
 * Copyright © 2009-2012 United States Government as represented by
 * the Chief Information Officer of the National Center for Telehealth
 * and Technology. All Rights Reserved.
 *
 * Copyright © 2009-2012 Contributors. All Rights Reserved.
 *
 * THIS OPEN SOURCE AGREEMENT ("AGREEMENT") DEFINES THE RIGHTS OF USE,
 * REPRODUCTION, DISTRIBUTION, MODIFICATION AND REDISTRIBUTION OF CERTAIN
 * COMPUTER SOFTWARE ORIGINALLY RELEASED BY THE UNITED STATES GOVERNMENT
 * AS REPRESENTED BY THE GOVERNMENT AGENCY LISTED BELOW ("GOVERNMENT AGENCY").
 * THE UNITED STATES GOVERNMENT, AS REPRESENTED BY GOVERNMENT AGENCY, IS AN
 * INTENDED THIRD-PARTY BENEFICIARY OF ALL SUBSEQUENT DISTRIBUTIONS OR
 * REDISTRIBUTIONS OF THE SUBJECT SOFTWARE. ANYONE WHO USES, REPRODUCES,
 * DISTRIBUTES, MODIFIES OR REDISTRIBUTES THE SUBJECT SOFTWARE, AS DEFINED
 * HEREIN, OR ANY PART THEREOF, IS, BY THAT ACTION, ACCEPTING IN FULL THE
 * RESPONSIBILITIES AND OBLIGATIONS CONTAINED IN THIS AGREEMENT.
 *
 * Government Agency: The National Center for Telehealth and Technology
 * Government Agency Original Software Designation: Provider Resilience001
 * Government Agency Original Software Title: Provider Resilience
 * User Registration Requested. Please send email
 * with your contact information to: robert.kayl2@us.army.mil
 * Government Agency Point of Contact for Original Software: robert.kayl2@us.army.mil
 *
 */
#import "LineChartDataSource.h"

@implementation LineChartDataSource
@synthesize dataFileName;

@synthesize series1Data, series1Dates;



  
- (NSString *)dataFilePath:(NSString *)plistFileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * fileName = [[[NSString alloc] initWithString:plistFileName] autorelease];
    fileName  = [fileName stringByAppendingString:@".plist"];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (NSDate *)dateFromString:(NSString *)str
{
    static BOOL monthLookupTableInitialised = NO;
    static NSMutableArray *monthIdx;
    static NSArray *monthNames;
    static NSDictionary *months;
    
    if (!monthLookupTableInitialised) {
        monthIdx = [[NSMutableArray alloc] init ];
        for (int i = 1; i <= 12; ++i) {
            [monthIdx addObject:[NSNumber numberWithInt:i]];
        }
        
        monthNames = [[NSArray alloc] initWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
        months = [[NSDictionary alloc] initWithObjects:monthIdx forKeys:monthNames];
        monthLookupTableInitialised = YES;
    }
    
    NSRange dayRange = NSMakeRange(0,2);
    NSString *dayString = [str substringWithRange:dayRange];
    NSUInteger day = [dayString intValue];
    
    NSRange monthRange = NSMakeRange(3, 3);
    NSString *monthString = [str substringWithRange:monthRange];
    NSUInteger month = [[months objectForKey:monthString] unsignedIntValue];
    
    NSRange yearRange = NSMakeRange(7, 4);
    NSString *yearString = [str substringWithRange:yearRange];
    NSUInteger year = [yearString intValue];
    
    NSRange hourRange = NSMakeRange(12, 2);
    NSString *hourString = [str substringWithRange:hourRange];
    NSUInteger hour = [hourString intValue];

    NSRange minRange = NSMakeRange(15, 2);
    NSString *minString = [str substringWithRange:minRange];
    NSUInteger min = [minString intValue];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    [components setHour:hour];
    [components setMinute:min];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:components];
    
    [components release];
    [gregorian release];
    
    return date;
}

- (id)initWithFileName:(NSString *)fileName seriesCount:(NSInteger)seriesCount {
    self = [super init];
    if (self) {
        // Initialize the calendar
        cal = [[NSCalendar currentCalendar] retain];
        stepLineMode = NO;
        
        [self setDataFileName:fileName];
        numSeriesInChart = seriesCount;
        
        // Grab the data
        [self reReadData];
        
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialize the calendar
        cal = [[NSCalendar currentCalendar] retain];
        stepLineMode = NO;
        
        // Grab the data
        [self reReadData];
   
    }
    
    return self;
}

-(NSInteger)reReadData {
    
    NSInteger lastScore = -1;    // If no data yet, return this
    
    // Setup the Graph (data goes here)
    NSMutableArray *rawData;   // Pairs:  Date, Score
    
    // Catch and release (if we have been here before)
    if (series1Data != nil)  {
        [series1Data release];
        series1Data = nil;
    }
    if (series1Dates != nil)   {
        [series1Dates release];
        series1Dates = nil;
    }
    
    // We first try to find the data in our App directory (the updated version)
    NSString *filePath = [self dataFilePath:dataFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // Doesn't exist in our App directory...look for one in the bundle
        filePath = [[NSBundle mainBundle] pathForResource:dataFileName ofType:@"plist"];
    }
    
    // Make sure we got a file
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        rawData =[[NSMutableArray alloc] initWithContentsOfFile:filePath];
        
        
        series1Data = [[NSMutableArray alloc] init];
        series1Dates = [[NSMutableArray alloc] init];
        
        //NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
        //[dateFormat setDateFormat:@"dd-MMM-yyyy hh:mma"];
        
        for (int i = 0; i < [rawData count]; i += (numSeriesInChart+1)) {    
            // read in date axis unsigned 
            int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDateComponents* components = [calendar components:flags fromDate:[rawData objectAtIndex:i]];
            NSDate* dateOnly = [calendar dateFromComponents:components];
            
            // Convert to just date
            [series1Dates addObject:dateOnly];
            // [series1Dates addObject:[rawData objectAtIndex:i]];
            
            // read in data axis based on # of series
            for (int j=i+1; j<=(i+numSeriesInChart); j++)
                [series1Data addObject:[rawData objectAtIndex:j]];
            
        }
        
        [rawData release];
        rawData = nil;
    }
    
    if (series1Data != nil)
        if ([series1Data count] > 0) {
            NSNumber *lastNumber = [series1Data objectAtIndex:[series1Data count]-1];
            lastScore = [lastNumber integerValue];
        }  
    
    
    return lastScore;
    
}

- (void) dealloc {
	[cal release];
    [series1Dates release];
    [series1Data release];
	[super dealloc];
}

-(void)toggleSeriesType {
    stepLineMode = !stepLineMode;
}

#pragma mark -
#pragma mark Datasource Protocol Functions

// Returns the number of points for a specific series in the specified chart
- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    
    // Grab the # of points from the array
    //NSLog(@"# of datapoints per series: %d",[series1Data count]/[self numberOfSeriesInSChart:chart]);
    return [series1Data count]/[self numberOfSeriesInSChart:chart];    // Note:  All points for all series are here...so divide by the # of series
}

// Returns the series at the specified index for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
    
    // Our series are either of type SChartLineSeries or SChartStepLineSeries depending on stepLineMode.
    SChartLineSeries *lineSeries = stepLineMode? 
                                    [[[SChartStepLineSeries alloc] init] autorelease]:
                                    [[[SChartLineSeries alloc] init] autorelease];
    
    //SChartScatterSeries *lineSeries = [[[SChartScatterSeries alloc] init] autorelease];
    
    // Define several unique characteristics (for each possible series index
    switch (index%3) {   // Use modulo 3...or whatever our count is so we loop through the colors if there are extra series
        case 0:
            // Greenish
            lineSeries.style.pointStyle.radius = [NSNumber numberWithInt:8];
            lineSeries.style.pointStyle.color = [UIColor colorWithRed:80.f/255.f green:151.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.pointStyle.showPoints = YES;
            
            lineSeries.style.lineWidth = [NSNumber numberWithInt: 4];  // Adjust the line width
            
            lineSeries.style.lineColor = [UIColor colorWithRed:80.f/255.f green:151.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColor = [UIColor colorWithRed:90.f/255.f green:131.f/255.f blue:10.f/255.f alpha:1.f];
            
            lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:182.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:120.f/255.f blue:0.f alpha:1.f];
            
            lineSeries.baseline = [NSNumber numberWithInt:0];
            lineSeries.style.showFill = YES;
            
            lineSeries.crosshairEnabled = YES;
            
            lineSeries.title = [NSString stringWithFormat:@"Compassion"];  
            break;
            
        case 1:
            // Purplish
            lineSeries.style.pointStyle.radius = [NSNumber numberWithInt:8];
            lineSeries.style.pointStyle.color = [UIColor colorWithRed:80.f/255.f green:0.f blue:151.f/255.f alpha:1.f];
            lineSeries.style.pointStyle.showPoints = YES;
            
            lineSeries.style.lineWidth = [NSNumber numberWithInt: 4];  // Adjust the line width
            
            lineSeries.style.lineColor = [UIColor colorWithRed:80.f/255.f green:0.f blue:151.f/255.f alpha:1.f];
            lineSeries.style.areaColor = [UIColor colorWithRed:90.f/255.f green:10.f/255.f blue:131.f/255.f alpha:1.f];
            
            lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:0.f blue:182.f/255.f alpha:1.f];
            lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:0.f blue:120.f/255.f alpha:1.f];
            
            lineSeries.baseline = [NSNumber numberWithInt:0];
            lineSeries.style.showFill = YES;
            
            lineSeries.crosshairEnabled = YES;
            lineSeries.title = [NSString stringWithFormat:@"Burnout"];   
            break;
            
        case 2:
            // Yellowish
            lineSeries.style.pointStyle.radius = [NSNumber numberWithInt:8];
            lineSeries.style.pointStyle.color = [UIColor colorWithRed:151.f/255.f green:80.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.pointStyle.showPoints = YES;
            
            lineSeries.style.lineWidth = [NSNumber numberWithInt: 4];  // Adjust the line width
            
            lineSeries.style.lineColor = [UIColor colorWithRed:151.f/255.f green:80.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColor = [UIColor colorWithRed:131.f/255.f green:90.f/255.f blue:10.f/255.f alpha:1.f];
            
            lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:182.f/255.f green:227.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:120.f/255.f green:120.f/250.f blue:0.f alpha:1.f];
            
            lineSeries.baseline = [NSNumber numberWithInt:0];
            lineSeries.style.showFill = YES;
            
            lineSeries.crosshairEnabled = YES;
            lineSeries.title = [NSString stringWithFormat:@"Traumatic Stress"];  
            break;
        default:
            break;
    }
    
    return lineSeries;
}

// Returns the number of series in the specified chart
- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return numSeriesInChart;
}

// Returns the data point at the specified index for the given series/chart.
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    
    // Construct a data point to return
    SChartDataPoint *datapoint = [[[SChartDataPoint alloc] init] autorelease];
    
    // We simply move one day forward for each dataIndex
    datapoint.xValue = [series1Dates objectAtIndex:dataIndex];
    
    // Construct an NSNumber for the yValue of the data point
    // If there are mulitple series, then this array will have multiple points for each date
    // Note the formula for indexing to the correct item
    NSInteger myIndex = seriesIndex + dataIndex*numSeriesInChart;
    datapoint.yValue = [NSNumber numberWithFloat:[[series1Data objectAtIndex:myIndex] floatValue]];
    
    return datapoint;
}

@end
