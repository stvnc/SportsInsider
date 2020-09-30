//
//  NetworkLayer.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 21/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

class NetworkLayer{
    static var shared = NetworkLayer()
    
    private init(){}
    
    let session = URLSession.shared
    
    // team by name, player by name, event by name search
    
    // for time being, we'll use method overloading to fetch datas 
    
    func fetchBySearch(searchParameter: String, searchName: String, completion: @escaping(TeamResults) -> Void)  {
        
        let searchName = searchName.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string:            "https://www.thesportsdb.com/api/v1/json/1/search\(searchParameter).php?\(Array(searchParameter)[0].lowercased())=\(searchName)") else { return }
        
        print("PLAYER URL: \(url)")
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                return
            }
            
            do {
                let dataList = try JSONDecoder().decode(TeamResults.self, from: data)
                //                print("SportsList = \(sportsList.sports)")
                DispatchQueue.main.async {
                    completion(dataList)
                }
            }catch {
                print("ERROR! \(error.localizedDescription)")
                return
            }
        }.resume()
        
        
    }
    
    func fetchBySearch(searchParameter: String, searchName: String, completion: @escaping(PlayerResults) -> Void)  {
        
        let searchName = searchName.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string:            "https://www.thesportsdb.com/api/v1/json/1/search\(searchParameter).php?\(Array(searchParameter)[0].lowercased())=\(searchName)") else { return }
        
        print("PLAYER URL: \(url)")
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                return
            }
            
            do {
                let dataList = try JSONDecoder().decode(PlayerResults.self, from: data)
                //                print("SportsList = \(sportsList.sports)")
                DispatchQueue.main.async {
                    completion(dataList)
                }
            }catch {
                print("ERROR! \(error.localizedDescription)")
                return
            }
        }.resume()
        
        
    }
    
    func fetchBySearch(searchParameter: String, searchName: String, completion: @escaping(EventResults) -> Void)  {
        
        let searchName = searchName.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string:            "https://www.thesportsdb.com/api/v1/json/1/search\(searchParameter).php?\(Array(searchParameter)[0].lowercased())=\(searchName)") else { return }
        
        print("PLAYER URL: \(url)")
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                return
            }
            
            do {
                let dataList = try JSONDecoder().decode(EventResults.self, from: data)
                //                print("SportsList = \(sportsList.sports)")
                DispatchQueue.main.async {
                    completion(dataList)
                }
            }catch {
                print("ERROR! \(error.localizedDescription)")
                return
            }
        }.resume()
        
        
    }
    
    // fetch all sports https://www.thesportsdb.com/api/v1/json/1/all_sports.php
    
    func fetchAllSports(completion: @escaping(SportsResult) -> Void, errorHandler: @escaping(Error) -> Void){
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/all_sports.php") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }
            
            do {
                let sportsList = try JSONDecoder().decode(SportsResult.self, from: data)
                //                print("SportsList = \(sportsList.sports)")
                DispatchQueue.main.async {
                    completion(sportsList)
                }
            }catch {
                print("ERROR!")
                return
            }
        }.resume()
    }
    
    // fetch all leagues https://www.thesportsdb.com/api/v1/json/1/all_leagues.php
    
    func fetchAllLeagues(completion: @escaping(LeagueResult) -> Void, errorHandler: @escaping(Error) -> Void){
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }
            
            do {
                let leaguesList = try JSONDecoder().decode(LeagueResult.self, from: data)
                print(leaguesList)
                DispatchQueue.main.async {
                    completion(leaguesList)
                }
            }catch {
                print("ERRORS: \(error.localizedDescription)")
                return
            }
        }.resume()
    }
    
    // fetch all countries https://www.thesportsdb.com/api/v1/json/1/all_countries.php
    
    func fetchAllCountries(completion: @escaping([Countries]) -> Void, errorHandler: @escaping(Error) -> Void){
        
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }
            
            do {
                let countriesList = try JSONDecoder().decode([Countries].self, from: data)
                DispatchQueue.main.async {
                    completion(countriesList)
                }
            }catch {
                return
            }
        }.resume()
    }
    
    func fetchAllEvents(completion: @escaping(EventResults) -> Void, errorHandler: @escaping(Error) -> Void) {
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/eventsnextleague.php?id=4328") else { return }
        
        print("Event URL: \(url)")
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print("Error in event: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }
            
            do {
                let eventsList = try JSONDecoder().decode(EventResults.self, from: data)
                print("List of Events = \(eventsList.events.count)")
                DispatchQueue.main.async {
                    completion(eventsList)
                }
            }catch {
                print("Error in event: \(error.localizedDescription)")
                return
            }
        }.resume()
    }
    
    // For future goals, this will be generic by conforming to ResultProtocol
    func fetchTeamBySpecificID(id: String, completion: @escaping(TeamResults) -> Void, errorHandler: @escaping(Error) -> Void) {
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=\(id)") else { return }
        
        print("Event URL: \(url)")
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print("Error in event: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }
            
            do {
                let teamData = try JSONDecoder().decode(TeamResults.self, from: data)
                DispatchQueue.main.async {
                    completion(teamData)
                }
            }catch {
                print("Error in team: \(error.localizedDescription)")
                return
            }
        }.resume()
    }
}
