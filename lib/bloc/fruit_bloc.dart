import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:testapp/model/fruit.dart';
import 'package:testapp/model/fruit_dao.dart';
import 'fruit_event.dart';
import 'fruit_state.dart';


class FruitBloc extends Bloc<FruitEvent, FruitState> {
  FruitDao _fruitDao = FruitDao();

  @override
  // TODO: implement initialState
  FruitState get initialState => FruitsLoading();

  @override
  Stream<FruitState> mapEventToState(FruitEvent event,) async* {
    if (event is LoadFruits) {
      yield FruitsLoading();
      yield* _reloadFruits();
    } else if (event is AddRandomFruit) {
      await _fruitDao.insert(RandomFruitGenerator.getRandomFruit());
      yield* _reloadFruits();
    } else if (event is UpdateWithRandomFruit) {
      final newFruuit = RandomFruitGenerator.getRandomFruit();
      newFruuit.id = event.updateFruit.id;
      await _fruitDao.update(newFruuit);
      yield* _reloadFruits();
    } else if (event is DeleteFruit) {
      await _fruitDao.delete(event.fruit);
      yield*_reloadFruits();
    }
  }
  Stream<FruitState> _reloadFruits() async*{
    final fruits  = await _fruitDao.getAllStoredByName();
    yield FruitsLoaded(fruits);
  }
}
class RandomFruitGenerator{
  static final _fruits = [
    Fruit(name: 'Banana', isSweet: true),
    Fruit(name :'apple',isSweet: false ),
    Fruit(name: 'mango',isSweet: true),
    Fruit(name: 'Strawberry', isSweet: true),
    Fruit(name: 'Kiwi', isSweet: false),
    Fruit(name: 'Apple', isSweet: true),
    Fruit(name: 'Pear', isSweet: true),
    Fruit(name: 'Lemon', isSweet: false),

  ];
  static Fruit getRandomFruit(){
    return _fruits[Random().nextInt(_fruits.length)];
  }

}

