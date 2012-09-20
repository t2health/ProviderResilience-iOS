//
//  PRdatabaseSQL.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/23/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import "PRdatabaseSQL.h"
#import <sqlite3.h>

@implementation PRdatabaseSQL

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilenameSQL];
}

// Retrieve Data

// ProQOL Table 
// Retrieve all rows
- (NSMutableArray *)getProQOLdata {
    // Allocate the array
    NSMutableArray *arrayRows = [[[NSMutableArray alloc] init] retain];
    
    
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"Database could not be opened or created...aborting!");
    }
    
    sqlite3_stmt *stmt;
    NSString *query = @"Select qolID, qolQuestion, custom from PROQOL order by qolID";
    if((sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, nil) == SQLITE_OK)) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // Place the values into an array
            NSMutableArray *rowArray = [[NSMutableArray alloc] init];
            NSNumber *rowID = [NSNumber numberWithInt:sqlite3_column_int(stmt, 0)];
            NSString *rowQuestion = [NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(stmt,1)];
            NSNumber *rowCustom = [NSNumber numberWithInt:sqlite3_column_int(stmt, 2)];
            
            [rowArray addObject:rowID];
            [rowArray addObject:rowQuestion];
            [rowArray addObject:rowCustom];
            
            //NSLog(@"RowID: %@  Text: %@  Custom: %@",rowID,rowQuestion,rowCustom);
            
            // And add this array element to the row Array
            [arrayRows addObject:rowArray];
            
            // Clean up
            [rowArray release];
        }
        sqlite3_finalize(stmt);
    } else {
        NSLog(@"Error PROQOL (sqlite3_open): %s", sqlite3_errmsg(database));
    } 
    
    sqlite3_close(database);
    
    return arrayRows;
}

/*
// ProQOL Table 
// Retrieve all rows
- (BOOL)getProQOLdata:(NSMutableArray **) arrayRows {
    BOOL bStatus = YES;
    
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"Database could not be opened or created...aborting!");
    }
    
    sqlite3_stmt *stmt;
    NSString *query = @"Select qolID, qolQuestion, custom from PROQOL order by qolID";
    if((sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, nil) == SQLITE_OK)) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // Place the values into an array
            NSMutableArray *rowArray = [[NSMutableArray alloc] init];
            NSNumber *rowID = [NSNumber numberWithInt:sqlite3_column_int(stmt, 0)];
            NSString *rowQuestion = [NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(stmt,1)];
            NSNumber *rowCustom = [NSNumber numberWithInt:sqlite3_column_int(stmt, 2)];
            
            [rowArray addObject:rowID];
            [rowArray addObject:rowQuestion];
            [rowArray addObject:rowCustom];
            
            NSLog(@"RowID: %@  Text: %@  Custom: %@",rowID,rowQuestion,rowCustom);
            
            // And add this array element to the row Array
            [*arrayRows addObject:rowArray];
            
            // Clean up
            [rowArray release];
        }
        sqlite3_finalize(stmt);
    } else {
        NSLog(@"Error PROQOL (sqlite3_open): %s", sqlite3_errmsg(database));
    } 
    
    sqlite3_close(database);
    
    return bStatus;
}
*/


// Insert Helpers
// Table: ResilienceBuilders
- (void)helpInsRB: (sqlite3 *)ourDatabase rbQuestion:(NSString *)question custom:(int)nCustom {
    sqlite3_stmt *stmt;
    char *errormsg = NULL;
    char *update = "insert or replace into ResilienceBuilders (rbQuestion, custom) values (?, ?);";
    if((sqlite3_prepare_v2(ourDatabase, update, -1, &stmt, nil) == SQLITE_OK)) {
        //NSLog(@"proceed with insert...");
        // Bind our values
        sqlite3_bind_text(stmt, 1, [question UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 2, nCustom);
        
        // Insert it
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert1(0, @"Error updating table: %s", errormsg);
        } else {
            //NSLog(@"Insert was successful");
        }
    } else {
        NSLog(@"Error (sqlite3_open): %s", sqlite3_errmsg(ourDatabase));
    }
    sqlite3_finalize(stmt);
}

// Table: ResilienceKillers
- (void)helpInsRK: (sqlite3 *)ourDatabase rkQuestion:(NSString *)question custom:(int)nCustom {
    sqlite3_stmt *stmt;
    char *errormsg = NULL;
    char *update = "insert or replace into ResilienceKillers (rkQuestion, custom) values (?, ?);";
    if((sqlite3_prepare_v2(ourDatabase, update, -1, &stmt, nil) == SQLITE_OK)) {
        //NSLog(@"proceed with insert...");
        // Bind our values
        sqlite3_bind_text(stmt, 1, [question UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 2, nCustom);
        
        // Insert it
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert1(0, @"Error updating table: %s", errormsg);
        } else {
            //NSLog(@"Insert was successful");
        }
    } else {
        NSLog(@"Error (sqlite3_open): %s", sqlite3_errmsg(ourDatabase));
    }
    sqlite3_finalize(stmt);
}

