//
//  Debugging.h
//
//  Created by NextFaze on 18/03/12.
//  Copyright 2012 NextFaze. All rights reserved.
//

// "DEBUG=1" needs to be added to the "Preprocessor Macros" for the Debug configuration

#ifndef NFLog
#ifdef DEBUG
	#define NFLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
	#define NFLog(format, ...)
#endif
#endif

#define VIEW_DEBUG 0
