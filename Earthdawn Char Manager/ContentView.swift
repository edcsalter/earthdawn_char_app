//
//  ContentView.swift
//  Earthdawn Char Manager
//
//  Created by Ed Salter on 9/8/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showAddCharacterDialog = false
	@State private var newCharacterName = ""
	@State private var characterName = ""
	
    @FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Character.name, ascending: true)],
        animation: .default)
	private var characters: FetchedResults<Character>

    var body: some View {
		NavigationView {
			List {
				ForEach(characters) { character in
					NavigationLink {
						Text("Item at \(character.name!)")
					} label: {
						Text(character.name!)
					}
				}
				.onDelete(perform: deleteItems)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
				ToolbarItem {
					Button(action: {
						showAddCharacterDialog = true
					}) {
						Label("Add Item", systemImage: "plus")
					}
				}
			}
			.navigationTitle("Characters")
			.navigationBarTitleDisplayMode(.inline)
			Text("Select an item")
		}
		.sheet(isPresented: $showAddCharacterDialog) {
			usernamePrompt()
		}
    }

	private func addCharacter() {
		withAnimation {
			let newChar = Character(context: viewContext)
			newChar.name = newCharacterName
			newCharacterName = ""
			
			do {
				try viewContext.save()
			} catch {
				// Handle the Core Data error appropriately
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { characters[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
	
	@ViewBuilder func usernamePrompt() -> some View {
		VStack {
			Text("New Character")
				.font(.headline)
				.padding()

			TextField("Enter character name", text: $newCharacterName)
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding()

			// OK Button
			Button("OK") {
				characterName = newCharacterName
				showAddCharacterDialog = false
				addCharacter()
			}
			.padding()

			// Cancel Button
			Button("Cancel") {
				showAddCharacterDialog = false
			}
			.padding()
		}
		.padding()
	}
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
