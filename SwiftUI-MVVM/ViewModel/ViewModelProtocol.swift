//
//  ViewModelProtocol.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Combine
import SwiftUI

typealias ViewModelProtocol = BaseDataProtocol & ViewModelLoadProtocol & ViewModelLoadFuncProtocol & ObservableObject

extension ViewModelLoadProtocol where Self: BaseDataProtocol, Self: ViewModelLoadFuncProtocol {
    
    func nextState() {
        switch state {
        case .initialize, .loadFail, .refreshLoading:
            state = .loadStart
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
                case .finished: self.state.success()
                case .failure: self.state.failure()
                }
            },
            receiveValue: { [weak self] models in
                guard let self = self else { return }
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
