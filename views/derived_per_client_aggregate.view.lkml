view: derived_per_client_aggregate {
  derived_table: {
    sql:
    SELECT
        client_info.client_id,
        CAST(DATE(submission_timestamp) AS TIMESTAMP) AS submission_date,
        {% parameter client_aggregation_type %}({% parameter metric %}) AS client_aggregate,
    FROM org_mozilla_firefox.metrics m
    WHERE
        DATE(submission_timestamp) >= '2020-01-01'
        AND sample_id = 1
    GROUP BY
        client_id,
        submission_date ;;
  }

  dimension: submission_date {
    type: date
    sql: ${TABLE}.submission_date ;;
  }

  dimension: client_aggregate {
    sql: ${TABLE}.client_aggregate ;;
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
      label: "Max"
      value: "max"
    }
    allowed_value: {
      label: "Min"
      value: "min"
    }
  }

  parameter: daily_aggregation_type {
    default_value: "max"
    type: unquoted
    allowed_value: {
      label: "Sum"
      value: "sum"
    }
    allowed_value: {
      label: "Max"
      value: "max"
    }
    allowed_value: {
      label: "Min"
      value: "min"
    }
  }

  measure: daily_aggregate {
    sql: {% parameter daily_aggregation_type %}(${client_aggregate}) ;;
    type: number
  }
}
