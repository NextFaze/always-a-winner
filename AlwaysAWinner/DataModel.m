//
//  DataModel.m
//
//  Created by NextFaze on 24/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "DataModel.h"
#import "FileManager.h"

#define UseSavedDataModel 0

@implementation DataModel

+ (DataModel *) instance 
{
	static DataModel *instance = nil;
	if (!instance) {
		instance = [[DataModel alloc] init];
	}
	return instance;
}

-(id) init
{
    NFLog(@"Initialising...");
    
    self = [super init];
    
    if (!self) return nil;
    
    //attempt to load datamodel from internet
    //NSURL *url = [NSURL URLWithString:@"http://www.nextfaze.com/alwaysawinner/DataModel.plist"];
    //dataModel = [[NSMutableDictionary alloc] initWithContentsOfURL:url];
    dataModel = nil; 
     
    if (dataModel) {
        NFLog(@"Downloaded dataModel. Saving to disk.");
        [self save];
    }
    else {
        NFLog(@"Download of online dataModel failed. Will use saved version.");
        //first try the documents dir for a downloaded version
        NSDictionary *loadedModel = [FileManager loadDictionaryFromXML:@"dataModel"];
        if (loadedModel && UseSavedDataModel) {
            dataModel = [[NSMutableDictionary alloc] initWithDictionary:loadedModel];
        }
        else {
            NFLog(@"No saved dataModel. Reading from main bundle.");
            NSString *path = [[NSBundle mainBundle] pathForResource:@"DataModel" ofType:@"plist"];
            dataModel = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        }
    }
    
    NFLog(@"Initialisation complete.");
    
	return self;
}

- (void) dealloc 
{
    [dataModel release];
    
    [super dealloc];
}

#pragma mark -

- (BOOL)save
{
    //save database back to disk
    BOOL writeSuccesful = [FileManager saveDictionaryAsXML:dataModel withName:@"DataModel"];
    if (!writeSuccesful) {
        NFLog(@"ERROR: Unable to save DataBase to disk.");
    }
    return writeSuccesful;
}

#pragma mark - Internal

- (NSArray *)allPrizes
{
    return [dataModel objectForKey:@"Prizes"];
}

#pragma mark -

- (NSUInteger)numberOfPrizes
{
    return [[self allPrizes] count];
}

- (Prize *)prizeAtIndex:(NSInteger)index
{
    NSMutableDictionary *dict = [[self allPrizes] objectAtIndex:index];
    return [Prize prizeWithDictionary:dict];
}

@end










