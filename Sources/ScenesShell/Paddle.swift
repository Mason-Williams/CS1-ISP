import Igis
import Scenes

class Paddle: RenderableEntity {
    var rectangle: Rectangle

    init(rect:Rect) {
        rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)

        // Using a meaningful name can be helpful for debugging
        super.init(name: "Paddle")
    }

    override func render(canvas:Canvas) {
        let strokeStyle = StrokeStyle(color:Color(.black))
        let fillStyle = FillStyle(color:Color(.white))
        let lineWidth = LineWidth(width:2)
        canvas.render(strokeStyle, fillStyle, lineWidth, rectangle)
    }

    func move(to point:Point) {
        rectangle.rect.topLeft = point
    }

    override func boundingRect() -> Rect {
        return rectangle.rect
        //return Rect(topLeft:Point(x:rectangle.center.x, y:rectangle.center.y),size: Size(width: rectangle.rect.width, height: rectangle.rect.height))
    }

    override func calculate(canvasSize:Size) {
        let canvasBoundingRect = Rect(size:canvasSize)

        let paddleBoundingRect = Rect(topLeft:Point(x:rectangle.rect.center.x,y:rectangle.rect.center.y), size:Size(width:rectangle.rect.width,height:rectangle.rect.height))

        let tooFarUp = paddleBoundingRect.topLeft.y < canvasBoundingRect.topLeft.y
        let tooFarDown = paddleBoundingRect.bottomLeft.y > canvasBoundingRect.bottomLeft.y

        if tooFarUp {
        self.move(to: Point(x:paddleBoundingRect.topLeft.x,y:paddleBoundingRect.topLeft.y))
        } else if tooFarDown {
        self.move(to: Point(x:canvasBoundingRect.topLeft.x,y:canvasBoundingRect.bottomLeft.y))
        }
    }

}




