//
//  Enum.swift
//  diary_app
//
//  Created by Quentin Banet on 17/03/2025.
//

enum MenuOption: String, CaseIterable, Identifiable {
    case home
    case calendar
    
    var id: String { self.rawValue }
}

enum feelings: String, CaseIterable, Identifiable, Codable {
    case joy = "Happy"
    case sadness = "Sad"
    case anger = "Angry"
    case fear = "Fearful"
    case love = "Love"
    case surprise = "Surprised"
    case disgust = "Disgusted"
    case neutral = "Neutral"
    
    var id: String { self.rawValue }
    
    var emoji: String {
        switch self {
        case .joy: return "😃"
        case .sadness: return "😢"
        case .anger: return "😡"
        case .fear: return "😨"
        case .love: return "❤️"
        case .surprise: return "😲"
        case .disgust: return "🤢"
        case .neutral: return "😐"
        }
    }
}
