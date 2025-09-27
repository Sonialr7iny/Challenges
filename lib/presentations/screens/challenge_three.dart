import 'package:flutter/material.dart';

class ChallengeThree extends StatefulWidget {
  const ChallengeThree({super.key});

  @override
  State<ChallengeThree> createState() => _ChallengeThreeState();
}

class _ChallengeThreeState extends State<ChallengeThree> {

  final Map<Color, bool> _matched = {
    Colors.red: false,
    Colors.green: false,
    Colors.blue: false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[100],
        shape: CircleBorder(),
        onPressed: (){
        setState(() {
         _matched.keys.forEach((color){
           _matched[color]=false;
         });
        });
      },child: Icon(Icons.refresh,color: Colors.black,),),
      appBar: AppBar(
        title:  Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Text("Physics Playground",textAlign: TextAlign.center,),
      ),
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _matched.keys.map((color) {
              if (_matched[color] == true) {
                return const SizedBox(width: 80, height: 80);
              }
              return Draggable<Color>(
                data: color,
                feedback: _buildBall(color, 40,),
                childWhenDragging: _buildBall(color.withOpacity(0.3), 40),
                child: _buildBall(color, 40),
              );
            }).toList(),
          ),

          // Containers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _matched.keys.map((color) {
              return DragTarget<Color>(
                onWillAccept: (incoming) {
                  // Highlight if correct target
                  return true;
                },
                onAccept: (incoming) {
                  setState(() {
                    if (incoming == color) {
                      _matched[color] = true;
                    }
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _matched[color] == true
                          ? color
                          : color.withOpacity(0.6),
                      border: Border.all(
                        color: candidateData.isNotEmpty
                            ? (candidateData.first == color
                            ? Colors.green
                            : Colors.red)
                            : Colors.transparent,

                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(_matched[color]==true?Icons.check:Icons.keyboard_arrow_down,color: Colors.white,)
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBall(Color color, double size, ) {
    return Material(
      shape: const CircleBorder(),
      child: Container(
        width: size * 1,
        height: size * 1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  String colorName(Color color) {
    if (color == Colors.red) return "Red";
    if (color == Colors.green) return "Green";
    if (color == Colors.blue) return "Blue";
    return "Unknown";
  }
}
