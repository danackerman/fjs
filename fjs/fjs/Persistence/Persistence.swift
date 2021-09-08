//
//  Persistence.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//

import CoreData
import Combine
import os.log

class PersistenceController: ObservableObject  {
    private static let authorName = "fjs"
    private static let remoteDataImportAuthorName = "fjs Data Import"
   
    static let shared = PersistenceController()
    private var Api = ApiRequest.shared

    
    private var subscriptions: Set<AnyCancellable> = []

    var places = PassthroughSubject<[LocationModel], Never>()


    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<1 {
            let newItem = Location(context: viewContext)
            newItem.storeNo =  1
            newItem.latitude = 35.99996
            newItem.longitude = -83.777618
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "fjs")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func fetchLocations(completion: @escaping([LocationModel]?, _ error: Error?) -> ()) {
        
        let baseURL = "https://raw.githubusercontent.com/PFJCodeChallenge/pfj-locations/master/locations.json"
        
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

    private func batchInsertLocations(_ locations: [LocationModel]) {

        guard !locations.isEmpty else { return }

      os_log(
        .info,
        log: .default,
        "Batch inserting \(locations.count) locations")

      container.performBackgroundTask { context in
        context.transactionAuthor = PersistenceController.remoteDataImportAuthorName
        let batchInsert = self.newBatchInsertRequest(with: locations)
        do {
          try context.execute(batchInsert)
          os_log(.info, log: .default, "Finished batch inserting \(locations.count) fireballs")
        } catch {
          let nsError = error as NSError
          os_log(.error, log: .default, "Error batch inserting locations %@", nsError.userInfo)
        }
      }
    }

    private func newBatchInsertRequest(with locations: [LocationModel]) -> NSBatchInsertRequest {
        var index = 0
        let total = locations.count
        let batchInsert = NSBatchInsertRequest(
            entity: Location.entity()) { (managedObject: NSManagedObject) -> Bool in
            guard index < total else { return true }

            if let location = managedObject as? Location {
                let data = locations[index]
                location.storeNo = data.storeNo
            }

            index += 1
            return false
        }
        
        return batchInsert
    }
}
