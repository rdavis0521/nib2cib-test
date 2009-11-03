/*
 * AppController.j
 * TestSplit
 *
 * Created by You on July 22, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <AppKit/CPCib.j>
@import "TrFilterRule.j"

CPCibOwner              = @"CPCibOwner",
CPCibTopLevelObjects    = @"CPCibTopLevelObjects",
CPCibReplacementClasses = @"CPCibReplacementClasses";
    
var CPCibObjectDataKey  = @"CPCibObjectDataKey";

function boundsString(bounds, label)
{
    var minx = CPRectGetMinX(bounds);
    var miny = CPRectGetMinY(bounds);
    var height = CPRectGetHeight(bounds);
    var width = CPRectGetWidth(bounds);
    var str = label + " minx:"+minx + " miny:"+miny + " height:"+height + " width:" +width;
    
    return str;
}



@implementation TrFilterManager : CPObject
{
    CPScrollView    m_documentView;
    CPScrollView    m_scroller;
    CPWindow        m_window;
    CPView          m_containerView;
    CPTextField     m_description;
    CPPopUpButton   m_qualifier;
    CPButton        m_cancel;
    CPButton        m_save;
    CPButton        m_addrule;
    
    CPArray         m_filterRules;
    Number          m_filterOffset;
}

- (TrFilterManager) init
{
    CPLog.debug("TrFilterManager:init: ");
    
    self = [super init];
    CPLog.trace("self: " + self);
    
    m_filterRules = [[CPArray alloc] init];
    m_filterOffset = 0;
    return self;
}

- (void)awakeFromCib
{
    CPLog.debug("TrFilterManager: awakeFromCib: " + self);
    CPLog.trace("m_scroller: " + m_scroller);
    CPLog.trace("m_window: " + m_window);
    CPLog.trace("m_containerView: " + m_containerView);
    CPLog.trace("m_documentView: " + m_documentView);
    CPLog.trace("did finish self: " + self);
    
    [m_scroller setDocumentView: m_documentView];
    
    // Initialize first filter
    [self addRule: self];
}

- (void) addRule:(id) aSender
{
    CPLog.debug("TrFilterManager: addNewFilter: ");
    var filterRule = [[TrFilterRule alloc] initWithFilterManager: self];
    [filterRule loadCibFile: self];
}

- (void) deleteRule: aFilter
{
    CPLog.debug("TrFilterManager: deleteFilter: " + aFilter);
    if (m_filterRules.length <= 1) return;
    if ([m_filterRules containsObject: aFilter])
    {
        var filterView = [aFilter filterView];
        [filterView removeFromSuperview];
        [m_filterRules removeObject: aFilter];
        [self redrawFilters];
    }
}

- (void) cancel:(id)aSender
{
    CPLog.debug(" TrFilterManager cancel:" );
    [m_window close];
}

- (void) save:(id)aSender
{
    CPLog.debug(" TrFilterManager save:" );
    var qual = [m_qualifier titleOfSelectedItem];
    var desc = [m_description stringValue];

    CPLog.debug ("m_qualifier: " + qual);
    CPLog.debug ("m_description: " + desc);
    [m_window close];
}

- (void) redrawFilters
{
    CPLog.debug(" TrFilterManager redrawFilters: ");
    if ( m_filterRules.length <=0) return;
    
    var filterRule = [m_filterRules lastObject];
    var filterView = [filterRule filterView];
    var filterFrame = [filterView frame];
    var filterOrigin = filterFrame.origin;
    var filterSize = filterFrame.size;
    
    for (var i=0; i<m_filterRules.length; i++)
    {
        filterRule = [m_filterRules objectAtIndex:i];
        filterView = [filterRule filterView];
        filterOrigin.y = m_filterOffset * i;
        
        [filterView setFrameOrigin: filterOrigin];
    }
    var frameSize = [m_documentView frame].size;
    frameSize.height = m_filterRules.length * m_filterOffset;
    [m_documentView setFrameSize: frameSize];
    CPLog.trace("redrawFilters: length: " + m_filterRules.length);
    CPLog.trace("redrawFilters: length: " + m_filterRules.length);
    CPLog.trace(boundsString([m_documentView frame], "document frame"));
}

- (void) filterOpened: (TrFilterRule) aFilter
{
    CPLog.debug(" TrFilterManager filterOpened: " + aFilter );
    var filterRule = aFilter;

    var filterView = [filterRule filterView];
    var filterFrame = [filterView frame];
    var filterOrigin = filterFrame.origin;
    if ( m_filterOffset == 0 )
        m_filterOffset = Math.max(m_filterOffset, CGRectGetHeight(filterFrame) + 2);
    
    filterOrigin.y = m_filterOffset * m_filterRules.length;
    [filterView setFrameOrigin: filterOrigin];
    [m_documentView addSubview: filterView];

    [m_filterRules addObject: filterRule];
    
    [self redrawFilters];
}

- (void)cibDidFinishLoading:(CPCib)aCib
{
    CPLog.debug("TrFilterManager cibDidFinishLoading: "+ aCib);
}

- (void) loadCibFile: aDelegate
{
    CPLog.debug("TrFilterManager:loadCibFile: " + aDelegate);

    var mainBundle = [CPBundle mainBundle];

    [mainBundle loadCibFile:"FilterGenerator.cib"
        externalNameTable:[CPDictionary dictionaryWithObject:self forKey:CPCibOwner]
             loadDelegate:aDelegate];

}


@end
