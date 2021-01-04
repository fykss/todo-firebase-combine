//
//  TaskListViewModel.swift
//  ToDo
//
//  Created by Vladyslav Lietun on 17.12.2020.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var taskListViewModel = [TaskCellViewModel]()
    @Published var taskRepository = TaskRepository()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        taskRepository
            .$tasks
            .map { tasks in
                tasks.map { task in
                    TaskCellViewModel(task: task)
                }
            }
            .assign(to: \.taskListViewModel, on: self)
            .store(in: &subscriptions)
        
        self.taskListViewModel = testDataTasks.map { task in
            TaskCellViewModel(task: task)
        }
    }
    
    func addTask(task: Task) {
        taskRepository.addTask(task: task)
    }
}
