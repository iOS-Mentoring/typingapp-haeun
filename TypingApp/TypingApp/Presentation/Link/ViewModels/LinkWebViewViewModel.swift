//
//  LinkWebViewModel.swift
//  TypingApp
//
//  Created by 권하은 on 2/12/25.
//

import Foundation
import Combine

struct LinkWebViewViewModelInput: ViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
}

struct LinkWebViewViewModelOutput: ViewModelOutput {
    let urlRequest: AnyPublisher<URLRequest, Never>
}

final class LinkWebViewViewModel: ViewModelProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    
    typealias Input = LinkWebViewViewModelInput
    typealias Output = LinkWebViewViewModelOutput
    
    private let urlString: String
    private let urlRequestSubject = PassthroughSubject<URLRequest, Never>()
    
    var urlRequest: AnyPublisher<URLRequest, Never> {
        urlRequestSubject.eraseToAnyPublisher()
    }
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func transform(input: LinkWebViewViewModelInput) -> LinkWebViewViewModelOutput {
        input.viewDidLoad
            .sink { [weak self] in
                self?.loadWebPage()
            }
            .store(in: &cancellables)
        
        return Output(
            urlRequest: urlRequestSubject.eraseToAnyPublisher()
        )
    }
    
    private func loadWebPage() {
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        urlRequestSubject.send(request)
    }
}
