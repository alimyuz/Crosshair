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
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let frame = NSScreen.main!.frame
        
        overlayWindow = NSWindow(contentRect: frame, styleMask: .borderless, backing: .buffered, defer: false)
        overlayWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        overlayWindow.contentViewController = OverlayViewController()
        overlayWindow.ignoresMouseEvents = true
        overlayWindow.level = .floating
        
        overlayWindow.makeKeyAndOrderFront(nil)
        
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        popover = NSPopover()
        popover.contentViewController = ViewController()
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.behavior = .transient
        popover.animates = true
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "xmark.circle", accessibilityDescription: "crosshair app")
            button.action = #selector(statusItemClick)
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @objc
    private func statusItemClick(_ sender: NSStatusBarButton) {
        self.popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY)
    }
}
