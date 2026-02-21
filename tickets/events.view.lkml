view: events {
  view_label: "Events"
  sql_table_name: TEST_DB.TICKET.EVENT ;;
  drill_fields: [event_id]

  dimension: event_id {
    group_label: "Keys/IDs"
    label: "Event ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.EVENTID ;;
  }

  dimension: cat_id {
    group_label: "Keys/IDs"
    label: "Category ID"
    type: number
    sql: ${TABLE}.CATID ;;
  }

  dimension: date_id {
    group_label: "Keys/IDs"
    label: "Date ID"
    type: number
    sql: ${TABLE}.DATEID ;;
  }

  dimension_group: event {
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
    sql: DATEADD(YEAR, 11, ${TABLE}.STARTTIME) ;;
  }

  dimension: event_name {
    label: "Event Name"
    type: string
    sql: ${TABLE}.EVENTNAME ;;
  }

  dimension: venue_id {
    group_label: "Keys/IDs"
    label: "Venue ID"
    type: number
    # hidden: yes
    sql: ${TABLE}.VENUEID ;;
  }

  measure: count {
    label: "Number of Events"
    type: count
    drill_fields: [detail*]
  }

  measure: count_dates {
    label: "Number of Dates w/ Events"
    type: count_distinct
    sql: ${date_id} ;;
    drill_fields: [detail*]
  }

  measure: count_venues {
    label: "Number of Venues w/ Events"
    type: count_distinct
    sql: ${venue_id} ;;
    drill_fields: [detail*]
  }

  measure: temporary {
    type: sum
    sql: 10000 ;;
  }

  set: detail {
    fields: [
      event_id,
      event_name,
      categories.cat_name,
      categories.cat_group,
      venue.venue_name,
      listings.count,
      sales.count
    ]
  }

}
