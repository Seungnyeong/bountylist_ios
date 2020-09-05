 //
//  BountyViewController.swift
//  BountyList
//
//  Created by SN on 2020/08/31.
//  Copyright © 2020 com.snkim. All rights reserved.
//

import UIKit

 class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MVVM
    
    // Model
    // - Boundty Info
    // > Bounty Info 만들자
    
    // View
    // - ListCell
    // > ListCell 필요한 정보를 ViewModel 한테서 받아와야 겠다.
    // > ListCell 은 ViewModel 로 부터 받은 정보로 뷰 업데이트
    
    // ViewModel
    // - BountyViewModel
    // > BountyViewModel 을 만들고, View Layer 에서 필요한 메서드 만들기
    // > 모델 가지고 있기, Bounty Info 들
    
//    let bountyInfoList: [BountyInfo] = [
//        BountyInfo(name: "brook", bounty: 300000),
//        BountyInfo(name: "chopper", bounty: 50),
//        BountyInfo(name: "franky", bounty: 4400000),
//        BountyInfo(name: "luffy", bounty: 160000),
//        BountyInfo(name: "nami", bounty: 80000),
//        BountyInfo(name: "robin", bounty: 990000),
//        BountyInfo(name: "sanji", bounty: 929319),
//        BountyInfo(name: "zoro", bounty: 647211)
//    ]
    
    let viewModel = BountyViewModel()
    
//    let nameList = ["brook", "chopper", "franky", "luffy", "nami", "robin", "sanji", "zoro"]
//    let bountyList = [3000000, 50, 44000000, 3000000, 1600000, 80000, 99090000, 1200000]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 줄꺼에요. perform segue 전에
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                
                let bountyInfo = viewModel.bountyInfo(at: index)
                
//                vc?.name = nameList[index]
//                vc?.bounty = bountyList[index]
                  vc?.viewModel.update(model: bountyInfo)
//                vc?.name = bountyInfo.name
//                vc?.bounty = bountyInfo.bounty
                
            }
           
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return bountyList.count
        //return bountyInfoList.count
        return viewModel.numOfBountyInfoList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as? ListCell else {
                return UITableViewCell()
            }
//
//        return cell;
        
//       if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as? ListCell {
//            let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
//            cell.imgView.image = img
//            cell.nameLabel.text = nameList[indexPath.row]
//            cell.bountyLabel.text = "\(bountyList[indexPath.row])"

//            let bountyInfo = bountyInfoList[indexPath.row]
            let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
            cell.update(info: bountyInfo)
//            cell.imgView.image = bountyInfo.image
//            cell.nameLabel.text = bountyInfo.name
//            cell.bountyLabel.text = "\(bountyInfo.bounty)"
            return cell;
//        }
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("---> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}


 class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var bountyLabel : UILabel!
    
    func update(info : BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
 }

 
 class BountyViewModel {
    let bountyInfoList: [BountyInfo] = [
           BountyInfo(name: "brook", bounty: 300000),
           BountyInfo(name: "chopper", bounty: 50),
           BountyInfo(name: "franky", bounty: 4400000),
           BountyInfo(name: "luffy", bounty: 160000),
           BountyInfo(name: "nami", bounty: 80000),
           BountyInfo(name: "robin", bounty: 990000),
           BountyInfo(name: "sanji", bounty: 929319),
           BountyInfo(name: "zoro", bounty: 647211)
       ]
    
    var numOfBountyInfoList : Int {
        return bountyInfoList.count
    }
    
    var sortedList : [BountyInfo] {
        let sortedList = bountyInfoList.sorted {
            prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    func bountyInfo(at index : Int) -> BountyInfo {
        return sortedList[index]
    }
 }
