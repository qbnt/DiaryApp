//
//  Diary.swift
//  diary_app
//
//  Created by Quentin Banet on 17/03/2025.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

// ------------- Diary ------------- //
class Diary: ObservableObject {
    @Published var entries: [DiaryEntry] = []
    private var db = Firestore.firestore()
    
    init() {
        fetchEntries()
    }
    
    func fetchEntries() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Pas d'utilisateur connecté")
            return
        }

        db.collection("diaryEntries")
            .document(userID)
            .collection("entries")
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Erreur lors de la récupération des entrées : \(error)")
                    return
                }

                self.entries = querySnapshot?.documents.compactMap { document in
                    let entry = try? document.data(as: DiaryEntry.self)
                    entry?.firestoreID = document.documentID
                    return entry
                } ?? []
            }
    }
    
    func addEntry(_ entry: DiaryEntry) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        do {
            try db.collection("diaryEntries")
                .document(userID)
                .collection("entries")
                .addDocument(from: entry)
        } catch {
            print("Erreur lors de l'ajout de l'entrée : \(error)")
        }
        fetchEntries()
    }
    
    func deleteEntry(_ entry: DiaryEntry) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        guard let firestoreID = entry.firestoreID else {
            print("Erreur : ID Firestore non trouvé")
            return
        }
        db.collection("diaryEntries")
            .document(userID)
            .collection("entries")
            .document(firestoreID)
            .delete { error in
                if let error = error {
                    print("Erreur lors de la suppression de l'entrée : \(error)")
                } else {
                    print("Entrée supprimée avec succès")
                    self.fetchEntries()
                }
            }
    }
}

//  MockData - Preview  //
extension Diary {
    static var preview: Diary {
        let diary = Diary()
        diary.entries = [
            DiaryEntry(username: "alice@example.com",
                       date: Date(),
                       title: "Une journée ensoleillée",
                       feeling: feelings.joy,
                       text: "Aujourd'hui, le soleil était au rendez-vous et j'ai passé une superbe journée."),
            DiaryEntry(username: "bob@example.com",
                       date: Date().addingTimeInterval(-86400),
                       title: "Un jour difficile",
                       feeling: feelings.sadness,
                       text: "Hier a été un peu compliqué, mais j'espère que demain ira mieux."),
            DiaryEntry(username: "charlie@example.com",
                       date: Date().addingTimeInterval(-172800),
                       title: "Réflexions",
                       feeling: feelings.fear,
                       text: "Il est temps de réfléchir à de nouveaux projets et objectifs.")
        ]
        return diary
    }
}


// ------------- DiaryEntry ------------- //
class DiaryEntry: Codable, Identifiable {
    var id = UUID()
    var firestoreID: String?
    var usermail: String
    var date: Date
    var title: String
    var feeling: feelings
    var text: String
    
    init(username: String, date: Date, title: String, feeling: feelings, text: String) {
        self.usermail = username
        self.date = date
        self.title = title
        self.feeling = feeling
        self.text = text
    }
}
