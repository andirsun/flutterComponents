import 'package:flutter/material.dart';
import 'package:flutter_components/src/models/movie_model.dart';
import 'package:flutter_components/src/providers/movies_provider.dart';
import 'package:flutter_components/src/widgets/card_swiper_widget.dart';
import 'package:flutter_components/src/widgets/movie_horizontal.dart';
import 'package:google_fonts/google_fonts.dart';


class MoviesPage extends StatefulWidget {
  MoviesPage({Key key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {

  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: GoogleFonts.righteous(
            color: Colors.white,
            textStyle: Theme.of(context).textTheme.headline5
          ),
        ),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){}
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swipeCards(),
            _footer(context)
          ],
        ),
      )
    );
  }

  Widget _swipeCards() {

    return FutureBuilder(
      future: moviesProvider.getInTheaters(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if(snapshot.hasData){
          return CardSwiper(movies : snapshot.data);
        } else { 
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );
    
  }

  Widget _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Populars',
              style: GoogleFonts.righteous(textStyle: Theme.of(context).textTheme.headline6),
            ),
          ),
          SizedBox(height: 5,),
          FutureBuilder(
            future : moviesProvider.getPopulars(),
            builder: (context,AsyncSnapshot<List<Movie>> snapshot){
              if(snapshot.hasData){
                return MoviesCarousel(movies: snapshot.data);
              }else {
                return Center(child: CircularProgressIndicator());
              }
            }
          )
        ],
      ),
    );
  }
}