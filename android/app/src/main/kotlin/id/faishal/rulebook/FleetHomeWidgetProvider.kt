package id.faishal.rulebook

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class FleetHomeWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.fleet_home_widget).apply {
                val title = widgetData.getString("widget_title", "RuleBook") ?: "RuleBook"
                val subtitle = widgetData.getString("widget_subtitle", "Pocket SOPs, rules & checklists") ?: "Pocket SOPs, rules & checklists"
                val badge = widgetData.getString("widget_badge", "SOP") ?: "SOP"
                val meta = widgetData.getString("widget_meta", "") ?: ""
                val progress = widgetData.getInt("widget_progress", -1)

                setTextViewText(R.id.hw_title, title)
                setTextViewText(R.id.hw_subtitle, subtitle)
                setTextViewText(R.id.hw_badge, badge)

                if (meta.isNotEmpty()) {
                    setViewVisibility(R.id.hw_meta, View.VISIBLE)
                    setTextViewText(R.id.hw_meta, meta)
                } else {
                    setViewVisibility(R.id.hw_meta, View.GONE)
                }

                if (false && progress in 0..100) {
                    setViewVisibility(R.id.hw_progress, View.VISIBLE)
                    setProgressBar(R.id.hw_progress, 100, progress, false)
                } else {
                    setViewVisibility(R.id.hw_progress, View.GONE)
                }

                setOnClickPendingIntent(
                    R.id.hw_root,
                    HomeWidgetLaunchIntent.getActivity(
                        context,
                        MainActivity::class.java,
                        Uri.parse("faishal-rulebook://open/"),
                    ),
                )
            setTextViewText(R.id.hw_btn_0, "Rules")
            setOnClickPendingIntent(
                R.id.hw_btn_0,
                HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("faishal-rulebook://open/"),
                ),
            )
            setTextViewText(R.id.hw_btn_1, "SOP")
            setOnClickPendingIntent(
                R.id.hw_btn_1,
                HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("faishal-rulebook://open/sop"),
                ),
            )
            setTextViewText(R.id.hw_btn_2, "Checklist")
            setOnClickPendingIntent(
                R.id.hw_btn_2,
                HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("faishal-rulebook://open/checklist"),
                ),
            )
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
