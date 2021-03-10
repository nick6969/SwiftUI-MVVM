//
//  APIClient-PetInfo.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/10/21.
//

import Foundation
import Combine

protocol APIPetInfoProtocol {
    func petInfo(skip: Int) -> AnyPublisher<[PetPriceModel], Error>
}

extension APIClient: APIPetInfoProtocol {

    func petInfo(skip: Int) -> AnyPublisher<[PetPriceModel], Error> {
        guard let url = URL(string: "https://agridata.coa.gov.tw/api/v1/PorkTransType?$skip=\(skip)&TransDate=1100309&$top=10") else {
            return Fail(error: ApiError.badURL).eraseToAnyPublisher()
        }
        let transform: (PetResult) -> [PetPriceModel] = { $0.data }
        return run(URLRequest(url: url), transform: transform)
    }
    
}
