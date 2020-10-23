view: event_types {
  sql_table_name: `org_mozilla_firefox.event_types`
    ;;

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    drill_fields: [event]
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: name {
    type: string
    sql: CONCAT(${TABLE}.category, " - ", ${TABLE}.event) ;;
  }

  dimension: event_properties {
    hidden: yes
    sql: ${TABLE}.event_properties ;;
  }

  dimension_group: first_timestamp {
    hidden: yes
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
    sql: ${TABLE}.first_timestamp ;;
  }

  dimension: index {
    hidden: yes
    type: string
    sql: ${TABLE}.index ;;
  }

  dimension: numeric_index {
    hidden: yes
    type: number
    sql: ${TABLE}.numeric_index ;;
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

  measure: funnel {
    sql: mozfun.event_analysis.create_funnel_regex(ARRAY_AGG(mozfun.event_analysis.event_index_to_match_string(index)), True)
  }
}

view: event_types__event_properties {
  dimension: index {
    type: number
    sql: ${TABLE}.index ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: event_types__event_properties__value {
  dimension: index {
    type: number
    sql: ${TABLE}.index ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}
