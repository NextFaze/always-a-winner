//
//  Prize.m
//
//  Created by NextFaze on 24/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "Prize.h"

@implementation Prize

- (id)initWithDictionary:(NSMutableDictionary *)dictionary
{
    if  (self = [super init]) {
        //set defaults
        dict = [dictionary retain];

    }
    return self;
}

+ (Prize *)prizeWithDictionary:(NSMutableDictionary *)dictionary;
{
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        NFLog(@"ERROR: Not passed a dictionary object.");
        return nil;
    }
    
    Prize *prize = [[[Prize alloc] initWithDictionary:dictionary] autorelease];
        
    return prize;
}

- (void)dealloc 
{
    [dict release];
    
    [super dealloc];
}

- (NSString *)name
{
    return [dict valueForKey:@"PrizeName"];
}

- (void)setName:(NSString*)value
{
    [dict setValue:[NSString stringWithString:value] forKey:@"PrizeName"];
}


- (UIImage *)image
{
    NSString *filename = [NSString stringWithFormat:@"%@.jpg", [dict valueForKey:@"PrizeImageName"]];
    UIImage *image= [UIImage imageNamed:filename];
    
    if (!image) {
        NFLog(@"ERROR: Could not locate file %@", filename);
    }
    
    return image;
}

- (void)setImage:(UIImage *)value
{
    NFLog(@"ERROR: Not yet implemented");
}

- (NSString *)text
{
    return [dict valueForKey:@"PrizeText"];
}

- (UIImage *)textImage
{
    NSString *fileName = [dict valueForKey:@"PrizeTextImageName"];
    if (fileName)
        return [UIImage imageNamed:fileName];
    return nil;
}

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithDictionary:dict];
}


@end














