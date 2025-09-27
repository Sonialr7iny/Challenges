import 'package:challenges/presentations/screens/challenge_three.dart';
import 'package:flutter/material.dart';

class ChallengeTwo extends StatefulWidget {
  const ChallengeTwo({super.key});

  @override
  State<ChallengeTwo> createState() => _ChallengeTwoState();
}

class _ChallengeTwoState extends State<ChallengeTwo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int dotCount = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    const totalDuration = 1500;
    const dotDuration = 500;

    final start = (dotDuration * index) / totalDuration;
    final end = start + (dotDuration / totalDuration);

    final animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(start, end, curve: Curves.linear),
    );

    final sizeTween = Tween<double>(begin: 12.0, end: 100.0);
    final opacityTween = Tween<double>(begin: 0.5, end: 1.0);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final size = sizeTween.evaluate(animation);
        final opacity = opacityTween.evaluate(animation);
        return Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sequential Loading Dots', textAlign: TextAlign.center),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_sharp)),
        actions: [
          IconButton(onPressed: (){Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChallengeThree()),
          );}, icon: Icon(Icons.navigate_next_rounded,size: 40,)),
        ],
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
              dotCount, (index) => _buildDot(index)),
        ),
      ),
    );
  }
}