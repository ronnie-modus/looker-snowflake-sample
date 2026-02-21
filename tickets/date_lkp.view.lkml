view: date_lkp {
  view_label: "Dates"
  sql_table_name: TEST_DB.TICKET.DATE ;;

  dimension: date_id {
    label: "Date ID"
    type: number
    primary_key: yes
    sql: ${TABLE}.DATEID ;;
  }

  dimension_group: calendar {
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
    sql: DATEADD(YEAR, 11, ${TABLE}.CALDATE) ;;
  }

  dimension: day {
    label: "Day"
    type: string
    sql: ${TABLE}.DAY ;;
  }

  dimension: week {
    label: "Week"
    type: number
    sql: ${TABLE}.WEEK ;;
  }

  dimension: holiday {
    label: "Is Holiday"
    type: yesno
    sql: ${TABLE}.HOLIDAY ;;
  }

  dimension: month {
    label: "Month"
    type: string
    sql: ${TABLE}.MONTH ;;
  }

  dimension: qtr {
    label: "Quarter"
    type: string
    sql: ${TABLE}.QTR ;;
  }

  dimension: year {
    label: "Year"
    type: number
    sql: ${TABLE}.YEAR + 11 ;;
  }

  measure: count {
    label: "Number of Dates"
    type: count
    drill_fields: [calendar_date, holiday]
  }
}
