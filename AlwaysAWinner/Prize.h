//
//  Prize.h
//
//  Created by NextFaze on 24/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prize : NSObject {
    NSMutableDictionary *dict;
}

+ (Prize *)prizeWithDictionary:(NSMutableDictionary *)dictionary;

- (NSString *)name;
- (void)setName:(NSString *)value;

- (UIImage *)image;
- (void)setImage:(UIImage *)value;

- (NSString *)text;
- (UIImage *)textImage;

- (NSDictionary *)dictionary;

@end
