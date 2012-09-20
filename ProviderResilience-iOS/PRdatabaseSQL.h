//
//  PRdatabaseSQL.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/23/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kFilenameSQL       @"prSqlData.sqlite3"

@interface PRdatabaseSQL : NSObject {
    
}

- (NSString *)dataFilePath;
- (void)createDbTables;

// ProQOL Table 
// Retrieve all rows
//- (BOOL)getProQOLdata:(NSMutableArray **) arrayRows;
- (NSMutableArray *)getProQOLdata;

// Debug method(s) to read records and log them
- (void)logSQLrecords;

- (int)count;

@end
