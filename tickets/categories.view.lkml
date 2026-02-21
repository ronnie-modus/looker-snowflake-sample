view: categories {
  view_label: "Categories"
  sql_table_name: TEST_DB.TICKET.CATEGORY ;;

  dimension: cat_id {
    label: "Category ID"
    type: number
    primary_key: yes
    sql: ${TABLE}.CATID ;;
  }

  dimension: cat_desc {
    label: "Category Descriptions"
    type: string
    sql: ${TABLE}.CATDESC ;;
  }

  dimension: cat_group {
    label: "Category Group"
    type: string
    sql: ${TABLE}.CATGROUP ;;
  }

  dimension: cat_name {
    label: "Category Name"
    type: string
    sql: ${TABLE}.CATNAME ;;

  }

  dimension: cat_color {
    label: "Category Color Box"
    type: string
    sql: ${cat_name} ;;
    html:
      {% if value == 'MLB' %}
        <p><img src="https://www.iconsdb.com/icons/preview/red/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'MLS' %}
        <p><img src="https://www.iconsdb.com/icons/preview/orange/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'NBA' %}
        <p><img src="https://www.iconsdb.com/icons/preview/yellow/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'NFL' %}
        <p><img src="https://www.iconsdb.com/icons/preview/green/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'NHL' %}
        <p><img src="https://www.iconsdb.com/icons/preview/gray/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'Classical' %}
        <p><img src="https://www.iconsdb.com/icons/preview/purple/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'Jazz' %}
        <p><img src="https://www.iconsdb.com/icons/preview/persian-red/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'Musicals' %}
        <p><img src="https://www.iconsdb.com/icons/preview/lime/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'Opera' %}
         <p><img src="https://www.iconsdb.com/icons/preview/olive/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'Plays' %}
        <p><img src="https://www.iconsdb.com/icons/preview/bisque/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% elsif value == 'Pop' %}
         <p><img src="https://www.iconsdb.com/icons/preview/navy-blue/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% else %}
        <p><img src="https://www.iconsdb.com/icons/preview/white/square-xxl.png" height=20 width=20>{{ rendered_value }}</p>
      {% endif %}
    ;;
  }

  measure: count {
    label: "Number of Categories"
    type: count
    drill_fields: [cat_id, cat_name, cat_group]
  }

  measure: count_sports {
    label: "Number of Sport Categories"
    type: count
    filters: {
      field: cat_group
      value: "Sports"
    }
    drill_fields: [cat_id, cat_name, cat_group]
  }

  measure: percent_sports {
    type: number
    value_format_name: percent_2
    sql: ${count_sports} / ${count} ;;
  }
}
