//
//  Publisher+Tiollo.swift
//  Tiollo
//
//  Created by Moll, Eduardo on 12/17/19.
//  Copyright © 2019 Moll, Eduardo. All rights reserved.
//

import Foundation
import Combine

extension Publisher {
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return receive(on: DispatchQueue.main).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                result(.failure(error))
            default:
                break
            }
        },  receiveValue: {
            result(.success($0))
        })
    }
}
