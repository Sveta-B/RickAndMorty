//
//  Character.swift
//  RickAndMorty
//
//  Created by Света Брасс on 17.05.21.
//

import Foundation
struct Character {
    

var id: Int    //The id of the character.
    var name: String    //The name of the character.
    var status: String    //The status of the character ('Alive', 'Dead' or 'unknown').
    var species: String   // The species of the character.
    var type: String    //The type or subspecies of the character.
    var gender: String   // The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
    var origin: NSObject   // Name and link to the character's origin location.
    var location: NSObject   // Name and link to the character's last known location endpoint.
    var image: String // (url)    //nce they are intended to be used as avatars.
    var episode: NSArray  //(urls)   // List of episodes in which this character appeared.
    var url: String // (url)   // Link to the character's own URL endpoint.
    var created: String  //  Time at which the character was created in the database.
}
