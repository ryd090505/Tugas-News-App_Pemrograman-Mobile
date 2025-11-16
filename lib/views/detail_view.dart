import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/detail_controller.dart';
import '../utils/app_colors.dart';
import '../utils/date_formatter.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final article = controller.article;
    final radius = 18.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 320,
              pinned: true,
              backgroundColor: AppColors.background,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppColors.neumorphismOuter(blur: 10, offset: 6),
                    ),
                    child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: article.urlToImage != null
                    ? Hero(
                        tag: article.urlToImage!,
                        child: CachedNetworkImage(
                          imageUrl: article.urlToImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: (c, u) => Container(color: AppColors.surface),
                          errorWidget: (c, u, e) => Container(
                            color: AppColors.surface,
                            child: Icon(Icons.broken_image, size: 80, color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.surface,
                        child: Center(child: Icon(Icons.article, size: 96, color: AppColors.textSecondary)),
                      ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 580),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(offset: Offset(0, 30 * (1 - value)), child: child),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title card (neumorphism)
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(radius),
                          boxShadow: AppColors.neumorphismOuter(blur: 16, offset: 8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(article.title ?? '—',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                )),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.person, size: 16, color: AppColors.textSecondary),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    article.author ?? 'Unknown',
                                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.access_time, size: 16, color: AppColors.textSecondary),
                                const SizedBox(width: 6),
                                Text(DateFormatter.formatFullDate(article.publishedAt), style: TextStyle(color: AppColors.textSecondary)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      if (article.description != null)
                        Text(
                          article.description!,
                          style: TextStyle(color: AppColors.textPrimary, fontSize: 16, height: 1.5),
                        ),

                      const SizedBox(height: 12),

                      if (article.content != null)
                        Text(
                          article.content!,
                          style: TextStyle(color: AppColors.textPrimary, fontSize: 15, height: 1.6),
                        ),

                      const SizedBox(height: 22),

                      // source link & actions
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: AppColors.neumorphismOuter(blur: 12, offset: 6, opacityDark: 0.30),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.link, size: 16, color: AppColors.primary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      article.url ?? '-',
                                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // share & bookmark
                          Column(
                            children: [
                              InkWell(
                                onTap: controller.shareArticle,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: AppColors.neumorphismOuter(blur: 12, offset: 6, opacityDark: 0.28),
                                  ),
                                  child: Icon(Icons.share, color: AppColors.textPrimary),
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: controller.bookmarkArticle,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: AppColors.neumorphismOuter(blur: 12, offset: 6, opacityDark: 0.28),
                                  ),
                                  child: Icon(Icons.bookmark_border, color: AppColors.textPrimary),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
