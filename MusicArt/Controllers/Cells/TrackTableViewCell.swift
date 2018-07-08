//
//  TrackTableViewCell.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    func setWith(_ track: Track) {
        textLabel?.text = track.name
        if let durationInt = Int(track.duration) {
            detailTextLabel?.text = getTimeDescription(for: durationInt)
        }
    }
    
    private func getTimeDescription(for integer: Int) -> String {
        let hours = integer / 3600
        let minutes = (integer % 3600) / 60
        let seconds = (integer % 3600) % 60
        
        let hourPart = hours >= 1 ? "\(hours):" : ""
        let minutePart = "\(minutes):"
        let secondsPart = "\(seconds)"
        
        return hourPart + minutePart + secondsPart
    }
    
}
