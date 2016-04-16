//
//  File.swift
//  pokedex
//
//  Created by Casey Lyman on 4/5/16.
//  Copyright © 2016 bearcode. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAtk: String!
    private var _evolutionId: String!
    private var _pokemonUrl: String!
    private var _evolutionLevel: String!
    private var _evolutionName: String!
    
    var evolutionName: String {
        if _evolutionName == nil {
            _evolutionName = ""
        }
        return _evolutionName
    }
    
    var evolutionLevel: String {
        if _evolutionLevel == nil {
            _evolutionLevel = ""
        }
        return _evolutionLevel
    }
    
    var evolutionId: String {
        if _evolutionId == nil {
            _evolutionId = ""
        }
        return _evolutionId
    }
    
    var baseAtk: String {
        if _baseAtk == nil {
            _baseAtk = ""
        }
        return _baseAtk
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init (name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)"
        
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON {response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = "\(name.capitalizedString)"
                    }
                    
                    if types.count > 1 {
                        for ndx in 1...types.count-1 {
                            if let name = types[ndx]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                    
                    print(self._type)
                    
                }
                    
                if let def = dict["defense"] as? Int {
                    self._defense = "\(def)"
                    print(self._defense)
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                    print(self.height)
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                    print(self.weight)
                }
                
                if let atk = dict["attack"] as? Int {
                    self._baseAtk = "\(atk)"
                    print(self.baseAtk)
                }
                
                if let evos = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evos.count > 0 {
                    
                    if let evoName = evos[0]["to"] as? String {
                        
                        if evoName.rangeOfString("mega") == nil {
                            self._evolutionName = evoName
                            print(self.evolutionName)

                            if let evoUrl = evos[0]["resource_uri"] as? String {
                                let evoId = evoUrl.stringByReplacingOccurrencesOfString("api/v1/pokemon/", withString: "")
                                self._evolutionId = evoId.stringByReplacingOccurrencesOfString("/", withString: "")
                                print(self.evolutionId)
                            } else {
                                self._evolutionId = ""
                            }
                            
                            if let evoLvl = evos[0]["level"] as? Int {
                                self._evolutionLevel = "\(evoLvl)"
                                print(self.evolutionLevel)
                            } else {
                                self._evolutionLevel = ""
                            }
                        }
                    }
                    
                }
                
                if let descrips = dict["descriptions"] as? [Dictionary<String,String>] where descrips.count > 0 {
                    
                    if let resourceUrl = descrips[0]["resource_uri"] where resourceUrl != "" {
                        let urlStr = "\(URL_BASE)\(resourceUrl)"
                        let nsurl = NSURL(string: urlStr)!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let result = response.result
                            if let resDict = result.value as? Dictionary<String,AnyObject> {
                                if let desc = resDict["description"] as? String {
                                    self._description = desc
                                } else {
                                    self._description = ""
                                }
                                print(self._description)
                            }
                            completed()
                        }
                    }
                }
            }
        }
    }
}
