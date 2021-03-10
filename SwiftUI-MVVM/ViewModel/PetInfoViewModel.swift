//
//  PetInfoViewModel.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/10/21.
//

import Foundation
import Combine

final class PetInfoViewModel: BaseViewModel<PetPriceModel>, ViewModelProtocol {
    
    private let client: APIPetInfoProtocol
    
    init(client: APIPetInfoProtocol = APIClient.shared) {
        self.client = client
        super.init()
    }
    
    func loadData() -> AnyPublisher<[PetPriceModel], Error> {
        client.petInfo(skip: models.count)
    }
    
    func loadDataMore() -> AnyPublisher<[PetPriceModel], Error> {
        client.petInfo(skip: models.count)
    }
    
}
