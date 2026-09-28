import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/rule_category.dart';
import '../../core/models/rule_item.dart';
import '../../core/providers/app_providers.dart';
import 'rule_detail_screen.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  late TextEditingController _searchController;

  final List<String> _quickFilterKeywords = [
    'Tilang',
    'Lembur',
    'Pesangon',
    'UU PDP',
    'K3',
    'Garansi',
    'Busway',
    'Knalpot',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rules = ref.watch(filteredRulesProvider);
    final activeCategory = ref.watch(selectedCategoryProvider);
    final bookmarkedIds = ref.watch(bookmarksProvider);
    final currentQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_stories, color: AppColors.primaryLight, size: 22),
            SizedBox(width: 10),
            Text('RuleBook', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Pengaturan & Privasi',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari pasal, tilang, pesangon, ITE, SOP...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).clear();
                        },
                      )
                    : null,
              ),
              onChanged: (val) {
                ref.read(searchQueryProvider.notifier).setQuery(val);
              },
            ),
          ),

          // Quick Keywords Chips
          SizedBox(
            height: 36,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _quickFilterKeywords.length,
              separatorBuilder: (ctx, i) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final kw = _quickFilterKeywords[index];
                final isSelected = currentQuery.toLowerCase() == kw.toLowerCase();
                return ActionChip(
                  label: Text(kw, style: TextStyle(fontSize: 11, color: isSelected ? Colors.white : const Color(0xFF94A3B8))),
                  backgroundColor: isSelected ? AppColors.primary : AppColors.bgSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isSelected ? AppColors.primaryLight : AppColors.border,
                    ),
                  ),
                  onPressed: () {
                    if (isSelected) {
                      _searchController.clear();
                      ref.read(searchQueryProvider.notifier).clear();
                    } else {
                      _searchController.text = kw;
                      ref.read(searchQueryProvider.notifier).setQuery(kw);
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Categories Horizontal Selector
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              scrollDirection: Axis.horizontal,
              itemCount: RuleCategory.values.length,
              separatorBuilder: (ctx, i) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = RuleCategory.values[index];
                final isSelected = activeCategory == cat;
                return ChoiceChip(
                  avatar: Icon(cat.icon, size: 14, color: isSelected ? Colors.white : cat.tagColor),
                  label: Text(cat.label),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  onSelected: (_) {
                    ref.read(selectedCategoryProvider.notifier).selectCategory(cat);
                  },
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                    color: isSelected ? Colors.white : const Color(0xFFCBD5E1),
                  ),
                );
              },
            ),
          ),

          // Counter indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menampilkan ${rules.length} aturan hukum',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                ),
                if (currentQuery.isNotEmpty || activeCategory != RuleCategory.all)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      ref.read(searchQueryProvider.notifier).clear();
                      ref.read(selectedCategoryProvider.notifier).selectCategory(RuleCategory.all);
                    },
                    child: const Text(
                      'Reset Filter',
                      style: TextStyle(fontSize: 11, color: AppColors.primaryLight, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),

          // Rules List
          Expanded(
            child: rules.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 48, color: Colors.grey.shade600),
                        const SizedBox(height: 12),
                        const Text(
                          'Tidak ada aturan yang cocok',
                          style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Coba kata kunci lain atau pilih kategori Semua.',
                          style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    itemCount: rules.length,
                    itemBuilder: (context, index) {
                      final item = rules[index];
                      final isSaved = bookmarkedIds.contains(item.id);
                      return _buildRuleCard(context, item, isSaved);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleCard(BuildContext context, RuleItem item, bool isSaved) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RuleDetailScreen(rule: item),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: item.category.tagColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.category.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: item.category.tagColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        size: 20,
                        color: isSaved ? AppColors.accent : const Color(0xFF94A3B8),
                      ),
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        ref.read(bookmarksProvider.notifier).toggleBookmark(item.id);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  item.summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.4),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.gavel, size: 14, color: AppColors.accent),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item.penaltyOrRight,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, size: 16, color: Color(0xFF64748B)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
