import 'package:sembast/sembast.dart';
import 'package:testapp/database/app_database.dart';
import 'package:testapp/model/fruit.dart';



class FruitDao{
  static const String FRUIT_STORE_NAME = 'fruits';
  final _fruitStore = intMapStoreFactory.store(FRUIT_STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;
  Future insert(Fruit fruit) async{
    await _fruitStore.add(await _db, fruit.toMap());

  }
  Future update(Fruit fruit) async {
    final finder  = Finder(filter: Filter.byKey(fruit.id));
    await _fruitStore.update(
      await _db,
      fruit.toMap(),
      finder: finder,
    );
  }
  Future delete(Fruit fruit) async{
    final finder = Finder(filter: Filter.byKey(fruit.id));
    await _fruitStore.delete(
      await _db,
      finder: finder,

    );
  }
  Future<List<Fruit>> getAllStoredByName()async {
    final finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);

    final recordSnapshots = await _fruitStore.find(
      await _db,
      finder: finder,
    );
    return recordSnapshots.map((snapshots){
      final fruit = Fruit.fromMap(snapshots.value);
      fruit.id = snapshots.key;
      return fruit;
    }).toList();
  }


}
