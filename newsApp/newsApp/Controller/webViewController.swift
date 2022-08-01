//
//  webViewController.swift
//  newsApp
//
//  Created by kranthi.kumar on 31/07/22.
//

import UIKit
import WebKit

class webViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var Activity: UIActivityIndicatorView!
    @IBOutlet weak var NavigationBar: UIView!
    @IBOutlet weak var webView: WKWebView!
    var urlWebView: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL (string: urlWebView!)
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
        self.webView.addSubview(self.Activity)
        self.Activity.startAnimating()
        self.webView.navigationDelegate = self
        self.Activity.hidesWhenStopped = true
    }
    func setNavigationBar() {
        self.NavigationBar.backgroundColor = .white
        self.NavigationBar.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.NavigationBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.NavigationBar.layer.shadowOpacity = 0.3
        self.NavigationBar.layer.shadowRadius = 3
        self.NavigationBar.clipsToBounds = false
        self.NavigationBar.layer.shouldRasterize = true
        self.NavigationBar.layer.rasterizationScale = UIScreen.main.scale
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Activity.stopAnimating()
    }
   

}
