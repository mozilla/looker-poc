view: event_counts {
  sql_table_name: `org_mozilla_firefox.event_counts`
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

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
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
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: device_manufacturer {
    type: string
    sql: ${TABLE}.device_manufacturer ;;
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.device_model ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: event_count {
    type: number
    sql: ${TABLE}.event_count ;;
  }

  dimension: events {
    type: string
    sql: ${TABLE}.events ;;
  }

  dimension: experiments {
    hidden: yes
    sql: ${TABLE}.experiments ;;
  }

  dimension: first_run_date {
    type: string
    sql: ${TABLE}.first_run_date ;;
  }

  dimension: locale {
    type: string
    sql: ${TABLE}.locale ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: os_version {
    type: string
    sql: ${TABLE}.os_version ;;
  }

  dimension: sample_id {
    type: number
    sql: ${TABLE}.sample_id ;;
  }

  dimension: subdivision1 {
    type: string
    sql: ${TABLE}.subdivision1 ;;
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

  dimension: user_count {
    type: number
    sql: ${TABLE}.user_count ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: event_counts__experiments {
  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}
