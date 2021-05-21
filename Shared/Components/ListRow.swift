//
//  ListRow.swift
//  SwiftUITests
//
//  Created by José Mateus Azevedo on 13/05/21.
//

import SwiftUI

struct ListRow: View {

    let item: ProductItem

    var body: some View {
        HStack {
            CheckboxFieldView()
            Text(String(item.itemNumber))
            Text(item.name)
            Spacer()
            Text("R$ \(String(format: "%.2f", item.price))")
        }.padding()
    }
}

struct CheckboxFieldView : View {

    @State var checkState:Bool = false

    var body: some View {
         Button(action: {
                self.checkState = !self.checkState
            }) {
            HStack(alignment: .top, spacing: 10) {
                   Rectangle()
                            .fill(self.checkState ? Color.gray : Color.black)
                            .frame(width:20, height:20, alignment: .center)
                            .cornerRadius(10)
            }
        }
        .foregroundColor(Color.white)
        .buttonStyle(PlainButtonStyle())
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(item: ProductItem(id: UUID.init(), name: "arroz", price: 32.99, itemNumber: 4))
    }
}
