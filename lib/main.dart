import "package:flutter/material.dart";

void main()
{
  runApp(Myapp());
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: BMI(),
    );
  }
}

class Myapp extends StatefulWidget
{
  const Myapp({super.key});
  @override
  State<Myapp> createState()=>_MyappState();
}
class BMI extends StatefulWidget
{
  BMI({super.key});
  @override
  State<BMI> createState()=>_BMI();
}
class _BMI extends State<BMI>
{
  GlobalKey<FormState> _formkey=GlobalKey();
  TextEditingController age=TextEditingController();
  TextEditingController height=TextEditingController();
  TextEditingController weight=TextEditingController();
  bool isshow=false;
  var bmi=0.0;
  String result='';
  Color colorresult=Colors.red;
  void calculateBMI(int weight, int height) {
       bmi = weight / ((height / 100) * (height / 100)); // Correct BMI calculation
     print(bmi);
    if (bmi < 16.0) {
      result = 'Severely Underweight';
      colorresult=Colors.red;
    } else if (bmi >= 16.0 && bmi <= 16.9) {
      result = 'Moderately Underweight';
      colorresult=Colors.orange;
    } else if (bmi >= 17.0 && bmi <= 18.4) {
      result = 'Mildly Underweight';
      colorresult=Colors.yellow;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      result = 'Normal Weight';
      colorresult=Colors.green;
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      result = 'Overweight';
      colorresult=Colors.yellow;
    } else if (bmi >= 30.0 && bmi <= 34.9) {
      result = 'Obese Class I (Moderate)';
      colorresult=Colors.orange;
    } else if (bmi >= 35.0 && bmi <= 39.9) {
      result = 'Obese Class II (Severe)';
      colorresult=Colors.red;
    } else {
      result = 'Obese Class III (Very Severe)';
      colorresult=Colors.red.shade900;
    }

    setState(() {  // Ensure this function is inside a StatefulWidget
      isshow = true;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(20.0),
         child: Form(
           key:_formkey,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                     Text("BMI Calculator",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: 20,),
                          TextFormField(
                            controller: age,
                             validator: (value)
                            {
        
                              if(value==null || value.isEmpty)
                                return 'Please enter age';
                              else if (int.parse(value) < 18)
                                return 'age shoud be >18';
                              else
                                return null;
        
                            },
                            decoration: const InputDecoration(
                              label: Text("Age"),
        
                              border: OutlineInputBorder()
                            ),
                            keyboardType: TextInputType.number,
        
                          ),
                         SizedBox(height: 20,),
                         TextFormField(
                           controller: height,
                           validator: (value)
                           {
        
                             if(value==null || value.isEmpty)
                               return 'Please enter height';
                             else
                               return null;
        
                           },
                           decoration: const InputDecoration(
                             label: Text("Height"),
                             prefix: Text("CM:"),
                               border: OutlineInputBorder(),
        
                           ),
                           keyboardType: TextInputType.number,
                         ),
                         SizedBox(height: 20,),
                         TextFormField(
                           controller: weight,
                           validator: (value)
                           {
        
                             if(value==null || value.isEmpty)
                               return 'Please enter wight';
                             else
                               return null;
        
                           },
                           decoration: const InputDecoration(
                             label: Text("Weght "),
                             prefix: Text("KG:"),
                               border: OutlineInputBorder(),
        
                           ),
                           keyboardType: TextInputType.number,
                         ),
                       ],
                     ),
                   SizedBox(height: 20,),
                   Container(
                     width: 350,
                     height: 45,
                     child: ElevatedButton(
                       onPressed: (){
                         if(_formkey.currentState!.validate())
                           {
                             calculateBMI(int.parse(weight.text), int.parse(height.text));
                           }
                       }, child: Text("Calculate BMI",style: TextStyle(fontWeight: FontWeight.bold),),
                     style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(0)
                         ),
                         elevation: 5,
                         backgroundColor: Colors.blueAccent
                     ),
                     ),
                   ),
               SizedBox(height: 20,),
               isshow?Center(
                 child: Container(
                   child:Column(
                     children: [
                       Text("BMI: ${bmi.toStringAsFixed(2)}"),
                       Text("$result",style: TextStyle(color: colorresult),),
                     ],
                   ),
                 ),
               ):SizedBox.shrink()
        
             ],
           ),
         ),
        ),
      ),
    );
  }
}