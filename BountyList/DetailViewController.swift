//
//  DetailViewController.swift
//  BountyList
//
//  Created by SN on 2020/08/31.
//  Copyright © 2020 com.snkim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MVVM
       
   // Model
   // - Boundty Info
   // > Bounty Info 만들자
   
   // View
   // - ImageView , nameLabe, bountyLabel
   // > view들은 viewModel를 통해서 구성되기 ?
   // > ListCell 은 ViewModel 로 부터 받은 정보로 뷰 업데이트
   
   // ViewModel
   // - DetailViewModel
   // > View Layer 에서 필요한 메서드 만들기
   // > 모델 가지고 있기, Bounty Info 들
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var bountyLabel : UILabel!
    
//    var name : String?
//    var bounty : Int?
    
//    var bountyInfo : BountyInfo?
    
    let viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        if let bountyInfo = viewModel.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
//        if let bountyInfo = self.bountyInfo {
//            imgView.image = bountyInfo.image
//            nameLabel.text = bountyInfo.name
//            bountyLabel.text = "\(bountyInfo.bounty)"
//        }
//        if let name = self.name, let bounty = self.bounty {
//            imgView.image = UIImage(named: "\(name).jpg")
//            nameLabel.text = name
//            bountyLabel.text = "\(bounty)"
//        }
        
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

class DetailViewModel {
    var bountyInfo : BountyInfo?
    
    func update(model : BountyInfo?) {
        bountyInfo = model
    }
}
