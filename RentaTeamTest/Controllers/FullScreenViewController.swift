//
//  FullScreenViewController.swift
//  RentaTeamTest
//
//  Created by Alex Krzywicki on 02.09.2021.
//

import UIKit

class FullScreenViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fullImage: UIImageView!
    
    var indexPath: IndexPath!
    var transferedImage: URL?


    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = transferedImage {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    self.fullImage.image = UIImage(data: data)
                    let date = Date()
                    let df = DateFormatter()
                    df.dateFormat = "yyyy.MM.dd HH:mm"
                    let dateString = df.string(from: date)
                    self.dateLabel.text = "Image was cached at: " + dateString
                }
            }
            
            task.resume()
        }
    }

    


}
