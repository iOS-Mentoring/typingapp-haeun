//
//  LinkWebViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/12/25.
//

import UIKit
import WebKit
import Combine

class LinkWebViewController: UIViewController {
    private let webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let viewModel: LinkWebViewViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: LinkWebViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadWebPage()
    }
    
    private func setupUI() {
        view.addSubview(webView, autoLayout: [.bottomSafeArea(0), .leadingSafeArea(0), .trailingSafeArea(0), .topSafeArea(0)])
    }
    
    private func bindViewModel() {
        viewModel.urlRequest
            .receive(on: DispatchQueue.main)
            .sink { [weak self] request in
                self?.webView.load(request)
            }
            .store(in: &cancellables)
    }
}
