/*
 *  Copyright (C) 2017 The Contributors
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or (at
 *  your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful, but
 *  WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 *  General Public License for more details.
 *
 *  A copy of the GNU General Public License can be found in the file
 *  "gpl.txt" in the top directory of this repository.
 */

#import <AppKit/AppKit.h>
#include <string.h>

char *dlg_open_disk(void)
{
	__block char *result = NULL;

	void (^work)(void) = ^{
		@autoreleasepool {
			NSOpenPanel *panel = [NSOpenPanel openPanel];

			[panel setTitle:@"Open Disk Image"];
			[panel setAllowsMultipleSelection:NO];
			[panel setCanChooseDirectories:NO];
			[panel setCanChooseFiles:YES];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
			[panel setAllowedFileTypes:@[@"disk", @"img", @"st"]];
#pragma clang diagnostic pop

			if ([panel runModal] == NSModalResponseOK) {
				NSURL *url = [[panel URLs] firstObject];

				if (url != nil) {
					const char *path = [[url path] UTF8String];

					if (path != NULL) {
						result = strdup(path);
					}
				}
			}
		}
	};

	if ([NSThread isMainThread]) {
		work();
	}
	else {
		dispatch_sync(dispatch_get_main_queue(), work);
	}

	return result;
}
