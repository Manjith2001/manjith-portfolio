import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/projects_data.dart';
import '../../../models/project_model.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/section_header.dart';
import 'project_card.dart';

class ProjectsSection extends StatefulWidget {
  final NavigationController navController;

  const ProjectsSection({super.key, required this.navController});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Filter projects based on selected pill
    final List<ProjectModel> filteredProjects = ProjectsData.projects.where((p) {
      if (_selectedCategory == 'All') return true;
      if (_selectedCategory == 'Video Demos') return p.hasVideo;
      if (_selectedCategory == 'Featured') return p.isFeatured;
      if (_selectedCategory == 'Maps & Location') {
        return p.hasMapIntegration || p.category == 'Maps & Location';
      }
      return p.category == _selectedCategory;
    }).toList();

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          const SectionHeader(
            tag: 'Device Lab',
            title: 'Commercial App Gallery',
            subtitle:
                'Explore 17+ commercial applications deployed to Google Play Store & Apple App Store. '
                'Watch live 60fps walkthrough video recordings of top-tier production deployments.',
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 40),

          // Refined Pill Filter Bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: ProjectsData.categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (cat == 'Video Demos') ...[
                          Icon(
                            Icons.play_circle_fill_rounded,
                            size: 15,
                            color: isSelected ? Colors.white : AppColors.accentCyan,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          cat,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() => _selectedCategory = cat);
                    },
                    backgroundColor: AppColors.card,
                    selectedColor: AppColors.primary,
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : AppColors.borderLight.withValues(alpha: 0.8),
                        width: 1.2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    elevation: isSelected ? 4 : 0,
                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                  ),
                );
              }).toList(),
            ).animate().fadeIn(delay: 150.ms).slideX(begin: 0.05, end: 0),
          ),
          const SizedBox(height: 48),

          // Device Lab Gallery (Symmetric, Equal Proportion Grid)
          LayoutBuilder(
            builder: (context, constraints) {
              if (filteredProjects.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    'No projects found in this category.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                );
              }

              if (width >= 1100) {
                // 4-column symmetric grid on desktop
                return _buildGrid(filteredProjects, 4, constraints.maxWidth);
              } else if (width >= 800) {
                // 3-column symmetric grid on laptop
                return _buildGrid(filteredProjects, 3, constraints.maxWidth);
              } else if (width >= 550) {
                // 2-column symmetric grid on tablet
                return _buildGrid(filteredProjects, 2, constraints.maxWidth);
              } else {
                // 1-column centered on mobile
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: _buildGrid(filteredProjects, 1, 320),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<ProjectModel> projects, int columns, double maxWidth) {
    const double spacing = 28.0;
    final double totalSpacing = spacing * (columns - 1);
    final double itemWidth = (maxWidth - totalSpacing) / columns;

    return Wrap(
      spacing: spacing,
      runSpacing: 48,
      children: projects.asMap().entries.map((entry) {
        final index = entry.key;
        final project = entry.value;

        return SizedBox(
          width: itemWidth,
          child: ProjectCard(
            project: project,
            isFeatured: false,
            onSelect: () => widget.navController.openProjectDetail(project),
          ).animate().fadeIn(delay: (50 * (index % 8)).ms).slideY(begin: 0.08, end: 0),
        );
      }).toList(),
    );
  }
}