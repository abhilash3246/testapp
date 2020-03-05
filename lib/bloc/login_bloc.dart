import 'dart:async';
import 'package:testapp/widgets/validator.dart';
import 'package:rxdart/rxdart.dart';



class Login_bloc  extends Object with Validators implements BaseBloc{
  final _emailController = BehaviorSubject<String>();
  final _passwordcontroller = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;
  Function (String) get passwordchanged => _passwordcontroller.sink.add;

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password => _passwordcontroller.stream.transform(passwordValiator);


  Stream<bool> get submitCheck =>
      Observable.combineLatest2(email, password, (e,p)=> true);
  @override
  void dispose() {
    _emailController?.close();
    _passwordcontroller?.close();
  }

}
abstract class BaseBloc{
  void dispose();
}