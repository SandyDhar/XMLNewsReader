//
//  DetailViewController.swift
//  XMLNewsReader
//
//  Created by Sudeepth Dharavasthu on 8/1/16.
//  Copyright © 2016 Sudeepth Dharavasthu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var webViewer: UIWebView!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let postwebView = self.webViewer {
                postwebView.loadHTMLString(detail.valueForKey("content")!.description, baseURL: nil)
                //print(detail.valueForKey("content")!.description)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

