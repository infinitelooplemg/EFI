//
//  CCTApiService.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 26/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import Disk

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
                DispatchQueue.main.async {
                    completion(nil,responseError)
                }
                return
            }
            do {
                
                let response = try JSONDecoder().decode(DeleteMeasurerResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
                
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
                DispatchQueue.main.async {
                    completion(nil,responseError)
                }
                return
            }
            do {
                
                let response = try JSONDecoder().decode(NewMeasurerResponse.self, from: data)
                print(response)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }
        
        task.resume()
    }
    
    func fetchStates(completion: @escaping (_ results: [State]?, _ error: Error?) -> ()){
        if Disk.exists("estados.json", in: .documents){
            do{
                let states = try Disk.retrieve("estados.json", from: .documents, as: [State].self)
                completion(states,nil)
            } catch{
                
            }
        } else {
            
            components.path = "/api/ios/v1/estados"
            
            guard let url = components.url else { fatalError("Could not create URL from components") }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                
                
                guard let data = responseData else {
                    completion(nil,responseError)
                    return
                }
                
                do {
                    let Container = try JSONDecoder().decode(States.self, from: data)
                    DispatchQueue.main.async {
                        do {
                            try Disk.save(Container.Estados, to: .documents, as: "estados.json")
                        } catch {
                            
                        }
                        completion(Container.Estados,nil)
                    }
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            task.resume()
            
        }
    }
    
    
    func fetchCounties(by state:State, completion: @escaping (_ results: [County]?, _ error: Error?) -> ()){
        
        let name = state.Nombre
        if Disk.exists("\(name)counties.json", in: .documents){
            do{
                let counties = try Disk.retrieve("\(name)counties.json", from: .documents, as: [County].self)
                completion(counties,nil)
            } catch{
                
            }
        } else {
            components.path = "/api/ios/v1/municipios"
            
            guard let url = components.url else { fatalError("Could not create URL from components") }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            var headers = request.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = headers
            
            
            let parameter = CountyRequestParameters(ClaveEstado: state.Clave)
            request.httpBody = encodeToJson(parameters: parameter)
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                
                
                guard let data = responseData else {
                    completion(nil,responseError)
                    return
                }
                do {
                    
                    let Container = try JSONDecoder().decode(Counties.self, from: data)
                    DispatchQueue.main.async {
                        do {
                            try Disk.save(Container.Municipios, to: .documents, as: "\(name)counties.json")
                        } catch {
                            
                        }
                        completion(Container.Municipios,nil)
                    }
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            
            
            task.resume()
            
        }
    }
    
    
    func fetchElectricalDivision(by state:State,county:County, completion: @escaping (_ results: [ElectricalDivision]?, _ error: Error?) -> ()){
        components.path = "/api/ios/v1/divisionesElectricas"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        let parameter = ElectricalDivisionRequestParameters(ClaveEstado: state.Clave, ClaveMunicipio: county.Clave)
        request.httpBody = encodeToJson(parameters: parameter)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            DispatchQueue.main.async {
                guard let data = responseData else {
                    
                    completion(nil,responseError)
                    return
                }
                
                
                do {
                    
                    let divisions = try JSONDecoder().decode(ElectricalDivisions.self, from: data)
                    
                    completion(divisions.DivisionesElectricas,nil)
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        }
        
        task.resume()
    }
    
    func fetchCRERates( completion: @escaping (_ results: [CRERate]?, _ error: Error?) -> ()){
        components.path = "/api/ios/v1/tarifasCRE"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            DispatchQueue.main.async {
                guard let data = responseData else {
                    
                    completion(nil,responseError)
                    return
                }
                
                
                
                do {
                    
                    let divisions = try JSONDecoder().decode(TarifasCRE.self, from: data)
                    completion(divisions.TarifasCRE,nil)
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        }
        
        task.resume()
    }
    
    func newUserLocation(parameter:NewLocationRequestParameters, completion: @escaping (_ results: NewLocationResponse?, _ error: Error?) -> ()){
        components.path = "/api/ios/v1/localizacion"
        
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
            
            DispatchQueue.main.async {
                guard let data = responseData else {
                    
                    completion(nil,responseError)
                    return
                }
                
                let cadena = String(data: data, encoding: .utf8)
                do {
                    
                    let response = try JSONDecoder().decode(NewLocationResponse.self, from: data)
                    completion(response,nil)
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        }
        
        task.resume()
    }
    
    func fetchHistoricalActivityBy(_ day:Date,measurer:Measurer,and electricalVariable:ElectricalVariables, completion: @escaping (_ results: [MeasurerRecord]?, _ error: Error?) -> ()){
        components.path =  "/api/ios/v1/historico"
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        let dateString = dateFormatter.string(from: day)
        var parameters = RecordsByDayRequestParameters()
        parameters.ClaveMedidor = measurer.Clave
        parameters.FechaGrafica = dateString
        parameters.TipoGrafica = electricalVariable.rawValue
        
        request.httpBody = encodeToJson(parameters: parameters)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            DispatchQueue.main.async {
                
                guard let data = responseData else {
                    completion(nil,responseError)
                    return
                }
                
                
                do {
                    let response = try JSONDecoder().decode(RecordsByDayResponse.self, from: data)
                    let records = response.Respuesta?.Registros
                    
                    completion(records,nil)
                } catch let jsonErr {
                }
            }
            
        }
        
        task.resume()
    }
    
    func fetchLocationsList(completion: @escaping (_ results:LocationsListResponse?,_ error: Error?)->()) {
        components.path =  "/api/ios/v1/listamedidores"
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        
        let parameters = LocationsListRequestParameters()
       
        request.httpBody = encodeToJson(parameters: parameters)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            DispatchQueue.main.async {
                
                guard let data = responseData else {
                    completion(nil,responseError)
                    return
                }
                
                
                do {
                    let response = try JSONDecoder().decode(LocationsListResponse.self, from: data)
                    completion(response,nil)
                } catch let jsonErr {
                }
            }
            
        }
        
        task.resume()

    }
    
    
    func delete(location:Location, completion: @escaping(_ results: DeleteLocationResponse?, _ error: Error?)->()) {
        components.path =  "/api/ios/v1/localizacion"
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let parameters = DeleteLocationParameters()
        parameters.ClaveLocalizacion = location.Clave!
        request.httpBody = encodeToJson(parameters: parameters)
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard let data = responseData else {
                DispatchQueue.main.async {
                    
                    completion(nil,responseError)
                }
                return
            }
            do {
                let response = try JSONDecoder().decode(DeleteLocationResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(response,nil)
                }
                
            } catch let jsonErr {
            }
        }
        
        task.resume()
    }
    
    
    func fetchInstantDataFor(measurer:Measurer? ,completion: @escaping (_ results: InstantActivity?, _ error: Error?) -> ()){
        
        components.path = "/api/ios/v1/ins"
        
        guard let url = components.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        var parameters = InstantActivityRequestParameters()
        parameters.NS = "ABC-0004"
        
        request.httpBody = encodeToJson(parameters: parameters)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            DispatchQueue.main.async {
                guard let data = responseData else {
                    completion(nil,responseError)
                    return
                }
                
                do {
                    
                    let instantActivityResponse = try JSONDecoder().decode(InstantActivityResponse.self, from: data)
                    
                    if let instantActivity = instantActivityResponse.Respuesta {
                        completion(instantActivity,nil)
                    }
                    
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        }
        
        task.resume()
    }
}


