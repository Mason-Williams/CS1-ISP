import Foundation
import Scenes
import Igis

/*
 This class is responsible for rendering the background.
 */


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
    
    
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
        
    }

    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }

    override func render(canvas:Canvas) {
        //    clearCanvas(canvas:canvas)
        let buildingRectA = Rect(topLeft: Point(x: 0, y:0), size: Size(width: 4000,height: 1000))
        
        renderBuildingA(canvas: canvas, rect: buildingRectA, color: .green)

        let buildingRectB = Rect(topLeft: Point(x:0, y: 0), size: Size(width: 4000,height: 700))
        
        renderBuildingB(canvas: canvas, rect: buildingRectB, color: .blue)

        let ellipse = Ellipse(center:Point(x:400, y:800), radiusX:200, radiusY:75, fillMode: .fill)
        canvas.render(ellipse)


    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        
        
    }

    

    
      


    
}

