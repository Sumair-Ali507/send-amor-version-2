import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

import '../controllers/message_controller.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController chatMessageController = Get.put(MessageController());
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Listen to changes in messages and auto-scroll
    chatMessageController.messages.listen((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {

          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        excludeHeaderSemantics: true,
        title: Text(
          "TechiBot",
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                itemCount: chatMessageController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatMessageController.messages[index];
                  final isUser = message['isUser'];
                  final time = message['time'];

                  return Align(
                    alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        BubbleSpecialTwo(
                          isSender: isUser,
                          color: isUser
                              ? const Color(0XFF25D366)
                              : theme.colorScheme.secondary.withOpacity(0.2),
                          seen: true,
                          text: message['text'],
                          tail: true,
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: isDarkMode
                                ? theme.colorScheme.onSurface
                                : const Color(0XFF000000),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w, left: 20.w),
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Obx(
                () => chatMessageController.isTypeing.value
                ? Padding(
              padding: EdgeInsets.all(8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    chatMessageController.responseText.value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  )
                ],
              ),
            )
                : const SizedBox.shrink(),
          ),
          // Text field for message
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? theme.colorScheme.surface.withOpacity(0.8)
                          : Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),

                        borderSide: BorderSide(
                          color: theme.colorScheme.onSurface.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      // suffixIcon: IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.emoji_emotions_outlined,
                      //     color: theme.colorScheme.onSurface.withOpacity(0.6),
                      //   ),
                      // ),
                    ),
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                FloatingActionButton(
                  heroTag: "send_button",
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      chatMessageController
                          .sendMessage(messageController.text.trim());
                      messageController.clear();
                    }
                  },
                  backgroundColor: const Color(0XFF25D366),
                  foregroundColor: Colors.white,
                  child: Icon(Icons.send, size: 24.w),
                )
              ],
            ),
          ),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}