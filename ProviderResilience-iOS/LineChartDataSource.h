//
//  LineChartDataSource.h
//  LineChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//  07/13/2012 T2 Modified example - even converted to 'scattered' style (instead of line style)
//

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
