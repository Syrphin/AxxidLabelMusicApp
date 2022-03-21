//
//  ArtistDetailViewController.swift
//  Axxid Label
//
//  Created by Syrphin on 20.03.22.
//

import UIKit


class ArtistDetailViewController: UIViewController {
    
    var name = ""
    var album = ""
    var genre = ""
    var image: UIImage?
    var trackCount = 0
    var country = ""
    var copyright = ""
    
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var countryDetail: UILabel!
    @IBOutlet weak var copyrightDetail: UILabel!
    @IBOutlet weak var trackCountDetail: UILabel!
    @IBOutlet weak var genreDetail: UILabel!
    @IBOutlet weak var albumNameDetail: UILabel!
    @IBOutlet weak var nameDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameDetail.text = name
        albumNameDetail.text = album
        genreDetail.text = genre
        trackCountDetail.text = trackCount.description
        countryDetail.text = country
        copyrightDetail.text = copyright
        imageDetail.image = image
        
        
    }
}
