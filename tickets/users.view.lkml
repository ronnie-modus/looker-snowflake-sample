view: users {
  view_label: "Users"
  sql_table_name: TEST_DB.TICKET.USERS ;;
  drill_fields: [detail*]

  parameter: likes_category {
    full_suggestions: yes
    allowed_value: {value: "User Likes Broadway"}
    allowed_value: {value: "User Likes Classical"}
    allowed_value: {value: "User Likes Concerts"}
    allowed_value: {value: "User Likes Musicals"}
    allowed_value: {value: "User Likes Jazz"}
    allowed_value: {value: "User Likes Opera"}
    allowed_value: {value: "User Likes Rock"}
    allowed_value: {value: "User Likes Sports"}
    allowed_value: {value: "User Likes Theater"}
    allowed_value: {value: "User Likes Vegas"}
  }

  dimension: user_likes_category {
    label_from_parameter: likes_category
    sql:
            CASE
             WHEN {% parameter likes_category %} = 'User Likes Broadway' THEN ${likes_broadway}
             WHEN {% parameter likes_category %} = 'User Likes Classical' THEN ${likes_classical}
             WHEN {% parameter likes_category %} = 'User Likes Concerts' THEN ${likes_concerts}
             WHEN {% parameter likes_category %} = 'User Likes Musicals' THEN ${likes_musicals}
             WHEN {% parameter likes_category %} = 'User Likes Jazz' THEN ${likes_jazz}
             WHEN {% parameter likes_category %} = 'User Likes Opera' THEN ${likes_opera}
             WHEN {% parameter likes_category %} = 'User Likes Rock' THEN ${likes_rock}
             WHEN {% parameter likes_category %} = 'User Likes Sports' THEN ${likes_sports}
             WHEN {% parameter likes_category %} = 'User Likes Theater' THEN ${likes_theater}
             WHEN {% parameter likes_category %} = 'User Likes Vegas' THEN ${likes_vegas}
             ELSE NULL
            END ;;
  }

  dimension: user_id {
    label: "User ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.USERID ;;
  }

  dimension: likes_broadway {
    label: "Likes Broadway"
    type: string
    sql: ${TABLE}.LIKEBROADWAY ;;
  }

  dimension: city {
    label: "City"
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: likes_classical {
    label: "Likes Classical"
    type: string
    sql: ${TABLE}.LIKECLASSICAL ;;
  }

  dimension: likes_concerts {
    label: "Likes Concerts"
    type: yesno
    sql: ${TABLE}.LIKECONCERTS ;;
  }

  dimension: email {
    label: "Email"
    type: string
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: first_name {
    label: "First Name"
    type: string
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: full_name {
    label: "Full Name"
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension: last_first_name {
    label: "Last, First Name"
    type: string
    sql: ${last_name} || ', ' || ${first_name} ;;
  }

  dimension: likes_jazz {
    label: "Likes Jazz"
    type: yesno
    sql: ${TABLE}.LIKEJAZZ ;;
  }

  dimension: last_name {
    label: "Last Name"
    type: string
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: likes_musicals {
    label: "Likes Musicals"
    type: yesno
    sql: ${TABLE}.LIKEMUSICALS ;;
  }

  dimension: likes_opera {
    label: "Likes Opera"
    type: yesno
    sql: ${TABLE}.LIKEOPERA ;;
  }

  dimension: phone {
    label: "Phone"
    type: string
    sql: ${TABLE}.PHONE ;;
  }

  dimension: likes_rock {
    label: "Likes Rock"
    type: yesno
    sql: ${TABLE}.LIKEROCK ;;
  }

  dimension: likes_sports {
    label: "Likes Sports"
    type: yesno
    sql: ${TABLE}.LIKESPORTS ;;
  }

  dimension: state {
    label: "State"
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.STATE ;;
  }

  dimension: likes_theater {
    label: "Likes Theater"
    type: yesno
    sql: ${TABLE}.LIKETHEATRE;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.USERNAME ;;
  }

  dimension: likes_vegas {
    label: "Likes Vegas"
    type: yesno
    sql: ${TABLE}.LIKEVEGAS ;;
  }

  dimension: is_50_states {
    type: yesno
    sql: ${state} in ('AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY') ;;
  }

  measure: count {
    label: "Number of Users"
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      user_id,
      first_name,
      last_name,
      state
    ]
  }
}
