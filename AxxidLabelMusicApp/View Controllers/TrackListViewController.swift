//
//  TrackListViewController.swift
//  Axxid Label
//
//  Created by Syrphin on 14.03.22.
//

import UIKit


class TrackListViewController: UIViewController {
    
    var responce: Response?
    let imageLoader = ImageLoader.shared
    
    
    @IBOutlet weak var trackTableView: UITableView!
    let searchControler = UISearchController(searchResultsController: nil )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setupSearchBar()
        downlandJSON {
            self.trackTableView.reloadData()
        }
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchControler
        searchControler.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchControler.obscuresBackgroundDuringPresentation = false
    }
    
    private func  config() {
        trackTableView.delegate = self
        trackTableView.dataSource = self
        
        let nib = UINib(nibName: "TrackTableViewCell", bundle: nil)
        trackTableView.register(nib, forCellReuseIdentifier: "AlbumCell")
        
        
    }
    
    func downlandJSON (complited: @escaping  () -> ()) {
        let url = URL(string: "https://itunes.apple.com/lookup?id=553899&entity=album")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil {
                do {
                    self.responce = try JSONDecoder().decode(Response.self, from: data!)
                    DispatchQueue.main.async {
                        complited()
                    }
                } catch {
                    print("JSON Error")
                }
            }
        } .resume()
    }
}


extension TrackListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responce?.results?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trackCell = trackTableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        let track = responce?.results?[indexPath.row]
        
        if track?.collectionName != nil {
            trackCell.nameAlbums.text = track?.collectionName
        }
        //     let numberCollectionName = track?.collectionName
        //            trackCell.nameAlbums.text = numberCollectionName
        
        var urlString = track?.artworkUrl100
        if urlString != nil {
            let url = URL(string: urlString!)
            imageLoader.loadImage(from: url!) { image in
                trackCell.imageAlbums.image = image
                
            }
        }
        return trackCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trackTableView.deselectRow(at: indexPath, animated: true)
        guard let editScreen = storyboard?.instantiateViewController(withIdentifier: "ArtistDetailView") as? ArtistDetailViewController else {
            return
        }
        navigationController?.pushViewController(editScreen, animated: true)
        
        
        let infoAlbum = responce?.results?[indexPath.row]
        editScreen.name = infoAlbum?.artistName ?? ""
        editScreen.album = infoAlbum?.collectionName ?? ""
        editScreen.genre = infoAlbum?.primaryGenreName ?? ""
        editScreen.country = infoAlbum?.country ?? ""
        editScreen.copyright = infoAlbum?.copyright ?? ""
        editScreen.trackCount = infoAlbum?.trackCount ?? 0
        
        
        var urlStringCell = infoAlbum?.artworkUrl100
        if urlStringCell != nil {
            let url = URL(string: urlStringCell!)
            imageLoader.loadImage(from: url!) { image in
                editScreen.imageDetail.image = image
                
            }
        }
        
    }
}


extension TrackListViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


























