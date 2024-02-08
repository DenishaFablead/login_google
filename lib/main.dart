import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_google/firebase_options.dart';
import 'package:login_google/service/ems_service.dart';
// import 'package:google_with_login/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

SharedPreferences? sp;
User? user;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sp = await SharedPreferences.getInstance();
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sp!.getBool('gmail') == true ? Guser() : name(),
      // home: razor_pay(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //fontFamily: 'Neonderthaw',
          ),
    );
  }
}

class name extends StatefulWidget {
  name({Key? key}) : super(key: key);

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
// final EmsPdfService _emsPdfService= EmsPdfService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Center(
              child: OutlinedButton(
                onPressed: () async {
                  FirebaseService service = FirebaseService();
                  await service.signInwithGoogle();
                  user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await sp!.setBool('gmail', true);
                    await sp!.setString('username', user!.displayName!);
                    await sp!.setString('useremail', user!.email!);
                    await sp!.setString('userphoto', user!.photoURL!);
              
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Guser()));
                  }
                },
                child: const Text("Gmail With Login"),
              ),
            ),
          //    Center(
          //     child: OutlinedButton(
          //       onPressed: () async {
          //  final data=await _emsPdfService.GeneratePdf();
          //  _emsPdfService.savePdffile("one pdf", data);
          //       },
          //       child: const Text("invoice"),
          //     ),
          //   ),
          ],
        ),
      ),
    );
  }
}

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

class Guser extends StatefulWidget {
  Guser({Key? key}) : super(key: key);

  @override
  State<Guser> createState() => _GuserState();
}

class _GuserState extends State<Guser> {
  bool onSuccess = false;
    bool onSuccesse = false;
  String? payid, playerid,r_paymentid;
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  void _openCheckout() {
    var options = {
      'key': 'YOUR_RAZORPAY_KEY',
      'amount': 100, // Amount in paise
      'name': 'Example Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Center(child: Column(
              children: [ CircleAvatar(
                radius: 50,
                child: Image.network(sp!.getString('userphoto').toString()),
              ),
               Text(sp!.getString('username').toString()),
               Text(sp!.getString('useremail').toString())
              ],
            ),),
            // ListTile(
            //   leading: CircleAvatar(
            //     child: Image.network(sp!.getString('userphoto').toString()),
            //   ),
            //   title: Text(sp!.getString('username').toString()),
            //   subtitle: Text(sp!.getString('useremail').toString()),
            // ),
           SizedBox(height: 10,),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => UsePaypal(
                          sandboxMode: true,
                          clientId:
                              "Ac9XMI-B-Pnp7kQvk5Z3sw9W9DDwnGH5fL7C41RayEissvScmUTA28xLS8JtVWM9S9N32qQqc52nELmv",
                          secretKey:
                              "EEg_2MGGASnS9FYxSOy3ws1th8pK9PUU3TfVZQlTTooHoRaZwupk_3-aQ3vyM-GacAy5FjO9G1sNCUoR",
                          returnURL: "https://samplesite.com/return",
                          cancelURL: "https://samplesite.com/cancel",
                          transactions: const [
                            {
                              "amount": {
                                "total": '10.12',
                                "currency": "USD",
                                "details": {
                                  "subtotal": '10.12',
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              // "payment_options": {
                              //   "allowed_payment_method":
                              //       "INSTANT_FUNDING_SOURCE"
                              // },
                              "item_list": {
                                "items": [
                                  {
                                    "name": "A demo product",
                                    "quantity": 1,
                                    "price": '10.12',
                                    "currency": "USD"
                                  }
                                ],

                                // shipping address is not required though
                                // "shipping_address": {
                                //   "recipient_name": "Jane Foster",
                                //   "line1": "Travis County",
                                //   "line2": "",
                                //   "city": "Austin",
                                //   "country_code": "US",
                                //   "postal_code": "73301",
                                //   "phone": "+00000000",
                                //   "state": "Texas"
                                // },
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            print("onSuccess: $params");
                            setState(() {
                              onSuccess = true;
                              payid = params['paymentId'];
                              playerid = params['payerID'];
                            });
                          },
                          onError: (error) {
                            print("onError: $error");
                          },
                          onCancel: (params) {
                            print('cancelled: $params');
                          }),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:
                        Text("payPal", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ), SizedBox(height: 10,),
             onSuccess == false
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment id : $payid "),
                        Text("Payer id : $playerid "),
                      ],
                    ),
                  ),
             
            InkWell(
              onTap: () {
                //   print("object");
                // MakePayment();

                Razorpay razorpay = Razorpay();
                var options = {
                  'key': 'rzp_test_ZgBWoDTTjFrdoi',
                  'amount': 100, //in the smallest currency sub-unit.
                  'currency': 'INR',
                  'name': 'Actofit',
                  // 'order_id': Your_Generated_Product_Id, // Generate order_id using Orders API
                  'description': 'Product Id. # 1234',
                  'timeout': 60, // in seconds
                  'prefill': {'contact': '', 'email': 'actofit@yopmail.comm'}
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponse);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:
                        Text("razorpay", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
              onSuccesse == false
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment id : $r_paymentid "),
                        // Text("Payer id : $playerid "),
                      ],
                    ),
                  ), SizedBox(height: 10,),
            Center(
              child: OutlinedButton(
                onPressed: () async {
                  FirebaseService service = FirebaseService();
                  await service.signOutFromGoogle();
                  sp!.setBool('gmail', false);
                  sp!.remove('username');
                  sp!.remove('useremail');
                  sp!.remove('userphoto');
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => name()));
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Cancle",
        "${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.data.toString());
    setState(() {
        onSuccesse = true;
         r_paymentid= response.paymentId;
    });
   
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${r_paymentid= response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class razor_pay extends StatefulWidget {
  const razor_pay({super.key});

  @override
  State<razor_pay> createState() => _razor_payState();
}

class _razor_payState extends State<razor_pay> {
  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT:${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE:${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handlePaymentWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS:${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  void MakePayment() async {
    var options = {
      'key': 'rzp_test_ZgBWoDTTjFrdoi',
      'amount': 100,
      'name': 'Acme Corp.',
      'timeout': 120,
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                MakePayment();
              },
              child: Text("BUY"),
            ),
          ),
        ],
      ),
    );
  }
}
