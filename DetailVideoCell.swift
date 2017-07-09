//
//  DetailVideoCell.swift
//  
//
//  Created by Nikolay Revin on 19.06.17.
//  Copyright © 2017 Nikolay Revin. All rights reserved.
//

import UIKit

class DetailVideoCell: UITableViewCell {

    @IBOutlet weak var webView: UIWebView!
    
    var type: VideoType!
    var id: String! {
        didSet {
            load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.allowsInlineMediaPlayback = false
        URLCache.shared.removeAllCachedResponses()
    }
    
    func load() {
        guard let type = type, let id = id, let url = URL(string: String(format: type.url, id)) else { return }
        webView.loadRequest(URLRequest(url: url))
    }
    
    func loadIframe() {
        guard let type = type, let id = id, let url = URL(string: String(format: type.url, id)) else { return }
        webView.loadHTMLString("<iframe width=\"100%\" height=\"\(webView.frame.size.height*3)\" src=\"\(url)?autoplay=1\" frameBorder=\"0\" scrolling=\"no\" allowfullscreen webkitAllowFullScreen mozallowfullscreen></iframe>", baseURL: nil)
    }
    
    deinit {
        webView.loadHTMLString("", baseURL: nil)
        if webView.isLoading {
            webView.stopLoading()
        }
        webView.delegate = nil
        webView.removeFromSuperview()
    }
}
