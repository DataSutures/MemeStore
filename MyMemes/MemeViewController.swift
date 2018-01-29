//
//  MemeViewController.swift
//  MyMemes
//
//  Created by Kimberly Smith on 11/2/17.
//  Copyright © 2017 Smith Kimberly. All rights reserved.
//

import UIKit

class MemeViewController: UITableViewController {
    
    var memesCollection: MemeCollection!
    var imageCollector: ImageCollector!
    var meme: Meme!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return memesCollection.allMemes.count
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! MemeCell
        let meme = memesCollection.allMemes[indexPath.row]
        cell.title.text = meme.title
        cell.type.text = meme.type
        cell.ratingImageView.image = image(forRating: meme.rating)
        return cell
    }
    func image(forRating rating: Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let meme = memesCollection.allMemes[indexPath.row]
            let title = "Delete \(meme.title)?"
            let message = "Are you sure?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                self.memesCollection.removeMeme(meme)
                self.imageCollector.deleteImage(forKey: meme.itemKey)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    @IBAction func canceltoMemeViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveMemeDetail(_ segue: UIStoryboardSegue) {
        guard let newMemeViewController = segue.source as? NewMemeViewController,
            let meme = newMemeViewController.meme , let image = newMemeViewController.imageView.image
            else {
                let alertController = UIAlertController(title: "No Image Selected.", message: "You must select an image.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
                return
        }
        
        // add the new meme to collection
        memesCollection.addMeme(meme)
        
        //save image to imageCollection
        imageCollector.setImage(image, forKey: meme.itemKey)
        
        // update the tableView
        let indexPath = IndexPath(row: memesCollection.allMemes.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        memesCollection.moveMeme(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMeme"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let meme = memesCollection.allMemes[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.meme = meme
                detailViewController.imageCollector = imageCollector
            }
        case "addNewMeme"?:
            let newMemeViewController = segue.destination as! NewMemeViewController
            newMemeViewController.memeCollection = memesCollection
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
    }
    
}
