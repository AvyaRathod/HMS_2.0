//
//  DAddView.swift
//  HMS
//
//  Created by Anant on 24/04/24.
//

import SwiftUI

import SwiftUI

struct DAddView: View {
    @State private var image: Image?
    @State private var isImagePickerPresented: Bool = false
    @State private var dname: String = ""
    @State private var demp: String = ""
    @State private var demail: String = ""
    @State private var ddepartment: String = ""
    @State private var dpass: String = ""
    @State private var dspecialisationIndex = 0
    @State private var dcontact: String = ""
    @State private var dexperience: String = ""
    @State private var ddegree: String = ""
    @State private var dcabin: String = ""
    @State private var dimage: String = ""
    @State private var isSpecialisationExpanded = false
    @State private var selectedExperienceIndex = 0
    @State private var isExperiencePickerPresented = false
    let yearsOfExperience: [Int] = Array(0...50)
    @State private var dexperienceIndex = 0
    
    let specializations: [DoctorModel.Specialization] = [
        .Cardiologist, .Orthopedic, .Endocrinologist,
        .Gastroenterology, .Hematologist, .Neurologist,
        .Oncologist, .Orthopedist, .Pediatrician,
        .Psychiatrist, .Pulmonologist, .Rheumatologist,
        .Urologist, .Ophthalmologist, .Gynecologist
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack{
                    imageView
                                    .onTapGesture {
                                        self.isImagePickerPresented.toggle()
                                    }
                                    .sheet(isPresented: $isImagePickerPresented) {
                                        ImagePickerView(image: self.$image)
                                    }.padding(.top, 10).padding(.bottom,10).padding()



                }
                
                
                InputFieldView(data: $dname, title: "Name")
                InputFieldView(data: $demp, title: "Employee Id")
                InputFieldView(data: $demail, title: "Email")
                InputFieldView(data: $ddepartment, title: "Department")
                InputFieldView(data: $dpass, title: "Set Password")
                
                ZStack {
                    Picker("Specialisation", selection: $dspecialisationIndex) {
                        ForEach(0..<specializations.count) { index in
                            Text(specializations[index].rawValue)
                                
                        }
                    }
                    .accentColor(.black)
                    .pickerStyle(DefaultPickerStyle())
                    .frame(width: 360, height: 52) // Set frame size to match InputFieldView
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    HStack {
                        Text("Specialisation")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 4)
                            .background(Color.white)
                        Spacer()
                    }
                    .padding(.leading, 18)
                    .offset(y: -25)
                }
                .padding(4)
                
                
                InputFieldView(data: $dcontact, title: "Contact")
                InputFieldView(data: $dexperience, title: "Experience")
                
                
                InputFieldView(data: $ddegree, title: "Degree")
                InputFieldView(data: $dcabin, title: "Cabin No.")
                
                
                Button(action: {
                                    // Print entered data
                                    print("Name: \(dname)")
                                    print("Employee ID: \(demp)")
                                    print("Email: \(demail)")
                                    print("Department: \(ddepartment)")
                                    print("Password: \(dpass)")
                                    print("Specialisation: \(specializations[dspecialisationIndex].rawValue)")
                                    print("Contact: \(dcontact)")
                                    print("Experience: \(dexperience)")
                                    print("Degree: \(ddegree)")
                                    print("Cabin No.: \(dcabin)")
                                }) {
                                    Text("Save")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
            }
            .padding()
            
            
        }
    }
    
    var imageView: some View {
        ZStack {
            if let selectedImage = image {
                selectedImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 125, height: 125)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 125, height: 125)
                    .overlay(Image(systemName: "person.circle.fill")
                                .foregroundColor(.white))
            }
        }
    }
    
    
}


struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: Image?

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: Image?

        init(image: Binding<Image?>) {
            _image = image
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                image = Image(uiImage: uiImage)
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

}

#Preview {
    DAddView()
}
