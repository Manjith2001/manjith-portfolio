import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/projects_data.dart';
import '../../../models/project_model.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/section_header.dart';
import '../../widgets/tech_chip.dart';
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

    int crossAxisCount;
    if (width >= 1150) {
      crossAxisCount = 3;
    } else if (width >= 720) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header without machine-generated slashes
          const SectionHeader(
            tag: 'Commercial Applications',
            title: 'Project Showcase & Video Demos',
            subtitle:
                'Explore 17+ commercial applications deployed to Google Play Store & Apple App Store. '
                'Watch live 60fps walkthrough video recordings of Enkage, Rentings, YalDiet, Healthy Diet, '
                'The Champions Diet, Under Thirty, Nura, Steamed, and Traffic Map.',
          ),
          const SizedBox(height: 32),

          // Symmetrical Category Filter Tabs Track
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: ProjectsData.categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TechChip(
                      label: cat,
                      icon: cat == 'Video Demos'
                          ? Icons.play_circle_fill_rounded
                          : null,
                      isSelected: isSelected,
                      color: cat == 'Video Demos'
                          ? AppColors.accentCyan
                          : AppColors.primaryLight,
                      onTap: () => setState(() => _selectedCategory = cat),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 36),

          // Responsive Project Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final spacing = 20.0;

              if (filteredProjects.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(40),
                  alignment: Alignment.center,
                  child: const Text('No projects found in this category.'),
                );
              }

              // Chunk projects into symmetrical rows based on crossAxisCount
              final List<List<ProjectModel>> rows = [];
              for (var i = 0; i < filteredProjects.length; i += crossAxisCount) {
                rows.add(filteredProjects.sublist(
                  i,
                  (i + crossAxisCount > filteredProjects.length)
                      ? filteredProjects.length
                      : i + crossAxisCount,
                ));
              }

              return Column(
                children: [
                  for (int r = 0; r < rows.length; r++) ...[
                    if (r > 0) const SizedBox(height: 24),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (int c = 0; c < rows[r].length; c++) ...[
                            if (c > 0) SizedBox(width: spacing),
                            Expanded(
                              child: ProjectCard(
                                project: rows[r][c],
                                onSelect: () => widget.navController
                                    .openProjectDetail(rows[r][c]),
                              ),
                            ),
                          ],
                          // Fill remaining slots in last row to maintain equal proportions
                          for (int k = 0; k < crossAxisCount - rows[r].length; k++) ...[
                            SizedBox(width: spacing),
                            const Expanded(child: SizedBox.shrink()),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
