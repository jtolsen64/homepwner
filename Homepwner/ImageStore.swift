//
//  ImageStore.swift
//  Homepwner
//
//  Created by Jayden Olsen on 3/27/17.
//  Copyright © 2017 Jayden Olsen. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<NSString,UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
}

