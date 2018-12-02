//
//  ViewController.swift
//  WorldCup
//
//  Created by Yassir RAMDANI on 10/06/2018.
//  Copyright © 2018 Yassir RAMDANI. All rights reserved.
//

import UIKit
import GoogleMobileAds
class MainPage: UIViewController {
    let generic = Generic.getGeneric()
    var myMatchs : [Match] = []
    var indicator = -1

    let collec : UICollectionView = {
        let tab = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        tab.showsVerticalScrollIndicator = false
        return tab
    }()
    
    var bannerView: GADBannerView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.collec.register(ScoreCell.self, forCellWithReuseIdentifier: "cell")
        



        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3934826150219455/4648556212"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
        
        myMatchs = []
        refresh()
        let _ = Timer.scheduledTimer(withTimeInterval: 160, repeats: true) { (t) in
            self.refresh()
            print("refresh")
        }
      
        let v = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 260))
        view.addSubview(v)
        let gradientColor = CAGradientLayer()
        let topcolor = UIColor(red: 230.0/255.0, green: 115.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        let bottomcolor = UIColor(red: 250.0/255.0, green: 217.0/255.0, blue: 97.0/255.0, alpha: 1.0)
        gradientColor.colors = [topcolor.cgColor, bottomcolor.cgColor]
        gradientColor.locations = [0,1]
        gradientColor.frame = v.frame
        v.layer.addSublayer(gradientColor)
        
        view.addSubview(collec)
        collec.translatesAutoresizingMaskIntoConstraints = false
        collec.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collec.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        collec.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collec.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collec.backgroundColor = .clear
        collec.tintColor = .clear
        
        collec.delegate = self
        collec.dataSource = self
        
        collec.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 62, right: 0)
        
        
        view.addSubview(titleLab)
        titleLab.translatesAutoresizingMaskIntoConstraints = false
        titleLab.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        titleLab.topAnchor.constraint(equalTo: view.topAnchor, constant: 28).isActive = true
        titleLab.heightAnchor.constraint(equalToConstant: 38).isActive = true
        titleLab.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleLab.font = UIFont.init(name: "bignoodletitling", size: 32)
        titleLab.text = "Matches"
        titleLab.textColor = .white
        titleLab.textAlignment = .center
        let tapg = UITapGestureRecognizer(target: self, action: #selector(slideToday))
        titleLab.addGestureRecognizer(tapg)
        titleLab.isUserInteractionEnabled = true
        
        view.addSubview(refreshBtn)
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        refreshBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        refreshBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        refreshBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        refreshBtn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        refreshBtn.setImage(#imageLiteral(resourceName: "refresh").withRenderingMode(.alwaysTemplate), for: .normal)
        refreshBtn.tintColor = .white
        refreshBtn.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        
        
        view.addSubview(menuBtn)
        menuBtn.translatesAutoresizingMaskIntoConstraints = false
        menuBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        menuBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        menuBtn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu").withRenderingMode(.alwaysTemplate), for: .normal)
        menuBtn.tintColor = .white
        menuBtn.addTarget(self, action: #selector(menu), for: .touchUpInside)
        
        
        
        view.addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bannerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant:50).isActive = true
        
    }
    
    @objc func slideToday(wait : Bool = false){
        var i = 0
        for m in self.myMatchs {
            i += 1
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let mydte = dateFormatter.date(from:m.datetime ?? "")
            if  Date().compare(mydte!) == .orderedAscending {
                break
            }
            
        }
        self.generic.perform(after: wait ? 0:1, conpletion: {
            self.collec.scrollToItem(at: IndexPath(item: i, section: 0), at: .bottom, animated: true)
        })

    }
    
    
    let refreshBtn = UIButton(type: UIButtonType.custom)
    let menuBtn = UIButton(type: UIButtonType.custom)
    let titleLab = UILabel()
    @objc func menu(){
        let alert = UIAlertController(title: NSLocalizedString("ALERTTITLE", comment: ""), message: NSLocalizedString("ALERTMESSAGE", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil) )
        alert.addAction(UIAlertAction(title: "✍️ \(NSLocalizedString("RATE", comment: "")) ✍️", style: .default, handler: {(ale) in
            self.generic.rateApp(appId: "id1399939626") { success in
                print("RateApp \(success)")
            }
        }) )
        present(alert, animated: true, completion: nil)
    }
    @objc func refresh(){
        generic.getData(Url: APIURL+MATCHS) { (m:[Match]) in
            self.myMatchs = []
            self.myMatchs.append(contentsOf: m)
            DispatchQueue.main.async {
                self.collec.reloadData()
                self.slideToday(wait: true)
            }
            
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension MainPage : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return myMatchs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScoreCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 2
        cell.match = myMatchs[indexPath.item]
        cell.tabv.reloadData()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-40, height: indexPath.item == indicator ? 200+CGFloat(myMatchs[indexPath.item].events.count*40) :200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ScoreCell
        UIView.animate(withDuration: 0.8, animations: {
            cell?.contentView.layoutIfNeeded()
            collectionView.performBatchUpdates({
               
                if self.indicator == indexPath.item{
                    self.indicator = -1
                        cell?.frame.size = CGSize(width:(cell?.frame.width)!,height:200)
                        cell?.state = .collapsed
                }else {
                    (collectionView.cellForItem(at: IndexPath(item: self.indicator, section: 0)) as? ScoreCell)?.state = .collapsed
                    self.indicator = indexPath.item
                    cell?.frame.size = CGSize(width:(cell?.frame.width)!,height:200+CGFloat(self.myMatchs[indexPath.item].events.count*40))
                        cell?.state = .expended

                }
            }, completion: { (ended) in
                
                //collectionView.reloadData()
            
            })
        })
        
    }
   
    
}
