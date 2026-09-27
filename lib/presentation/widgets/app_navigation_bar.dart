import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_helper.dart';
import '../controllers/navigation_controller.dart';
import 'custom_button.dart';

class AppNavigationBar extends StatelessWidget {
  final NavigationController navController;

  const AppNavigationBar({super.key, required this.navController});

  @override
  Widget build(BuildContext context) {
    final isScrolled = navController.isScrolled;
    final isDesktop = Responsive.isDesktop(context);

    // Floating glass-morphic bar styling
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      margin: EdgeInsets.only(
        top: isScrolled ? 16 : 24,
        left: Responsive.isMobile(context) ? 16 : 32,
        right: Responsive.isMobile(context) ? 16 : 32,
      ),
      height: 72,
      decoration: BoxDecoration(
        color: isScrolled
            ? AppColors.background.withValues(alpha: 0.7)
            : AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isScrolled
              ? AppColors.borderLight.withValues(alpha: 0.8)
              : AppColors.border.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo / Monogram
                Flexible(child: _buildLogo(context)),

                // Desktop Nav Links
                if (isDesktop) ...[
                  Flexible(
                    flex: 2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildNavItem(
                            'About',
                            () => navController.scrollToSection(navController.heroKey),
                            navController.activeSection == 'hero',
                          ),
                          _buildNavItem(
                            'Clients',
                            () => navController.scrollToSection(navController.clientsKey),
                            navController.activeSection == 'clients',
                          ),
                          _buildNavItem(
                            '17+ Apps & Demos',
                            () => navController.scrollToSection(navController.projectsKey),
                            navController.activeSection == 'projects',
                          ),
                          _buildNavItem(
                            'Capabilities',
                            () => navController.scrollToSection(navController.capabilitiesKey),
                            navController.activeSection == 'capabilities',
                          ),
                          _buildNavItem(
                            'Shorebird OTA',
                            () => navController.scrollToSection(navController.shorebirdKey),
                            navController.activeSection == 'shorebird',
                          ),
                          _buildNavItem(
                            'Skills',
                            () => navController.scrollToSection(navController.skillsKey),
                            navController.activeSection == 'skills',
                          ),
                          _buildNavItem(
                            'Experience',
                            () => navController.scrollToSection(navController.experienceKey),
                            navController.activeSection == 'experience',
                          ),
                          _buildNavItem(
                            'Contact',
                            () => navController.scrollToSection(navController.contactKey),
                            navController.activeSection == 'contact',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Actions
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        label: 'Resume',
                        icon: Icons.download_rounded,
                        variant: ButtonVariant.ghost,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        onPressed: () => UrlHelper.downloadResume(),
                      ),
                      const SizedBox(width: 8),
                      CustomButton(
                        label: "Let's Talk",
                        icon: Icons.chat_bubble_outline_rounded,
                        variant: ButtonVariant.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        onPressed: () => navController.scrollToSection(navController.contactKey),
                      ),
                    ],
                  ),
                ] else ...[
                  // Mobile Menu Button
                  IconButton(
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.textPrimary,
                      size: 28,
                    ),
                    onPressed: () => _openMobileMenu(context),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => navController.scrollToSection(navController.heroKey),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
              ),
              child: Text(
                'MH',
                style: AppTypography.h3(
                  size: 18,
                  weight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Manjith Hemachandran',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body(
                      size: 14,
                      weight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Flutter Engineer',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall(
                      size: 11,
                      color: AppColors.accentCyan,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, VoidCallback onTap, bool isActive) {
    return _NavHoverItem(label: label, onTap: onTap, isActive: isActive);
  }

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Material(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.borderLight, width: 1),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                _buildMobileMenuItem(ctx, 'About', () {
                  Navigator.pop(ctx);
                  navController.scrollToSection(navController.heroKey);
                }),
                _buildMobileMenuItem(ctx, 'Worked Clients & Brands', () {
                  Navigator.pop(ctx);
                  navController.scrollToSection(navController.clientsKey);
                }),
                _buildMobileMenuItem(ctx, '17+ Production Apps & Demos', () {
                  Navigator.pop(ctx);
                  navController.scrollToSection(navController.projectsKey);
                }),
                _buildMobileMenuItem(ctx, 'Capabilities', () {
                  Navigator.pop(ctx);
                  navController.scrollToSection(navController.capabilitiesKey);
                }),
                _buildMobileMenuItem(ctx, 'Shorebird OTA', () {
                  Navigator.pop(ctx);
                  navController.scrollToSection(navController.shorebirdKey);
                }),
                _buildMobileMenuItem(ctx, 'Technical Skills', () {
                  Navigator.pop(ctx);
                  navController.scrollToSection(navController.skillsKey);
                }),
                _buildMobileMenuItem(ctx, 'Experience', () {
                  Navigator.pop(ctx);
                  navController.scrollToSection(navController.experienceKey);
                }),
                _buildMobileMenuItem(ctx, 'Contact', () {
                  Navigator.pop(ctx);
                  navController.scrollToSection(navController.contactKey);
                }),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'Download Resume (PDF)',
                  icon: Icons.download_rounded,
                  variant: ButtonVariant.outline,
                  width: double.infinity,
                  onPressed: () {
                    Navigator.pop(ctx);
                    UrlHelper.downloadResume();
                  },
                ),
                const SizedBox(height: 12),
                CustomButton(
                  label: "Let's Talk",
                  icon: Icons.chat_bubble_outline_rounded,
                  variant: ButtonVariant.primary,
                  width: double.infinity,
                  onPressed: () {
                    Navigator.pop(ctx);
                    navController.scrollToSection(navController.contactKey);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileMenuItem(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: AppTypography.body(
          size: 16,
          weight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: AppColors.textMuted,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}

class _NavHoverItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _NavHoverItem({
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  State<_NavHoverItem> createState() => _NavHoverItemState();
}

class _NavHoverItemState extends State<_NavHoverItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: active ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(100), // Pill when active
          ),
          child: Text(
            widget.label,
            style: AppTypography.button(
              color: active ? Colors.white : AppColors.textSecondary,
              size: 14,
              weight: active ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
