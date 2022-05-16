//
//  ViewController.swift
//  Crosshair
//
//  Created by Alim Yuzbashev on 16.05.2022.
//

import AppKit


class ViewController: NSViewController {
    
    private lazy var openFileButton: NSButton = {
        let button = NSButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Select file"
        button.action = #selector(openFileClicked)
        return button
    }()
    
    private lazy var sizeSlider: NSSlider = {
        let size = UserDefaults.standard.integer(forKey: "image.size")
        let slider = NSSlider(value: Double(size), minValue: 1, maxValue: 200, target: self, action: #selector(sliderChanged))
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    override func loadView() {
        view = NSView(frame: NSMakeRect(0.0, 0.0, 400.0, 270.0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        
        view.addSubview(openFileButton)
        NSLayoutConstraint.activate([
            openFileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openFileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            openFileButton.heightAnchor.constraint(equalToConstant: 50),
            openFileButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        view.addSubview(sizeSlider)
        NSLayoutConstraint.activate([
            sizeSlider.topAnchor.constraint(equalTo: openFileButton.bottomAnchor, constant: 30),
            sizeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sizeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    @objc
    private func openFileClicked() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        
        let i = openPanel.runModal();
        
        if i == .OK {
            let url = openPanel.url!
            let data = try? Data(contentsOf: url)
            
            UserDefaults.standard.set(data, forKey: "image.data")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "image.updated"), object: nil)
        }
    }
    
    @objc
    private func sliderChanged(_ sender: NSSlider) {
        UserDefaults.standard.set(sender.intValue, forKey: "image.size")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "image.updated"), object: nil)
    }
}
