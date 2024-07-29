//
//  VideoManager.swift
//  Qarva
//
//  Created by Guga Valashvili on 27.07.24.
//

import UIKit

struct VideoManager {
    
    func fetchVideos(completion: @escaping(VideoModel) -> Void) {
        
        guard let url = URL(string: "https://vodinfo-prod01.silktv.ge/ka/load") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error Fetch Videos: \(error.localizedDescription)")
            }
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(VideoModel.self, from: jsonData)
                completion(decodedData)
            } catch {
                print("Error Decoding Data")
            }
        }
        dataTask.resume()
    }
}
