//
//  ArtistListViewController.swift
//  Axxid Label
//
//  Created by Syrphin on 14.03.22.
//

import UIKit

class ArtistListViewController: UIViewController {

    @IBOutlet weak var infoArtistTabel: UITableView!
    
    var bioKraftwerk = [BioKraftwerk]()
    let imageArtistLoader = ImageLoader.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        downalandBioJSON {
            self.infoArtistTabel.reloadData()
        }
        
    }
    
    func downalandBioJSON (complition: @escaping () -> ()) {
        let sharedSession = URLSession.shared
        guard let urlBio = URL(string: "https://imdb-api.com/en/API/Name/k_d0u6tzbp/nm1436137") else {return}
        let request = URLRequest(url: urlBio)
        let dataTask = sharedSession.dataTask(with: request) { data, response, error in
            if error == nil {
                do {
                    var element = try JSONDecoder().decode(BioKraftwerk.self, from: data!)
                    self.bioKraftwerk.append(element)
                    print(self.bioKraftwerk)
                    DispatchQueue.main.async {
                        complition()
                    }
                } catch {
                    print("BioJSON Erorr")
                }
            }
            
        }
        dataTask.resume()
    }
    
    func config() {
        infoArtistTabel.delegate = self
        infoArtistTabel.dataSource = self
        
    }
}

extension ArtistListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bioKraftwerk.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellBio = tableView.dequeueReusableCell(withIdentifier: "BioCell", for: indexPath) as? ArtistTableViewCell else {
            return UITableViewCell()
        }
        let aboutKraftwerk = bioKraftwerk[indexPath.row]
        cellBio.artistName.text = aboutKraftwerk.name
        cellBio.artistBio.text = aboutKraftwerk.summary
        
        let urlString = aboutKraftwerk.image
        if urlString != nil {
            let url = URL(string: urlString!)
            imageArtistLoader.loadImage(from: url!) { image in
                cellBio.artistImage?.image = image
                
            }
        }
        
        return cellBio
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        700
        
    }
}
















    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

