//
//  FileManager.m
//
//  Created by NextFaze on 18/03/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "FileManager.h"

#define FilePath @"MyFiles"

#define JPEGCompressionQuality 0.7

@implementation FileManager

#pragma mark - Internal

+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    return documentsDirectory;
}

+ (NSString *)filePath
{
    NSString *documentsDirectory = [self documentPath];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:FilePath];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];   
    
    return documentsDirectory;
}

#pragma mark - 

+ (NSArray *)allJPEGsOnDisk
{
    // Get private docs dir
    NSString *documentsDirectory = [self filePath];
    NFLog(@"Loading files from %@", documentsDirectory);
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NFLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"jpg" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
            [retval addObject:image];
        }
    }
    
    return retval;
}

+ (void)saveImageAsJPEG:(UIImage *)image
{
    NSString *docPath = [self filePath];
    
    NSString *nextFileName = [NSString stringWithFormat:@"%d.jpg", [[self allJPEGsOnDisk] count] + 1];
    
//    NSString *thumbImagePath = [docPath stringByAppendingPathComponent:kThumbImageFile];
//    NSData *thumbImageData = UIImagePNGRepresentation(_thumbImage);
//    [thumbImageData writeToFile:thumbImagePath atomically:YES];
    
    NSString *fullImagePath = [docPath stringByAppendingPathComponent:nextFileName];
    NSData *fullImageData = UIImageJPEGRepresentation(image, JPEGCompressionQuality);
    [fullImageData writeToFile:fullImagePath atomically:YES]; 
}


+ (UIImage *)loadImage:(NSString *)fileName
{
    NSString *fullImagePath = [[self filePath] stringByAppendingPathComponent:fileName];
    return [UIImage imageWithContentsOfFile:fullImagePath];
}

+(UIImage *)loadThumb:(NSString *)fileName
{
    NFLog(@"ERROR: Not yet implemented");
    return nil;
}

#pragma mark - XML

+ (BOOL)saveDictionaryAsXML:(NSDictionary *)dictionary withName:(NSString *)name
{
    if (!name) {
        NFLog(@"ERROR: No name supplied.");
        return NO;        
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%@.plist",name];    
    NSString *fullFilePath = [[self documentPath] stringByAppendingPathComponent:fileName];
    
    if (!dictionary) {
        NFLog(@"WARNING: No dictionary supplied. Attempting to delete");
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        return [fileManager removeItemAtPath:fullFilePath error:&error];
    }
    
    NSString *error;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:dictionary
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:fullFilePath atomically:YES];
    }
    else {
        NFLog(@"ERROR: %@",error);
        [error release];
        return NO;
    }
    
    return YES;
    
}

+ (NSDictionary *)loadDictionaryFromXML:(NSString *)name
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
//    self.plistFile = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"example.plist"];
    NSString *fileName = [NSString stringWithFormat:@"%@.plist",name];    
    NSString *fullFilePath = [[self documentPath] stringByAppendingPathComponent:fileName];
    NFLog(@"File path: %@", fullFilePath);
    return [[[NSDictionary alloc] initWithContentsOfFile:fullFilePath] autorelease];
}

+ (BOOL)saveString:(NSString *)string withFilename:(NSString *)filename
{
    NSString *fullFilePath = [[self documentPath] stringByAppendingPathComponent:filename];
    NSError *error;
    BOOL success = [string  writeToFile:fullFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];

    if (!success) {
        NFLog(@"ERROR: %@",error);
    }
    
    return success;
}

+ (NSString *)loadString:(NSString *)filename
{
    
    NSString *fullFilePath = [[self documentPath] stringByAppendingPathComponent:filename];
    NSError *error;
    NFLog(@"File path: %@", fullFilePath);
    return [NSString stringWithContentsOfFile:fullFilePath encoding:NSUTF8StringEncoding error:&error];
}







@end










