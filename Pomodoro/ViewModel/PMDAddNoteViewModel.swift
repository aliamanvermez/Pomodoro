//
//  PMDAddNoteViewModel.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 11.09.2023.
//

import Foundation
import CoreData
import UIKit

class PMDAddNoteViewModel {
    
    func saveNote(title: String, note: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName:"Note", in: context)
        let newNote = NSManagedObject(entity: entity!, insertInto: context)
        newNote.setValue(title, forKey: "title")
        newNote.setValue(note, forKey: "note")
        newNote.setValue(UUID(), forKey: "id")
        newNote.setValue(Date(), forKey: "date")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

}
