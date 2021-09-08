//
//  RemoteDataSource.swift
//  fjs
//
//  Created by Dan Ackerman on 9/8/21.
//

import Foundation
import Combine
import os.log

class RemoteDataSource {
    
    private var Api = ApiRequest.shared

    private let baseURL = "https://raw.githubusercontent.com/PFJCodeChallenge/pfj-locations/master/locations.json"

    private var subscriptions: Set<AnyCancellable> = []
    
    private func dataTaskPublisher(for url: URL) -> AnyPublisher<Data, URLError> {
      URLSession.shared.dataTaskPublisher(for: url)
        .compactMap { data, response -> Data? in
          guard let httpResponse = response as? HTTPURLResponse else {
            os_log(.error, log: OSLog.default, "Data download had no http response")
            return nil
          }
          guard httpResponse.statusCode == 200 else {
            os_log(.error, log: OSLog.default, "Data download returned http status: %d", httpResponse.statusCode)
            return nil
          }
            
          return data
        }
        .eraseToAnyPublisher()
    }

    func fetchLocations(completion: @escaping([LocationModel]?, _ error: Error?) -> ()) {
             
        let target = (baseURL)
                
        let apikey = ""

        Api.get(ApiKey: apikey, targetURL: target, associatedtype: [LocationModel].self) { result in
            switch result {
            case .success(let response):
                completion(response, nil)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
