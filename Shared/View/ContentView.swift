//
//  ContentView.swift
//  Shared
//
//  Created by José Mateus Azevedo on 11/05/21.
// swiftlint:disable identifier_name

import SwiftUI

struct ContentView: View {

    @State private var newItem = ""
    @State private var allItens: [ItemList] = []
    private let key = "ItensKey"
    @State var showSheet = false
    @StateObject var shoppingList = ShoppingListDemo()

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    MoneyDetails()
                    HStack {
                        Text("Minha Lista")
                            .font(Font.custom(FontNameManager.Poppins.bold, size: 24))
                        Spacer()
                        Button(action: {
                            showSheet.toggle()
                        }) {
                            Text("Adicionar produto")
                                .frame(height: 10)
                                .font(Font.custom(FontNameManager.Poppins.medium, size: 17))
                                .padding()
                                .background(Color("AccentColor"))
                                .foregroundColor(Color("TitleColor"))
                                .cornerRadius(40)
                        }
                    }.padding()

                    List {
                        ForEach(allItens) { item in
                            ListRow(item: ProductItem(id: UUID.init(), name: "arroz", price: 32.99, itemNumber: 4))
                        }
                        .onDelete(perform: deleteItem)
                        .onTapGesture {
                            self.showSheet.toggle()
                        }
                    }
                }
                .navigationBarTitle("Compras da semana")
                .listStyle(GroupedListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(
                            destination: SettingsView(shoppingList: shoppingList),
                            label: {
                                Image(systemName: "gearshape.fill")
                            })
                    }
                }
                .background(Color("BackgroundColor"))
            }
            .onAppear(perform: loadList)
            AddProductModalView(isShowing: $showSheet)
        }
    }

    private func saveList() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.allItens), forKey: key)
    }

    private func loadList() {
        if let todosData = UserDefaults.standard.value(forKey: key) as? Data {
            if let todosList = try? PropertyListDecoder().decode(Array<ItemList>.self, from: todosData) {
                self.allItens = todosList
            }
        }
    }

    private func deleteItem(at offsets: IndexSet) {
        self.allItens.remove(atOffsets: offsets)
        saveList()
    }
}

struct ItemList: Codable, Identifiable {
    var id = UUID()
    let itemName: String
}

class ShoppingListDemo: ObservableObject {
    @Published var objective: String = ""
    @Published var budget: Double = 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
