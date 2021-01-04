//
//  TaskRepository.swift
//  ToDo
//
//  Created by Vladyslav Lietun on 17.12.2020.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    
    private let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("tasks")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId!)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap { document in
                    do {
                        let doc = try document.data(as: Task.self)
                        return doc
                    }
                    catch {
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    func addTask(task: Task) {
        do {
            var addedTask = task
            addedTask.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("tasks").addDocument(from: addedTask)
        }
        catch {
            fatalError("Something wrong: \(error)")
        }
    }
    
    func updateTask(task: Task) {
        if let taskId = task.id {
            do {
                let _ = try db.collection("tasks").document(taskId).setData(from: task)
            }
            catch {
                fatalError("Something wrong: \(error)")
            }
        }
    }
}
