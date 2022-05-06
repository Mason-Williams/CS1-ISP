import Foundation
import Scenes
import Igis

/*
 This class is responsible for rendering the background.
 */

//hope you have fun playing our game
class Background : RenderableEntity {
    func renderBuildingA(canvas: Canvas, rect: Rect, color: Color.Name){
        let rectangle = Rectangle(rect: rect, fillMode: .fill)
        let fill = FillStyle(color : Color(color))
        canvas.render(fill, rectangle)
    }

    func renderBuildingB(canvas: Canvas, rect: Rect, color: Color.Name){
        let rectangle = Rectangle(rect: rect, fillMode: .fill)
        let fill = FillStyle(color : Color(color))
        canvas.render(fill, rectangle)
    }
    let bladee : Image
    var width = 0
    var height = 0
    
    
    init() {
        guard let bladeeURL = URL(string:"https://codermerlin.com/users/mason-williams/ispbackground.png") else {
            fatalError("Failed to create URL for bladee")
        }
        // Using a meaningful name can be helpful for debugging
        
        bladee = Image(sourceURL : bladeeURL)
        super.init(name:"Background")
    }

    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }

    

    override func setup(canvasSize:Size, canvas:Canvas) {
        canvas.setup(bladee)
        width = canvasSize.width
        height = canvasSize.height
        
    }

    override func render(canvas:Canvas) {
        clearCanvas(canvas:canvas)
        if bladee.isReady {
            bladee.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:width, height:height)))
            canvas.render(bladee)
        


    }

    

    
      


    
}
}
