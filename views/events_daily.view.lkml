view: events_daily {
  sql_table_name: `org_mozilla_firefox.events_daily`
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

  dimension: completed_event_1 {
    type: yesno
    sql:  REGEXP_CONTAINS(${TABLE}.events, mozfun.event_analysis.create_funnel_regex([
            mozfun.event_analysis.event_index_to_match_string(${event_types.index})],
            True)) ;;
  }

  dimension: completed_event_2 {
    type: yesno
    sql:  REGEXP_CONTAINS(${TABLE}.events,
            mozfun.event_analysis.create_funnel_regex([
              mozfun.event_analysis.event_index_to_match_string(${event_types.index}),
              mozfun.event_analysis.event_index_to_match_string(${event_2.index})],
            True)) ;;
  }

  dimension: completed_event_3 {
    type: yesno
    sql:  REGEXP_CONTAINS(${TABLE}.events,
            mozfun.event_analysis.create_funnel_regex([
              mozfun.event_analysis.event_index_to_match_string(${event_types.index}),
              mozfun.event_analysis.event_index_to_match_string(${event_2.index}),
              mozfun.event_analysis.event_index_to_match_string(${event_3.index})],
            True)) ;;
  }


  dimension: completed_event_4 {
    type: yesno
    sql:  REGEXP_CONTAINS(${TABLE}.events,
            mozfun.event_analysis.create_funnel_regex([
              mozfun.event_analysis.event_index_to_match_string(${event_types.index}),
              mozfun.event_analysis.event_index_to_match_string(${event_2.index}),
              mozfun.event_analysis.event_index_to_match_string(${event_3.index}),
              mozfun.event_analysis.event_index_to_match_string(${event_4.index})],
            True)) ;;
  }


  measure: count_sessions_event1 {
    label: "Step 1"
    type: count

    filters: {
      field: completed_event_1
      value: "yes"
    }
  }

  measure: count_sessions_event2 {
    label: "Step 2"
    type: count
    description: "Only includes sessions which also completed event 1"

    filters: {
      field: completed_event_2
      value: "yes"
    }
  }

  measure: count_sessions_event3 {
    label: "Step 3"
    type: count
    description: "Only includes sessions which also completed up to event 2"

    filters: {
      field: completed_event_3
      value: "yes"
    }
  }

  measure: count_sessions_event4 {
    label: "Step 4"
    type: count
    description: "Only includes sessions which also completed up to event 3"

    filters: {
      field: completed_event_4
      value: "yes"
    }
  }
}