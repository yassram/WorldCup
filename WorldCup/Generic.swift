//
//  Generic.swift
//  WorldCup
//
//  Created by Yassir RAMDANI on 10/06/2018.
//  Copyright © 2018 Yassir RAMDANI. All rights reserved.
//

import UIKit

let APIURL = "http://worldcup.sfg.io"
let MATCHS = "/matches"
let TEAMS = "/teams"


class Generic: NSObject {

    private static let generic = Generic()

    static func getGeneric() -> Generic{
        return generic
    }
    
    func perform(after sec: Float, conpletion : @escaping ()->()){
        _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(sec), repeats: false, block: { (T) in
            conpletion()
            T.invalidate()
        })
    }

    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    
    
    
    func getData<T:Decodable>(Url:String ,completion:@escaping(T)->()){
        
        var request = URLRequest(url: URL(string: Url)!)
        request.addValue("cf0acf6332244408b274facae959ad9b", forHTTPHeaderField: "X-Auth-Token")
        print(request.url?.absoluteString ?? "")
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard  error == nil else{
                print(100,error?.localizedDescription ?? "error URLRequest")
                return
            }

            guard let data = data else{
                print("Empty Data")
                return
            }

            do {

                let json = try JSONDecoder().decode(T.self, from: data)

                
                
                completion(json)
            }catch let err {
                print(err.localizedDescription)
            }

        }).resume()



    }
}


enum Countries : String {
    case RUS,KSA,EGY,URU,POR,ESP,MAR,IRN,FRA,AUS,PER,DEN,ARG,ISL,CRO,NGA,BRA,SUI,CRC,SRB,GER,MEX,SWE,KOR,BEL,PAN,TUN,ENG,POL,JPN,COL,SEN
 
    
}
extension String {
    func flag()->String! {
        switch self {
        case Countries.KOR.rawValue :
            return "kr"
        case Countries.BEL.rawValue :
            return "be"
        case Countries.PAN.rawValue :
            return "pa"
        case Countries.TUN.rawValue :
            return "tn"
        case Countries.ENG.rawValue :
            return "gb"
        case Countries.POL.rawValue :
            return "pl"
        case Countries.JPN.rawValue :
            return "jp"
        case Countries.COL.rawValue :
            return "co"
        case Countries.SEN.rawValue :
            return "sn"
        case Countries.RUS.rawValue :
            return "ru"
        case Countries.KSA.rawValue :
            return "sa"
        case Countries.EGY.rawValue :
            return "eg"
        case Countries.URU.rawValue :
            return "uy"
        case Countries.POR.rawValue :
            return "pt"
        case Countries.ESP.rawValue :
            return "es"
        case Countries.MAR.rawValue :
            return "ma"
        case Countries.IRN.rawValue :
            return "ir"
        case Countries.FRA.rawValue :
            return "fr"
        case Countries.AUS.rawValue :
            return "au"
        case Countries.PER.rawValue :
            return "pe"
        case Countries.DEN.rawValue :
            return "dk"
        case Countries.ARG.rawValue :
            return "ar"
        case Countries.ISL.rawValue :
            return "is"
        case Countries.CRO.rawValue :
            return "cr"
        case Countries.NGA.rawValue :
            return "ng"
        case Countries.BRA.rawValue :
            return "br"
        case Countries.SUI.rawValue :
            return "sz"
        case Countries.CRC.rawValue :
            return "cr"
        case Countries.SRB.rawValue :
            return "sr"
        case Countries.GER.rawValue :
            return "de"
        case Countries.MEX.rawValue :
            return "mx"
        case Countries.SWE.rawValue :
            return "se"
        default:
            return "e"
        }
    }
}
extension UIImageView{

    public func imageFromURL(string : String){
        URLSession.shared.dataTask(with: URL(string:string)!) { (data, resp, err) in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                    
            }
        }.resume()
    }

    
}


