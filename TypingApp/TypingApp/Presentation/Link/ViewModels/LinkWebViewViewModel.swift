//
//  LinkWebViewModel.swift
//  TypingApp
//
//  Created by 권하은 on 2/12/25.
//

import Foundation
import Combine

final class LinkWebViewViewModel {
    private let urlString: String
    private let urlRequestSubject = PassthroughSubject<URLRequest, Never>()
    
    var urlRequest: AnyPublisher<URLRequest, Never> {
        urlRequestSubject.eraseToAnyPublisher()
    }
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func loadWebPage() {
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        urlRequestSubject.send(request)
    }
}
