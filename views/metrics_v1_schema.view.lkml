view: metrics_v1_schema {
  sql_table_name: `moz-fx-data-bq-looker-poc.org_mozilla_firefox.metrics_v1_schema`
    ;;

  dimension: column_name {
    type: string
    sql: ${TABLE}.column_name ;;
  }

  dimension: data_type {
    type: string
    sql: ${TABLE}.data_type ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: field_path {
    type: string
    sql: ${TABLE}.field_path ;;
  }

  dimension: table_catalog {
    type: string
    sql: ${TABLE}.table_catalog ;;
  }

  dimension: table_name {
    type: string
    sql: ${TABLE}.table_name ;;
  }

  dimension: table_schema {
    type: string
    sql: ${TABLE}.table_schema ;;
  }
}
