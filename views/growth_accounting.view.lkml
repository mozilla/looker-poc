include: "/views/*.view.lkml"

view: growth_accounting {
  extends: [baseline_clients_last_seen]

  measure: last_updated_date {
    sql: MAX(${submission_raw}) ;;
    hidden: yes
  }

  dimension: active_this_week {
    sql: mozfun.bits28.active_in_range(days_seen_bits, -6, 7) ;;
    type: yesno
  }

  dimension: active_last_week {
    sql: mozfun.bits28.active_in_range(days_seen_bits, -13, 7) ;;
    type: yesno
  }

  dimension: new_this_week {
    sql: DATE_DIFF(${submission_date}, first_run_date, DAY) BETWEEN 0 AND 6 ;;
    type: yesno
  }

  dimension: new_last_week {
    sql: DATE_DIFF(${submission_date}, first_run_date, DAY) BETWEEN 7 AND 13 ;;
    type: yesno
  }

  measure: overall_active_previous {
    type: count
    filters: [active_last_week: "yes"]
  }

  measure: overall_active_current {
    type: count
    filters: [active_this_week: "yes"]
  }

  measure: overall_resurrected {
    type: count
    filters: [new_last_week: "no", new_this_week: "no", active_last_week: "no", active_this_week: "yes"]
  }

  measure: new_users {
    type: count
    filters: [new_this_week: "yes", active_this_week: "yes"]
  }

  measure: established_users_returning {
    type: count
    filters: [new_last_week: "no", new_this_week: "no", active_last_week: "yes", active_this_week: "yes"]
  }

  measure: new_users_returning {
    type: count
    filters: [new_last_week: "yes", active_last_week: "yes", active_this_week: "yes"]
  }

  measure: new_users_churned_count {
    type: count
    filters: [new_last_week: "yes", active_last_week: "yes", active_this_week: "no"]
    hidden: yes
  }

  measure: established_users_churned_count {
    type: count
    filters: [new_last_week: "no", new_this_week: "no", active_last_week: "yes", active_this_week: "no"]
    hidden: yes
  }

  measure: new_users_churned {
    type: number
    sql: -1 * ${new_users_churned_count} ;;
  }

  measure: established_users_churned {
    type: number
    sql: -1 * ${established_users_churned_count} ;;
  }

  measure: overall_churned {
    type: number
    sql: ${new_users_churned} + ${established_users_churned} ;;
  }

  measure: overall_retention_rate {
    type: number
    sql: SAFE_DIVIDE((${established_users_returning} + ${new_users_returning}), ${overall_active_previous}) ;;
  }

  measure: established_user_retention_rate {
    type: number
    sql:  SAFE_DIVIDE(
      ${established_users_returning},
      (${established_users_returning} + ${established_users_churned_count})
    );;
  }

  measure: new_user_retention_rate {
    type: number
    sql: SAFE_DIVIDE(${new_users_returning}, (${new_users_returning} + ${new_users_churned_count})) ;;
  }

  measure: overall_churn_rate {
    type: number
    sql: SAFE_DIVIDE((${established_users_churned_count} + ${new_users_churned_count}), ${overall_active_previous}) ;;
  }

  measure: fraction_of_active_resurrected {
    type: number
    sql: SAFE_DIVIDE(${overall_resurrected}, ${overall_active_current}) ;;
  }

  measure: fraction_of_active_new {
    type: number
    sql: SAFE_DIVIDE(${new_users}, ${overall_active_current}) ;;
  }

  measure: fraction_of_active_established_returning {
    type: number
    sql: SAFE_DIVIDE(${established_users_returning}, ${overall_active_current}) ;;
  }

  measure: fraction_of_active_new_returning {
    type: number
    sql: SAFE_DIVIDE(${new_users_returning}, ${overall_active_current}) ;;
  }

  measure: quick_ratio {
    type: number
    sql: SAFE_DIVIDE((${new_users} + ${overall_resurrected}), (${established_users_churned_count} + ${new_users_churned_count})) ;;
  }
}
