//
//  ViewModelProtocol.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Combine
import SwiftUI

typealias ViewModelProtocol = BaseDataProtocol & ViewModelLoadProtocol & ObservableObject

extension ViewModelLoadProtocol where Self: BaseDataProtocol {
    
    func nextState() {
        switch state {
        case .initialize, .loadFail, .refreshLoading:
            state = .loadStart
            isLoading = true
            process(loadData())
            
        case .loadDone, .loadMoreDone, .loadMoreFail:
            state = .loadMoreStart
            process(loadDataMore())
            
        case .loadStart, .loadMoreStart, .noMoreCanLoad:
            break
        }
    }
    
    func refreshState() {
        guard state != .loadStart else { return }
        state = .refreshLoading
        nextState()
    }
    
    private
    func process(_ publisher: AnyPublisher<[Model], Error>) {
        publisher
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .finished:
                    switch self.state {
                    case .loadStart:
                        self.error = nil
                        self.isLoading = false
                        self.state = .loadDone
                    case .loadMoreStart:
                        self.error = nil
                        self.state = .loadMoreDone
                    default: break
                    }
                case let .failure(error):
                    switch self.state {
                    case .loadStart:
                        self.state = .loadFail
                        self.isLoading = false
                        self.error = error
                    case .loadMoreStart:
                        self.state = .loadMoreFail
                        self.error = error
                    default: break
                    }
                }
            },
            receiveValue: { [weak self] models in
                guard let self = self else { return }
                self.isLoading = false
                switch self.state {
                case .loadStart:
                    if models.isEmpty {
                        self.state = .noMoreCanLoad
                    } else {
                        self.models = models
                    }
                case .loadMoreStart:
                    if models.isEmpty {
                        self.state = .noMoreCanLoad
                    } else {
                        self.models.append(contentsOf: models)
                    }
                default: break
                }
            })
            .store(in: &disposables)
    }
    
}
