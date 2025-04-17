import SwiftUI

fileprivate typealias DeleteHandler = (Education) -> Void
fileprivate typealias AddHandler = (Education) -> Void
fileprivate typealias CanMoveUpHandler = (Education) -> Bool
fileprivate typealias MoveUpHandler = (Education) -> Void
fileprivate typealias CanMoveDownHandler = (Education) -> Bool
fileprivate typealias MoveDownHandler = (Education) -> Void

struct EducationForm: View {

    @Bindable var collection: EducationCollection

    var body: some View {

        Form {
            ForEach(collection.items) { edu in
                EducationSection(
                    education: edu,
                    canMoveUpHandler: canMoveUp(_:),
                    moveUpHandler: moveUp(_:),
                    canMoveDownHandler: canMoveDown(_:),
                    moveDownHandler: moveDown(_:),
                    deleteHandler: deleteEducation(_:)
                )
            }

            AddEducationSection(
                addHandler: addEducation(_:)
            )
        }
        .formStyle(.grouped)
    }

    func deleteEducation(_ education: Education) {
        withAnimation {
            collection.items.removeAll { $0.id == education.id }
        }
    }

    func addEducation(_ education: Education) {
        withAnimation {
            collection.items.append(education)
        }
    }

    func canMoveUp(_ education: Education) -> Bool {
        // Check if the education exists in the array and is not the first item
        guard let index = collection.items.firstIndex(where: { $0.id == education.id }) else {
            return false
        }
        return index > 0
    }

    func moveUp(_ education: Education) -> Void {
        guard let index = collection.items.firstIndex(where: { $0.id == education.id }),
              canMoveUp(education) else {
            return
        }

        // Swap the education with the one above it
        withAnimation {
            collection.items.swapAt(index, index - 1)
        }
    }

    func canMoveDown(_ education: Education) -> Bool {
        // Check if the education exists in the array and is not the last item
        guard let index = collection.items.firstIndex(where: { $0.id == education.id }) else {
            return false
        }
        return index < collection.items.count - 1
    }

    func moveDown(_ education: Education) -> Void {
        guard let index = collection.items.firstIndex(where: { $0.id == education.id }),
              canMoveDown(education) else {
            return
        }

        // Swap the education with the one below it
        withAnimation {
            collection.items.swapAt(index, index + 1)
        }
    }
}

struct EducationSection: View {
    @Bindable var education: Education

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

        Section(education.institution) {
            TextField("Institution", text: $education.institution)

            TextField("Degree", text: $education.degree)

            TextField("Field of Study", text: $education.fieldOfStudy)

            TextField("Location", text: $education.location)

            DatePicker(
                "Start Date",
                selection: $education.startDate,
                displayedComponents: .date
            )

            if education.endDate != nil {
                DatePicker(
                    "End Date",
                    selection: Binding(
                        get: { education.endDate ?? Date() },
                        set: { education.endDate = $0 }
                    ),
                    displayedComponents: .date
                )
            }

            Toggle("Currently Studying", isOn: Binding(
                get: { education.endDate == nil },
                set: { isCurrentlyStudying in
                    education.endDate = isCurrentlyStudying ? nil : Date()
                }
            ))

            actionButtons
        }
    }

    var actionButtons: some View {
        HStack(spacing: 20) {
            Spacer()

            Button(action: {
                moveDownHandler(education)
            }, label: {
                Label("Move Down", systemImage: "arrowshape.down")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })
            .disabled(!canMoveDownHandler(education))

            Button(action: {
                moveUpHandler(education)
            }, label: {
                Label("Move Up", systemImage: "arrowshape.up")
                    .labelStyle(.iconOnly)
                    .font(.caption)
            })
            .disabled(!canMoveUpHandler(education))

            Button(action: {
                deleteHandler(education)
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

struct AddEducationSection: View {
    @State private var education = Education.empty
    fileprivate let addHandler: AddHandler

    // Date formatter for displaying dates
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {

        Section("Add Education") {
            TextField("Institution", text: $education.institution)

            TextField("Degree", text: $education.degree)

            TextField("Field of Study", text: $education.fieldOfStudy)

            TextField("Location", text: $education.location)

            DatePicker(
                "Start Date",
                selection: $education.startDate,
                displayedComponents: .date
            )

            if education.endDate != nil {
                DatePicker(
                    "End Date",
                    selection: Binding(
                        get: { education.endDate ?? Date() },
                        set: { education.endDate = $0 }
                    ),
                    displayedComponents: .date
                )
            }

            Toggle("Currently Studying", isOn: Binding(
                get: { education.endDate == nil },
                set: { isCurrentlyStudying in
                    education.endDate = isCurrentlyStudying ? nil : Date()
                }
            ))

            addButton
        }
    }

    var addButton: some View {
        HStack(spacing: 20) {
            Spacer()
            Button("Add", systemImage: "plus") {
                addHandler(education)
                education = Education.empty // reset
            }
            .buttonStyle(.plain)
            .disabled(education.institution.isEmpty || education.degree.isEmpty)
        }
    }
}

#Preview {
    EducationForm(collection: EducationCollection.mock)
}

#Preview {
    Form {
        AddEducationSection { _ in }
    }
    .formStyle(.grouped)
}
