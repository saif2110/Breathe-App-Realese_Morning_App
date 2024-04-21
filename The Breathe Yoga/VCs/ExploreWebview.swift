//
//  ExploreWebview.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 19/06/21.
//

import UIKit
import WebKit

class ExploreWebview: UIViewController {
    
    var image:UIImage = #imageLiteral(resourceName: "ex1")
    var htmlName = "zero"
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        imageVIew.image = image
        let url = Bundle.main.url(forResource: "\(htmlName)", withExtension: "html")!
        let request = URLRequest(url: url)
        webView.load(request)
        
        
        self.imageVIew.layer.masksToBounds = true
        self.imageVIew.layer.cornerRadius = 50
        self.imageVIew.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
extension WKWebView {

    /// load HTML String same font like the UIWebview
    ///
    //// - Parameters:
    ///   - content: HTML content which we need to load in the webview.
    ///   - baseURL: Content base url. It is optional.
    func loadHTMLStringWithMagic(content:String,baseURL:URL?){
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        loadHTMLString(headerString + content, baseURL: baseURL)
    }
}
