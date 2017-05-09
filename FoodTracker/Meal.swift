//
//  Meal.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 28/04/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //Propriedades.
    var name: String
    var photo: UIImage?
    var rating: Int
    
    
    //Tipos.
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    // Caminho de arquivos.
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")

    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // O nome não pode ser vazio.
        guard !name.isEmpty else {
            return nil
        }
        
        //A classificação deve estar entre 0 e 5.
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Não é possível decodificar o nome de um objeto Meal.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        self.init(name: name, photo: photo, rating: rating)
    }

}
