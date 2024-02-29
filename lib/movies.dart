import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/movies_page.dart';

class Movies extends StatefulWidget {
  const Movies({super.key,});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  final List<String> ratingNames = ['IMBD' ,'Rotten Tomatoes', 'Metacritic'];
  
  Future <Map<String,dynamic>> getMovies () async {
 

    final data = await http.get(Uri.parse('https://www.omdbapi.com/?i=tt3896198&apikey=c1cbc0fd'));
    if(data.statusCode == 200){
       final response = jsonDecode(data.body);
       //print(response);
        return response;
    }  
    else {
      throw 'An Unexpected Error';
    }
   
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        centerTitle: true,
      ),
      body: Column(
         children: [
            FutureBuilder(
              future: getMovies(),
              builder:(context,snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return  const Center(child:  CircularProgressIndicator.adaptive());
                }
                if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                final response = snapshot.data!;
                 final imageData = response['Poster'];
                 final yearData = response['Year'];
                 final infoData = response['Plot'];
                 final titleData = response['Title'];
                 
                 final actors = response['Actors'];
                 final director = response['Director'];
                 final List<String> rating = [response['Ratings'][0]['Value'],
                  response['Ratings'][1]['Value'],
                  response['Ratings'][2]['Value'],
                  ];
                 
                return ListTile(
                  leading: SizedBox(
                   
                    width: 80,
                    child: GestureDetector(
                      onTap: (){
                       
                         
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  MoviesPage(imageData: imageData,
                      infoData: infoData,
                      rating: rating,
                      director: director,
                      actors: actors,
                      ratingNames: ratingNames
                      )
                      )
                      );
                      },
                    
                      child: Image.network(imageData,fit: BoxFit.cover,)),
                  ),
                title: Text(titleData.toString()),
                subtitle: Text(yearData),
              );
              },
            )
         ],
      ),
    );
  }
}