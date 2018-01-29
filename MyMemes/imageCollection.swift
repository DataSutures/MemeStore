//
//  imageCollection.swift
//  MyMemes
//
//  Created by Kimberly Smith on 11/3/17.
//  Copyright © 2017 Smith Kimberly. All rights reserved.
//

import UIKit
class ImageCollector {
    
    let cache = NSCache<NSString,UIImage>()
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        let url = imageURL(forKey: key)
        if let data = UIImageJPEGRepresentation(image, 0.5){
            do {
                try data.write(to: url, options: [.atomic])
            } catch {
                print("Error with setrImage function in ImageCOllector \(error)")
            }
        }
    }
    func image(forKey key: String) -> UIImage? {
        
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path)
            else { return nil }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
        
    }
    func deleteImage(forKey key: String) {
        
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error removing the image from disk \(error)")
        }
    }
    func imageURL(forKey key: String) -> URL {
        
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
}
