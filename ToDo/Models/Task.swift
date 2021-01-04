//
//  Task.swift
//  ToDo
//
//  Created by Vladyslav Lietun on 17.12.2020.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

#if DEBUG
let testDataTasks = [
    Task(title: "First thing", completed: true),
    Task(title: "Second thing", completed: false),
    Task(title: "Third thing", completed: false),
    Task(title: "Fourth thing", completed: false),
]
#endif
