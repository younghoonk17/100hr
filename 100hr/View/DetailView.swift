import Foundation
import SwiftUI
import CoreData

struct DetailView: View {
    
    @State var date: Date = Date.now
    @State var time: Int = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Session.entity(), sortDescriptors: [])
    private var sessions: FetchedResults<Session>
    
    var body: some View {
        NavigationView {
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

struct DetailView_preview: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

