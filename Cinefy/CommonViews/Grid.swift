//
//   Grid.swift
//  Memorize-Example
//
//  Created by vobach on 06/05/2021.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    private var items: [Item]
    private var viewForItems: (Item) -> ItemView
    
    init(items: [Item], viewForItems: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItems = viewForItems
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let itemIndex = items.firstIndex(matching: item)!
        return viewForItems(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height, alignment: .center)
            .position(layout.location(ofItemAt: itemIndex))
        
    }
}

extension Array where Element: Identifiable {
    func firstIndex(matching item: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == item.id {
                return index
            }
        }
        return nil
    }
}