// Table: PROQOL
- (void)helpInsQOL: (sqlite3 *)ourDatabase qolQuestion:(NSString *)question custom:(int)nCustom {
    sqlite3_stmt *stmt;
    char *errormsg = NULL;
    char *update = "insert or replace into PROQOL (qolQuestion, custom) values (?, ?);";
    if((sqlite3_prepare_v2(ourDatabase, update, -1, &stmt, nil) == SQLITE_OK)) {
        //NSLog(@"proceed with insert...");
        // Bind our values
        sqlite3_bind_text(stmt, 1, [question UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 2, nCustom);
        
        // Insert it
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert1(0, @"Error updating table: %s", errormsg);
        } else {
            //NSLog(@"Insert was successful");
        }
    } else {
        NSLog(@"Error (sqlite3_open): %s", sqlite3_errmsg(ourDatabase));
    }
    sqlite3_finalize(stmt);
}

// Table: Burnout
- (void)helpInsBurn: (sqlite3 *)ourDatabase bQuestion:(NSString *)question custom:(int)nCustom {
    sqlite3_stmt *stmt;
    char *errormsg = NULL;
    char *update = "insert or replace into Burnout (bQuestion, custom) values (?, ?);";
    if((sqlite3_prepare_v2(ourDatabase, update, -1, &stmt, nil) == SQLITE_OK)) {
        //NSLog(@"proceed with insert...");
        // Bind our values
        sqlite3_bind_text(stmt, 1, [question UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 2, nCustom);
        
        // Insert it
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert1(0, @"Error updating table: %s", errormsg);
        } else {
            //NSLog(@"Insert was successful");
        }
    } else {
        NSLog(@"Error (sqlite3_open): %s", sqlite3_errmsg(ourDatabase));
    }
    sqlite3_finalize(stmt);
}





