//
//  MemeCollection.swift
//  MyMemes
//
//  Created by Kimberly Smith on 11/2/17.
//  Copyright © 2017 Smith Kimberly. All rights reserved.
//
import UIKit
class MemeCollection{
    
    var allMemes = [Meme]()
    
    let memeArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("memes.archive")
    }()
    
    init() {
        if let archivedMemes = NSKeyedUnarchiver.unarchiveObject(withFile: memeArchiveURL.path) as? [Meme] {
            allMemes = archivedMemes
        }
    }
    @discardableResult func createMeme(title: String, type: String, rating: Int) -> Meme {
        let newMeme = Meme(title: title,type: type, rating: rating)
        allMemes.append(newMeme)
        return newMeme
    }
    func addMeme(_ meme: Meme){
        allMemes.append(meme)
    }
    func removeMeme(_ meme: Meme) {
        if let index = allMemes.index(of: meme) {
            allMemes.remove(at: index)
        }
    }
    func moveMeme(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedMeme = allMemes[fromIndex]
        allMemes.remove(at: fromIndex)
        allMemes.insert(movedMeme, at: toIndex)
    }
    func saveChanges() -> Bool {
        print("Saving items to: \(memeArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allMemes, toFile: memeArchiveURL.path)
    }
    
}
