view: baseline_clients_last_seen {
  sql_table_name: `moz-fx-data-bq-looker-poc.org_mozilla_firefox.baseline_clients_last_seen`
    ;;

  dimension: android_sdk_version {
    type: string
    sql: ${TABLE}.android_sdk_version ;;
  }

  dimension: app_build {
    type: string
    sql: ${TABLE}.app_build ;;
  }

  dimension: app_channel {
    type: string
    sql: ${TABLE}.app_channel ;;
  }

  dimension: app_display_version {
    type: string
    sql: ${TABLE}.app_display_version ;;
  }

  dimension: architecture {
    type: string
    sql: ${TABLE}.architecture ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    suggest_explore: one_day_cls
    suggest_dimension: city
  }

  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }

  dimension: country {
    full_suggestions: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    drill_fields: [city]
    suggest_explore: one_day_cls
    suggest_dimension: country
  }

  dimension: days_created_profile_bits {
    type: number
    sql: ${TABLE}.days_created_profile_bits ;;
  }

  dimension: days_seen_bits {
    type: number
    sql: ${TABLE}.days_seen_bits ;;
  }

  dimension: days_seen_session_end_bits {
    type: number
    sql: ${TABLE}.days_seen_session_end_bits ;;
  }

  dimension: days_seen_session_start_bits {
    type: number
    sql: ${TABLE}.days_seen_session_start_bits ;;
  }

  dimension: days_since_created_profile {
    type: number
    sql: ${TABLE}.days_since_created_profile ;;
  }

  dimension: days_since_seen {
    type: number
    sql: ${TABLE}.days_since_seen ;;
  }

  dimension: days_since_seen_session_end {
    type: number
    sql: ${TABLE}.days_since_seen_session_end ;;
  }

  dimension: days_since_seen_session_start {
    type: number
    sql: ${TABLE}.days_since_seen_session_start ;;
  }

  dimension: device_manufacturer {
    full_suggestions: yes
    type: string
    sql: ${TABLE}.device_manufacturer ;;
    suggest_explore: one_day_cls
    suggest_dimension: device_manufacturer
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.device_model ;;
  }

  dimension: durations {
    type: number
    sql: ${TABLE}.durations ;;
  }

  dimension_group: first_run {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.first_run_date ;;
  }

  dimension: locale {
    full_suggestions: yes
    type: string
    sql: ${TABLE}.locale ;;
    suggest_explore: one_day_cls
    suggest_dimension: locale

  }

  dimension: normalized_channel {
    full_suggestions: yes
    type: string
    sql: ${TABLE}.normalized_channel ;;
    suggest_explore: one_day_cls
    suggest_dimension: normalized_channel

  }

  dimension: normalized_os {
    type: string
    sql: ${TABLE}.normalized_os ;;
  }

  dimension: normalized_os_version {
    type: string
    sql: ${TABLE}.normalized_os_version ;;
  }

  dimension: sample_id {
    type: number
    sql: ${TABLE}.sample_id ;;
  }

  dimension_group: submission {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.submission_date ;;
  }

  dimension: telemetry_sdk_build {
    type: string
    sql: ${TABLE}.telemetry_sdk_build ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
view: baseline_clients_last_seen_2 {
  sql_table_name: `moz-fx-data-bq-looker-poc.org_mozilla_firefox.baseline_clients_last_seen`
    ;;

  dimension: android_sdk_version {
    type: string
    sql: ${TABLE}.android_sdk_version ;;
  }

  dimension: app_build {
    type: string
    sql: ${TABLE}.app_build ;;
  }

  dimension: app_channel {
    type: string
    sql: ${TABLE}.app_channel ;;
  }

  dimension: app_display_version {
    type: string
    sql: ${TABLE}.app_display_version ;;
  }

  dimension: architecture {
    type: string
    sql: ${TABLE}.architecture ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }

  dimension: country {
    full_suggestions: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    drill_fields: [city]
  }

  dimension: days_created_profile_bits {
    type: number
    sql: ${TABLE}.days_created_profile_bits ;;
  }

  dimension: days_seen_bits {
    type: number
    sql: ${TABLE}.days_seen_bits ;;
  }

  dimension: days_seen_session_end_bits {
    type: number
    sql: ${TABLE}.days_seen_session_end_bits ;;
  }

  dimension: days_seen_session_start_bits {
    type: number
    sql: ${TABLE}.days_seen_session_start_bits ;;
  }

  dimension: days_since_created_profile {
    type: number
    sql: ${TABLE}.days_since_created_profile ;;
  }

  dimension: days_since_seen {
    type: number
    sql: ${TABLE}.days_since_seen ;;
  }

  dimension: days_since_seen_session_end {
    type: number
    sql: ${TABLE}.days_since_seen_session_end ;;
  }

  dimension: days_since_seen_session_start {
    type: number
    sql: ${TABLE}.days_since_seen_session_start ;;
  }

  dimension: device_manufacturer {
    full_suggestions: yes
    type: string
    sql: ${TABLE}.device_manufacturer ;;
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.device_model ;;
  }

  dimension: durations {
    type: number
    sql: ${TABLE}.durations ;;
  }

  dimension_group: first_run {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.first_run_date ;;
  }

  dimension: locale {
    full_suggestions: yes
    type: string
    sql: ${TABLE}.locale ;;
  }

  dimension: normalized_channel {
    full_suggestions: yes
    type: string
    sql: ${TABLE}.normalized_channel ;;
  }

  dimension: normalized_os {
    type: string
    sql: ${TABLE}.normalized_os ;;
  }

  dimension: normalized_os_version {
    type: string
    sql: ${TABLE}.normalized_os_version ;;
  }

  dimension: sample_id {
    type: number
    sql: ${TABLE}.sample_id ;;
  }

  dimension_group: submission {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.submission_date ;;
  }

  dimension: telemetry_sdk_build {
    type: string
    sql: ${TABLE}.telemetry_sdk_build ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