- (void)createDbTables {
    
    // Open the database
    //NSLog(@"Check for existence of the database...");
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"Database could not be opened or created...aborting!");
    }
    
    // Check if table exists: ResilienceBuilders    int count = 0;
    int count=0;
    const char* sqlStatement = "SELECT COUNT(*) FROM ResilienceBuilders";
    sqlite3_stmt *statement;
    
    if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK )
    {
        //Loop through all the returned rows (should be just one)
        while( sqlite3_step(statement) == SQLITE_ROW )
        {
            count = sqlite3_column_int(statement, 0);
        }
    }
    else
    {
        NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
    }
    
    // Finalize and close database.
    sqlite3_finalize(statement);
    
    if (count > 0) {
        NSLog(@"Database already existed...do NOT repopulate!!!");
        return;
    }
        
  
    
    //******************************************************************
    // NSLog(@"Create table:  ResilienceBuilders...");
    //******************************************************************
    char *errorMsg;
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS ResilienceBuilders (rbID INTEGER PRIMARY KEY, rbQuestion STRING, custom INTEGER );";
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table ResilienceBuilders: %s", errorMsg);
    }
    
    // Now populate this table (using helpInsRB)
    [self helpInsRB:database rbQuestion:@"Did you take a short walk?" custom:0];
    [self helpInsRB:database rbQuestion:@"Did you perform at-desk stretching or isometrics?" custom:0];
    [self helpInsRB:database rbQuestion:@"Are you focusing on today''s Resilience Practice using affirmations?" custom:0];
    [self helpInsRB:database rbQuestion:@"Have you taken a day off within the last 60 working days?" custom:0];
    [self helpInsRB:database rbQuestion:@"Have you laughed at something today?" custom:0];
    
    
    //******************************************************************
    // NSLog(@"Create table:  RBAnswers...");
    //******************************************************************
    createSQL = @"CREATE TABLE IF NOT EXISTS RBAnswers (rbaID INTEGER PRIMARY KEY, rbQuestion INTEGER, rbAnswer INTEGER, answerDate DATETIME );";
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table RBAnswers: %s", errorMsg);
    }
    
    // Now populate this table 
    // No records needed
    
    
    //******************************************************************
    // NSLog(@"Create table:  ResilienceKillers...");
    //******************************************************************
    createSQL = @"CREATE TABLE IF NOT EXISTS ResilienceKillers (rkID INTEGER PRIMARY KEY, rkQuestion STRING, custom INTEGER );";
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table ResilienceKillers: %s", errorMsg);
    }
    
    // Now populate this table (using helpInsRK)
    [self helpInsRK:database rkQuestion:@"Did you come to work sick today?" custom:0];
    [self helpInsRK:database rkQuestion:@"Did you skip lunch?" custom:0];
    [self helpInsRK:database rkQuestion:@"Did you eat lunch at your desk?" custom:0];
    [self helpInsRK:database rkQuestion:@"Have you eaten junk food?" custom:0];
    [self helpInsRK:database rkQuestion:@"Do you work on weekends?" custom:0];
    
    //******************************************************************
    // NSLog(@"Create table:  RKAnswers...");
    //******************************************************************
    createSQL = @"CREATE TABLE IF NOT EXISTS RKAnswers (rKaID INTEGER PRIMARY KEY, rKQuestion INTEGER, rKAnswer INTEGER, answerDate DATETIME );";
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table RKAnswers: %s", errorMsg);
    }
    
    // Now populate this table 
    // No records needed
    
    
    //******************************************************************
    // NSLog(@"Create table:  PROQOL...");
    //******************************************************************
    createSQL = @"CREATE TABLE IF NOT EXISTS PROQOL (qolID INTEGER PRIMARY KEY, qolQuestion STRING, custom INTEGER );";
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table PROQOL: %s", errorMsg);
    }
    
    // Now populate this table (using helpInsQOL)
    [self helpInsQOL:database qolQuestion:@"I am happy." custom:1];
    [self helpInsQOL:database qolQuestion:@"I am preoccupied with more than one person I treat." custom:2];
    [self helpInsQOL:database qolQuestion:@"I get satisfaction from being able to help people." custom:3];
    [self helpInsQOL:database qolQuestion:@"I feel connected to others." custom:4];
    [self helpInsQOL:database qolQuestion:@"I jump or am startled by unexpected sounds." custom:5];
    [self helpInsQOL:database qolQuestion:@"I feel invigorated after working with those I treat." custom:6];
    [self helpInsQOL:database qolQuestion:@"I find it difficult to separate my personal life from my life as a therapist/health care provider." custom:7];
    [self helpInsQOL:database qolQuestion:@"I am not as productive at work because I am losing sleep over traumatic experiences of a person I treat." custom:8];
    [self helpInsQOL:database qolQuestion:@"I think I might have been affected by the traumatic stress of those I treat." custom:9];
    [self helpInsQOL:database qolQuestion:@"I feel trapped by my job as a therapist/health care provider." custom:10];
    [self helpInsQOL:database qolQuestion:@"Because of my work, I have felt ''on edge'' about various things." custom:11];
    [self helpInsQOL:database qolQuestion:@"I like my work as a therapist/health care provider." custom:12];
    [self helpInsQOL:database qolQuestion:@"I feel depressed because of the traumatic experiences of the people I treat." custom:13];
    [self helpInsQOL:database qolQuestion:@"I feel as though I am experiencing the trauma of someone I have treated." custom:14];
    [self helpInsQOL:database qolQuestion:@"I have beliefs that sustain me." custom:15];
    [self helpInsQOL:database qolQuestion:@"I am pleased with how I am able to keep up with treatment techniques and protocols." custom:16];
    [self helpInsQOL:database qolQuestion:@"I am the person I always wanted to be." custom:17];
    [self helpInsQOL:database qolQuestion:@"My work makes me feel satisfied." custom:18];
    [self helpInsQOL:database qolQuestion:@"I feel worn out because of my work as a therapist/health care provider." custom:19];
    [self helpInsQOL:database qolQuestion:@"I have happy thoughts and feelings about those I treat and how I could help them." custom:20];
    [self helpInsQOL:database qolQuestion:@"I feel overwhelmed because my case load seems endless." custom:21];
    [self helpInsQOL:database qolQuestion:@"I believe I can make a difference through my work." custom:22];
    [self helpInsQOL:database qolQuestion:@"I avoid certain activities or situations because they remind me of frightening experiences of the people I treat." custom:23];
    [self helpInsQOL:database qolQuestion:@"I am proud of what I can do to help." custom:24];
    [self helpInsQOL:database qolQuestion:@"As a result of my work, I have intrusive, frightening thoughts." custom:25];
    [self helpInsQOL:database qolQuestion:@"I feel ''bogged down'' by the system." custom:26];
    [self helpInsQOL:database qolQuestion:@"I have thoughts that I am a ''success'' as a therapist/health care provider." custom:27];
    [self helpInsQOL:database qolQuestion:@"I can't recall important parts of my work with trauma victims." custom:28];
    [self helpInsQOL:database qolQuestion:@"I am a very caring person." custom:29];
    [self helpInsQOL:database qolQuestion:@"I am happy that I chose to do this work." custom:30];
    
    //******************************************************************
    // NSLog(@"Create table:  QOLAnswers...");
    //******************************************************************
    createSQL = @"CREATE TABLE IF NOT EXISTS QOLAnswers (qolaID INTEGER PRIMARY KEY, qolQuestion INTEGER, qolAnswer INTEGER, answerDate DATETIME );";
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table QOLAnswers: %s", errorMsg);
    }
    
    // Now populate this table 
    // No records needed    
    
    
    
    //******************************************************************
    // NSLog(@"Create table:  Burnout...");
    //******************************************************************
    createSQL = @"CREATE TABLE IF NOT EXISTS Burnout (bID INTEGER PRIMARY KEY, bQuestion String, custom INTEGER );";
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table Burnout: %s", errorMsg);
    }
    
    // Now populate this table (using helpInsBurn)
    [self helpInsBurn:database bQuestion:@"Happy" custom:0];
    [self helpInsBurn:database bQuestion:@"Trapped" custom:0];
    [self helpInsBurn:database bQuestion:@"Satisfied" custom:0];
    [self helpInsBurn:database bQuestion:@"Preoccupied" custom:0];
    [self helpInsBurn:database bQuestion:@"Connected" custom:0];
    [self helpInsBurn:database bQuestion:@"Worn out" custom:0];
    [self helpInsBurn:database bQuestion:@"Caring" custom:0];
    [self helpInsBurn:database bQuestion:@"On edge" custom:0];
    [self helpInsBurn:database bQuestion:@"Valuable" custom:0];
    [self helpInsBurn:database bQuestion:@"Traumatized" custom:0];
    
    
    //******************************************************************
    // NSLog(@"Create table:  BurnoutAnswers...");
    //******************************************************************
    createSQL = @"CREATE TABLE IF NOT EXISTS BurnoutAnswers (baID INTEGER PRIMARY KEY, bQuestion INTEGER, bAnswer INTEGER, answerDate DATETIME );";
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table BurnoutAnswers: %s", errorMsg);
    }
    
    // Now populate this table 
    // No records needed
    

    sqlite3_close(database);
}


