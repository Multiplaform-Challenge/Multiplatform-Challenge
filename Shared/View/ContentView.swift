//
//  ContentView.swift
//  Shared
//
//  Created by José Mateus Azevedo on 11/05/21.
// swiftlint:disable identifier_name

import SwiftUI

struct ContentView: View {

    @State var showSheet = false
    @StateObject private var shoppingListVM = ShoppingListViewModel()
    @StateObject var shoppingList = ShoppingListDemo()

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    MoneyDetails()
                    HStack {
                        Text("Minha Lista")
                        Spacer()
                        Button("Adicionar produto") {
                            showSheet.toggle()
                        }
                    }.padding()

                    List {
                        ForEach(shoppingListVM.itens, id: \.id) { item in
                            ListRow(item: ItemList(name: item.name, price: item.price, quantity: item.quantity, isChecked: item.isChecked))
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
                                Image(systemName: "gearshape")
                            })
                    }
                }
            }
            .onAppear(perform: {
                shoppingListVM.getAllItens()
            })
            AddProductModalView(isShowing: $showSheet)
        }
    }

    func deleteItem(at offsets: IndexSet) {
            offsets.forEach { index in
                let item = shoppingListVM.itens[index]
                shoppingListVM.delete(item)
            }
            shoppingListVM.getAllItens()
        }
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
