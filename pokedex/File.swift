//
//  File.swift
//  pokedex
//
//  Created by Casey Lyman on 4/5/16.
//  Copyright © 2016 bearcode. All rights reserved.
//

import Foundation

class pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init (name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}
