import 'package:flutter/material.dart';
import 'ball.dart';
import 'bat.dart';

enum Direction{up, down, left, right}

class Pong extends StatefulWidget {
  const Pong({Key? key}) : super(key: key);

  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  late double width;
  late double height;
  double increment = 3.0;
  double posx = 0;
  double posy = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  late Animation animation;
  late AnimationController controller;

  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  @override
  void initState() {

    width = 0;
    height = 0;

    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10)
    );

    animation = Tween(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      setState(() {
        vDir == Direction.down ? posy += increment : posy -= increment;
        hDir == Direction.right ? posx += increment : posx -= increment;
      });

      checkBorders();
      print("width: $width");
      print("height: $height");
      print("posy: $posy");
      print("posx: $posx");

    });
    controller.forward();//Iniciar la animación
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){

        height = constraints.maxHeight;
        width = constraints.maxWidth;
        batWidth = width / 5;
        batHeight = height / 25;

        return Stack(
          children: [
            Positioned(
              child: Ball(),
              top: posx,
              left: posy,
            ),
            Positioned(
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails update) => moveBat(update),
                child: Bat(null, batWidth, batHeight),
              ),
              left: batPosition,
              bottom: 0,
            )
          ],
        );
      }),
    );
  }

  void moveBat(DragUpdateDetails update){
    setState(() {
      batPosition +=  update.delta.dx;
    });
  }


  void checkBorders(){
    if(posx <= 0 && hDir == Direction.left){
      hDir == Direction.right;
    }

    if(posx >= width && hDir == Direction.right){
      hDir == Direction.left;
    }

    if(posy <= 0 && vDir == Direction.up){
      vDir == Direction.down;
    }

    if(posx >= height && vDir == Direction.down){
      vDir == Direction.up;
    }
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

}
