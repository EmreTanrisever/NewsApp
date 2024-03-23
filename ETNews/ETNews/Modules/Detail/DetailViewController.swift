//
//  DetailViewController.swift
//  ETNews
//
//  Created by Emre Tanrısever on 23.03.2024.
//

import UIKit
import WebKit

protocol DetailViewProtocol: AnyObject {
    func configure()
    func loadWebView()
}

final class DetailViewController: UIViewController {

    var presenter: DetailPresenterProtocol?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
}

extension DetailViewController: DetailViewProtocol {
    
    func configure() {
        view = webView
        webView.addSubview(spinner)
        setConstraints()
    }
    
    func loadWebView() {
        if let urlString = presenter?.returnURL() {
            guard let url = URL(string: urlString) else { return }
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url))
                self.webView.allowsBackForwardNavigationGestures = true
            }
        }
    }
}

extension DetailViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: webView.centerYAnchor)
        ])
    }
    
    private func startAnimating() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    private func stopAnimating() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.startAnimating()
        webView.scrollView.isScrollEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopAnimating()
        webView.scrollView.isScrollEnabled = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.stopAnimating()
        webView.scrollView.isScrollEnabled = true
    }
}
