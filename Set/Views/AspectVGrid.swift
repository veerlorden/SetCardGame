//
//  AspectVGrid.swift
//  Set
//
//  Created by Вадим Буркин on 12.07.2021.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var minimumPossibleCardWidth: CGFloat = 55
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            let minimumWidth: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
            
            if minimumWidth < minimumPossibleCardWidth {
                ScrollView(showsIndicators: false) {
                    createGrid(with: minimumPossibleCardWidth)
                        .padding(10)
                }
                .padding(-10)
            } else {
                VStack {
                    createGrid(with: minimumWidth)
                    Spacer(minLength: 0)
                }
            }
        }
    }
    
    private func createGrid(with cardWidth: CGFloat) -> some View {
        LazyVGrid(columns: [adaptiveGridItem(width: cardWidth)], spacing: 0)  {
            ForEach(items) { item in
                content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        
        return floor(size.width / CGFloat(columnCount))
    }
}
