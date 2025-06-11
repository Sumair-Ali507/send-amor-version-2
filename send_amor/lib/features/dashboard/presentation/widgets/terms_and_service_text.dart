import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
import '../pages/web_view_page.dart';

class TermsAndPrivacyWidget extends StatelessWidget {
  const TermsAndPrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Equivalent to the outer box spacing
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey, // Default text color
              ),
          children: [
            const TextSpan(text: 'By using Tarot.Pro you are agreeing to our '),
            TextSpan(
              text: 'Terms of Service',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(AppColor.secondaryColor), // Link color
                    decoration: TextDecoration.underline,
                  ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Handle navigation to Terms of Service
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewPage(
                        webUrl: 'https://www.tarot.pro/terms/',
                      ),
                    ),
                  );
                  //https://www.tarot.pro/privacy/
                },
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(AppColor.secondaryColor), // Link color
                    decoration: TextDecoration.underline,
                  ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Handle navigation to Privacy Policy
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewPage(
                        webUrl: 'https://www.tarot.pro/privacy/',
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
