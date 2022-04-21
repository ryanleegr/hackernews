//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by ryan lee on 4/20/22.
//

import Foundation

class NetworkManager: ObservableObject {
    
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search_by_date?tags=story") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                    let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                            
                        } catch {
                            print(error)
                            }
                        }
                }
            }
            task.resume()
        }
    }
}
