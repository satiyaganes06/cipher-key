import 'dart:io';
import 'dart:typed_data';
import 'package:cipherkey/utils/colors.dart' as colors;
import 'package:cipherkey/utils/dimensions.dart' as dimens;
import 'package:cipherkey/utils/constants.dart' as constants;
import 'package:cipherkey/presentation/widget/appbar.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  //final Gemini gemini = Gemini.instance;
  late GenerativeModel geminiModel;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(
      id: "0",
      firstName: "User",
      profileImage:
          "https://cdn.iconscout.com/icon/free/png-256/avatar-380-456332.png");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage: "https://cdn-icons-png.flaticon.com/512/3055/3055797.png",
  );

  @override
  void initState() {
    geminiModel = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: dotenv.env["GEMINI_API_KEY"]!,
      generationConfig: GenerationConfig(
        temperature: 0.15,
        topP: 0.95,
        topK: 64,
        maxOutputTokens: 8192,
      ),
      safetySettings: [
        SafetySetting(
          HarmCategory.harassment,
          HarmBlockThreshold.low,
        ),
        SafetySetting(
          HarmCategory.hateSpeech,
          HarmBlockThreshold.high,
        ),
        SafetySetting(
          HarmCategory.sexuallyExplicit,
          HarmBlockThreshold.low,
        ),
        SafetySetting(
          HarmCategory.dangerousContent,
          HarmBlockThreshold.none,
        ),
      ],
      systemInstruction: Content(
          'model', [TextPart(constants.Constants.geminiSystemInstruction)]),
    );

    geminiModel.startChat(history: [
      Content('model', [
        TextPart(
            '''Hello! I'm AI ChipherKey Assistant, your AI Cyber Assistant. How can I help you today?''')
      ]),
      Content('user', [TextPart('''Explain the basics of cybersecurity.''')]),
      Content('model', [
        TextPart(
            '''Cybersecurity is the practice of protecting computer systems and networks from unauthorized access, use, disclosure, disruption, modification, or destruction.''')
      ]),
      Content('user',
          [TextPart('''What is cybersecurity and why is it important?''')]),
      Content('model', [
        TextPart(
            '''Cybersecurity is the practice of protecting computer systems and networks from unauthorized access, use, disclosure, disruption, modification, or destruction. It's crucial because it safeguards sensitive information, protects against financial losses, ensures business continuity, and maintains public trust.''')
      ]),
      Content('user',
          [TextPart('''What are some common types of cyber threats?''')]),
      Content('model', [
        TextPart(
            '''Common cyber threats include malware (viruses, worms, ransomware), phishing attacks, social engineering, denial-of-service attacks, data breaches, and SQL injection.''')
      ]),
      Content('user',
          [TextPart('''My pornhub password got leaked, what should I do?''')]),
      Content('model', [
        TextPart(
            '''I understand you're concerned about your Pornhub password being leaked. It's important to take action to protect yourself. Here's what you should do: 1. Change your Pornhub password immediately. Use a strong, unique password that you don't use for any other accounts. 2. Enable two-factor authentication (2FA) on your Pornhub account. This adds an extra layer of security by requiring a code from your phone in addition to your password. 3. Check if your email address or other personal information was leaked. You can use services like Have I Been Pwned (https://haveibeenpwned.com/) to see if your information has been compromised in any data breaches. 4. Change your passwords for any other accounts that use the same password. It's best to use unique passwords for each of your online accounts. 5. Be cautious about clicking on links or opening attachments in emails or messages. These could be phishing attempts designed to steal your information. 6. Keep your software and operating system up to date. Updates often include security patches that can protect you from known vulnerabilities. Remember, it's important to be proactive about your online security. By taking these steps, you can help protect yourself from cyber threats.'''),
      ]),
      Content('user',
          [TextPart('''Describe what phishing is and how to avoid it.''')]),
      Content('model', [
        TextPart(
            '''Phishing is a cyberattack where scammers impersonate legitimate entities (like banks or companies) via email, text, or social media to trick you into revealing sensitive information like passwords or credit card details. To avoid phishing: Verify the sender: Double-check the sender's email address for misspellings or inconsistencies. Beware of urgency: Be wary of messages demanding immediate action or threatening negative consequences. Don't click suspicious links: Hover over links to see their true destination before clicking. Be cautious of attachments: Avoid opening attachments from unknown or suspicious senders. Contact the company directly: If unsure, reach out to the company through their official website or phone number.'''),
      ]),
      Content('user', [
        TextPart('''What is illicit video streaming and why is it a threat?''')
      ]),
      Content('model', [
        TextPart(
            '''Illicit video streaming refers to the unauthorized distribution or access of copyrighted video content, like movies or TV shows, without proper licensing or permission from the copyright holders. Here's why it's a threat: Financial Losses: It deprives content creators and the entertainment industry of revenue, hindering future productions. Security Risks: Illicit streaming websites or apps often lack security measures, exposing users to malware or data theft. Legal Consequences: Accessing or distributing copyrighted content illegally can lead to fines or legal action. Ethical Concerns: It undermines the hard work and creativity of those involved in producing legitimate content.'''),
      ]),
      Content('user', [TextPart('''How can I identify a suspicious URL?''')]),
      Content('model', [
        TextPart(
            '''Here are some red flags to help you identify suspicious URLs: Look for misspellings or variations in legitimate website names: For example, "amaz0n.com" instead of "amazon.com." Be wary of shortened URLs: While convenient, they can mask the true destination of a link. Use a link expander tool if unsure. Check for unusual domain extensions: Be cautious of unfamiliar extensions like ".xyz" or ".club" especially if they seem out of place for the supposed website. Look for a secure connection: Legitimate websites handling sensitive information should have "https://" and a padlock icon in the address bar. However, even HTTPS doesn't guarantee a site is safe. Be cautious of websites requesting unnecessary permissions: Be wary if a website asks for access to your camera, microphone, or location when it's not required. Pay attention to your browser warnings: Modern browsers often display warnings about potentially dangerous websites. If something feels off about a URL, trust your instincts and avoid it.'''),
      ]),
      Content('user', [
        TextPart(
            '''What signs indicate that an application might be malicious?''')
      ]),
      Content('model', [
        TextPart(
            '''Here are some signs that an application might be malicious: Unknown source: Be cautious about downloading apps from unofficial app stores or websites. Excessive permissions: Be wary of apps requesting access to features or data unrelated to their functionality. Negative reviews or low ratings: Check user reviews and ratings for any red flags or warnings about malware. Unusual behavior: If an app crashes frequently, drains battery life excessively, or displays suspicious pop-ups, it could be malicious. Unexpected network activity: Monitor your device for unusual data usage or network activity, which could indicate malware communication. If you suspect an application is malicious, it's best to uninstall it immediately and run a scan with a reputable antivirus software.'''),
      ]),
      Content('user', [
        TextPart(
            '''What should I look for to avoid falling for phishing scams?''')
      ]),
      Content('model', [
        TextPart(
            '''You're right to be wary of phishing scams! They're getting increasingly sophisticated. Here's what to watch out for: Suspicious Sender: Double-check the sender's email address. Look for misspellings, extra numbers, or if it's from a public domain (like @gmail.com) when it should be from a company domain. Generic Greetings: Be wary of emails starting with "Dear valued customer" or similar generic greetings. Legitimate companies usually personalize communications. Urgent or Threatening Language: Phishing emails often create a sense of urgency or fear to pressure you into acting quickly without thinking. Don't fall for it! Suspicious Links: Hover over any links without clicking them. Does the URL match the text of the link? Does it lead to a website that makes sense in the context of the email? Requests for Personal Information: Legitimate companies will never ask for sensitive information like passwords or credit card details via email. Grammatical Errors and Typos: While not always a guarantee of phishing, poor grammar and spelling mistakes can be red flags.'''),
      ]),
      // Content('user',
      //     [TextPart('can you generate a password using my name logathepan')]),
      // Content('model', [TextPart('log@th*e*p@n19102')]),
    ]);

    // gemini.s
    // gemini.info(model: 'gemini-1.5-flash-latest');
    // gemini.streamChat(
    //   [
    //     Content(
    //       role: 'user',
    //       parts: [Parts(text: 'Explain the basics of cybersecurity.')],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'Cybersecurity is the practice of protecting computer systems and networks from unauthorized access, use, disclosure, disruption, modification, or destruction.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text: 'What is cybersecurity and why is it important?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               "Cybersecurity is the practice of protecting computer systems and networks from unauthorized access, use, disclosure, disruption, modification, or destruction. It's crucial because it safeguards sensitive information, protects against financial losses, ensures business continuity, and maintains public trust.",
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text: 'What are some common types of cyber threats?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'Common cyber threats include malware (viruses, worms, ransomware), phishing attacks, social engineering, denial-of-service attacks, data breaches, and SQL injection.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text: 'My pornhub password got leaked, what should I do?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'I understand you\'re concerned about your Pornhub password being leaked. It\'s important to take action to protect yourself. Here\'s what you should do:\n\n1. **Change your Pornhub password immediately.** Use a strong, unique password that you don\'t use for any other accounts.\n2. **Enable two-factor authentication (2FA) on your Pornhub account.** This adds an extra layer of security by requiring a code from your phone in addition to your password.\n3. **Check if your email address or other personal information was leaked.** You can use services like Have I Been Pwned (https://haveibeenpwned.com/) to see if your information has been compromised in any data breaches.\n4. **Change your passwords for any other accounts that use the same password.** It\'s best to use unique passwords for each of your online accounts.\n5. **Be cautious about clicking on links or opening attachments in emails or messages.** These could be phishing attempts designed to steal your information.\n6. **Keep your software and operating system up to date.** Updates often include security patches that can protect you from known vulnerabilities.\n\nRemember, it\'s important to be proactive about your online security. By taking these steps, you can help protect yourself from cyber threats.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text: 'Describe what phishing is and how to avoid it.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'Phishing is a cyberattack where scammers impersonate legitimate entities (like banks or companies) via email, text, or social media to trick you into revealing sensitive information like passwords or credit card details.\n\nTo avoid phishing:\n\n* **Verify the sender:** Double-check the sender\'s email address for misspellings or inconsistencies.\n* **Beware of urgency:** Be wary of messages demanding immediate action or threatening negative consequences.\n* **Don\'t click suspicious links:** Hover over links to see their true destination before clicking.\n* **Be cautious of attachments:** Avoid opening attachments from unknown or suspicious senders.\n* **Contact the company directly:** If unsure, reach out to the company through their official website or phone number.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text: 'What is illicit video streaming and why is it a threat?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'Illicit video streaming refers to the unauthorized distribution or access of copyrighted video content, like movies or TV shows, without proper licensing or permission from the copyright holders.\n\nHere\'s why it\'s a threat:\n\n* **Financial Losses:** It deprives content creators and the entertainment industry of revenue, hindering future productions.\n* **Security Risks:** Illicit streaming websites or apps often lack security measures, exposing users to malware or data theft.\n* **Legal Consequences:** Accessing or distributing copyrighted content illegally can lead to fines or legal action.\n* **Ethical Concerns:** It undermines the hard work and creativity of those involved in producing legitimate content.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text: 'How can I identify a suspicious URL?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'Here are some red flags to help you identify suspicious URLs:\n\n* **Look for misspellings or variations in legitimate website names:** For example, \"amaz0n.com\" instead of \"amazon.com.\"\n* **Be wary of shortened URLs:** While convenient, they can mask the true destination of a link. Use a link expander tool if unsure.\n* **Check for unusual domain extensions:** Be cautious of unfamiliar extensions like \".xyz\" or \".club\" especially if they seem out of place for the supposed website.\n* **Look for a secure connection:** Legitimate websites handling sensitive information should have \"https://\" and a padlock icon in the address bar. However, even HTTPS doesn\'t guarantee a site is safe.\n* **Be cautious of websites requesting unnecessary permissions:** Be wary if a website asks for access to your camera, microphone, or location when it\'s not required.\n* **Pay attention to your browser warnings:** Modern browsers often display warnings about potentially dangerous websites.\n\nIf something feels off about a URL, trust your instincts and avoid it.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text:
    //               'What signs indicate that an application might be malicious?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'Here are some signs that an application might be malicious:\n\n* **Unknown source:** Be cautious about downloading apps from unofficial app stores or websites.\n* **Excessive permissions:** Be wary of apps requesting access to features or data unrelated to their functionality.\n* **Negative reviews or low ratings:** Check user reviews and ratings for any red flags or warnings about malware.\n* **Unusual behavior:** If an app crashes frequently, drains battery life excessively, or displays suspicious pop-ups, it could be malicious.\n* **Unexpected network activity:** Monitor your device for unusual data usage or network activity, which could indicate malware communication.\n\nIf you suspect an application is malicious, it\'s best to uninstall it immediately and run a scan with a reputable antivirus software.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text:
    //               'What should I look for to avoid falling for phishing scams?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'You\'re right to be wary of phishing scams! They\'re getting increasingly sophisticated. Here\'s what to watch out for:\n\n* **Suspicious Sender:** Double-check the sender\'s email address. Look for misspellings, extra numbers, or if it\'s from a public domain (like @gmail.com) when it should be from a company domain.\n* **Generic Greetings:** Be wary of emails starting with \"Dear valued customer\" or similar generic greetings. Legitimate companies usually personalize communications.\n* **Urgent or Threatening Language:** Phishing emails often create a sense of urgency or fear to pressure you into acting quickly without thinking. Don\'t fall for it!\n* **Suspicious Links:** Hover over any links *without* clicking them. Does the URL match the text of the link? Does it lead to a website that makes sense in the context of the email?\n* **Requests for Personal Information:** Legitimate companies will *never* ask for sensitive information like passwords or credit card details via email.\n* **Grammatical Errors and Typos:** While not always a guarantee of phishing, poor grammar and spelling mistakes can be red flags.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text: 'What are my options if I encounter a malicious URL?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'If you encounter a malicious URL, here\'s what you should do:\n\n1. **Don\'t click on it!** This is the most important step. Clicking on a malicious URL can lead to malware infections, phishing attempts, or other cyber threats.\n\n2. **Report the URL:** You can report malicious URLs to various authorities, including:\n * **Your email provider:** If you received the URL in an email, report it as phishing or spam.\n * **The website hosting service:** If you can identify the hosting service, report the malicious content to them.\n * **Security organizations:** You can report malicious URLs to organizations like Google Safe Browsing (https://safebrowsing.google.com/safebrowsing/report_phish/) or the Anti-Phishing Working Group (https://apwg.org/report-phishing/).\n\n3. **Warn others:** If you received the URL from a friend or colleague, let them know it\'s malicious so they don\'t click on it either.\n\n4. **Run a security scan:** If you accidentally clicked on the URL, run a full system scan with your antivirus or anti-malware software to ensure your device hasn\'t been compromised.\n\n5. **Stay informed:** Keep up-to-date with the latest security news and trends to better recognize and avoid potential threats in the future.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text:
    //               'What is ransomware and how can I protect myself against it?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'Ransomware is a type of malware that encrypts your files or locks you out of your computer, demanding payment (a ransom) to restore access. Protecting yourself against ransomware involves a combination of preventive measures and good security practices:\n\n1. **Regular Backups:** Regularly back up your data to an external hard drive or cloud service. Ensure backups are not continuously connected to your system, as ransomware can target these as well.\n\n2. **Update Software:** Keep your operating system, software, and antivirus programs up to date to protect against known vulnerabilities.\n\n3. **Email Caution:** Be cautious of email attachments and links from unknown or unexpected sources. Phishing emails are a common delivery method for ransomware.\n\n4. **Avoid Malicious Websites:** Don\'t visit suspicious websites or download software from untrusted sources. Use reputable antivirus and anti-malware software that can block access to malicious sites.\n\n5. **Enable Security Features:** Use security features like firewalls, pop-up blockers, and web filtering to reduce exposure to ransomware.\n\n6. **Educate Yourself:** Learn to recognize phishing attempts and other social engineering tactics that can deliver ransomware.\n\n7. **Disable Macros:** In Microsoft Office, disable macros by default, as they are often used to deliver ransomware through documents.\n\nBy following these steps, you can significantly reduce your risk of falling victim to ransomware attacks.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text: 'What is a botnet and why is it dangerous?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'A botnet is a network of computers infected with malware and controlled by a hacker, often without the knowledge of the device owners. Botnets can consist of thousands or even millions of compromised devices, which are used to carry out various malicious activities.\n\nHere\'s why botnets are dangerous:\n\n1. **Distributed Denial of Service (DDoS) Attacks:** Botnets can overwhelm a target\'s servers with traffic, causing service outages and significant financial losses.\n2. **Spam Distribution:** Botnets can send massive amounts of spam emails, often containing malware or phishing links, contributing to the spread of further infections.\n3. **Data Theft:** Botnets can be used to steal sensitive data from infected devices, including personal information, financial details, and login credentials.\n4. **Click Fraud:** Botnets can generate fake clicks on online advertisements, defrauding advertisers and skewing web traffic analytics.\n5. **Cryptomining:** Botnets can hijack the processing power of infected devices to mine cryptocurrencies, slowing down the devices and increasing electricity costs for the owners.\n\nTo protect against botnets, ensure your devices are secured with up-to-date antivirus software, firewalls, and by following safe browsing and email practices.',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'user',
    //       parts: [
    //         Parts(
    //           text: 'How can I identify if my computer is part of a botnet?',
    //         ),
    //       ],
    //     ),
    //     Content(
    //       role: 'model',
    //       parts: [
    //         Parts(
    //           text:
    //               'Identifying if your computer is part of a botnet can be challenging, but here are some signs to look out for:\n\n1. **Unusual Network Activity:** Monitor your network traffic for unexpected spikes in activity, especially if your computer is idle.\n2. **Slow Performance:** If your computer suddenly becomes slow or unresponsive, it could be due to botnet malware consuming resources.\n3. **Unexpected Crashes:** Frequent system crashes or errors can indicate malware issues.\n4. **High CPU or Memory Usage:** Check your task manager for processes using excessive CPU or memory resources.\n5. **Suspicious Programs:** Look for unfamiliar programs or processes running on your computer.\n6. **Spam Emails:** If friends or colleagues report receiving spam from your email address, your computer might be compromised.\n7. **Increased Data Usage:** Keep an eye on your data usage for unexplained increases.\n\nIf you suspect your computer is part of a botnet, run a full system scan with updated antivirus software, remove any identified threats, and consider seeking professional help to ensure your system is clean.',
    //         ),
    //       ],
    //     ),
    //   ],
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.AppColor.secondaryColor,
      appBar: CommonAppbar(title: 'AI ChipherKey Assistant'),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(trailing: [
        // IconButton(
        //   onPressed: _sendMediaMessage,
        //   icon: const Icon(
        //     Icons.image,
        //   ),
        // )
      ]),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      geminiModel.generateContentStream([
        Content('user', [TextPart(question)]),
      ]).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.candidates.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(
            () {
              messages = [lastMessage!, ...messages];
            },
          );
        } else {
          String response = event.candidates.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
