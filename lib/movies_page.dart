import 'package:flutter/material.dart';
class MoviesPage extends StatefulWidget {
  final String imageData;
  final String infoData;
  final List<String> rating;
  final String actors;
  final String director;
  const MoviesPage({super.key,
  required this.rating,
  required this.imageData,
  required this.infoData,
  required this.actors,
  required this.director,
  });

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   appBar: AppBar(
    title: const Text('Movies Detail Page '),
    centerTitle: true,
   ),
   body:  Padding(
     padding: const EdgeInsets.symmetric(horizontal: 10.0),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 400,
          height: 490,
          child: Image.network(widget.imageData,fit: BoxFit.cover,),
        ),
        const SizedBox(height: 20,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             for(int i = 0; i<3;i++)
             Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black
              ),
              child:Center(
                child: Text(
                widget.rating[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                  ),
                  )
                  ),
             
             
             ),
           ],
         ),
        const SizedBox(height: 20,),
        Text('Description: ${widget.infoData}',textAlign: TextAlign.justify,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
        Text('Directed By: ${widget.director}',style: const TextStyle(fontWeight: FontWeight.bold),),
               Text('Actor: ${widget.actors}',style: const TextStyle(fontWeight: FontWeight.bold)),
     
      ],
     ),
   ),
    );
  }
}