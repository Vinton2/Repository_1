//
//  ToDoList+CoreDataProperties.swift
//  Homework_14
//
//  Created by Иван Степанов on 19.05.2021.
//
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var toDoTask: String?

}

extension ToDoList : Identifiable {

}
