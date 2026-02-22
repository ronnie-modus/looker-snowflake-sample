view: user_aggregation {
    derived_table: {
      sql:
      select
        s.buyerid,
        count(s.eventid) as lifetime_events,
        sum(s.qtysold) as lifetime_tickets,
        sum(s.pricepaid) as lifetime_paid,
        min(d.caldate) as first_sale_date,
        max(d.caldate) as last_sale_date
      from looker_sample.public.sales as s
          left join looker_sample.public.date as d on s.dateid=d.dateid
      group by all
    ;;
    }

    dimension: buyer_id {
      type: number
      primary_key: yes
      sql: ${TABLE}.buyerid ;;
    }

    measure: avg_lifetime_paid {
      type: average
      sql: ${TABLE}.lifetime_paid ;;
      value_format_name: usd
    }

  measure: avg_lifetime_tickets {
    type: average
    sql: ${TABLE}.lifetime_tickets ;;
  }

  measure: avg_lifetime_events {
    type: average
    sql: ${TABLE}.lifetime_events ;;
  }

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: user_aggregation {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
