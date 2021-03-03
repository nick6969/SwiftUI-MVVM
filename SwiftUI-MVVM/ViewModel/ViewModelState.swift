//
//  ViewModelState.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Foundation

public enum ViewModelState {
    case initialize
    case loadStart
    case loadDone
    case loadFail
    case loadMoreStart
    case loadMoreDone
    case loadMoreFail
    case noMoreCanLoad
    case refreshLoading
}

extension ViewModelState {
    
    mutating func success() {
        switch self {
        case .loadStart: self = .loadDone
        case .loadMoreStart: self = .loadMoreDone
        default: break
        }
    }
    
    mutating func failure() {
        switch self {
        case .loadStart: self = .loadFail
        case .loadMoreStart: self = .loadMoreFail
        default: break
        }
    }
    
}
