 //
//  BountyViewController.swift
//  BountyList
//
//  Created by SN on 2020/08/31.
//  Copyright © 2020 com.snkim. All rights reserved.
//

import UIKit

 class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    let viewModel = BountyViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 줄꺼에요. perform segue 전에
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                
                let bountyInfo = viewModel.bountyInfo(at: index)
                  vc?.viewModel.update(model: bountyInfo)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //UICollectionViewDataSource,
    // 몇개를 보여줄까요?
    // 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    //셀은 어떻게 표현할 까요?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as?
            GridCell else {
                return UICollectionViewCell()
                
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        cell.update(info: bountyInfo)
        return cell
    }
    
    //UICollectionViewDelegate,
    // 셀이 클릭되었을 때 어쩔까요?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("---> \(indexPath.item)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    // UICollectionViewDelegateFlowLayout
    // cell size를 계산할거다. (목표 : 다양한 디바이스에서 일관적인 디자인을 보여주기 위해)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight : CGFloat = 65
        
        let width : CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height : CGFloat = width * 10/7 + textAreaHeight
        return CGSize(width: width, height: height);
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

 class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var bountyLabel : UILabel!
    
    func update(info : BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
 }

