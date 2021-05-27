import SwiftUI

struct ContentView: View {

    @State var showSheet = false
    @StateObject private var shoppingListVM = ShoppingListViewModel()

    var body: some View {
        NavigationView {
          VStack {
            MoneyDetails()
            HStack {
                Text("Minha Lista")
                Spacer()
                Button("Adicionar produto") {
                    shoppingListVM.name = "Macarrão"
                    shoppingListVM.save()
                    shoppingListVM.getAllItens()
                }
//                    showSheet.toggle()
//                }.sheet(isPresented: self.$showSheet, content: {
//                    Text("sfsdfdsf")
//                })
            }.padding()

            List {
                ForEach(shoppingListVM.itens, id: \.id) { item in
                    ListRow(item: ItemList(name: item.name, price: item.price, quantity: Int(item.quantity), isChecked: item.isChecked))
                }
                .onDelete(perform: deleteItem)
                .onTapGesture {
                    self.showSheet.toggle()
                }
            }
            .sheet(isPresented: self.$showSheet, content: {
                Text("Tela de editar")
            })
          }
          .navigationBarTitle("Compras da semana")
          .listStyle(GroupedListStyle())
        }
        .onAppear(perform: {
            shoppingListVM.getAllItens()
        })
    }

    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let item = shoppingListVM.itens[index]
            shoppingListVM.delete(item)
        }
        shoppingListVM.getAllItens()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
