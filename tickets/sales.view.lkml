include: "_period_comparison.view.lkml"
view: sales {
  view_label: "Sales"
  sql_table_name: TEST_DB.TICKET.SALES ;;
  extends: [_period_comparison]

  drill_fields: [detail*]

  dimension: sales_id {
    group_label: "Keys/IDs"
    label: "Sales ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.SALESID ;;
  }

  dimension: buyer_id {
    group_label: "Keys/IDs"
    label: "Buyer User ID"
    type: number
    sql: ${TABLE}.BUYERID ;;
  }

  dimension: commission {
    group_label: "Numerical Dimensions"
    label: "Commission"
    type: number
    sql: ${TABLE}.COMMISSION ;;
  }

  dimension: date_id {
    group_label: "Keys/IDs"
    label: "Date ID"
    type: number
    sql: ${TABLE}.DATEID ;;
  }

  dimension: event_id {
    group_label: "Keys/IDs"
    label: "Event ID"
    type: number
    # hidden: yes
    sql: ${TABLE}.EVENTID ;;
  }

  dimension: list_id {
    group_label: "Keys/IDs"
    label: "Listing ID"
    type: number
    sql: ${TABLE}.LISTID ;;
  }

  dimension: price_paid {
    group_label: "Numerical Dimensions"
    label: "Price Paid"
    type: number
    value_format_name: usd
    sql: ${TABLE}.PRICEPAID ;;
  }

  dimension: qty_sold {
    group_label: "Numerical Dimensions"
    label: "Quantity Sold"
    type: number
    sql: ${TABLE}.QTYSOLD ;;
  }

  dimension_group: sales {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: DATEADD(YEAR, 12, ${TABLE}.SALETIME) ;;
  }

  #### Used with period comparison view
  dimension_group: event {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date
    ]
    sql: DATEADD(YEAR, 12, ${TABLE}.SALETIME) ;;
  }

  dimension: days_to_sell {
    group_label: "Numerical Dimensions"
    label: "Days to Sell"
    type: duration_day
    sql_start: ${listings.list_raw} ;;
    sql_end: ${sales_raw} ;;
    value_format_name: decimal_1
  }

  dimension: seller_id {
    group_label: "Keys/IDs"
    label: "Selling User ID"
    type: number
    sql: ${TABLE}.SELLERID ;;
  }

  measure: count {
    label: "Number of Sales"
    type: count
    drill_fields: [detail*]
  }

  measure: count_buyers {
    label: "Number of Distinct Buyers"
    type: count_distinct
    sql: ${buyer_id} ;;
    drill_fields: [detail*]
  }

  measure: count_dates {
    label: "Number of Dates w/ Sales"
    type: count_distinct
    sql: ${date_id} ;;
    drill_fields: [detail*]
  }

  measure: count_events {
    label: "Number of Events Sold"
    type: count_distinct
    sql: ${event_id} ;;
    drill_fields: [detail*]
  }

  measure: count_listings {
    label: "Number of Listings Sold"
    type: count_distinct
    sql: ${list_id} ;;
    drill_fields: [detail*]
  }

  measure: count_sellers {
    label: "Number of Distinct Sellers"
    type: count_distinct
    sql: ${seller_id} ;;
    drill_fields: [detail*]
  }

  measure: avg_commission {
    label: "Average Commission"
    type: average
    value_format_name: usd
    sql: ${commission} ;;
    drill_fields: [detail*]
  }

  measure: avg_days_to_sell {
    label: "Average Days to Sell"
    type: average
    value_format_name: decimal_1
    sql: ${days_to_sell} ;;
    drill_fields: [detail*]
  }

  measure: avg_price_paid {
    label: "Average Price Paid"
    type: average
    value_format_name: usd
    sql: ${price_paid} ;;
    drill_fields: [detail*]
  }

  measure: avg_tickets_sold{
    label: "Average Tickets Sold"
    type: average
    value_format_name: decimal_1
    sql: ${qty_sold} ;;
    drill_fields: [detail*]
  }

  measure: total_commission {
    label: "Total Commission"
    type: sum
    value_format_name: usd
    sql: ${commission} ;;
    drill_fields: [detail*]
  }

  measure: total_price_paid {
    label: "Total Price Paid"
    type: sum
    value_format_name: usd
    sql: ${price_paid} ;;
    drill_fields: [detail*]
  }

  measure: total_tickets_sold{
    label: "Total Tickets Sold"
    group_label: "Total Tickets Sold"
    type: sum
    value_format_name: decimal_0
    sql: ${qty_sold} ;;
    drill_fields: [detail*]
  }

  measure: total_tickets_sold_current_period {
    label: "Total Tickets Sold Current Period"
    group_label: "Total Tickets Sold"
    type: sum
    value_format_name: decimal_0
    sql: ${qty_sold} ;;
    drill_fields: [detail*]
    filters: [is_current_period: "Yes"]
  }

  measure: total_tickets_sold_comparison_period {
    label: "Total Tickets Sold Comparison Period"
    group_label: "Total Tickets Sold"
    type: sum
    value_format_name: decimal_0
    sql: ${qty_sold} ;;
    drill_fields: [detail*]
    filters: [is_comparison_period: "Yes"]
  }

  set: detail {
    fields: [
      sales_id,
      sales_date,
      qty_sold,
      price_paid,
      commission,
      sellers.full_name,
      buyers.full_name,
      events.event_name,
      categories.cat_name,
      categories.cat_group,
      venue.venue_name
    ]
  }
}
