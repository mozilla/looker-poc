include: "/views/*.view.lkml"

view: user_activity {
  extends: [baseline_clients_last_seen]

  dimension: active_this_day {
    type: yesno
    sql: ${days_since_seen} < 1 ;;
  }

  dimension: active_in_last_5_days {
    type: yesno
    sql:  mozudf.bits_28.active_in_5(${days_seen_bits}) ;;
  }

  dimension: active_last_7_days {
    type: yesno
    sql: ${days_since_seen} < 7 ;;
  }

  dimension: active_two_weeks_ago {
    type: number
    sql: mozfun.bits28.active_in_range(${days_seen_bits}, -14, 7) ;;
  }

  dimension: active_last_week_and_two_weeks_ago {
    type: number
    sql: ${active_last_7_days} AND ${active_two_weeks_ago} ;;
  }

  measure: wow_retention {
    label: "WoW Retention"
    type: number
    sql: SAFE_DIVIDE(COUNTIF(${active_last_week_and_two_weeks_ago}), COUNTIF(${active_two_weeks_ago})) ;;
  }

  dimension: active_today {
    type: yesno
    sql: mozfun.bits28.active_in_range(${days_seen_bits}, 0, 1) ;;
  }

  dimension: active_yesterday {
    type: number
    sql: mozfun.bits28.active_in_range(${days_seen_bits}, -1, 1) ;;
  }

  dimension: active_today_and_yesterday {
    type: number
    sql: ${active_today} AND ${active_yesterday} ;;
  }

  measure: dod_retention {
    label: "DoD Retention"
    type: number
    sql: SAFE_DIVIDE(COUNTIF(${active_today_and_yesterday}), COUNTIF(${active_yesterday})) ;;
  }

  measure: user_count_active_28_days {
    label: "Monthly Active Users"
    type: count
    drill_fields: [users.id, users.name]

    link: {
      label: "MAU by Country"
      url:"/explore/fenix-activity/active_users?fields=active_users.user_count_active_28_days,users_v1.country&f[active_users.submission_date_date]=2+days&sorts=users_v1.country&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22light%22%2C%22map_position%22%3A%22fit_data%22%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Atrue%2C%22map_zoomable%22%3Atrue%2C%22map_marker_type%22%3A%22circle%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Afalse%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22show_null_points%22%3Atrue%2C%22interpolation%22%3A%22linear%22%2C%22type%22%3A%22looker_map%22%2C%22defaults_version%22%3A1%2C%22series_types%22%3A%7B%7D%7D&filter_config=%7B%22active_users.submission_date_date%22%3A%5B%7B%22type%22%3A%22past%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222%22%2C%22unit%22%3A%22day%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"    }
  }

  measure: user_count_active_this_day {
    label: "Daily Active Users"
    type: count
    drill_fields: [users.id, users.name]

    filters: {
      field: active_this_day
      value: "yes"
    }
  }

  measure: user_count_active_7_days {
    label: "Weekly Active Users"
    type: count
    drill_fields: [users.id, users.name]

    filters: {
      field: active_last_7_days
      value: "yes"
    }
  }

  dimension: intensity {
    type: number
    sql: BIT_COUNT(mozfun.bits28.range(${TABLE}.days_seen_bits, -13 + 0, 7)) ;;
  }

  measure: average_intensity {
    label: "Average Intensity"
    type: average
    sql: ${intensity} ;;
  }
}
