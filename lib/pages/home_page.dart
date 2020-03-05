import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/bloc/fruit_bloc.dart';
import 'package:testapp/bloc/fruit_event.dart';
import 'package:testapp/bloc/fruit_state.dart';
import 'package:testapp/model/fruit.dart';

class Homepage extends StatefulWidget{
  _HomePageState createState() => _HomePageState();

}
 class _HomePageState extends State<Homepage>{
  FruitBloc _fruitBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fruitBloc = BlocProvider.of<FruitBloc>(context);
    _fruitBloc.dispatch(LoadFruits());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Fruit app'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _fruitBloc.dispatch(AddRandomFruit());
        },
      ),



    );
  }
   Widget _buildBody(){
    return BlocBuilder(
      bloc: _fruitBloc,
      builder: (BuildContext context, FruitState state) {
        if (state is FruitsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FruitsLoaded) {
          return ListView.builder(
              itemCount: state.fruits.length,
              itemBuilder: (context, index) {
                final displayedFruit = state.fruits[index];
                return ListTile(
                  title: Text(displayedFruit.name),
                  subtitle: Text(
                      displayedFruit.isSweet ? 'very sweet' : 'soo sour'),
                  trailing: _buildUpdateDeleteButtons(displayedFruit),
                );
              },
          );
        }
      },
    );
  }
  Row _buildUpdateDeleteButtons(Fruit displayfruit){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: (){
            _fruitBloc.dispatch(UpdateWithRandomFruit(displayfruit));
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: (){
            _fruitBloc.dispatch(DeleteFruit(displayfruit));
          },
        ),
      ],

    );
  }

 }