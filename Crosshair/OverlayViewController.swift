//
//  OverlayViewController.swift
//  Crosshair
//
//  Created by Alim Yuzbashev on 16.05.2022.
//

import AppKit


class OverlayViewController: NSViewController {
    
    private let imageView: NSImageView = {
        let imageView = NSImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func loadView() {
        let frame = NSScreen.main!.frame
        view = NSView(frame: frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.clear.cgColor
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "image.updated"), object: nil, queue: .main, using: { [weak self] notification in
            self?.imageView.image = self?.crosshairImage()
        })
    }
    
    override func viewDidAppear() {
        view.window?.backgroundColor = .clear
        view.window?.isOpaque = false
        
        imageView.image = crosshairImage()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func crosshairImage() -> NSImage? {
        // image
        guard let data = UserDefaults.standard.data(forKey: "image.data") else { return nil }
        
        let image = NSImage(data: data)
        
        // size
        let size = UserDefaults.standard.integer(forKey: "image.size")
        image?.size = NSSize(width: size, height: size)
        
        // opacity
        let opacity = UserDefaults.standard.double(forKey: "image.opacity")
        imageView.alphaValue = CGFloat(opacity)
        
        return image
    }
}
