//
//  Idioms.swift
//  chinese idiom of the day
//
//  Created by George Li on 11/29/24.
//

import Foundation
import SwiftUI

struct Idiom: Codable {
    let id: String
    let idiom: String
    let pinyin: String
    let translation: String
    let examples: [Example]
}

struct Example: Codable {
    let sentence: String
    let translation: String
}

func loadIdiomsJSON() -> [Idiom]? {
    guard let url = Bundle.main.url(forResource: "idioms", withExtension: "json"),
          let data = try?  Data(contentsOf: url),
          let idioms = try? JSONDecoder().decode([Idiom].self, from:data) else {
        return nil
    }
    return idioms
}

func getDailyIdioms() -> [Idiom] {
    // Check for the last date and stored idioms
    let today = Calendar.current.startOfDay(for: Date())
    let lastDate = UserDefaults.standard.object(forKey: "lastIdiomDate") as? Date
    let savedIdioms = UserDefaults.standard.object(forKey: "dailyIdioms") as? Data
    let decoder = JSONDecoder()
    
    // If it's the same day, return the previously saved idioms
    if let lastDate, Calendar.current.isDate(today, inSameDayAs: lastDate),
       let savedIdioms = savedIdioms,
       let decodedIdioms = try? decoder.decode([Idiom].self, from: savedIdioms) {
        return decodedIdioms
    }
    
    // Otherwise, load idioms JSON only for a new day
    guard let idioms = loadIdiomsJSON(), !idioms.isEmpty else { return [] }
    print("Loading idioms JSON for a new day...")
    
    // Pick new idioms
    let newIdioms = pickRandomIdioms(from: idioms, count: 1)
    let encoder = JSONEncoder()
    if let encodedIdioms = try? encoder.encode(newIdioms) {
        UserDefaults.standard.set(today, forKey: "lastIdiomDate")
        UserDefaults.standard.set(encodedIdioms, forKey: "dailyIdioms")
    }
    
    return newIdioms
}

func pickRandomIdioms(from idioms: [Idiom], count: Int) -> [Idiom] {
    guard idioms.count >= count else { return idioms }
    return Array(idioms.shuffled().prefix(count))
}

func placeHolderIdiom() -> Idiom {
    Idiom(id: "0", idiom: "学无止境", pinyin: "xué wú zhǐ jìng", translation: "Learning is endless.", examples: [
        Example(
            sentence: "知识的海洋无边无际，我们应该秉持学无止境的态度。",
            translation: "The ocean of knowledge is boundless; we should embrace the attitude that learning is endless."
        ),
        Example(
            sentence: "虽然他已经取得了很多成就，但他仍然坚持学无止境，努力学习新知识。",
            translation: "Although he has achieved a lot, he still adheres to the principle of endless learning and strives to learn new knowledge."
        ),
        Example(
            sentence: "学无止境，这句话提醒我们要不断追求进步，不要停滞不前。",
            translation: "Learning is endless—this saying reminds us to continuously strive for progress and never remain stagnant."
        ),
    ])
}
