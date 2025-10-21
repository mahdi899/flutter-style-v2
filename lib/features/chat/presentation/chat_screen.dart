import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routing/routes.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/header_glass.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.prefill});

  final String? prefill;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _controller;
  final FocusNode _inputFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = <_ChatMessage>[
    const _ChatMessage(
      text: 'سلام! من اینجام تا استایل امروزت رو بچینم.',
      sender: _ChatSender.stylist,
    ),
    const _ChatMessage(
      text: 'چه چیزی الهام‌بخش امروزته؟',
      sender: _ChatSender.stylist,
    ),
  ];

  final List<String> _quickReplies = <String>[
    'یه ست رسمی برای جلسه می‌خوام',
    'تیپ کژوال برای عصرونه',
    'به من استایل اسپورت پیشنهاد بده',
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.prefill ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    _inputFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final String trimmed = _controller.text.trim();
    if (trimmed.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(_ChatMessage(text: trimmed, sender: _ChatSender.user));
      _messages.add(
        _ChatMessage(
          text: 'یادداشت شد! یک ست پیشنهادی بر اساس "${trimmed.replaceAll('\n', ' ')}" برات می‌فرستم.',
          sender: _ChatSender.stylist,
        ),
      );
    });
    _controller.clear();

    WidgetsBinding.instance.addPostFrameCallback((item) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _handleQuickReply(String text) {
    _controller
      ..text = text
      ..selection = TextSelection.collapsed(offset: text.length);
    FocusScope.of(context).requestFocus(_inputFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: HeaderGlass(
                title: Text(
                  'چت با استایلیست',
                  style: theme.textTheme.titleLarge,
                ),
                leading: IconButton(
                  onPressed: () => context.go(AppRoutePath.home),
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                trailing: SizedBox(
                  height: 42,
                  child: GradientButton(
                    onPressed: () => context.push(AppRoutePath.tryOn),
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('Try-On'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 140),
                children: <Widget>[
                  Text(
                    'مدیر استایل شخصی تو',
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: AppRadii.border24,
                        boxShadow: const <BoxShadow>[AppShadows.soft],
                      ),
                      child: Text(
                        'خوش اومدی! هر چیزی دوست داری برام بنویس تا سریع‌ترین مسیر رو به استایل دلخواهت پیدا کنیم.',
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF6D83F2),
                          Color(0xFF8B5CF6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: AppRadii.border24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'سوال اصلی امروز',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.prefill ??
                              'به چه استایلی برای امروز فکر می‌کنی؟',
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(8),
                        topEnd: Radius.circular(24),
                        bottomEnd: Radius.circular(24),
                        bottomStart: Radius.circular(24),
                      ),
                      boxShadow: const <BoxShadow>[AppShadows.soft],
                    ),
                    child: Text(
                      'جواب من اینه که با ترکیب آیتم‌های ذخیره‌شده‌ات شروع کنیم و بعد سراغ پیشنهادهای ترندی بریم.',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'پیام‌های اخیر',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  ..._messages.map(
                    (m) => _ChatBubble(
                      message: m,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'می‌تونی سریع انتخاب کنی',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _quickReplies.map((String text) {
                      return ActionChip(
                        label: Text(text),
                        onPressed: () => _handleQuickReply(text),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'یادگیری استایل',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _LearningCard(
                          title: 'نحوه ترکیب رنگ‌های جسورانه',
                          subtitle: 'مقاله ۵ دقیقه‌ای',
                          icon: Icons.palette_rounded,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _LearningCard(
                          title: '۳ ترفند برای لایه‌بندی',
                          subtitle: 'ویدیو کوتاه',
                          icon: Icons.layers_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: AppRadii.border24,
            boxShadow: const <BoxShadow>[AppShadows.soft],
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mic_none_rounded),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _inputFocusNode,
                  minLines: 1,
                  maxLines: 4,
                  textDirection: TextDirection.rtl,
                  decoration: const InputDecoration(
                    hintText: 'پیام بعدی را بنویس...',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              IconButton(
                onPressed: _handleSend,
                icon: const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.sender == _ChatSender.user;
    final ThemeData theme = Theme.of(context);

    return Align(
      alignment: isUser
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser
              ? AppColors.primary.withValues(alpha: 0.12)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(24),
            topRight: const Radius.circular(24),
            bottomLeft:
                isUser ? const Radius.circular(24) : const Radius.circular(8),
            bottomRight:
                isUser ? const Radius.circular(8) : const Radius.circular(24),
          ),
          boxShadow: const <BoxShadow>[AppShadows.soft],
        ),
        child: Text(
          message.text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isUser ? AppColors.primary : null,
          ),
        ),
      ),
    );
  }
}

class _LearningCard extends StatelessWidget {
  const _LearningCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppRadii.border24,
        boxShadow: const <BoxShadow>[AppShadows.soft],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: colorScheme.primary, size: 28),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Text(
            '+ ادامه یادگیری',
            style: theme.textTheme.labelLarge
                ?.copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({required this.text, required this.sender});

  final String text;
  final _ChatSender sender;
}

enum _ChatSender { user, stylist }
