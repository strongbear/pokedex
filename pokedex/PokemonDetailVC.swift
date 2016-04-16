//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Casey Lyman on 4/10/16.
//  Copyright © 2016 bearcode. All rights reserved.
//

import UIKit
import Alamofire

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAtkLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {

        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalizedString
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")

        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        descriptionLbl.text = pokemon.description
        defenseLbl.text = pokemon.defense
        typeLbl.text = pokemon.type
        heightLbl.text = pokemon.height
        pokedexLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        baseAtkLbl.text = pokemon.baseAtk
        
        if pokemon.evolutionId == "" {
            nextEvoImg.hidden = true
            nextEvolutionLbl.text = "NO EVOLUTIONS"
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.evolutionId)
            var str = "Next Evolution: \(pokemon.evolutionName)"
            
            if pokemon.evolutionLevel != "" {
                str += " - LVL \(pokemon.evolutionLevel)"
            }
            nextEvolutionLbl.text = str
        }
        
    }
    
    @IBAction func backBtnPressed() {
        dismissViewControllerAnimated(true, completion: nil)
    }


}
