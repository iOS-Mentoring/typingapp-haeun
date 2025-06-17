//
//  LinkWebViewController.swift
//  TypingApp
//
//  Created by 권하은 on 2/12/25.
//

import UIKit
import WebKit
import Combine

final class LinkWebViewController: UIViewController {
    private let webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let viewModel: LinkWebViewViewModel
    private let viewDidLoadTrigger = PassthroughSubject<Void, Never>()
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
        bind()
    }
    
    private func setupUI() {
        view.addSubview(webView, autoLayout: [.bottomSafeArea(0), .leadingSafeArea(0), .trailingSafeArea(0), .topSafeArea(0)])
    }
    
    private func bind() {
        let input = LinkWebViewViewModelInput(
            viewDidLoad: viewDidLoadTrigger.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input: input)
        
        output.urlRequest
            .sink { [weak self] urlRequest in
                guard let self else { return }
                self.webView.load(urlRequest)
            }
            .store(in: &cancellables)
        
        viewDidLoadTrigger.send()
    }
}
