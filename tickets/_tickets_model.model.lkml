connection: "snowflake_sample"

include: "/tickets/*.view"

explore: categories {
  view_name: categories
  group_label: "Event Tickets"
  label: "Categories"
}

explore: events {
  view_name: events
  group_label: "Event Tickets"
  label: "Events"

  cancel_grouping_fields: [
    events.venue_id
  ]

  join: venue {
    view_label: "Venues"
    type: left_outer
    relationship: many_to_one
    sql_on: ${events.venue_id}  = ${venue.venue_id} ;;
  }
  join: categories {
    view_label: "Categories"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${events.cat_id} = ${categories.cat_id} ;;
  }
  join: date_lkp {
    view_label: "Dates"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${events.date_id} = ${date_lkp.date_id} ;;
  }

  access_filter: {
    field: venue.venue_id
    user_attribute: venue_id_ua
  }

}

explore: listings {
  view_name: listings
  group_label: "Event Tickets"
  label: "Listings"
  join: events {
    view_label: "Events"
    type: left_outer
    relationship: many_to_one
    sql_on: ${listings.event_id} = ${events.event_id} ;;
  }
  join: sellers {
    view_label: "Selling User"
    from: users
    type: left_outer
    relationship: many_to_one
    sql_on: ${listings.seller_id} = ${sellers.user_id} ;;
  }
  join: venue {
    view_label: "Venues"
    type: left_outer
    relationship: many_to_one
    sql_on: ${events.venue_id}  = ${venue.venue_id} ;;
  }
  join: categories {
    view_label: "Categories"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${events.cat_id} = ${categories.cat_id} ;;
  }
  join: date_lkp {
    view_label: "Dates"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${listings.date_id} = ${date_lkp.date_id} ;;
  }
}


explore: sales {
  view_name: sales
  group_label: "Event Tickets"
  label: "Sales"
  join: listings {
    view_label: "Listings"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales.list_id} = ${listings.list_id} ;;
  }
  join: events {
    view_label: "Events"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales.event_id} = ${events.event_id} ;;
  }
  join: buyers {
    view_label: "Buying User"
    from: users
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales.buyer_id} = ${buyers.user_id} ;;
  }
  join: sellers {
    view_label: "Selling User"
    from: users
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales.seller_id} = ${sellers.user_id} ;;
  }
  join: venue {
    view_label: "Venues"
    type: left_outer
    relationship: many_to_one
    sql_on: ${events.venue_id}  = ${venue.venue_id} ;;
  }
  join: categories {
    view_label: "Categories"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${events.cat_id} = ${categories.cat_id} ;;
  }
  join: date_lkp {
    view_label: "Dates"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${sales.date_id} = ${date_lkp.date_id} ;;
  }
}

# Aggregate Table for explore:
# https://bytecode.looker.com/explore/_tickets_model/sales?qid=srl6rKyegGovqSUfqPpe8W&toggle=fil,vis
# Also used on Dashboard:

explore: +sales {
  aggregate_table: rollup__sales_month__venue_state {
    query: {
      dimensions: [sales_month, venue.state]
      measures: [avg_commission, avg_price_paid, total_tickets_sold]
      timezone: "UTC"
    }

    # Please specify a datagroup_trigger or sql_trigger_value
    # See https://looker.com/docs/r/lookml/types/aggregate_table/materialization
    materialization: {
      sql_trigger_value: SELECT CURDATE() ;; # IRL use a data_group
    }
  }

  aggregate_table: rollup__sales_month__venue_state_pt { # Time Zone is changed here.
    query: {
      dimensions: [sales_month, venue.state]
      measures: [avg_commission, avg_price_paid, total_tickets_sold]
      timezone: "America/Los_Angeles"
    }

    # Please specify a datagroup_trigger or sql_trigger_value
    # See https://looker.com/docs/r/lookml/types/aggregate_table/materialization
    materialization: {
      sql_trigger_value: SELECT CURDATE() ;; # IRL use a data_group
    }
  }
}
