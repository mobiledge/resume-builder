//
//  ContentView.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-03-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Print") {
                Resume.sampleResume.log()
            }
            Button("Create PDF") {

                let textFont = UIFont.systemFont(ofSize: 24.0, weight: .regular)

                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .natural
                paragraphStyle.lineBreakMode = .byWordWrapping

                let attributes = [
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.font: textFont
                ]

                let attributedString = NSAttributedString(
                    string: lorem,
                    attributes: attributes
                )

                PDFBuilder().draw(attributedString: attributedString)

            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

let lorem = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et arcu lorem. Duis vulputate augue sapien, eu rutrum massa eleifend et. Nulla ultricies auctor enim, sed commodo nunc ultricies id. Phasellus sed euismod lacus, non congue eros. Nulla scelerisque est sit amet hendrerit pretium. Pellentesque sollicitudin nisl volutpat dapibus posuere. Cras vulputate, urna eget interdum tempus, erat dui vehicula enim, non gravida leo dolor id lectus. Aliquam leo augue, pharetra eu purus eu, pretium volutpat nunc. Fusce eleifend eget augue fringilla facilisis.

Morbi posuere nibh erat, id consectetur augue lacinia sed. Quisque consequat mauris eget sapien porta, quis laoreet nisl cursus. Nulla congue blandit luctus. Quisque sed pulvinar velit, eu tincidunt purus. Praesent nibh nibh, euismod at arcu ut, mattis consectetur est. Quisque eu mauris ut orci cursus tincidunt sed a elit. Maecenas mi turpis, pulvinar non augue eget, ornare tristique sem. Curabitur ultricies ex nulla, in sagittis tellus sollicitudin vitae. Nam imperdiet venenatis mauris, vel commodo enim rutrum ut. In fringilla eros id tellus consectetur, ac pretium magna vehicula. Sed nisi dui, porta a accumsan at, faucibus ut elit. Aliquam laoreet dolor leo, at dapibus elit tristique non.

Morbi laoreet auctor libero ac mollis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam vitae pretium dolor, ut fermentum sem. Nulla facilisi. Phasellus finibus pellentesque dui, eget eleifend urna varius at. Suspendisse sit amet maximus nibh. Donec volutpat fringilla magna ut auctor.

Donec ut justo ornare, facilisis sem ac, eleifend libero. Pellentesque vel neque erat. Sed non gravida ligula. Vivamus et nisl vitae massa semper porta tristique quis libero. Nam ut lectus eget risus mattis sagittis. Aliquam at pulvinar risus, id varius risus. Cras enim urna, varius ornare varius a, auctor sit amet velit. Ut vehicula rhoncus quam vitae sodales. Aliquam eu risus nisi. Proin aliquet auctor velit vel pellentesque. Nulla facilisi. Aenean viverra lacus ante, commodo rutrum tellus imperdiet non.

Cras nisl elit, luctus quis gravida sed, vestibulum eu nisi. Nullam nec eros pulvinar, molestie dui consequat, aliquet erat. Etiam pellentesque posuere laoreet. Morbi et est ut neque dictum iaculis. Proin maximus rutrum libero at scelerisque. Nam venenatis lacus ac nisi mollis, ac imperdiet leo imperdiet. Mauris blandit placerat eleifend. Aliquam erat volutpat. Mauris volutpat lacus erat, id consectetur lorem finibus tincidunt. Donec tristique finibus dui non sodales. Sed diam urna, congue eget vestibulum in, ornare a felis.
"""
