//
//  ScoreCell.swift
//  WorldCup
//
//  Created by Yassir RAMDANI on 15/06/2018.
//  Copyright © 2018 Yassir RAMDANI. All rights reserved.
//

import UIKit

class ScoreCell: UICollectionViewCell {
    
    enum State {
        case expended, collapsed
        
        func img()->UIImage{
            switch self {
            case .collapsed:
                return #imageLiteral(resourceName: "down").withRenderingMode(.alwaysTemplate)
            case .expended:
                return #imageLiteral(resourceName: "up").withRenderingMode(.alwaysTemplate)
            }
        }
    }
    var state = State.collapsed {
        didSet{
            StateImg.image = state.img()
            tabv.reloadData()
        }
    }
    var match : Match? {
        didSet {
            if match?.home_team.country != "To Be Determined"{
                HomeTeamFlagImg.imageFromURL(string: "http://flagpedia.net/data/flags/normal/"+(match?.home_team.code.flag())!+".png")
                AwayTeamFlagImg.imageFromURL(string: "http://flagpedia.net/data/flags/normal/"+(match?.away_team.code.flag())!+".png")
            }else{
                HomeTeamFlagImg.image = nil
                AwayTeamFlagImg.image = nil
            }
            
            HomeTeamNameLab.text = match?.home_team.country
            AwayTeamNameLab.text = match?.away_team.country
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let mydte = dateFormatter.date(from:match?.datetime ?? "")
            dateFormatter.dateFormat = "EEEE dd MMMM YYYY (HH:mm)"
            var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
            dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation)
            dateFormatter.locale = Locale(identifier: NSLocalizedString("locID", comment: ""))
            if let mydte = mydte{
                DateLab.text = dateFormatter.string(from: mydte)

            }
            CityLab.text = match?.location ?? ""
            HomeTeamScoreLab.text = "\(match?.home_team.goals ?? 0)"
            AwayTeamScoreLab.text = "\(match?.away_team.goals ?? 0)"
            
            StatusLab.text = match?.status.uppercased() ?? ""
            if StatusLab.text != "COMPLETED" && StatusLab.text != "IN PROGRESS"{
                HomeTeamScoreLab.text = ""
                AwayTeamScoreLab.text = ""
            }
            StatusLab.text = NSLocalizedString(StatusLab.text!, comment: "")

            StateImg.image = state.img()
        }
    }
    
    let tabv : UITableView = {
        let tab = UITableView()
        tab.separatorColor = .clear
        tab.isScrollEnabled = false
        tab.allowsSelection = false
        return tab
    }()
    var StateImg : UIImageView = {
        let img = UIImageView()
        return img
    }()
    var HomeTeamFlagImg : UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 4
        img.layer.masksToBounds = true
        img.layer.borderWidth = 0.1
        img.layer.borderColor = UIColor.black.cgColor
        return img
    }()
    var AwayTeamFlagImg : UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 4
        img.layer.masksToBounds = true
        img.layer.borderWidth = 0.1
        img.layer.borderColor = UIColor.black.cgColor
        return img
    }()

    var HomeTeamNameLab : UILabel = {
       let lab = UILabel()
        lab.text = "Maroc"
        lab.textColor = UIColor(red: 157.0/255.0, green: 168.0/255.0, blue: 192.0/255.0, alpha: 1.0)
        lab.textAlignment = .center
        lab.font = UIFont.init(name: "AvenirNext-DemiBold ", size: 22)
        lab.sizeToFit()
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()
    var AwayTeamNameLab : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(red: 157.0/255.0, green: 168.0/255.0, blue: 192.0/255.0, alpha: 1.0)
        lab.text = "Iran"
        lab.font = UIFont.init(name: "AvenirNext-DemiBold ", size: 22)
        lab.sizeToFit()
        lab.adjustsFontSizeToFitWidth = true
        lab.textAlignment = .center
        return lab
    }()
    
    var HomeTeamScoreLab: UILabel = {
        let lab = UILabel()
        lab.text = "3"
        lab.textColor = UIColor(red: 73.0/255.0, green: 73.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        lab.font = UIFont.init(name: "bignoodletitling", size: 52)
        lab.textAlignment = .right
        return lab
    }()
    
    var AwayTeamScoreLab: UILabel = {
        let lab = UILabel()
        lab.text = "1"
        lab.textColor = UIColor(red: 73.0/255.0, green: 73.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        lab.font = UIFont.init(name: "bignoodletitling", size: 52)
        lab.sizeToFit()
        return lab
    }()
    
    var DateLab: UILabel = {
        let lab = UILabel()
        lab.text = "11 Fevrier 2018"
        lab.textColor = UIColor(red: 245.0/255.0, green: 160.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        lab.font = UIFont.init(name: "Avenir-Heavy", size: 12)
        lab.textAlignment = .center
        return lab
    }()
    var CityLab: UILabel = {
        let lab = UILabel()
        lab.text = "Mumbai"
        lab.textColor = UIColor(red: 145.0/255.0, green: 145.0/255.0, blue: 145.0/255.0, alpha: 1.0)
        lab.font = UIFont.init(name: "Avenir-Book", size: 12)
        lab.textAlignment = .center
        return lab
    }()
    
    var StatusLab: UILabel = {
        let lab = UILabel()
        lab.text = "FINAL"
        lab.textColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)
        lab.font = UIFont.init(name: "Farah", size: 12)
        lab.textAlignment = .center
        return lab
    }()
    
    var tiret: UILabel = {
        let lab = UILabel()
        lab.text = "-"
        lab.textColor = UIColor(red: 73.0/255.0, green: 73.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        lab.font = UIFont.init(name: "bignoodletitling", size: 52)
        lab.textAlignment = .center
        return lab
    }()
    let separator1 : UIView = {
       let v = UIView()
        v.backgroundColor = UIColor(red: 235.0/255.0, green: 237.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        return v
        
    }()
    let separator2 : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 235.0/255.0, green: 237.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        return v
        
    }()
    
    var StatsLab: UILabel = {
        let lab = UILabel()
        lab.text = "Stats"
        lab.textColor = UIColor(red: 245.0/255.0, green: 160.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        lab.font = UIFont.init(name: "Avenir-Heavy", size: 16)
        lab.textAlignment = .left
        return lab
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        tabv.layer.masksToBounds = true
        // imgs :
        
        addSubview(HomeTeamFlagImg)
        HomeTeamFlagImg.translatesAutoresizingMaskIntoConstraints = false
        HomeTeamFlagImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
        HomeTeamFlagImg.heightAnchor.constraint(equalToConstant: 64).isActive = true
        HomeTeamFlagImg.topAnchor.constraint(equalTo: topAnchor, constant: 48).isActive = true
        HomeTeamFlagImg.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        HomeTeamFlagImg.imageFromURL(string : "http://flagpedia.net/data/flags/normal/\("ma").png")
        HomeTeamFlagImg.image = nil
        
        addSubview(AwayTeamFlagImg)
        AwayTeamFlagImg.translatesAutoresizingMaskIntoConstraints = false
        AwayTeamFlagImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
        AwayTeamFlagImg.heightAnchor.constraint(equalToConstant: 64).isActive = true
        AwayTeamFlagImg.topAnchor.constraint(equalTo: topAnchor, constant: 48).isActive = true
        AwayTeamFlagImg.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        AwayTeamFlagImg.imageFromURL(string : "http://flagpedia.net/data/flags/normal/\("ir").png")
        AwayTeamFlagImg.image = nil
        
        
        
        // labs :
        
        addSubview(HomeTeamNameLab)
        HomeTeamNameLab.translatesAutoresizingMaskIntoConstraints = false
        HomeTeamNameLab.widthAnchor.constraint(equalToConstant: 100).isActive = true
        HomeTeamNameLab.heightAnchor.constraint(equalToConstant: 20).isActive = true
        HomeTeamNameLab.topAnchor.constraint(equalTo: HomeTeamFlagImg.bottomAnchor, constant: 2).isActive = true
        HomeTeamNameLab.centerXAnchor.constraint(equalTo: HomeTeamFlagImg.centerXAnchor).isActive = true
        
        addSubview(AwayTeamNameLab)
        AwayTeamNameLab.translatesAutoresizingMaskIntoConstraints = false
        AwayTeamNameLab.widthAnchor.constraint(equalToConstant: 100).isActive = true
        AwayTeamNameLab.heightAnchor.constraint(equalToConstant: 20).isActive = true
        AwayTeamNameLab.topAnchor.constraint(equalTo: AwayTeamFlagImg.bottomAnchor, constant: 2).isActive = true
        AwayTeamNameLab.centerXAnchor.constraint(equalTo: AwayTeamFlagImg.centerXAnchor).isActive = true
        
        addSubview(tiret)
        tiret.translatesAutoresizingMaskIntoConstraints = false
        tiret.widthAnchor.constraint(equalToConstant: 20).isActive = true
        tiret.heightAnchor.constraint(equalTo: HomeTeamFlagImg.heightAnchor).isActive = true
        tiret.topAnchor.constraint(equalTo: HomeTeamFlagImg.topAnchor, constant: 2).isActive = true
        tiret.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(AwayTeamScoreLab)
        AwayTeamScoreLab.translatesAutoresizingMaskIntoConstraints = false
        AwayTeamScoreLab.widthAnchor.constraint(equalToConstant: 100).isActive = true
        AwayTeamScoreLab.heightAnchor.constraint(equalTo: AwayTeamFlagImg.heightAnchor).isActive = true
        AwayTeamScoreLab.topAnchor.constraint(equalTo: AwayTeamFlagImg.topAnchor, constant: 2).isActive = true
        AwayTeamScoreLab.leftAnchor.constraint(equalTo: tiret.rightAnchor, constant: 12).isActive = true
        
        addSubview(HomeTeamScoreLab)
        HomeTeamScoreLab.translatesAutoresizingMaskIntoConstraints = false
        HomeTeamScoreLab.widthAnchor.constraint(equalToConstant: 100).isActive = true
        HomeTeamScoreLab.heightAnchor.constraint(equalTo: HomeTeamFlagImg.heightAnchor).isActive = true
        HomeTeamScoreLab.topAnchor.constraint(equalTo: HomeTeamFlagImg.topAnchor, constant: 2).isActive = true
        HomeTeamScoreLab.rightAnchor.constraint(equalTo: tiret.leftAnchor, constant: -12).isActive = true
        
        addSubview(DateLab)
        DateLab.translatesAutoresizingMaskIntoConstraints = false
        DateLab.widthAnchor.constraint(equalToConstant: 200).isActive = true
        DateLab.heightAnchor.constraint(equalToConstant: 14).isActive = true
        DateLab.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        DateLab.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(CityLab)
        CityLab.translatesAutoresizingMaskIntoConstraints = false
        CityLab.widthAnchor.constraint(equalToConstant: 200).isActive = true
        CityLab.heightAnchor.constraint(equalToConstant: 14).isActive = true
        CityLab.topAnchor.constraint(equalTo: DateLab.bottomAnchor, constant: 1).isActive = true
        CityLab.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
        addSubview(StatusLab)
        StatusLab.translatesAutoresizingMaskIntoConstraints = false
        StatusLab.widthAnchor.constraint(equalToConstant: 100).isActive = true
        StatusLab.heightAnchor.constraint(equalToConstant: 14).isActive = true
        StatusLab.topAnchor.constraint(equalTo: HomeTeamFlagImg.bottomAnchor, constant: 14).isActive = true
        StatusLab.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(separator1)
        separator1.translatesAutoresizingMaskIntoConstraints = false
        separator1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator1.widthAnchor.constraint(equalTo:widthAnchor).isActive = true
        separator1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        separator1.topAnchor.constraint(equalTo: topAnchor, constant: 160).isActive =  true
        
//        addSubview(separator2)
//        separator2.translatesAutoresizingMaskIntoConstraints = false
//        separator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        separator2.widthAnchor.constraint(equalTo:widthAnchor).isActive = true
//        separator2.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        separator2.topAnchor.constraint(equalTo: topAnchor, constant: 201).isActive =  true
        
        addSubview(StatsLab)
        StatsLab.translatesAutoresizingMaskIntoConstraints = false
        StatsLab.widthAnchor.constraint(equalToConstant: 200).isActive = true
        StatsLab.heightAnchor.constraint(equalToConstant: 14).isActive = true
        StatsLab.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 10).isActive = true
        StatsLab.leftAnchor.constraint(equalTo: leftAnchor , constant :70).isActive = true
        
        let statsmoj = UIImageView()
        statsmoj.image = #imageLiteral(resourceName: "stats-1").withRenderingMode(.alwaysTemplate)
        statsmoj.contentMode = .scaleAspectFit
        addSubview(statsmoj)
        statsmoj.tintColor = UIColor(red: 245.0/255.0, green: 160.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        statsmoj.translatesAutoresizingMaskIntoConstraints = false
        statsmoj.widthAnchor.constraint(equalToConstant: 30).isActive = true
        statsmoj.heightAnchor.constraint(equalToConstant: 30).isActive = true
        statsmoj.centerYAnchor.constraint(equalTo: StatsLab.centerYAnchor).isActive = true
        statsmoj.leftAnchor.constraint(equalTo: leftAnchor , constant :30).isActive = true

        
        addSubview(StateImg)
        StateImg.tintColor = UIColor(red: 245.0/255.0, green: 160.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        StateImg.translatesAutoresizingMaskIntoConstraints = false
        StateImg.widthAnchor.constraint(equalToConstant: 30).isActive = true
        StateImg.heightAnchor.constraint(equalToConstant: 30).isActive = true
        StateImg.centerYAnchor.constraint(equalTo: StatsLab.centerYAnchor).isActive = true
        StateImg.rightAnchor.constraint(equalTo: rightAnchor , constant :-20).isActive = true
        
        
        addSubview(tabv)
        tabv.translatesAutoresizingMaskIntoConstraints = false
        tabv.widthAnchor.constraint(equalTo:widthAnchor).isActive = true
        tabv.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tabv.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive =  true
        tabv.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        
        tabv.dataSource = self
        tabv.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ScoreCell : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return match?.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let m = match?.events[indexPath.item]
        cell.textLabel?.text = (m?.isHomeEvent)! ?  (m?.player ?? "") + " \(m?.time ?? "")" : " \(m?.time ?? "") " + (m?.player ?? "")
        cell.textLabel?.font = UIFont.init(name: "Avenir-Book", size: 12)
        cell.textLabel?.textAlignment = (m?.isHomeEvent)! ? .left : .right
        let imgv = UIImageView()
        cell.addSubview(imgv)
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imgv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imgv.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        imgv.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        imgv.contentMode = .scaleAspectFit
        switch m?.type_of_event {
        case "yellow-card"?:
            imgv.image = #imageLiteral(resourceName: "card").withRenderingMode(.alwaysTemplate)
            imgv.tintColor = .yellow
        case "substitution-in"?:
            imgv.image = #imageLiteral(resourceName: "in").withRenderingMode(.alwaysTemplate)
            imgv.tintColor = .green
        case "substitution-out"?:
            imgv.image = #imageLiteral(resourceName: "out").withRenderingMode(.alwaysTemplate)
            imgv.tintColor = .red
        case "red-card"?:
            imgv.image = #imageLiteral(resourceName: "card").withRenderingMode(.alwaysTemplate)
            imgv.tintColor = .red
        case "goal"? , "goal-own"? , "goal-penalty"? :
            imgv.image = #imageLiteral(resourceName: "ball")
        default:
            imgv.image = nil
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
