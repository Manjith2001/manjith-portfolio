import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/personal_info.dart';
import '../../../core/services/contact_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/brand_icons.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/url_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/section_header.dart';
import '../../widgets/tech_chip.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _selectedCategory = 'Commercial Mobile Development';
  final List<String> _categories = [
    'Commercial Mobile Development',
    'Payment Gateway Integration',
    'Shorebird OTA Architecture',
    'Full-Time / Contract Engineering',
    'General Inquiry',
  ];

  bool _isCopied = false;
  bool _isSubmitting = false;
  bool _isSent = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _copyEmail() {
    Clipboard.setData(const ClipboardData(text: PersonalInfo.email));
    setState(() => _isCopied = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Email address copied to clipboard! (manjithhemachandran333@gmail.com)',
        ),
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.primary,
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isCopied = false);
    });
  }

  Future<void> _handleSubmit() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final submission = ContactSubmission(
      name: name,
      email: email,
      category: _selectedCategory,
      message: message,
    );

    final result = await ContactService.submitInquiry(submission);

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    if (result.isSuccess) {
      setState(() {
        _isSent = true;
        _errorMessage = null;
      });
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } else {
      setState(() {
        _errorMessage = result.message;
      });
      if (result.useMailtoFallback) {
        _openMailtoFallback(name, email, message);
      }
    }
  }

  void _openMailtoFallback(String name, String email, String message) {
    final subject = 'Inquiry from $name ($_selectedCategory)';
    final body =
        'Sender: $name\nEmail: $email\nCategory: $_selectedCategory\n\n$message';
    UrlHelper.openEmail(PersonalInfo.email, subject: subject, body: body);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          const SectionHeader(
            tag: 'Get In Touch',
            title: "Let's Build Something Exceptional",
            subtitle:
                'Available for high-impact mobile development positions, enterprise mobile contracts, '
                'and production Flutter engineering opportunities. Direct message delivery to inbox.',
          ),
          const SizedBox(height: 40),

          // Content Grid
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _buildContactDetails(context)),
                    const SizedBox(width: 48),
                    Expanded(flex: 6, child: _buildQuickMessageForm(context)),
                  ],
                )
              : Column(
                  children: [
                    _buildContactDetails(context),
                    const SizedBox(height: 36),
                    _buildQuickMessageForm(context),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildContactDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Direct Connections',
          style: AppTypography.h3(size: 20, weight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Reach out directly via email, phone, or LinkedIn. Quick responses assured.',
          style: AppTypography.body(size: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        // Email Card
        _buildContactCard(
          icon: Icons.alternate_email_rounded,
          title: 'Direct Inbox',
          value: PersonalInfo.email,
          onTap: () => UrlHelper.openEmail(PersonalInfo.email),
          actionWidget: IconButton(
            icon: Icon(
              _isCopied ? Icons.check_rounded : Icons.copy_rounded,
              size: 16,
            ),
            color: _isCopied ? AppColors.accentEmerald : AppColors.textMuted,
            tooltip: 'Copy Email to Clipboard',
            onPressed: _copyEmail,
          ),
        ),
        const SizedBox(height: 12),

        // Phone Card
        _buildContactCard(
          icon: Icons.phone_outlined,
          title: 'Phone / WhatsApp',
          value: PersonalInfo.phoneDisplay,
          onTap: () => UrlHelper.openPhone(PersonalInfo.phone),
        ),
        const SizedBox(height: 12),

        // LinkedIn Card
        _buildContactCard(
          icon: BrandIcons.linkedin,
          title: 'LinkedIn Network',
          value: PersonalInfo.linkedInDisplay,
          onTap: () => UrlHelper.openUrl(PersonalInfo.linkedIn),
        ),
        const SizedBox(height: 12),

        // Location Card
        _buildContactCard(
          icon: Icons.location_on_outlined,
          title: 'Location & Availability',
          value: '${PersonalInfo.location} • Open Worldwide',
        ),
        const SizedBox(height: 24),

        // Resume Download Big Action Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: AppColors.primaryLight,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Curriculum Vitae (PDF)',
                      style: AppTypography.body(
                        size: 15,
                        weight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Complete 2.5+ years history, 17+ apps & Shorebird',
                      style: AppTypography.bodySmall(
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              CustomButton(
                label: 'Download',
                icon: Icons.download_rounded,
                variant: ButtonVariant.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                onPressed: () => UrlHelper.downloadResume(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
    Widget? actionWidget,
  }) {
    return MouseRegion(
      cursor: onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1.2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primaryLight, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodySmall(
                        size: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: AppTypography.body(
                        size: 14,
                        weight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              ?actionWidget,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickMessageForm(BuildContext context) {
    if (_isSent) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.accentEmerald.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentEmerald.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.accentEmerald.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.accentEmerald,
                size: 48,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Message Sent Successfully!',
              style: AppTypography.h3(
                size: 22,
                color: Colors.white,
                weight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Your inquiry has been delivered directly to Manjith\'s email (${PersonalInfo.email}). You will receive a response shortly.',
              style: AppTypography.body(
                size: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Send Another Message',
              icon: Icons.refresh_rounded,
              variant: ButtonVariant.outline,
              onPressed: () => setState(() => _isSent = false),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1.2),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.accentCyan,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Send Direct Inquiry to Mail',
                  style: AppTypography.h3(size: 18, weight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Inquiries submitted here are routed directly to manjithhemachandran333@gmail.com.',
            style: AppTypography.bodySmall(
              size: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),

          // Inquiry Category selector
          Text(
            'Project Category',
            style: AppTypography.mono(size: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TechChip(
                    label: cat,
                    isSelected: isSelected,
                    color: AppColors.primaryLight,
                    onTap: () => setState(() => _selectedCategory = cat),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Name Field
          _buildTextField(
            controller: _nameController,
            label: 'Your Name or Organization',
            hint: 'e.g. Alex Morgan or Tech Corp',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 16),

          // Email Field
          _buildTextField(
            controller: _emailController,
            label: 'Your Email Address',
            hint: 'e.g. alex@company.com',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          // Message Field
          _buildTextField(
            controller: _messageController,
            label: 'Project Scope / Message',
            hint: 'Tell me about your mobile project, timelines, or technology requirements...',
            icon: Icons.chat_bubble_outline_rounded,
            maxLines: 4,
          ),
          const SizedBox(height: 16),

          // Error banner if any
          if (_errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.redAccent,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: AppTypography.bodySmall(
                        size: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: _isSubmitting
                  ? 'Sending to Inbox...'
                  : 'Send Message to Email',
              icon: _isSubmitting
                  ? Icons.hourglass_top_rounded
                  : Icons.send_rounded,
              variant: ButtonVariant.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              onPressed: _isSubmitting ? null : _handleSubmit,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.mono(size: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: AppTypography.body(size: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.body(size: 13, color: AppColors.textMuted),
            prefixIcon: Icon(icon, color: AppColors.textMuted, size: 18),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
