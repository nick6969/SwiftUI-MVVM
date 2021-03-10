//
//  PetInfoView.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/10/21.
//

import SwiftUI

struct PetInfoView: View {
    
    @StateObject var viewModel = PetInfoViewModel()
    
    var body: some View {
        BaseListStack(viewModel: viewModel,
                       cellProvider: { model in
                        cellProvider(model: model)
                       },
                       errorViewProvider: { _ in
                        Text("error")
                       })
        
    }
    
    func cellProvider(model: PetPriceModel) -> AnyView {
        if model.id % 2 == 0 {
            return AnyView(Text(model.transDate + "-" + model.marketName + "- \(model.transNumAvgPrice)"))
        } else {
            return AnyView(Button(model.marketName) {
                print("click \(model.marketName)")
            })
        }
    }
    
}
