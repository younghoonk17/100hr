//
//  TestView.swift
//  100hr
//
//  Created by Yh on 6/03/23.
//

import Foundation
import SwiftUI
import CoreData

struct TestView: View {
    
    @State var date: Date = Date.now
    @State var time: Int = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Session.entity(), sortDescriptors: [])
    private var sessions: FetchedResults<Session>
    
    var body: some View {
        NavigationView {
//            VStack {
//                DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
//                    Text("Select a date")
//                }
//                TextField("Product quantity", value: $time, formatter: NumberFormatter())
//
//                HStack {
//                    Spacer()
//                    Button("Add") {
//                        addProduct()
//                    }
//                    Spacer()
//                    Button("Clear") {
//                        date = Date.now
//                        time = 0
//                    }
//                    Spacer()
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
                
                List {
                    ForEach(sessions) { s in
                        HStack {
                            Text(s.date ?? Date.now, style: .date)
                            Spacer()
                            Text("\(s.time)")
                        }
                    }
                    .onDelete(perform: deleteProducts)
                }
        }
    }
    
    private func addProduct() {
        withAnimation {
            let session = Session(context: viewContext)
            session.time = Int64(time)
            session.date = date
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
    
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { sessions[$0] }.forEach(viewContext.delete)
                saveContext()
            }
    }
    
}

struct TestView_preview: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

