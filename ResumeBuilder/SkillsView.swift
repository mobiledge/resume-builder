import SwiftUI

struct SkillSection: View {

    @Binding var skill: Skill

    var body: some View {
        Section {
            
            TextField(text: $skill.category, prompt: Text("Enter Skill Category")) {
                Text("Category")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
            }
            
            TextField(text: $skill.values, prompt: Text("Enter comma seperated skills")) {
                Text("Skills")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }


    }
}
#Preview(body: {
    Form {
        SkillSection(skill: .constant( Skill(category: "Languages", values: "Swift, Objective-C, C++, C")))
    }.formStyle(.grouped)
})

struct SkillsView: View {
    @State private var skills: Skills = Skills.mock
    @State private var newCategory: String = ""
    @State private var newValues: String = ""

    var body: some View {
        NavigationStack {
            Form {

                ForEach($skills.items) { $skill in
                    SkillSection(skill: $skill)
                }

                // Add new skill section
                Section("Add New Skill") {
                    TextField("Category", text: $newCategory)

                    TextField("Values (comma separated)", text: $newValues)

                    Button("Add Skill") {
                        if !newCategory.isEmpty && !newValues.isEmpty {
                            let newSkill = Skill(category: newCategory, values: newValues)
                            skills.items.append(newSkill)
                            newCategory = ""
                            newValues = ""
                        }
                    }
                    .disabled(newCategory.isEmpty || newValues.isEmpty)
                }
            }
            .formStyle(.grouped)
            .navigationTitle("Skills Manager")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: addEmptySkill) {
                        Label("Add Skill", systemImage: "plus")
                    }
                }
            }
        }
        .frame(minWidth: 400, minHeight: 500)
    }

    private func deleteSkill(at offsets: IndexSet) {
        skills.items.remove(atOffsets: offsets)
    }

    private func addEmptySkill() {
        skills.items.append(Skill(category: "", values: ""))
    }
}

#Preview {
    SkillsView()
}

/*
 struct SkillsSection: View {
 @Binding var skillsModel: Skills
 @State private var newSkillKey: String = ""
 @State private var newSkillValues: String = ""
 @FocusState private var focusedField: FormField?

 enum FormField {
 case skillKey, skillValues, existingSkillValues
 }

 var body: some View {
 Section("Professional Skills") {
 // Display existing skills

 ForEach(skillsModel.items.indices, id: \.self) { index in
 VStack(alignment: .leading) {
 Text(skillsModel.items[index].category)
 .font(.headline)

 TextField("Skill values", text: Binding(
 get: { skillsModel.items[index].values },
 set: { newValue in
 var updatedSkill = skillsModel.items[index]
 updatedSkill.values = newValue
 skillsModel.items[index] = updatedSkill
 }
 ))
 .focused($focusedField, equals: .existingSkillValues)
 .textFieldStyle(RoundedBorderTextFieldStyle())
 }
 .padding(.vertical, 4)
 }
 .onDelete(perform: deleteSkill)

 // Add new skill
 HStack {
 TextField("Skill Category", text: $newSkillKey)
 .focused($focusedField, equals: .skillKey)
 .textFieldStyle(RoundedBorderTextFieldStyle())
 .frame(width: 150)

 TextField("Skill Values (comma separated)", text: $newSkillValues)
 .focused($focusedField, equals: .skillValues)
 .textFieldStyle(RoundedBorderTextFieldStyle())

 Button(action: addSkill) {
 Image(systemName: "plus.circle.fill")
 .foregroundColor(.blue)
 }
 .buttonStyle(BorderlessButtonStyle())
 .disabled(newSkillKey.isEmpty)
 }
 .padding(.top, 8)
 }
 }

 private func addSkill() {
 // Convert key to capital case as specified
 let formattedKey = newSkillKey
 .trimmingCharacters(in: .whitespacesAndNewlines)
 .capitalized

 guard !formattedKey.isEmpty else { return }

 skillsModel.items.append(Skill(
 category: formattedKey,
 values: newSkillValues.trimmingCharacters(in: .whitespacesAndNewlines)
 ))

 // Clear fields after adding
 newSkillKey = ""
 newSkillValues = ""
 focusedField = .skillKey
 }

 private func deleteSkill(at offsets: IndexSet) {
 skillsModel.items.remove(atOffsets: offsets)
 }
 }



 // Preview
 struct SkillsSection_Previews: PreviewProvider {
 static var previews: some View {
 Form {
 SkillsSection(skillsModel: .constant(Skills.mock))
 }
 .formStyle(.grouped)
 .frame(width: 600, height: 400)
 }
 }

 // Usage example in a parent view
 struct SkillsFormView: View {
 @State private var skillsModel = Skills.mock

 var body: some View {
 Form {
 SkillsSection(skillsModel: $skillsModel)
 }
 .padding()
 .frame(width: 700, height: 500)
 .formStyle(.grouped)
 }
 }
 */
