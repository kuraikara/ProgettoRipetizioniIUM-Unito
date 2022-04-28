import 'package:flutter/material.dart';
import 'package:ripetizioni_mobile_app/widgets/navigation_controller.dart';
import 'homepage.dart';
import 'package:requests/requests.dart';


class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> fetchData() async{
    
     String email = _emailController.text;
     String password = _passwordController.text;
    final String url = 'http://10.0.2.2:8080/Prenotazioni0_war';
  
    final response = await Requests.post(url + '/login', body: {
      'email': email,
      'password': password,
    });

    dynamic data = response.json();

    print(data);
    
    if(data['status'] == 'ok'){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Color.fromARGB(255, 121, 6, 6)],
            ),
          ),
          child: Stack(children: <Widget>[
            Container(height: double.infinity,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Accedi', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),),
                  SizedBox(height: 30.0,),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.email, color: Colors.white,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,) ,
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,) ,
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: (){
                        
                        fetchData().then((value) => {
                          if( value ){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()))
                         }else{
                          showDialog(
                            // ignore: prefer_const_constructors
                            context: context, builder: (context) => AlertDialog(
                              title: const Text('Errore'),
                              content: const Text('Username o password errati'),
                            ))
                        }
                      });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text('Accedi', style: TextStyle(color: Colors.black, fontSize: 18, letterSpacing: 1.5),),
                      color: Colors.white,
                    ),
                  ),
                  
                ],)
              
            ),
          ],) ,
        )
      ),
    );
  }
}