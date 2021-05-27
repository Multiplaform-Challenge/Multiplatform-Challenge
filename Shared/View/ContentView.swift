//
//  ContentView.swift
//  Shared
//
//  Created by José Mateus Azevedo on 11/05/21.
// swiftlint:disable identifier_name

import SwiftUI

enum TypeModal {
    case addModal
    case editModal
}

struct ContentView: View {

    @State var showSheet = false
    @State var showWithoutPriceModal = false
    @State var itemSelect: ProductItem? = nil
    @StateObject var shoppingListVM = ShoppingListViewModel()
    @StateObject var shoppingList = ShoppingListDemo()
    @State var typeModal: TypeModal = .addModal

    init() {
        let appearance = UINavigationBar.appearance()
        appearance.largeTitleTextAttributes = [.font : UIFont(name: FontNameManager.Poppins.bold, size: 30)!]
        appearance.backgroundColor = UIColor(named: "BackgroundColor")
    }

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    MoneyDetails(shoppingListVM: shoppingListVM)
                    HStack {
                        Text("Minha Lista")
                            .font(Font.custom(FontNameManager.Poppins.bold, size: 24))
                        Spacer()
                        Button(action: {
                            self.typeModal = .addModal
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
                        ForEach(shoppingListVM.itens, id: \.id) { item in
                            ListRow(item: item,
                                    isShowingWithoutPriceModal: $showWithoutPriceModal,
                                    action: {
                                        self.itemSelect = item
                                    }, shoppingListVM: shoppingListVM)
                                .onTapGesture {
                                    self.itemSelect = item
                                    self.typeModal = .editModal
                                    self.showSheet.toggle()
                                }
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .listStyle(PlainListStyle())
                    .colorMultiply(Color("BackgroundColor")).padding(.top)
                }
                .navigationBarTitle("Compras da semana")
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
            .onAppear(perform: {
                shoppingListVM.getAllItens()
            })
            WithoutPriceModalView(isShowing: $showWithoutPriceModal,
                                  shoppingListVM: shoppingListVM,
                                  item: itemSelect)
            modalView(typeModal)
        }
    }

    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let item = shoppingListVM.itens[index]
            shoppingListVM.delete(item)
        }
        shoppingListVM.getAllItens()
    }

    func modalView(_ type: TypeModal) -> some View {
        switch type {
        case .addModal:
            return AddProductModalView(isEdit: false,
                                       isShowing: $showSheet,
                                       shoppingListVM: shoppingListVM)
        case .editModal:
            return AddProductModalView(isEdit: true,
                                       item: itemSelect,
                                       isShowing: $showSheet,
                                       shoppingListVM: shoppingListVM)
        }
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
