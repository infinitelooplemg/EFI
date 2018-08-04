//
//  CCTApiService.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 26/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

final class CCTApiService {
    
    var components = URLComponents()
    
    init() {
        components.scheme = "http"
        components.host = "api2.energiacon100t.mx"
    }
    
    func encodeToJson<T:Codable>(parameters:T)-> Data? {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(parameters)
            return jsonData
        } catch {
            return nil
        }
    }
    
    func fetchLocations(completion: @escaping (_ results: [Location]?, _ error: Error?) -> ()) {
        components.path = "/api/ios/v1/localizaciones"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let parameter = LocationsRequestParameters()
        
        request.httpBody = encodeToJson(parameters: parameter)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard let data = responseData else {
                completion(nil,responseError)
                return
            }
            do {
                let Container = try JSONDecoder().decode(LocationsResponse.self, from: data)
                completion(Container.Localizaciones,nil)
            } catch let jsonErr {
                print(jsonErr)
            }
        }
        task.resume()
        
    }
    
    func fetchMeasurers(for location:Location,completion: @escaping (_ results: [Measurer]?, _ error: Error?) -> ()){
        
        components.path = "/api/ios/v1/medidores"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        var parameter = MeasurersRequestParameters()
        parameter.ClaveLocalizacion = location.Clave
        
        request.httpBody = encodeToJson(parameters: parameter)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            guard let data = responseData else {
                completion(nil,responseError)
                return
            }
            DispatchQueue.main.async {
                do {
                    let dat = String(data: data, encoding: .utf8)
                    
                    let Container = try JSONDecoder().decode(MeasurersResponse.self, from: data)
                    completion(Container.Medidores,nil)
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        }
        task.resume()
    }
    
    
    func delete(measurer:Measurer,for location:Location, completion: @escaping (_ results: DeleteMeasurerResponse?, _ error: Error?) ->()) {
        
        components.path = "/api/ios/v1/medidor"
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        var parameters = DeleteMeasurerRequestParameters()
        parameters.NS = measurer.Clave
        parameters.ClaveLocalizacion = location.Clave!
        request.httpBody = encodeToJson(parameters: parameters)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            guard let data = responseData else {
                completion(nil,responseError)
                return
            }
            do {
                
                let response = try JSONDecoder().decode(DeleteMeasurerResponse.self, from: data)
                print(response)
                completion(response,nil)
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }
        
        task.resume()
    }
    
    func newMeasurer(parameter:RegisterMeasurerRequestParameters, completion: @escaping (_ results: NewMeasurerResponse?, _ error: Error?) -> ()){
        components.path = "/api/ios/v1/medidor"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        request.httpBody = encodeToJson(parameters: parameter)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
    
                guard let data = responseData else {
                    
                    completion(nil,responseError)
                    return
                }
                do {
                    
                    let response = try JSONDecoder().decode(NewMeasurerResponse.self, from: data)
                    
                    completion(response,nil)
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            
        }
        
        task.resume()
    }
}


