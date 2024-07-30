//
//  ViewModel.swift
//  Demo App
//
//  Created by Subodh Jondhale on 30/07/24.
//

import Foundation

class ViewModel {

    // MARK: - Properties

    var pages: [Page] = []

    // MARK: - Initializer

    init() {
        loadData()
    }

    // MARK: - Private Helpers

    private func loadData() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("Failed to locate JSON file.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let items = try JSONDecoder().decode([Page].self, from: data)
            self.pages = items
        } catch {
            print("Failed to load JSON file: \(error.localizedDescription)")
        }
    }
}

