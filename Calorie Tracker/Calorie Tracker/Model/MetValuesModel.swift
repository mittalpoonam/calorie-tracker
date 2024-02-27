//
//  MetValuesModel.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 21/02/24.
//

import SwiftUI

struct MetValuesModel: Decodable {
    let sheet1: [Sheet1]

    enum CodingKeys: String, CodingKey {
        case sheet1 = "Sheet1"
    }
}

// MARK: - Sheet1
struct Sheet1: Decodable {
    let activity: ParticularActivity
    let specificMotion: String
    let meTs: Double

    enum CodingKeys: String, CodingKey {
        case activity = "ACTIVITY"
        case specificMotion = "SPECIFIC MOTION"
        case meTs = "METs"
    }
}

enum ParticularActivity: String, Decodable {
    case bicycling = "bicycling"
    case conditioningExercise = "conditioning exercise"
    case dancing = "dancing"
    case fishingAndHunting = "fishing and hunting"
    case homeActivities = "home activities"
    case homeRepair = "home repair"
    case inactivityQuietLight = "inactivity quiet/light"
    case lawnAndGarden = "lawn and garden"
    case miscellaneous = "miscellaneous"
    case musicPlaying = "music playing"
    case occupation = "occupation"
    case religiousActivities = "religious activities"
    case running = "running"
    case selfCare = "self care"
    case sexualActivity = "sexual activity"
    case sports = "sports"
    case transportation = "transportation"
    case volunteerActivities = "volunteer activities"
    case walking = "walking"
    case waterActivities = "water activities"
    case winterActivities = "winter activities"
}

