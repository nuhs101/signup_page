import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Builder Signup',
      home: SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: FormBuilderValidators.required(
                  errorText: 'Please enter some text',
                ),
              ),
              const SizedBox(height: 10),

              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Email is required',
                  ),
                  FormBuilderValidators.email(errorText: 'Enter a valid email'),
                ]),
              ),
              const SizedBox(height: 10),

              FormBuilderDateTimePicker(
                name: 'dob',
                inputType: InputType.date,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                validator: FormBuilderValidators.required(
                  errorText: 'Please select your date of birth',
                ),
              ),
              const SizedBox(height: 10),

              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Password is required',
                  ),
                  FormBuilderValidators.minLength(
                    8,
                    errorText: 'Password must be at least 8 characters',
                  ),

                  FormBuilderValidators.match(
                    RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$'),
                    errorText:
                        'Password must contain at least one uppercase letter and one number',
                  ),
                ]),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signup Successful!')),
                    );
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
