import 'package:flutter/material.dart';
import 'package:particle_field/particle_field.dart';
import 'package:rnd/rnd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Particle Field Demo',
      debugShowCheckedModeBanner: false,
      home: ParticleFieldExample(),
    );
  }
}

class ParticleFieldExample extends StatelessWidget {
  const ParticleFieldExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpriteSheet sparkleSpriteSheet = SpriteSheet(
      image: const AssetImage('assets/images/particle-21x23.png'),
      frameWidth: 21,
    );

    final ParticleField field = ParticleField(
      spriteSheet: sparkleSpriteSheet,
      origin: Alignment.topLeft,
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        particles.add(Particle(x: rnd(size.width), vx: rnd(-1, 1)));
        for (int i = particles.length - 1; i >= 0; i--) {
          Particle particle = particles[i];
          particle.update(vy: particle.vy + 0.1, frame: particle.frame + 1);
          if (!size.contains(particle.toOffset())) particles.removeAt(i);
        }
      },
    );

    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home,color: Colors.white,),
            Icon(Icons.notifications,color: Colors.white),
            Icon(Icons.settings,color: Colors.white),
            Icon(Icons.people,color: Colors.white),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("Particle Field Effect",style: TextStyle(fontSize: 15),),
      ),
      body: DefaultTextStyle(
        style: const TextStyle(),
        child: Container(
          color: const Color(0xFF110018),
          child: Stack(children: [
            Positioned.fill(
              child: Transform.scale(scale: 1.05, child: field),
            ),
          ]),
        ),
      ),
    );
  }
}