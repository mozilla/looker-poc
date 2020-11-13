view: per_day_client_aggregate {
  sql_table_name: `moz-fx-data-bq-looker-poc.org_mozilla_firefox.metrics`
    ;;

  dimension: additional_properties {
    type: string
    sql: ${TABLE}.additional_properties ;;
  }

  dimension: client_info {
    hidden: yes
    sql: ${TABLE}.client_info ;;
  }

  dimension: document_id {
    type: string
    sql: ${TABLE}.document_id ;;
  }

  dimension: events {
    hidden: yes
    sql: ${TABLE}.events ;;
  }

  dimension: metadata {
    hidden: yes
    sql: ${TABLE}.metadata ;;
  }

  dimension: metrics {
    hidden: yes
    sql: ${TABLE}.metrics ;;
  }

  dimension: normalized_app_name {
    type: string
    sql: ${TABLE}.normalized_app_name ;;
  }

  dimension: normalized_channel {
    type: string
    sql: ${TABLE}.normalized_channel ;;
  }

  dimension: normalized_country_code {
    type: string
    sql: ${TABLE}.normalized_country_code ;;
  }

  dimension: normalized_os {
    type: string
    sql: ${TABLE}.normalized_os ;;
  }

  dimension: normalized_os_version {
    type: string
    sql: ${TABLE}.normalized_os_version ;;
  }

  dimension: ping_info {
    hidden: yes
    sql: ${TABLE}.ping_info ;;
  }

  dimension: sample_id {
    type: number
    sql: ${TABLE}.sample_id ;;
  }

  dimension_group: submission {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.submission_timestamp ;;
  }

  dimension: android_sdk_version {
    type: string
    sql: ${TABLE}.client_info.android_sdk_version ;;
  }

  dimension: app_build {
    type: string
    sql: ${TABLE}.client_info.app_build ;;
  }

  dimension: app_channel {
    type: string
    sql: ${TABLE}.client_info.app_channel ;;
  }

  dimension: app_display_version {
    type: string
    sql: ${TABLE}.client_info.app_display_version ;;
  }

  dimension: architecture {
    type: string
    sql: ${TABLE}.client_info.architecture ;;
  }

  dimension: client_id {
    type: string
    sql: ${TABLE}.client_info.client_id ;;
  }

  dimension: device_manufacturer {
    type: string
    sql: ${TABLE}.client_info.device_manufacturer ;;
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.client_info.device_model ;;
  }

  dimension: first_run_date {
    type: string
    sql: ${TABLE}.client_info.first_run_date ;;
  }

  dimension: locale {
    type: string
    sql: ${TABLE}.client_info.locale ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.client_info.os ;;
  }

  dimension: os_version {
    type: string
    sql: ${TABLE}.client_info.os_version ;;
  }

  dimension: telemetry_sdk_build {
    type: string
    sql: ${TABLE}.client_info.telemetry_sdk_build ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.metadata.geo.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.metadata.geo.country ;;
  }

  dimension: db_version {
    type: string
    sql: ${TABLE}.metadata.geo.db_version ;;
  }

  dimension: subdivision1 {
    type: string
    sql: ${TABLE}.metadata.geo.subdivision1 ;;
  }

  dimension: subdivision2 {
    type: string
    sql: ${TABLE}.metadata.geo.subdivision2 ;;
  }

  dimension_group: parsed_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ping_info.parsed_end_time ;;
  }

  dimension_group: parsed_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ping_info.parsed_start_time ;;
  }

  dimension: ping_type {
    type: string
    sql: ${TABLE}.ping_info.ping_type ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.ping_info.reason ;;
  }

  dimension: seq {
    type: number
    sql: ${TABLE}.ping_info.seq ;;
  }

  parameter: metric {
    default_value: ""
    type: unquoted
    suggest_explore: metrics_v1_schema
    suggest_dimension: metrics_v1_schema.field_path
  }

  parameter: client_aggregation_type {
    default_value: "sum"
    type: unquoted
    allowed_value: {
      label: "Sum"
      value: "sum"
    }
    allowed_value: {
      label: "Mode"
      value: "mozfun.stats.mode_last(ARRAY_AGG("
    }
  }

  measure: client_aggregate {
    sql: {% parameter client_aggregation_type %}(${TABLE}.{% parameter metric %}) ;;
    label_from_parameter: metric
    type: number
  }

  measure: per_day_aggregate {
    sql: ${client_aggregate}  ;;
    type: sum
  }
}
