import 'package:flutter/material.dart';

import '../../../core/constants/personal_info.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
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
      color: Colors.transparent, // Clean, minimal
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 64,
        horizontal: Responsive.horizontalPadding(context).horizontal / 2,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: Responsive.maxContentWidth,
          ),
          child: Column(
            children: [
              const Divider(color: AppColors.borderLight, height: 1),
              const SizedBox(height: 48),
              
              // Top Row
              width < 850
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildBrandInfo(),
                        const SizedBox(height: 32),
                        _buildSocialTextLinks(),
                        const SizedBox(height: 32),
                        _buildScrollToTop(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildBrandInfo(),
                        _buildSocialTextLinks(),
                        _buildScrollToTop(),
                      ],
                    ),

              const SizedBox(height: 48),

              // Bottom Copyright
              width < 700
                  ? Column(
                      children: [
                        Text(
                          '© 2026 Manjith Hemachandran. All rights reserved.',
                          style: AppTypography.bodySmall(
                            size: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Engineered with Flutter Web • Clean Architecture',
                          style: AppTypography.mono(
                            size: 11,
                            color: AppColors.textMuted,
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
                              size: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                        Text(
                          'Engineered with Flutter Web • Clean Architecture',
                          style: AppTypography.mono(
                            size: 11,
                            color: AppColors.textMuted,
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
            Text(
              'MH',
              style: AppTypography.h3(
                size: 18,
                weight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                PersonalInfo.name,
                style: AppTypography.body(
                  size: 15,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          PersonalInfo.title,
          style: AppTypography.bodySmall(size: 13, color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildSocialTextLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextLink(
          label: 'LinkedIn',
          onTap: () => UrlHelper.openUrl(PersonalInfo.linkedIn),
        ),
        const SizedBox(width: 24),
        _buildTextLink(
          label: 'Email',
          onTap: () => UrlHelper.openEmail(PersonalInfo.email),
        ),
        const SizedBox(width: 24),
        _buildTextLink(
          label: 'Resume',
          onTap: () => UrlHelper.downloadResume(),
        ),
      ],
    );
  }

  Widget _buildTextLink({
    required String label,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: AppTypography.body(
            size: 14,
            weight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildScrollToTop() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => navController.scrollToSection(navController.heroKey),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'BACK TO TOP',
              style: AppTypography.mono(
                size: 11,
                weight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_upward_rounded,
              size: 16,
              color: AppColors.primaryLight,
            ),
          ],
        ),
      ),
    );
  }
}
