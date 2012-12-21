//
//  XMLParser.h
//  Biimm
//
//  Created by Christophe Bergé on 01/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Annonce.h"
#import "BiimmAppDelegate.h"

@class BiimmAppDelegate, Annonce;

@interface XMLParser : NSObject {
	NSMutableString *currentElementValue;
	Annonce *uneAnnonce;
	BiimmAppDelegate *appDelegate;
}

- (XMLParser *) initXMLParser;

@end
