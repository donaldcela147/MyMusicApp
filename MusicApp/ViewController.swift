//
//  ViewController.swift
//  MusicApp
//
//  Created by Florian Cela on 16.10.20.
//  Copyright © 2020 Florian Cela. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    var songs = [Song]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
    }
    
    func configureSongs(){
        songs.append(Song(name: "Master of Puppets", albumName: "Master of Puppets", artistName: "Metallica", imageName: "cover0", trackName: "master"))
        songs.append(Song(name: "Kill the Pain", albumName: "Live or Die", artistName: "Accept", imageName: "cover1", trackName: "killthepain"))
        songs.append(Song(name: "Dashuria", albumName: "Dashuria jone", artistName: "Robert Aliaj", imageName: "cover2", trackName: "dashuria"))
        songs.append(Song(name: "Zemer e Lodhur", albumName: "Zemra", artistName: "Francesk Radi", imageName: "cover3", trackName: "cesku"))
        songs.append(Song(name: "Gabim", albumName: "Diktator", artistName: "Elita 5", imageName: "cover4", trackName: "gabim"))
        songs.append(Song(name: "Bjondina", albumName: "Dashurise se shkuar", artistName: "Ilir Veliu", imageName: "cover5", trackName: "bjondina"))
        songs.append(Song(name: "Master of Puppets", albumName: "Master of Puppets", artistName: "Metallica", imageName: "cover0", trackName: "master"))
        songs.append(Song(name: "Kill the Pain", albumName: "Live or Die", artistName: "Accept", imageName: "cover1", trackName: "killthepain"))
        songs.append(Song(name: "Dashuria", albumName: "Dashuria jone", artistName: "Robert Aliaj", imageName: "cover2", trackName: "dashuria"))
        songs.append(Song(name: "Zemer e Lodhur", albumName: "Zemra", artistName: "Francesk Radi", imageName: "cover3", trackName: "cesku"))
        songs.append(Song(name: "Gabim", albumName: "Diktator", artistName: "Elita 5", imageName: "cover4", trackName: "gabim"))
        songs.append(Song(name: "Bjondina", albumName: "Dashurise se shkuar", artistName: "Ilir Veliu", imageName: "cover5", trackName: "bjondina"))
        songs.append(Song(name: "Master of Puppets", albumName: "Master of Puppets", artistName: "Metallica", imageName: "cover0", trackName: "master"))
        songs.append(Song(name: "Kill the Pain", albumName: "Live or Die", artistName: "Accept", imageName: "cover1", trackName: "killthepain"))
        songs.append(Song(name: "Dashuria", albumName: "Dashuria jone", artistName: "Robert Aliaj", imageName: "cover2", trackName: "dashuria"))
        songs.append(Song(name: "Zemer e Lodhur", albumName: "Zemra", artistName: "Francesk Radi", imageName: "cover3", trackName: "cesku"))
        songs.append(Song(name: "Gabim", albumName: "Diktator", artistName: "Elita 5", imageName: "cover4", trackName: "gabim"))
        songs.append(Song(name: "Bjondina", albumName: "Dashurise se shkuar", artistName: "Ilir Veliu", imageName: "cover5", trackName: "bjondina"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else {return}
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
    
     struct Song {
        let name:String
        let albumName:String
        let artistName:String
        let imageName:String
        let trackName:String
    }

}

