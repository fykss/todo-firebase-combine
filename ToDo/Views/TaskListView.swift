//
//  ContentView.swift
//  ToDo
//
//  Created by Vladyslav Lietun on 17.12.2020.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListViewModel = TaskListViewModel()
    
    @State var presentAddNewTask = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListViewModel.taskListViewModel) { taskCellViewModel in
                        TaskCellView(taskCellViewModel: taskCellViewModel)
                    }
                    if presentAddNewTask {
                        TaskCellView(taskCellViewModel: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskListViewModel.addTask(task: task)
                            self.presentAddNewTask.toggle()
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                Button(action: { self.presentAddNewTask.toggle() }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                        Text("Add New Task")
                    }
                })
                .padding()
            }
            .navigationBarTitle("Tasks")
        }
    }
    
    let imageSize: CGFloat = 25
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCellView: View {
    @ObservedObject var taskCellViewModel: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellViewModel.complitionStateImageName)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .onTapGesture {
                    self.taskCellViewModel.task.completed.toggle()
                }
            TextField("Enter your task", text: $taskCellViewModel.task.title, onCommit:  {
                self.onCommit(taskCellViewModel.task)
            })
        }
    }
    
    let imageSize: CGFloat = 25
}
