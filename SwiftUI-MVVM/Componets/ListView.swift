//
//  ListView.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Foundation
import SwiftUI

struct ListView<ViewModel, Model, Cell>: View where Model: Codable & Identifiable & Hashable,
                                                    Cell: View,
                                                    ViewModel: BaseViewModel<Model>,
                                                    ViewModel: ViewModelLoadProtocol {
    
    private(set) var viewModel: ViewModel
    private(set) var cellProvider: (Model) -> Cell
    
    var body: some View {
        List(viewModel.models) { model in
            cellProvider(model)
                .onAppear {
                    if model == viewModel.models.last {
                        viewModel.nextState()
                    }
                }
        }.onAppear {
            viewModel.nextState()
        }
    }
}
