//
//  FileManager.h
//
//  Created by NextFaze on 18/03/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

//+ (NSArray *)allJPEGsOnDisk;
//+ (void)saveImageAsJPEG:(UIImage *)image;

+ (UIImage *)loadImage:(NSString *)fileName;
+ (UIImage *)loadThumb:(NSString *)fileName;

+ (BOOL)saveDictionaryAsXML:(NSDictionary *)dictionary withName:(NSString *)name;
+ (NSDictionary *)loadDictionaryFromXML:(NSString *)name;

+ (BOOL)saveString:(NSString *)string withFilename:(NSString *)filename;
+ (NSString *)loadString:(NSString *)filename;



@end