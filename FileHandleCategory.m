//
//  FileHandleCategory.m
//  zipQuickLook
//
//  Created by Ricky Nelson on 1/12/11.
//  Copyright 2011 Lark Software, LLC. All rights reserved.
//

#import "FileHandleCategory.h"


@implementation NSFileHandle (Utilities)
/* -- 
 Category for NSFileHandle that allows us to query on a full pipe
 -- */

-(NSData *) availableDataOrError {
	for (;;) {
		@try {
			return [self availableData];
		} 
		@catch (NSException *e) {
			if ([[e name] isEqualToString:NSFileHandleOperationException]) {
				if ([[e reason] isEqualToString: @"*** -[NSConcreteFileHandle availableData]: Interrupted system call"]) {
					continue;
				}
				
				return nil;
			}
			
			@throw;
		}
	}	
}

@end
