# AuroraView

Showcasing a technique used to create performant Aurora gradients (blurred blobs) in SwiftUI on macOS.


## Problem
To achieve this effect in SwiftUI, you would typically create Shapes and using the `.blur` modifier.
This would incur a heavy performance penalty while animating (up to 50% CPU).

## Solution
By using a CALayer and Core Animation to animate the blobs, we can offload all the work to the WindowServer & GPU. The result is an app CPU utilization of 0%.
A CALayer overlay is also used a noise filter to smooth out the banding artifacts that are common in blurred color gradients.
A NSViewRepresentable is ued to make everything accessible from SwiftUI.
