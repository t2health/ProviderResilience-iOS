//
//  LineChartDataSource.h
//  LineChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//  07/13/2012 T2 Modified example - even converted to 'scattered' style (instead of line style)
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
#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>

// Define the datasources that are supported
// These are plist files containing a list of dates/scores
#define LineChartSource_Burnout     @"BurnoutScores"
#define LineChartSource_ProQOL      @"ProQOLScores"

@interface LineChartDataSource : NSObject <SChartDatasource> {
    NSCalendar *cal; //Calendar used for constructing date objects.
    BOOL stepLineMode;
    
    NSString *dataFileName;
    NSInteger numSeriesInChart;
}

@property (nonatomic, retain) NSMutableArray *series1Data, *series1Dates;
@property (nonatomic, retain) NSString *dataFileName;

-(void)toggleSeriesType;
- (NSString *)dataFilePath:(NSString *)plistFileName;
-(NSInteger)reReadData;
-(id)initWithFileName:(NSString *)fileName seriesCount:(NSInteger)seriesCount;

@end
