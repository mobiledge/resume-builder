import SwiftUI

fileprivate typealias DeleteHandler = (WorkExperience) -> Void
fileprivate typealias AddHandler = (WorkExperience) -> Void
fileprivate typealias CanMoveUpHandler = (WorkExperience) -> Bool
fileprivate typealias MoveUpHandler = (WorkExperience) -> Void
fileprivate typealias CanMoveDownHandler = (WorkExperience) -> Bool
fileprivate typealias MoveDownHandler = (WorkExperience) -> Void

struct WorkExperienceForm: View {

    @Bindable var collection: WorkExperienceCollection

    var body: some View {

        Form {
            ForEach(collection.items) { exp in
                WorkExperienceSection(
                    experience: exp,
                    canMoveUpHandler: canMoveUp(_:),
                    moveUpHandler: moveUp(_:),
                    canMoveDownHandler: canMoveDown(_:),
                    moveDownHandler: moveDown(_:),
                    deleteHandler: deleteWorkExperience(_:)
                )
            }
        }
        .formStyle(.grouped)
    }

    func deleteWorkExperience(_ experience: WorkExperience) {
        withAnimation {
            collection.items.removeAll { $0.id == experience.id }
        }
    }

    func addWorkExperience(_ experience: WorkExperience) {
        withAnimation {
            collection.items.append(experience)
        }
    }

    func canMoveUp(_ experience: WorkExperience) -> Bool {
        // Check if the experience exists in the array and is not the first item
        guard let index = collection.items.firstIndex(where: { $0.id == experience.id }) else {
            return false
        }
        return index > 0
    }

    func moveUp(_ experience: WorkExperience) -> Void {
        guard let index = collection.items.firstIndex(where: { $0.id == experience.id }),
              canMoveUp(experience) else {
            return
        }

        // Swap the experience with the one above it
        withAnimation {
            collection.items.swapAt(index, index - 1)
        }
    }

    func canMoveDown(_ experience: WorkExperience) -> Bool {
        // Check if the experience exists in the array and is not the last item
        guard let index = collection.items.firstIndex(where: { $0.id == experience.id }) else {
            return false
        }
        return index < collection.items.count - 1
    }

    func moveDown(_ experience: WorkExperience) -> Void {
        guard let index = collection.items.firstIndex(where: { $0.id == experience.id }),
              canMoveDown(experience) else {
            return
        }

        // Swap the experience with the one below it
        withAnimation {
            collection.items.swapAt(index, index + 1)
        }
    }
}

struct WorkExperienceSection: View {
    @Bindable var experience: WorkExperience

    fileprivate let canMoveUpHandler: CanMoveUpHandler
    fileprivate let moveUpHandler: MoveUpHandler
    fileprivate let canMoveDownHandler: CanMoveDownHandler
    fileprivate let moveDownHandler: MoveDownHandler
    fileprivate let deleteHandler: DeleteHandler

    // Date formatter for displaying dates
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {

        Section(experience.companyName) {
            TextField("Company Name", text: $experience.companyName)

            TextField("Position", text: $experience.position)

            TextField("Location", text: $experience.location)

            DatePicker(
                "Start Date",
                selection: Binding(
                    get: { experience.startDate ?? Date() },
                    set: { experience.startDate = $0 }
                ),
                displayedComponents: .date
            )

            Toggle("Current Position", isOn: $experience.isCurrentPosition)

            if !experience.isCurrentPosition {
                DatePicker(
                    "End Date",
                    selection: Binding(
                        get: { experience.endDate ?? Date() },
                        set: { experience.endDate = $0 }
                    ),
                    displayedComponents: .date
                )
            }

            TextEditor(text: $experience.description)
                .textEditorStyle(.plain)
                .frame(minHeight: 60)

            actionButtons
        }
    }

    var actionButtons: some View {
        HStack(spacing: 20) {
            Spacer()

            Button(action: {
                moveDownHandler(experience)
            }, label: {
                Label("Move Down", systemImage: "arrowshape.down")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })
            .disabled(!canMoveDownHandler(experience))

            Button(action: {
                moveUpHandler(experience)
            }, label: {
                Label("Move Up", systemImage: "arrowshape.up")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })
            .disabled(!canMoveUpHandler(experience))

            Button(action: {
                deleteHandler(experience)
            }, label: {
                Label("Delete", systemImage: "trash")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })
        }
        .buttonStyle(.plain)
        .foregroundStyle(Color.secondary)
    }
}

#Preview {
    WorkExperienceForm(collection: WorkExperienceCollection.mock)
}

