import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final maskFormatter = MaskTextInputFormatter(
    filter: {"#": RegExp(r'[0-9]')},
  );
  final phoneController = TextEditingController();
  final codeController = TextEditingController()..text = '+2';
  final _formKey = GlobalKey<FormState>();
  var phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: double.infinity,
                  height: 200,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "No Need To Add The Number To Your Contacts",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "Lobster",
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      IntlPhoneField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Mobile Number',
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                        initialCountryCode: 'EG',
                        controller: phoneController,
                        inputFormatters: [maskFormatter],
                        validator: (value) {
                          if (value == null || value.completeNumber.isEmpty) {
                            return 'Please Enter a Phone Number';
                          }
                          return null;
                        },
                        onChanged: (phone) {
                          phoneNumber = phone.completeNumber;
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening Whatsapp ....')),
                      );
                      openWhatsapp(phone: phoneNumber);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Open Whatsapp Chat',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void openWhatsapp({@required String? phone}) async {
  var url = Uri.parse("whatsapp://send?phone=" + phone.toString());
  await launchUrl(url);
}
