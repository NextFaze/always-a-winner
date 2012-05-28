//
//  DataModel.h
//
//  Created by NextFaze on 24/05/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Prize.h"

@interface DataModel : NSObject {
    NSMutableDictionary *dataModel;
}

+ (DataModel *)instance;
- (BOOL)save;

- (NSUInteger)numberOfPrizes;
- (Prize *)prizeAtIndex:(NSInteger)index;

@end
