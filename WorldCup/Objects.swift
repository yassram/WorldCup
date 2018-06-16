//
//  Objects.swift
//  WorldCup
//
//  Created by Yassir RAMDANI on 10/06/2018.
//  Copyright © 2018 Yassir RAMDANI. All rights reserved.
//

import Foundation


struct Match:  Decodable {
    
    var venue : String!
    var location : String!
    var datetime : String!
    var status : String!
    var time : String!
    var fifa_id : String!
    var winner : String!
    var winner_code : String!
    var home_team : Team!
    var away_team : Team!
    
    var home_team_events : [MatchEvent?]!
    var away_team_events : [MatchEvent?]!

    // //   var away_team_events : [T]?
//
    var events : [MatchEvent?]! = []
    
    private enum CodingKeys: String, CodingKey {
        case venue, location, datetime, status, time, fifa_id, winner, winner_code, home_team, away_team, home_team_events,away_team_events
    }
   
    init(from decoder : Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        venue = try? container?.decode(String.self, forKey: .venue) ?? ""
        location = try? container?.decode(String.self, forKey: .location) ?? ""
        datetime = try? container?.decode(String.self, forKey: .datetime) ?? ""
        status = try? container?.decode(String.self, forKey: .status) ?? ""
        fifa_id = try? container?.decode(String.self, forKey: .fifa_id) ?? ""
        winner = try? container?.decode(String.self, forKey: .winner) ?? ""
        winner_code = try? container?.decode(String.self, forKey: .winner_code) ?? ""
        home_team = try? container?.decode(Team.self, forKey: .home_team) ?? Team()
        away_team = try? container?.decode(Team.self, forKey: .away_team) ?? Team()
        
        if home_team.country != "To Be Determined"{
            home_team_events = try? container?.decode([MatchEvent?].self, forKey: .home_team_events) ?? []
            away_team_events = try? container?.decode([MatchEvent?].self, forKey: .away_team_events) ?? []
            
            home_team_events.forEach({ (me) in
                if var me = me{
                    me.isHomeEvent = true
                    events.append(me)
                }
            })
            away_team_events.forEach({ (me) in
                if var me = me{
                    me.isHomeEvent = false
                    events.append(me)
                }
            })
            
            events.sort(by: { (m1, m2) -> Bool in
                return m1?.id ?? 0 < m2?.id ?? 1
            })
            
        }

    }
    
}
struct  MatchEvent: Decodable {

    var id : Int!
    var type_of_event :String!
    var player :String!
    var time :String!
    var isHomeEvent : Bool!
}

struct Team : Decodable {
    var id :Int!
    var country :String!
    var fifa_code :String!
    var group_id :Int!
    var group_letter :String!
    
    var code :String!
    var goals :Int!
}





