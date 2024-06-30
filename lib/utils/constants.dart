class Constants {
  //Sign-Up
  static String signUpTitle = 'Create Account';
  static String emailFieldSignUp = 'Enter email';
  static String emailFieldErrorSignUp = 'Enter correct email';
  static String masterPasswordFieldSignUp = 'Enter Master Password';
  static String masterPasswordFieldEmptySignUp = 'Please enter password';
  static String masterPasswordFieldErrorSignUp = 'Enter valid password';
  static String masterPasswordDescriptionSignUp =
      'The master password is the one you use to log in to this account. It is important that you do not lose your master password. If you forget your password, there is no way to recover it.';
  static String confirmMasterPasswordFieldSignUp = 'Enter Confirm Password';
  static String confirmMasterPasswordFieldErrorSignUp2 =
      'Please enter confirm master password';
  static String confirmMasterPasswordFieldErrorSignUp = 'Password not matching';
  static String masterPasswordHintFieldSignUp = 'Enter Master Password Hint';
  static String masterPasswordHintFieldEmptySignUp =
      'Please enter master password hint';
  static String submitButtonTitleSignUp = 'Sign Up';
  static String agreementStatementSignUp = 'Terms of service, Privacy policy';
  static String signInTitleButtonSignUp = 'Login';
  static String signInDescButtonSignUp = 'Already have account?';

  //Sign-In
  static String logInTitle = 'Login';
  static String emailFieldLogIn = 'Enter email';
  static String emailFieldErrorLogIn = 'Enter correct email';
  static String masterPasswordFieldLogIn = 'Enter Master Password';
  static String masterPasswordFieldEmptyLogIn = 'Please enter master password';
  static String masterPasswordFieldErrorLogIn = 'Enter valid master password';
  static String masterPasswordHint = 'Get Master Password Hint';
  static String submitButtonTitleLogIn = 'Login';
  static String notAmemberSubtextLogIn = 'Not a member?';

  static String addAccountTitle = 'Add Vault';
  static String viewAccountTitle = 'View Vault';
  static String editAccountTitle = 'Edit Vault';

  //Hive Storage name
  static String hiveStorageName = 'sivaji_secure';

  //Links
  static const String emptyIconPath =
      'https://firebasestorage.googleapis.com/v0/b/cipherkey-a6262.appspot.com/o/Company%20Logo%2Fempty_icon_2.png?alt=media&token=65e83cc8-8bd6-4401-aa67-aa8cb449b529';
  static const String agreementLink =
      'https://www.app-privacy-policy.com/live.php?token=JvqWdaPVMFtGq5vzD1JU1WxMZY29bs0S';

  //Gemini System Instruction
  static String geminiSystemInstruction = """
This AI model is designed to provide information and guidance on cybersecurity awareness and the specific features and functionalities of an application that monitors URLs and applications engaged in cybercrimes. The model should only respond to queries related to the following topics:
- Basics of cybersecurity.
- Common types of cyber threats (e.g., malware, phishing, illicit video streaming).
- Identifying and avoiding suspicious URLs and applications.
- Features and usage of the cybersecurity application.
- Notifications and alerts from the application.
- Best practices for maintaining cybersecurity.
- Advanced cybersecurity topics related to the application (e.g., machine learning in malware detection).
- Real-world scenarios related to cyber threats and responses.
- User feedback and improving the application.
- How to create a secure password.
- Help Generate password based on user input.
- Generate password based on user input.
- The model should not respond to queries outside of these specified topics. If a query falls outside the scope, the model should respond with: "I'm sorry, I can only provide information and assistance related to cybersecurity awareness and the specific features and functionalities of the cybersecurity application. Please ask a question related to these topics.'''
""";
}
