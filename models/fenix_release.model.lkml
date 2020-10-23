connection: "bigquery"

# include all the views
include: "/views/**/*.view"

datagroup: fenix_release_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: fenix_release_default_datagroup

# should use this next time: https://help.looker.com/hc/en-us/articles/360048648594-Filtering-a-View-Using-a-Field-from-Another-View-without-Joining-Views
explore: funnel_analysis {
  from: events_daily
  join: event_types {
    view_label: "Funnel Event 1"
    relationship: many_to_one
    type: cross
  }
  join: event_2 {
    view_label: "Funnel Event 2"
    from: event_types
    relationship: many_to_one
    type: cross
  }
  join: event_3 {
    view_label: "Funnel Event 3"
    from: event_types
    relationship: many_to_one
    type: cross
  }
  join: event_4 {
    view_label: "Funnel Event 4"
    from: event_types
    relationship: many_to_one
    type: cross
  }
  always_filter: {
    filters: [
      submission_date: "1 year",
      event_types.category: "events",
      event_types.event: "app^_opened^_all^_startup",
      event_2.category: "events",
      event_2.event: "search^_bar^_tapped",
      event_3.category: "events",
      event_3.event: "search^_bar^_tapped",
      event_4.category: "events",
      event_4.event: "search^_bar^_tapped"
    ]
  }
}
