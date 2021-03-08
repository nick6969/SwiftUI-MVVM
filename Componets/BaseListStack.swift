//
//  BaseListStack.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/8/21.
//

import SwiftUI

struct BaseListStack<ViewModel, Model, Cell>: View where Model: Codable & Identifiable & Hashable,
                                                         Cell: View,
                                                         ViewModel: BaseViewModel<Model>,
                                                         ViewModel: ViewModelLoadProtocol {
    
    private(set) var viewModel: ViewModel
    private(set) var cellProvider: (Model) -> Cell
    private(set) var errorViewProvider: (Error) -> Cell

    var body: some View {
        ZStack(alignment: .center) {
            List(viewModel.models) { model in
                cellProvider(model).onAppear {
                    if model == viewModel.models.last { viewModel.nextState() }
                }
            }.onAppear { viewModel.nextState() }
            if let error = viewModel.error {
                errorViewProvider(error)
            }
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
    
}
