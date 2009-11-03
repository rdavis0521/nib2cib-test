/*
 * AppController.j
 * Filter
 *
 * Created by You on July 24, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "TrFilterManager.j"

CPCibOwner              = @"CPCibOwner",
CPCibTopLevelObjects    = @"CPCibTopLevelObjects",
CPCibReplacementClasses = @"CPCibReplacementClasses";
    
var CPCibObjectDataKey  = @"CPCibObjectDataKey";


@implementation AppController : CPObject
{
    CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    TrFilterManager m_filterManager;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
    CPLog.debug("AppController: applicationDidFinishLaunching");
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things. 
    
    // In this case, we want the window from Cib to become our full browser window
    CPLog.debug("AppController: awakeFromCib");
    [theWindow setFullBridge:YES];

    m_filterManager = [[TrFilterManager alloc] init];
    [m_filterManager loadCibFile: self];
}

- (void)cibDidFinishLoading:(CPCib)aCib
{
    CPLog.debug("AppController: cibDidFinishLoading: "+ aCib);
}


@end
