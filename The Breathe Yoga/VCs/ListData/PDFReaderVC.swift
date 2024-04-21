//
//  PDFReaderVC.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 30/06/21.
//

import WebKit
import UIKit

class PDFReaderVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var exportButton:UIButton!{
        didSet{
            exportButton.clipsToBounds = true
            exportButton.layer.cornerRadius = exportButton.bounds.height/2
        }
    }
    
    var url:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
    
    @IBAction func exportAction(sender:UIButton){
        if let url = url {
            let documento = NSData(contentsOf: url)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("document was not found")
        }
    }
    
}
