import 'dart:async';


 mixin Validators{
   var emailValidator = StreamTransformer<String,String>.fromHandlers(
     handleData: (email,sink){
       if(email.contains("@")){
         sink.add(email);
       }else{
         sink.addError("Email is not valid");
       }
     }

   );

   var passwordValiator = StreamTransformer<String,String>.fromHandlers(
     handleData:(password,sink){
       if(password.length>3){
         sink.add(password);
       }else{
         sink.addError("Password length should greater than 3");
       }
     }
   );
 }