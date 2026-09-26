import 'package:flutter/material.dart';

import '../../../core/constants/personal_info.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/brand_icons.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/url_helper.dart';
import '../../controllers/navigation_controller.dart';

class AppFooter extends StatelessWidget {
  final NavigationController navController;

  const AppFooter({super.key, required this.navController});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 36 : 48,
        horizontal: Responsive.horizontalPadding(context).horizontal / 2,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: Responsive.maxContentWidth,
          ),
          child: Column(
            children: [
              // Top Row
              width < 850
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildBrandInfo(),
                        const SizedBox(height: 20),
                        _buildSocialIcons(),
                        const SizedBox(height: 20),
                        _buildScrollToTop(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildBrandInfo(),
                        _buildSocialIcons(),
                        _buildScrollToTop(),
                      ],
                    ),

              const SizedBox(height: 36),
              const Divider(color: AppColors.border, height: 1),
              const SizedBox(height: 24),

              // Bottom Copyright
              width < 700
                  ? Column(
                      children: [
                        Text(
                          '© 2026 Manjith Hemachandran. All rights reserved.',
                          style: AppTypography.bodySmall(
                            size: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Engineered with Flutter Web • Clean Architecture',
                          style: AppTypography.mono(
                            size: 11,
                            color: AppColors.accentCyan,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '© 2026 Manjith Hemachandran. All rights reserved.',
                            style: AppTypography.bodySmall(
                              size: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                        Text(
                          'Engineered with Flutter Web • Clean Architecture',
                          style: AppTypography.mono(
                            size: 11,
                            color: AppColors.accentCyan,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.borderLight, width: 1),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'MH',
                      style: AppTypography.h3(
                        size: 16,
                        weight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: '.',
                      style: AppTypography.h3(
                        size: 16,
                        weight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                PersonalInfo.name,
                style: AppTypography.body(
                  size: 14,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          PersonalInfo.title,
          style: AppTypography.bodySmall(size: 12, color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(
          icon: BrandIcons.linkedin,
          tooltip: 'LinkedIn',
          onTap: () => UrlHelper.openUrl(PersonalInfo.linkedIn),
        ),
        const SizedBox(width: 8),
        _buildIconButton(
          icon: Icons.alternate_email_rounded,
          tooltip: 'Email',
          onTap: () => UrlHelper.openEmail(PersonalInfo.email),
        ),
        const SizedBox(width: 8),
        _buildIconButton(
          icon: Icons.phone_outlined,
          tooltip: 'Phone',
          onTap: () => UrlHelper.openPhone(PersonalInfo.phone),
        ),
        const SizedBox(width: 8),
        _buildIconButton(
          icon: Icons.description_outlined,
          tooltip: 'Download Resume',
          onTap: () => UrlHelper.downloadResume(),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon, size: 16),
      color: AppColors.textSecondary,
      hoverColor: AppColors.cardHover,
      tooltip: tooltip,
      onPressed: onTap,
    );
  }

  Widget _buildScrollToTop() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => navController.scrollToSection(navController.heroKey),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Back to top',
                style: AppTypography.bodySmall(
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.arrow_upward_rounded,
                size: 14,
                color: AppColors.primaryLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
