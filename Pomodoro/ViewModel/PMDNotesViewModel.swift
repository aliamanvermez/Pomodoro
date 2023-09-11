//
//  PMDNotesViewModel.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 11.09.2023.
//

import Foundation
import UIKit
import CoreData
class PMDNotesViewModel{
    
    var noteTitleArray = [String]()
    var noteIDArray = [UUID]()
    var selectedNote = ""
    var selectedNoteID : UUID?
    
    @objc func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let noteTitle = result.value(forKey: "title") as? String {
                    self.noteTitleArray.append(noteTitle)
                }
                if let noteID = result.value(forKey: "id") as? UUID {
                    self.noteIDArray.append(noteID)
                }
            }
            
        }catch {
            print("Error")
        }
    }
}
