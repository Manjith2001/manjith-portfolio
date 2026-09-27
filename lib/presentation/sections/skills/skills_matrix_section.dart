import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/skills_data.dart';
import '../../../models/experience_model.dart';
import '../../widgets/section_header.dart';

class SkillsMatrixSection extends StatelessWidget {
  const SkillsMatrixSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    int columns = 1;
    if (width >= 1024) columns = 3;
    else if (width >= 768) columns = 2;

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            tag: 'Technology Ecosystem',
            title: 'Verified Skills & Tech Ecosystem',
            subtitle:
                'Hands-on engineering competencies grouped across mobile platforms, state architectures, '
                'payment gateways, and production cloud services. Zero subjective percentages.',
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 64),
          
          _buildMasonryLikeGrid(columns),
        ],
      ),
    );
  }

  Widget _buildMasonryLikeGrid(int columns) {
    final List<List<Widget>> cols = List.generate(columns, (_) => <Widget>[]);
    
    for (int i = 0; i < SkillsData.categories.length; i++) {
      cols[i % columns].add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _FloatingPod(category: SkillsData.categories[i]),
        ).animate().fadeIn(delay: (100 * i).ms).slideY(begin: 0.1),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cols.map((colItems) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: columns > 1 ? 12.0 : 0),
            child: Column(
              children: colItems,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _FloatingPod extends StatefulWidget {
  final SkillCategoryModel category;

  const _FloatingPod({required this.category});

  @override
  State<_FloatingPod> createState() => _FloatingPodState();
}

class _FloatingPodState extends State<_FloatingPod> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered ? Matrix4.translationValues(0, -4, 0) : Matrix4.identity(),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? widget.category.accentColor.withOpacity(0.5) : AppColors.borderLight,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? widget.category.accentColor.withOpacity(0.15) : Colors.black.withOpacity(0.2),
              blurRadius: _isHovered ? 32 : 16,
              offset: const Offset(0, 8),
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surface,
              widget.category.accentColor.withOpacity(0.02),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.category.accentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: widget.category.accentColor.withOpacity(0.2)),
                  ),
                  child: Icon(widget.category.icon, color: widget.category.accentColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.category.name,
                    style: AppTypography.h3(size: 20, weight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: widget.category.skills.asMap().entries.map((entry) {
                final isCore = entry.key < 2; // First 2 skills as "core" skills
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: isCore ? 16 : 14, vertical: isCore ? 10 : 8),
                  decoration: BoxDecoration(
                    color: isCore ? widget.category.accentColor.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: isCore 
                          ? widget.category.accentColor.withOpacity(0.5) 
                          : AppColors.borderLight,
                    ),
                  ),
                  child: Text(
                    entry.value,
                    style: AppTypography.bodySmall(
                      size: isCore ? 13 : 12,
                      color: isCore ? Colors.white : AppColors.textSecondary,
                      weight: isCore ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
