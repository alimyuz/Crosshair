//
//  AppDelegate.swift
//  Crosshair
//
//  Created by Alim Yuzbashev on 16.05.2022.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var overlayWindow: NSWindow!
    // 1
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let frame = NSScreen.main!.frame
        
        overlayWindow = NSWindow(contentRect: frame, styleMask: .borderless, backing: .buffered, defer: false)
        //overlayWindow.level =  //NSWindow.Level(rawValue: Int(CGWindowLevelForKey()))
        overlayWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenPrimary]
        overlayWindow.contentViewController = OverlayViewController()
        overlayWindow.ignoresMouseEvents = true
        
        overlayWindow.makeKeyAndOrderFront(nil)
        
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        popover = NSPopover()
        popover.contentViewController = ViewController()
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.behavior = .transient
        popover.animates = true
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "1.circle", accessibilityDescription: "1")
            button.action = #selector(statusItemToggle)
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @objc
    private func statusItemToggle(_ sender: NSStatusBarButton) {
        self.popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY)
    }
}
