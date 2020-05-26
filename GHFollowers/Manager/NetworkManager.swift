//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 10/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import UIKit

struct NetworkManager {
    
    static let shared       = NetworkManager()
    let cache               = NSCache<NSString, UIImage>()
    let baseURL             = "https://api.github.com/users/"
    
    private init() {}
    
    
    func getFollowers(for username: String, pageNo: Int, completionHandler: @escaping (Result<[Follower],GFError>) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(pageNo)"
        
        guard let url = URL(string: endPoint) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let _ = error {
                completionHandler(.failure(.invalidNetworkConnnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    completionHandler(.failure(.invalidResponse))
                    return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completionHandler(.success(followers))
            }
            catch {
                completionHandler(.failure(.invalidDecoding))
            }
        }
        task.resume()
    }
    
    
    func getUserInfo(for username: String, completionHandler: @escaping (Result<User,GFError>) -> Void) {
        let endPoint = baseURL + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let _ = error {
                completionHandler(.failure(.invalidNetworkConnnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    completionHandler(.failure(.invalidResponse))
                    return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let userInfo = try decoder.decode(User.self, from: data)
                completionHandler(.success(userInfo))
            }
            catch {
                completionHandler(.failure(.invalidDecoding))
            }
        }
        task.resume()
    }

    
    func downloadImage(with urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else { completion(nil); return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
                else {
                    completion(nil)
                    return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
