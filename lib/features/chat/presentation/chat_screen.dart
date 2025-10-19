import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/header_glass.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.prefill});

  final String? prefill;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.prefill ?? '');
  final ScrollController _scrollController = ScrollController();
  final FocusNode _inputFocusNode = FocusNode();

  final List<_ChatMessage> _messages = <_ChatMessage>[
    const _ChatMessage(
      text: 'سلام! من مدیر استایل شخصی‌ات هستم. آماده‌ام تا بر اساس مناسبت و حال و هوای امروز کمکت کنم.',
      isUser: false,
    ),
    const _ChatMessage(
      text: 'برای شروع بگو امروز چه برنامه‌ای داری یا چه آیتمی می‌خواهی ست کنی.',
      isUser: false,
    ),
  ];

  final List<String> _quickReplies = <String>[
    'برای یک قرار دوستانه چی بپوشم؟',
    'استایل اداری با کت بارانی می‌خوام',
    'چه رنگی به کتانی قرمز میاد؟',
    'یک ست مینیمال پیشنهاد بده',
  ];

  final List<_LearningCard> _learningCards = const <_LearningCard>[
    _LearningCard(
      title: 'فرمول ست کتانی رنگی',
      description: 'سه اصل ساده برای ست کردن کتانی‌های خاص رنگ.',
      colors: <Color>[Color(0xFF6366F1), Color(0xFFA855F7)],
    ),
    _LearningCard(
      title: 'گاید استایل مینیمال روزانه',
      description: 'با چند آیتم محدود، استایل یک هفته را بساز.',
      colors: <Color>[Color(0xFF22C55E), Color(0xFF34D399)],
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _inputFocusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    final String text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
    });
    _controller.clear();
    _scrollToBottom();

    Future<void>.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() {
        _messages.add(
          _ChatMessage(
            text: 'متوجه شدم! دارم گزینه‌های مناسب را بررسی می‌کنم. یک ایده تازه همزمان برایت می‌فرستم.',
            isUser: false,
          ),
        );
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _applyQuickReply(String value) {
    setState(() {
      _controller.text = value;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    });
    _inputFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: HeaderGlass(
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
                  child: Icon(Icons.auto_awesome_rounded,
                      color: theme.colorScheme.primary),
                ),
                title: Text(
                  'مدیر استایل شخصی تو',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_rounded),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
                children: <Widget>[
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: AppRadii.radius24,
                          topRight: AppRadii.radius24,
                          bottomLeft: AppRadii.radius24,
                        ),
                      ),
                      child: Text(
                        'خوش اومدی! برای شروع از من هرچی دوست داری بپرس.',
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _applyQuickReply(
                      widget.prefill ?? 'امروز چه ست جدیدی پیشنهاد می‌دی؟',
                    ),
                    child: GlassCard(
                      padding: const EdgeInsets.all(20),
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFF6366F1),
                          Color(0xFFA855F7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'سؤال امروزت چیه؟',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.prefill ??
                                'مثلاً: «برای مهمانی شبانه چه بپوشم؟»',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._messages
                      .map(
                        (_ChatMessage message) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Align(
                            alignment: message.isUser
                                ? AlignmentDirectional.centerEnd
                                : AlignmentDirectional.centerStart,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: message.isUser
                                    ? theme.colorScheme.primary.withOpacity(0.18)
                                    : theme.colorScheme.surface,
                                borderRadius: BorderRadius.only(
                                  topLeft: AppRadii.radius24,
                                  topRight: AppRadii.radius24,
                                  bottomLeft: message.isUser
                                      ? AppRadii.radius24
                                      : Radius.circular(12),
                                  bottomRight: message.isUser
                                      ? Radius.circular(12)
                                      : AppRadii.radius24,
                                ),
                                boxShadow: message.isUser
                                    ? null
                                    : const <BoxShadow>[AppShadows.soft],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Text(
                                  message.text,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: message.isUser
                                        ? theme.colorScheme.onBackground
                                        : theme.colorScheme.onSurface,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  const SizedBox(height: 12),
                  Text(
                    'بپرس تا سریع جواب بدم',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _quickReplies
                        .map(
                          (String reply) => ActionChip(
                            label: Text(reply),
                            onPressed: () => _applyQuickReply(reply),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'یادگیری استایل',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  ..._learningCards.map(
                    (_LearningCard card) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GlassCard(
                        padding: const EdgeInsets.all(20),
                        gradient: LinearGradient(
                          colors: card.colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              card.title,
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              card.description,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                            const SizedBox(height: 16),
                            GradientButton(
                              onPressed: () {},
                              child: const Text('مطالعه کن'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _ChatInputBar(
              controller: _controller,
              focusNode: _inputFocusNode,
              onSend: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  const _ChatInputBar({
    required this.controller,
    required this.onSend,
    required this.focusNode,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: AppRadii.border32,
            boxShadow: const <BoxShadow>[AppShadows.soft],
          ),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: onSend,
                icon: const Icon(Icons.send_rounded),
                color: theme.colorScheme.primary,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'پیامت را بنویس...',
                  ),
                  minLines: 1,
                  maxLines: 4,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mic_none_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.isUser,
  });

  final String text;
  final bool isUser;
}

class _LearningCard {
  const _LearningCard({
    required this.title,
    required this.description,
    required this.colors,
  });

  final String title;
  final String description;
  final List<Color> colors;
}
