/*
 * AppController.j
 * TestSplit
 *
 * Created by You on July 22, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <AppKit/CPCib.j>

CPCibOwner              = @"CPCibOwner",
CPCibTopLevelObjects    = @"CPCibTopLevelObjects",
CPCibReplacementClasses = @"CPCibReplacementClasses";
    
var CPCibObjectDataKey  = @"CPCibObjectDataKey";


@implementation TrFilterRule : CPObject
{
    CPView          m_filterView;
    CPButton        m_delete;
    CPPopUpButton   m_rule1;
    CPPopUpButton   m_rule2;
    
    TrFilterManager m_manager;
}

- (TrFilterRule) initWithFilterManager: aManager
{
    CPLog.debug("TrFilterRule:init: ");
    
    self = [super init];
    CPLog.trace("self: " + self);
    
    m_manager = aManager;
    return self;
}

- (CPView) filterView
{
    CPLog.trace("TrFilterRule:filterView");
    return m_filterView;
}
- (void)awakeFromCib
{
    CPLog.debug("TrFilterRule: awakeFromCib: " + self);
    CPLog.trace("m_filterView: " + m_filterView);
    CPLog.trace("m_delete: " + m_delete);
    CPLog.trace("m_rule1: " + m_rule1);
    CPLog.trace("did finish self: " + self);
    [m_filterView setBackgroundColor: [CPColor grayColor]];
    [m_manager filterOpened: self];
    
}

- (void) deleteRule:(id)aSender
{
    CPLog.debug(" TrFilterRule deleteRule:"  + aSender);
    [m_manager deleteRule: self];
}


- (void)cibDidFinishLoading:(CPCib)aCib
{
    CPLog.debug("TrFilterRule cibDidFinishLoading: "+ aCib);
}

- (void) loadCibFile: aDelegate
{
    CPLog.debug("TrFilterRule:loadCibFile: " + aDelegate);

    var mainBundle = [CPBundle mainBundle];

    [mainBundle loadCibFile:"FilterRule.cib"
        externalNameTable:[CPDictionary dictionaryWithObject:self forKey:CPCibOwner]
             loadDelegate:aDelegate];

}


@end
