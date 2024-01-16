import 'package:final_project_1/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:file_picker/file_picker.dart';


final theme = ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),

);


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}


class Auth{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  Future <void> sinInWithEmailAndPassword(
    {
      required String email, required String password,
    }
  ) async{
    await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );

  }
  Future <void> signUpWithEmailAndPassword(
    {
      required String email, required String password,
    }
  ) async{
    await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/profile': (context) => ProfilePage(),
      },
      title: "My App",
      debugShowCheckedModeBanner: false,
      
    );
  }
}



class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage = '';
  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Umm! $errorMessage.',
      style: TextStyle(
        color: Colors.red[400],
      ),
    );
  }
FilePickerResult? _img;
Future<void> pickImage() async{
  FilePickerResult? result= await FilePicker.platform.pickFiles(
    type: FileType.image
  );
  if(result!= null){
    setState(() {
      _img= result;
    });
  }else{
    print("no file selected");
  }

}
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
late var c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              _img == null ?
              
              IconButton(
                
                onPressed: (){
                pickImage();
                }, 
              
                icon: Icon(Icons.person ,color: Colors.purple,)
                )
                :
                IconButton(
                onPressed: (){
                pickImage();
                }, 
                
                icon: Image(image: MemoryImage(_img!.files.first.bytes!))
                ),
                SizedBox(height: 15,),
              TextFormField(
                  decoration: const InputDecoration(
            
                              label: Text("Enter Your Email",style: TextStyle(color: Colors.white),),
                              filled: true,
                              fillColor: Colors.purple,
                            enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),   
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),   
                        ),),
                controller: emailController,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
               TextFormField(
                  decoration: const InputDecoration(
            
                              label: Text("Enter Your Full Name",style: TextStyle(color: Colors.white),),
                              filled: true,
                              fillColor: Colors.purple,
                            enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),   
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),   
                        ),),
                controller: fullnameController,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Fullname';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
               decoration: const InputDecoration(
            
                              label: Text("Enter Your Password",style: TextStyle(color: Colors.white),),
                              filled: true,
                              fillColor: Colors.purple,
                            enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),   
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),   
                        ),),
                controller: passwordController,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {

                    _handleSignUp();
                  }
                },
                child: Text('Sign Up',style: TextStyle(color: Colors.purple),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    try{  
      await Auth().signUpWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
        ).whenComplete(() {
          Future.delayed(Duration(seconds: 3)).then((value) {
            UserDetails user= UserDetails(
            fullName: fullnameController.text, 
            email: emailController.text, 
            password: passwordController.text, 
            photourl: photourl);
          var userid= Auth()._auth.currentUser!.uid;
          userref.child("users").child(userid).set(user.toMap()).whenComplete(() {
            Navigator.pushNamed(context, "/profile");
          });
          });
          
        });

    } on FirebaseAuthException catch (e){
      print(e.toString());
    }
  }

  final DatabaseReference userref= FirebaseDatabase.instance.reference();
}
var photourl="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYM-EGcVo86EANXlbWe33sG8GzYd9M6qj6wvNR9RGrQofR2Kmkx4gqgB7ivNShaXYIw60&usqp=CAU";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage = '';
  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Umm! $errorMessage.',
      style: TextStyle(
        color: Colors.red[400],
      ),
    );
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("Meals"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              const Text('Welcome!', style: TextStyle(fontSize: 18.0,color: Colors.purple),textScaleFactor: 2,),
              SizedBox(height: 30,),
              TextFormField(
                controller: _controllerEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
            
                              label: Text("Email",style: TextStyle(color: Colors.white),),
                              filled: true,
                              fillColor: Colors.purple,
                            enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),   
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),   
                        ),),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _controllerPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
               decoration:const InputDecoration(
                              label: Text("Password",style: TextStyle(color: Colors.white),),
                              filled: true,
                              fillColor: Colors.purple,
                             enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),  
                           
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color:Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),   
                        ),
                            ) ,
                obscureText: true,
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  // Implement your forget password logic
                },
                child: GestureDetector(
                  onTap: () {
                   
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'A password reset email has been sent to your email address.'
                      ,style: TextStyle(color: Colors.purple),
                      ),
                    ));
                  },
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forget Password', textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              _errorMessage(),

              const SizedBox(height: 20.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        side: const BorderSide
                        (
                        width: 2, 
                        color: Colors.purple 
                          ),                     
                        primary: Colors.purple, // Background color
                        ),
                
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _handleSignin();
                  }
                },
                
                child: const Text('Sign In', style: TextStyle(color: Colors.white),
              ),),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage () ));
                  
                },
                child: const Text('Don\'t have an account? Sign Up'
               ,style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignin() async {
    try{
      await Auth().sinInWithEmailAndPassword(
        email: _controllerEmail.text, 
        password: _controllerPassword.text
        );
        print("Logged in Successfully");
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TabsScreen() ));
    } on FirebaseAuthException catch(e){
      print(e.message);
    }
    
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserDetails? user;

Future<void> fetchUserData() async {
  String userid= Auth()._auth.currentUser!.uid;
UserDetails? usr= await FirebaseService().getUserDetails(userid);
if(usr != null){
setState(() {
  user= usr;
});
}else{
  print("user not available");
}
}

  @override
  Widget build(BuildContext context) {
    fetchUserData();
    return Scaffold(
      
        appBar: AppBar(
          title: Text('Profile Page'),
        ),
        body: 
        user == null?
        Text("Data Not Found"): 
        ListView(
            children: [
              SizedBox(height: 40,),
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photourl),
                radius: 50,
              ),
              SizedBox(height: 50,),
              Text("The email is : ${user!.email} ",style: TextStyle(color: Colors.purple), textScaleFactor: 1.5,),
              SizedBox(height: 10,),
              Text("The password is: ${user!.password}",style: TextStyle(color: Colors.purple), textScaleFactor: 1.5,),
              SizedBox(height: 10,),
              Text("Full Name is: ${user!.fullName}",style: TextStyle(color: Colors.purple), textScaleFactor: 1.5,)
            ],
          ),

    );
  }
}

class FirebaseService{
  Future<UserDetails?> getUserDetails(String useruid) async{
        try{
          DatabaseReference refh= FirebaseDatabase.instance.ref().child("users");
          DatabaseEvent event= await refh.child(useruid).once();
          if(event.snapshot.value != null){
            Map<dynamic, dynamic> snapdata= event.snapshot.value as dynamic;
            return UserDetails.fromMap(snapdata as Map<dynamic, dynamic>);
          }else{
            return null;
          }
        } catch (e){
          print(e.toString());
        }
       return null; 
  }
}


class UserDetails{
  String email;
  String password;
  String fullName;
  String photourl;
  UserDetails({
    required this.fullName, 
    required this.email,
    required this.password,
    required this.photourl
    });

    Map<dynamic, dynamic> toMap(){
      return {
        "email":email,
        "password":password,
        "fullName": fullName,
        "photourl":photourl
      };
    }
    factory UserDetails.fromMap(Map<dynamic, dynamic> map){
      return UserDetails(
        email: map["email"],
        password: map["password"],
        fullName: map["fullName"],
        photourl: map["photourl"]
      );
    }
}

