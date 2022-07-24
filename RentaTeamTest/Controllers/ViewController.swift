//
//  ViewController.swift
//  RentaTeamTest
//
//  Created by Alex Krzywicki on 02.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    
    let unsplash = UnsplashConnector.shared
    
    var posts: [Post] = []
    var current_page = 1
    var total_page = 1
    
    override func viewDidLoad() {
      super.viewDidLoad()
      collectionView.delegate = self
      let height = view.frame.size.width/2 + 70
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = 0
      layout.minimumInteritemSpacing = 0
      layout.itemSize = CGSize(width: view.frame.size.width/2, height: height)

      
        unsplash.posts(query: "kawasaki", page: String(current_page)) { [weak self] posts, error in
        if let error = error {
          print("error", error)
          return
        }
        
        self?.posts = posts!
        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
      }
    }
      


  }

  extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
      let post = posts[indexPath.item]
      
      
      if indexPath.row == posts.count - 1 {
          current_page = current_page + 1
          
        unsplash.posts(query: "kawasaki", page: String(current_page)) { [weak self] posts, error in
            if let error = error {
              print("error", error)
              return
            }
            
              self?.posts.append(contentsOf: posts!)
            DispatchQueue.main.async {
              self?.collectionView.reloadData()
            }
          }

      }
      
      
      cell.title = post.description
      
      cell.image = nil
      cell.badge = nil
      
      let representedIdentifier = post.id
      cell.representedIdentifier = representedIdentifier
      
      func image(data: Data?) -> UIImage? {
        if let data = data {
          return UIImage(data: data)
        }
        return UIImage(systemName: "picture")
      }
      
        unsplash.image(post: post) { data, error  in
        let img = image(data: data)
        DispatchQueue.main.async {
          if (cell.representedIdentifier == representedIdentifier) {
            cell.image = img
          }
        }
      }
          
        unsplash.profileImage(post: post) { data, error  in
        let img = image(data: data)
        DispatchQueue.main.async {
          if (cell.representedIdentifier == representedIdentifier) {
            cell.badge = img
          }
        }
      }
      
      return cell
    }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let vc = storyboard?.instantiateViewController(identifier: "FullScreenViewController") as! FullScreenViewController
          let sendImage = posts[indexPath.row].urls.regular
          vc.indexPath = indexPath
          vc.transferedImage = URL(string: sendImage)
          self.navigationController?.pushViewController(vc, animated: true)
      }

  }