// Temp method(s) to look at (log) our records
- (void)logSQLrecords {
    // Open the database
    //NSLog(@"Check for existence of the database...");
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Database could not be opened or created...CHECK IT OUT!");
    }
    
    // Look at the data
    // ResilienceBuilders
    NSLog(@"********************** ResilienceBuilders Records");
    NSString *query = @"Select rbID, rbQuestion, custom from ResilienceBuilders order by rbID";
    sqlite3_stmt *stmt;
    if((sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, nil) == SQLITE_OK)) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // Get the values
            int row = sqlite3_column_int(stmt, 0);
            char *rowData = (char *)sqlite3_column_text(stmt,1);
            
            NSLog(@"Row: %d  Text: %s",row,rowData);
        }
        sqlite3_finalize(stmt);
    } else {
        NSLog(@"Error ResilienceBuilders (sqlite3_open): %s", sqlite3_errmsg(database));
    }
    
    
    // ResilienceKillers
    NSLog(@"********************** ResilienceKillers Records");
    query = @"Select rkID, rkQuestion, custom from ResilienceKillers order by rkID";
    if((sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, nil) == SQLITE_OK)) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // Get the values
            int row = sqlite3_column_int(stmt, 0);
            char *rowData = (char *)sqlite3_column_text(stmt,1);
            
            NSLog(@"Row: %d  Text: %s",row,rowData);
        }
        sqlite3_finalize(stmt);
    } else {
        NSLog(@"Error ResilienceKillers (sqlite3_open): %s", sqlite3_errmsg(database));
    }
    
    // PROQOL
    NSLog(@"********************** PROQOL Records");
    query = @"Select qolID, qolQuestion, custom from PROQOL order by qolID";
    if((sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, nil) == SQLITE_OK)) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // Get the values
            int row = sqlite3_column_int(stmt, 0);
            char *rowData = (char *)sqlite3_column_text(stmt,1);
            
            NSLog(@"Row: %d  Text: %s",row,rowData);
        }
        sqlite3_finalize(stmt);
    } else {
        NSLog(@"Error PROQOL (sqlite3_open): %s", sqlite3_errmsg(database));
    } 
    
    // Burnout
    NSLog(@"********************** Burnout Records");
    query = @"Select bID, bQuestion, custom from Burnout order by bID";
    if((sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, nil) == SQLITE_OK)) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // Get the values
            int row = sqlite3_column_int(stmt, 0);
            char *rowData = (char *)sqlite3_column_text(stmt,1);
            
            NSLog(@"Row: %d  Text: %s",row,rowData);
        }
        sqlite3_finalize(stmt);
    } else {
        NSLog(@"Error Burnout (sqlite3_open): %s", sqlite3_errmsg(database));
    }
    
    sqlite3_close(database);
    
}

- (int)count {
    NSLog(@"Why are we here in PRdatabaseSQL.m:count ???");
    return 0;
}

@end
