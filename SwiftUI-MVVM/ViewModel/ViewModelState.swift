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
