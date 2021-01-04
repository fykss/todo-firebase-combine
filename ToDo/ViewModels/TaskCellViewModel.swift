//
//  TaskCellViewModel.swift
//  ToDo
//
//  Created by Vladyslav Lietun on 17.12.2020.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var taskRepository = TaskRepository()
    @Published var task: Task
    @Published var complitionStateImageName = ""
    var id = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.complitionStateImageName, on: self)
            .store(in: &subscriptions)
        
        $task
            .compactMap { task in
                task.id
            }
            .assign(to: \.id, on: self)
            .store(in: &subscriptions)
        
        $task
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { task in
                self.taskRepository.updateTask(task: task)
            }
            .store(in: &subscriptions)
    }
}
