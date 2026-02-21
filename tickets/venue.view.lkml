view: venue {
  view_label: "Venues"
  sql_table_name: TEST_DB.TICKET.VENUE ;;
  drill_fields: [detail*]

  dimension: venue_id {
    label: "Venue ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.VENUEID ;;
  }

  dimension: city {
    label: "Venue City"
    type: string
    sql: ${TABLE}.VENUECITY ;;
  }

  dimension: seats {
    label: "Venue Seats"
    type: number
    sql: ${TABLE}.VENUESEATS ;;
  }

  dimension: state {
    label: "Venue State"
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.VENUESTATE ;;
  }

  dimension: venue_name {
    label: "Venue Name"
    type: string
    sql: ${TABLE}.VENUENAME ;;
  }

  dimension: is_50_states {
    type: yesno
    sql: ${state} in ('AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY') ;;
  }

  measure: count {
    label: "Number of Venues"
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      venue_id,
      venue_name,
      city,
      state,
      events.count
    ]
  }
}
