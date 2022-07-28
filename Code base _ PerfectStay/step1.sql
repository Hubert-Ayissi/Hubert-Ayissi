SELECT *,             
(CASE WHEN  re_reveil_step_desendormissement_per_uuid is not null THEN 1 ELSE 0 END) AS re_endormi_puis_reveil,
 DATE_DIFF(  cast(substr(re_last_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) as re_delay_subscription_to_last_open, 
 
 
(CASE WHEN 
     second_delay_btw_order_date > 360 THEN "m_360+"
WHEN second_delay_btw_order_date > 330 THEN "l_331-360"
WHEN second_delay_btw_order_date > 300 THEN "k_301-330"
WHEN second_delay_btw_order_date > 271 THEN "j_271-300"
WHEN second_delay_btw_order_date > 240 THEN "i_241-270"
WHEN second_delay_btw_order_date > 210 THEN "h_211-240"
WHEN second_delay_btw_order_date > 180 THEN "g_181-210"
WHEN second_delay_btw_order_date > 150 THEN "f_151-180"
WHEN second_delay_btw_order_date > 120 THEN "e_121-150"
WHEN second_delay_btw_order_date > 90 THEN "d_91-120"
WHEN second_delay_btw_order_date > 60 THEN "c_61-90"
WHEN second_delay_btw_order_date > 30 THEN "b_31-60"
WHEN second_delay_btw_order_date >= 0 THEN "a_0-30" END) as second_delay_btw_order_date_30_bins,

(CASE WHEN second_delay_btw_order_date > 360 THEN "p_360+"
WHEN second_delay_btw_order_date > 330 THEN "o_331-360"
WHEN second_delay_btw_order_date > 300 THEN "m_301-330"
WHEN second_delay_btw_order_date > 271 THEN "l_271-300"
WHEN second_delay_btw_order_date > 240 THEN "k_241-270"
WHEN second_delay_btw_order_date > 210 THEN "j_211-240"
WHEN second_delay_btw_order_date > 180 THEN "i_181-210"
WHEN second_delay_btw_order_date > 150 THEN "h_151-180"
WHEN second_delay_btw_order_date > 120 THEN "g_121-150"
WHEN second_delay_btw_order_date > 90 THEN "f_91-120"
WHEN second_delay_btw_order_date > 60 THEN "e_61-90"
WHEN second_delay_btw_order_date > 30 THEN "d_31-60"
WHEN second_delay_btw_order_date >= 2 THEN "c_2-30" 
WHEN second_delay_btw_order_date = 1 THEN "b_1"
WHEN second_delay_btw_order_date = 0 THEN "a_0" END) as second_delay_btw_order_date_30_bins_v2 , 


# Delai soucription > first open
 DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) as re_delay_subscription_to_first_open, 

(CASE 
WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  = -1 THEN "a_0"  # decalage horaire 
WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  = 0 THEN "a_0" 
WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  = 1 THEN "b_1" 
WHEN ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 2) and ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 10)  THEN "c_2-9" 
WHEN ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 10) and ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 20)  THEN "d_10-20" 
WHEN ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 20) and ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 30)  THEN "e_20-30" 
WHEN ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 30) and ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 40)  THEN "f_30-40" 
WHEN ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 40) and ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 50)  THEN "g_40-50" 
WHEN ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 50) and ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 60)  THEN "h_50-60" 
WHEN ( DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 60 )  THEN "i_60+" 
 # 6 outliers négatifs bizarres où subscription date postérieure à first open 
END 
) as re_segmentation_delay_subscription_to_first_open , 

# SEGMENTATION NAV DST SESSION DAYS 

(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 0 THEN 1 ELSE 0 END ) as re_delay_subscription_to_first_open_0,
(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 1 THEN 1 ELSE 0 END) as re_delay_subscription_to_first_open_1,
(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 2 THEN 1 ELSE 0 END) as re_delay_subscription_to_first_open_2,
(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 3 THEN 1 ELSE 0 END) as re_delay_subscription_to_first_open_3,
(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 4 THEN 1 ELSE 0 END) as re_delay_subscription_to_first_open_4,
(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 5 THEN 1 ELSE 0 END) as re_delay_subscription_to_first_open_5,
(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 6 THEN 1 ELSE 0 END) as re_delay_subscription_to_first_open_6,
(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 7 THEN 1 ELSE 0 END) as re_delay_subscription_to_first_open_7,
(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 8 THEN 1 ELSE 0 END) as re_delay_subscription_to_first_open_8,
(CASE WHEN  DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY ) = 9 THEN 1 ELSE 0 END) as re_delay_subscription_to_first_open_9,
(CASE WHEN (DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 10) and (DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 20)  THEN 1 ELSE 0 END ) as re_delay_subscription_to_first_open_10_19 ,
(CASE WHEN (DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 20) and (DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 30)  THEN 1 ELSE 0 END) as  re_delay_subscription_to_first_open_20_29 ,
(CASE WHEN (DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 30) and (DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 39) THEN 1 ELSE 0 END) re_delay_subscription_to_first_open_30_39   ,
(CASE WHEN (DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 40) and (DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  < 49) THEN 1 ELSE 0 END) re_delay_subscription_to_first_open_40_49  ,
(CASE WHEN DATE_DIFF( cast(substr(re_first_open_date,1,10)as date)  ,  crm_subscriptionDate  , DAY )  >= 50 THEN 1 ELSE 0 END)  as re_delay_subscription_to_first_open_50 ,






# SEGMENT REACTIVITE 
(CASE WHEN re_ratio_open > 0.70 then "ouvreur_fidele"  
WHEN re_ratio_open > 0.4 then "ouvreur_regulier"
WHEN re_ratio_open = 0 then "jamais_ouvert" 
ELSE "ouvreur_occasionnel" END)  as re_segment_ouvreur, 

( CASE WHEN re_ratio_open > 0.9 then "90-100%"  
WHEN re_ratio_open > 0.8 then "80-90%"
WHEN re_ratio_open > 0.7 then "70-80%"
WHEN re_ratio_open > 0.6 then "60-70%"
WHEN re_ratio_open > 0.5 then "50-60%"
WHEN re_ratio_open > 0.4 then "40-50%"
WHEN re_ratio_open > 0.3 then "30-40%"
WHEN re_ratio_open > 0.2 then "20-30%"
WHEN re_ratio_open > 0.1 then "10-20%"
WHEN re_ratio_open > 0 then "0-10%"
WHEN re_ratio_open = 0 then "0" END ) as re_ratio_open_bins, 

(CASE WHEN re_ratio_clic > 0.9 then "90-100%"  
WHEN re_ratio_clic > 0.8 then "80-90%"
WHEN re_ratio_clic > 0.7 then "70-80%"
WHEN re_ratio_clic > 0.6 then "60-70%"
WHEN re_ratio_clic > 0.5 then "50-60%"
WHEN re_ratio_clic > 0.4 then "40-50%"
WHEN re_ratio_clic > 0.3 then "30-40%"
WHEN re_ratio_clic > 0.2 then "20-30%"
WHEN re_ratio_clic > 0.1 then "10-20%"
WHEN re_ratio_clic > 0 then "0-10%"
WHEN re_ratio_clic = 0 then "0" END) as re_ratio_clic_bins, 

(CASE WHEN re_ratio_clic > 0.30 then "0.30_++%"  
WHEN re_ratio_clic > 0.28 then "0.28-0.30%"
WHEN re_ratio_clic > 0.26 then "0.26-0.28%"
WHEN re_ratio_clic > 0.24 then "0.24-0.26%"
WHEN re_ratio_clic > 0.22 then "0.22-0.24%"
WHEN re_ratio_clic > 0.20 then "0.20-0.22%"
WHEN re_ratio_clic > 0.18 then "0.18-0.20%"
WHEN re_ratio_clic > 0.16 then "0.16-0.18%"
WHEN re_ratio_clic > 0.14 then "0.14-0.16%"
WHEN re_ratio_clic > 0.12 then "0.12-0.14%"
WHEN re_ratio_clic > 0.10 then "0.10-0.12%"
WHEN re_ratio_clic > 0.08 then "0.08-0.10%"
WHEN re_ratio_clic > 0.06 then "0.06-0.08%"
WHEN re_ratio_clic > 0.04 then "0.04-0.06%"
WHEN re_ratio_clic > 0.02 then "0.02-0.04%"
WHEN re_ratio_clic > 0 then "0-0.02%"
WHEN re_ratio_clic = 0 then "0" END) as re_ratio_clic_2_bins, 



(CASE WHEN re_ratio_open > 0.70 THEN 1 ELSE 0 END) as re_ouvreur_fidele, 
(CASE WHEN (re_ratio_open <= 0.70) and (re_ratio_open > 0.4)  THEN 1 ELSE 0 END) as re_ouvreur_regulier, 
(CASE WHEN (re_ratio_open > 0) and (re_ratio_open <= 0.4) THEN 1 ELSE 0 END) as re_ouvreur_occasionnel, 
(CASE WHEN re_ratio_open = 0 THEN 1 ELSE 0 END) as re_jamais_ouvert, 

#(CASE WHEN re_ratio_open >= 0.70 THEN 1 ELSE 0 END) as re_ouvreur_fidele, 
#(CASE WHEN (re_ratio_open < 0.70) and (re_ratio_open >= 0.4)  THEN 1 ELSE 0 END) as re_ouvreur_regulier, 
#(CASE WHEN (re_ratio_open > 0) and (re_ratio_open < 0.4) THEN 1 ELSE 0 END) as re_ouvreur_occasionnel, 
#(CASE WHEN re_ratio_open = 0 THEN 1 ELSE 0 END) as re_jamais_ouvert, 

(CASE WHEN re_ratio_clic > 0.50 then "cliqueur_fidele"  
WHEN (re_ratio_clic <= 0.5) and (re_ratio_clic > 0.2)  THEN "cliqueur_regulier" 
WHEN re_ratio_clic = 0 then "jamais_clique"
ELSE "cliqueur_occasionnel" END) as re_segment_cliqueur , 

(CASE WHEN re_ratio_clic > 0.50 THEN 1 ELSE 0 END) as re_cliqueur_fidele, 
(CASE WHEN (re_ratio_clic <= 0.5) and (re_ratio_clic > 0.2)  THEN 1 ELSE 0 END) as re_cliqueur_regulier, 
(CASE WHEN (re_ratio_clic > 0) and (re_ratio_clic <= 0.2 ) THEN 1 ELSE 0 END) as re_cliqueur_occasionnel, 
(CASE WHEN re_ratio_clic = 0 THEN 1 ELSE 0 END) as re_jamais_clique, 


## OLD METHODE POUR LES OUVREURS & CLIQUEURS 
# A . OLD OUVREURS
(CASE WHEN re_ratio_sent_open > 0.70 then "ouvreur_fidele"  
WHEN re_ratio_sent_open > 0.4 then "ouvreur_regulier"
WHEN re_ratio_sent_open = 0 then "jamais_ouvert" 
ELSE "ouvreur_occasionnel" END)  as re_old_segment_ouvreur, 

( CASE WHEN re_ratio_sent_open > 0.9 then "90-100%"  
WHEN re_ratio_sent_open > 0.8 then "80-90%"
WHEN re_ratio_sent_open > 0.7 then "70-80%"
WHEN re_ratio_sent_open > 0.6 then "60-70%"
WHEN re_ratio_sent_open > 0.5 then "50-60%"
WHEN re_ratio_sent_open > 0.4 then "40-50%"
WHEN re_ratio_sent_open > 0.3 then "30-40%"
WHEN re_ratio_sent_open > 0.2 then "20-30%"
WHEN re_ratio_sent_open > 0.1 then "10-20%"
WHEN re_ratio_sent_open > 0 then "0-10%"
WHEN re_ratio_sent_open = 0 then "0" END ) as re_old_ratio_sent_open_bins, 

# B . OLD CLIQUEURS
( CASE WHEN re_ratio_sent_clic > 0.9 then "90-100%"  
WHEN re_ratio_sent_clic > 0.8 then "80-90%"
WHEN re_ratio_sent_clic > 0.7 then "70-80%"
WHEN re_ratio_sent_clic > 0.6 then "60-70%"
WHEN re_ratio_sent_clic > 0.5 then "50-60%"
WHEN re_ratio_sent_clic > 0.4 then "40-50%"
WHEN re_ratio_sent_clic > 0.3 then "30-40%"
WHEN re_ratio_sent_clic > 0.2 then "20-30%"
WHEN re_ratio_sent_clic > 0.1 then "10-20%"
WHEN re_ratio_sent_clic > 0 then "0-10%"
WHEN re_ratio_sent_clic = 0 then "0" END ) as re_old_ratio_sent_clic_bins, 

(CASE WHEN re_ratio_sent_clic > 0.50 then "cliqueur_fidele"  
WHEN (re_ratio_sent_clic <= 0.5) and (re_ratio_clic > 0.2)  THEN "cliqueur_regulier" 
WHEN re_ratio_sent_clic = 0 then "jamais_clique"
ELSE "cliqueur_occasionnel" END) as re_old_segment_cliqueur, 

# SEGMENTATION NAV DST SESSION DAYS 
(CASE 
WHEN nav_nb_distinct_session_days = 0 THEN "0" 
WHEN nav_nb_distinct_session_days = 1 THEN "1" 
WHEN nav_nb_distinct_session_days = 2 THEN "2" 
WHEN nav_nb_distinct_session_days = 3 THEN "3" 
WHEN nav_nb_distinct_session_days = 4 THEN "4" 
WHEN nav_nb_distinct_session_days = 5 THEN "5" 
WHEN nav_nb_distinct_session_days = 6 THEN "6" 
WHEN nav_nb_distinct_session_days = 7 THEN "7" 
WHEN nav_nb_distinct_session_days = 8 THEN "8" 
WHEN nav_nb_distinct_session_days = 9 THEN "9" 
WHEN (nav_nb_distinct_session_days >= 10) and (nav_nb_distinct_session_days < 20)  THEN "10-19" 
WHEN (nav_nb_distinct_session_days >= 20) and (nav_nb_distinct_session_days < 30)  THEN "20-29" 
WHEN (nav_nb_distinct_session_days >= 30) and (nav_nb_distinct_session_days < 39)  THEN "30-39" 
WHEN (nav_nb_distinct_session_days >= 40) and (nav_nb_distinct_session_days < 49)  THEN "40-49" 
WHEN (nav_nb_distinct_session_days >= 50)  THEN "50+" 
ELSE "1" 
END 
) as nav_segmentation_distinct_session_days , 


(CASE WHEN nav_nb_distinct_session_days = 0 THEN 1 ELSE 0 END ) as nav_dst_day_0,
(CASE WHEN nav_nb_distinct_session_days = 1 THEN 1 ELSE 0 END) as nav_dst_day_1,
(CASE WHEN nav_nb_distinct_session_days = 2 THEN 1 ELSE 0 END) as nav_dst_day_2,
(CASE WHEN nav_nb_distinct_session_days = 3 THEN 1 ELSE 0 END) as nav_dst_day_3,
(CASE WHEN nav_nb_distinct_session_days = 4 THEN 1 ELSE 0 END) as nav_dst_day_4,
(CASE WHEN nav_nb_distinct_session_days = 5 THEN 1 ELSE 0 END) as nav_dst_day_5,
(CASE WHEN nav_nb_distinct_session_days = 6 THEN 1 ELSE 0 END) as nav_dst_day_6,
(CASE WHEN nav_nb_distinct_session_days = 7 THEN 1 ELSE 0 END) as nav_dst_day_7,
(CASE WHEN nav_nb_distinct_session_days = 8 THEN 1 ELSE 0 END) as nav_dst_day_8,
(CASE WHEN nav_nb_distinct_session_days = 9 THEN 1 ELSE 0 END) as nav_dst_day_9,
(CASE WHEN (nav_nb_distinct_session_days >= 10) and (nav_nb_distinct_session_days < 20)  THEN 1 ELSE 0 END ) as nav_dst_day_10_19 ,
(CASE WHEN (nav_nb_distinct_session_days >= 20) and (nav_nb_distinct_session_days < 30)  THEN 1 ELSE 0 END) as  nav_dst_day_20_29 ,
(CASE WHEN (nav_nb_distinct_session_days >= 30) and (nav_nb_distinct_session_days < 39) THEN 1 ELSE 0 END) nav_dst_day_30_39   ,
(CASE WHEN (nav_nb_distinct_session_days >= 40) and (nav_nb_distinct_session_days < 49) THEN 1 ELSE 0 END) nav_dst_day_40_49  ,
(CASE WHEN nav_nb_distinct_session_days >= 50 THEN 1 ELSE 0 END)  as nav_dst_day_more_50 ,


# AGG ENDORMISSEMENT 
(CASE 
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 900 THEN "900-+"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 800 THEN "801-900"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 700 THEN "701-800"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 600 THEN "601-700"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 500 THEN "501-600"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 400 THEN "401-500"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 300 THEN "301-400"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 200 THEN "201-300"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 100 THEN "101-200"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement >= 0 THEN "0-100" ELSE "0-100" END) as re_endormi_delai_souscription_to_last_open_date_before_first_endormissement_100_bins,



(CASE WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 900 THEN "v_901-+"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 800 THEN "u_801-900"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 700 THEN "t_701-800"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 600 THEN "s_601-700"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 500 THEN "r_501-600"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 400 THEN "q_401-500"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 300 THEN "p_301-330"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 271 THEN "o_271-300"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 240 THEN "n_241-270"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 210 THEN "m_211-240"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 180 THEN "l_181-210"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 150 THEN "k_151-180"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 120 THEN "j_121-150"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 90 THEN "i_91-120"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 60 THEN "h_61-90"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 30 THEN "g_31-60"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 22 THEN "f_23-30"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 15 THEN "e_15-22"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 7 THEN "d_8-15"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 1 THEN "c_2-7"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 0 THEN "b_1"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 0 THEN "a_0" ELSE "a_0" END) as re_endormi_delai_souscription_to_last_open_date_before_first_endormissement_flex_bins,

(CASE WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement >= 361 THEN "m_361-+"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 330 THEN "l_331-360"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 300 THEN "k_301-330"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 271 THEN "j_271-300"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 240 THEN "i_241-270"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 210 THEN "h_211-240"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 180 THEN "g_181-210"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 150 THEN "f_151-180"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 120 THEN "e_121-150"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 90 THEN "d_91-120"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 60 THEN "c_61-90"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 30 THEN "b_31-60"
WHEN re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 0 THEN "a_0-30" ELSE "a_0-30" END) as re_endormi_delai_souscription_to_last_open_date_before_first_endormissement_30_bins,



( CASE WHEN (re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 0) or
 ( (re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 0 ) and  (re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 30 ) )
 THEN 1 ELSE 0 END) re_endormi_del_0_30,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 30 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 60 )  THEN 1 ELSE 0 END ) re_endormi_del_31_60,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 60 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 90 )  THEN 1 ELSE 0 END ) re_endormi_del_61_90,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 90 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 120 )  THEN 1 ELSE 0 END ) re_endormi_del_91_120,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 120 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 150 )  THEN 1 ELSE 0 END ) re_endormi_del_121_150,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 150 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 180 )  THEN 1 ELSE 0 END ) re_endormi_del_151_180,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 180 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 210 )  THEN 1 ELSE 0 END ) re_endormi_del_181_210,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 210 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 240 )  THEN 1 ELSE 0 END ) re_endormi_del_211_240,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 240 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 270 )  THEN 1 ELSE 0 END ) re_endormi_del_241_270,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 270 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 300 )  THEN 1 ELSE 0 END ) re_endormi_del_271_300,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 300 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 330 )  THEN 1 ELSE 0 END ) re_endormi_del_301_330,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 330 ) and  ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement <= 360 )  THEN 1 ELSE 0 END ) re_endormi_del_331_360,
( CASE WHEN ( re_endormi_delai_souscription_to_last_open_date_before_first_endormissement > 360 ) THEN 1 ELSE 0 END ) re_endormi_del_361_more,


# Segmentation transac

(CASE WHEN first_numberofpassengers = 1 THEN 1 ELSE 0 END) as first_1_passenger, 
(CASE WHEN first_numberofpassengers = 2 THEN 1 ELSE 0 END) as first_2_passenger, 
(CASE WHEN first_numberofpassengers > 2 THEN 1 ELSE 0 END) as first_3_and_more_passenger, 
(CASE WHEN first_numberofpassengers = 1 THEN "1_passenger" 
WHEN first_numberofpassengers = 2 THEN "2_passenger"
WHEN first_numberofpassengers = 3 THEN "3+_passenger" END) as first_segmentation_nb_passenger,


(CASE WHEN second_numberofpassengers = 1 THEN 1 ELSE 0 END) as second_1_passenger, 
(CASE WHEN second_numberofpassengers = 2 THEN 1 ELSE 0 END) as second_2_passenger, 
(CASE WHEN second_numberofpassengers > 2 THEN 1 ELSE 0 END) as second_3_and_more_passenger, 
(CASE WHEN second_numberofpassengers = 1 THEN "1_passenger" 
WHEN second_numberofpassengers = 2 THEN "2_passenger"
WHEN second_numberofpassengers = 3 THEN "3+_passenger" END) as second_segmentation_nb_passenger,

(CASE WHEN ((first_numberofpassengers = 1) and (first_nb_hommes = 1)) THEN "1_Adulte seul homme"
WHEN ((first_numberofpassengers = 1) and (first_nb_femmes = 1)) THEN "2_Adulte seule femme"
WHEN ((first_numberofpassengers = 2) and (first_nb_femmes = 1) and (first_nb_hommes = 1)   and (first_nb_adults = 2)) THEN "3_Couple adultes homme et femme"
WHEN ((first_numberofpassengers = 2) and (first_nb_femmes = 0) and (first_nb_hommes = 2)   and (first_nb_adults = 2)) THEN "4_Couple adultes hommes"
WHEN ((first_numberofpassengers = 2) and (first_nb_femmes = 2) and (first_nb_hommes = 0)  and (first_nb_adults = 2)) THEN "5_Couple adultes femmes"
WHEN ((first_numberofpassengers > 1) and  (first_nb_adults = 1) and ((first_nb_children > 0) or ( first_nb_infants >0)) ) THEN "7_Famille dont 1 adulte"
WHEN ((first_numberofpassengers > 2) and  (first_nb_adults = 2) and ((first_nb_children > 0) or ( first_nb_infants >0)) ) THEN "8_Famille dont 2 adultes"
WHEN ((first_numberofpassengers > 2) and  (first_nb_adults > 2) and ((first_nb_children > 0) or ( first_nb_infants >0)) ) THEN "9_Famille dont >2 adultes"
WHEN ((first_numberofpassengers > 2) and  (first_nb_adults > 2) and (first_nb_children = 0) and  (first_nb_infants = 0)  ) THEN "6_Groupes d'amis >2 adultes"
 END) as first_segmentation_passengers,

(CASE WHEN ((first_numberofpassengers = 1) and (first_nb_hommes = 1)) THEN 1 ELSE 0 END ) as first_seg_1_adulte_seul_homme,
(CASE WHEN ((first_numberofpassengers = 1) and (first_nb_femmes = 1)) THEN 1 ELSE 0 END ) as first_seg_2_adulte_seul_femme,
(CASE WHEN ((first_numberofpassengers = 2) and (first_nb_femmes = 1) and (first_nb_hommes = 1)   and (first_nb_adults = 2) ) THEN 1 ELSE 0 END ) as first_seg_3_couple_adultes_homme_et_femme,
(CASE WHEN ((first_numberofpassengers = 2) and (first_nb_femmes = 0) and (first_nb_hommes = 2)   and (first_nb_adults = 2))  THEN 1 ELSE 0 END ) as first_seg_4_couple_adultes_hommes,
(CASE WHEN ((first_numberofpassengers = 2) and (first_nb_femmes = 2) and (first_nb_hommes = 0)  and (first_nb_adults = 2)) THEN 1 ELSE 0 END ) as first_seg_5_couple_adultes_femmes,
(CASE WHEN ((first_numberofpassengers > 1) and  (first_nb_adults = 1) and ((first_nb_children > 0) or ( first_nb_infants >0)) ) THEN 1 ELSE 0 END ) as first_seg_7_famille_1_adulte,
(CASE WHEN ((first_numberofpassengers > 2) and  (first_nb_adults = 2) and ((first_nb_children > 0) or ( first_nb_infants >0)) ) THEN 1 ELSE 0 END )as first_seg_8_famille_2_adultes,
(CASE WHEN ((first_numberofpassengers > 2) and  (first_nb_adults > 2) and ((first_nb_children > 0) or ( first_nb_infants >0)) )  THEN 1 ELSE 0 END ) as first_seg_9_famille_au_moins_3_adultes,
( CASE WHEN ((first_numberofpassengers > 2) and  (first_nb_adults > 2) and (first_nb_children = 0) and  (first_nb_infants = 0)  ) THEN 1 ELSE 0 END ) as first_seg_6_tribus_amis_adultes,


(CASE WHEN ((first_numberofpassengers = 1) and  (first_nb_children = 0) and ( first_nb_infants =0) ) THEN  "1_adulte_seul"
WHEN ( (first_numberofpassengers = 2) and (first_nb_femmes = 1) and (first_nb_hommes = 1)   and (first_nb_adults = 2)  ) THEN "2_adultes_homme_femme"
WHEN (  (first_nb_children > 0) OR  (first_nb_infants> 0)    ) THEN "4_famille"
WHEN ( (first_numberofpassengers > 1) and (first_numberofpassengers > 1) and  (first_nb_children = 0) and ( first_nb_infants =0) )  THEN "3_adultes_amis"
 END) as first_seg_macro,

(CASE WHEN ((first_numberofpassengers = 1) and  (first_nb_children = 0) and ( first_nb_infants =0) ) THEN 1 ELSE 0 END ) as first_seg_macro_1_adulte_seul,
(CASE WHEN ( (first_numberofpassengers = 2) and (first_nb_femmes = 1) and (first_nb_hommes = 1)   and (first_nb_adults = 2)  ) THEN 1 ELSE 0 END ) as first_seg_macro_2_adultes_homme_femme,
(CASE WHEN ( (first_numberofpassengers = 2) and (first_nb_femmes = 1) and (first_nb_hommes = 1)   and (first_nb_adults = 2)  ) THEN 0
WHEN ( (first_numberofpassengers > 1) and  (first_nb_children = 0) and ( first_nb_infants =0) ) THEN 1 ELSE 0 END ) as first_seg_macro_3_amis,
(CASE WHEN ( (first_nb_children > 0) OR  (first_nb_infants> 0)  ) THEN 1 ELSE 0 END ) as first_seg_macro_4_famille, #, 



# DESABO & SEGMENTATION // DESABO 

(CASE WHEN (red_list_uuid is not null) OR (optout is not null) THEN "opt-out" 
WHEN (crm_subscription_below_90d =  1) and (tr_bool_open = 0) THEN "inactif_recent" 
WHEN (crm_subscription_below_90d =  1) and (tr_bool_open = 1) THEN "actif_recent" 
WHEN (crm_subscription_below_90d =  0) and (tr_bool_open = 0) THEN "inactif" 
WHEN (crm_subscription_below_90d =  0) and (tr_bool_open = 1) and (has_opened_below_90days =1)  THEN "actif"
WHEN (crm_subscription_below_90d =  0) and (tr_bool_open = 1) and (has_opened_below_90days =0)  THEN "endormi"
ELSE "autre" END) as segment_v2_optout,


(CASE WHEN (red_list_uuid is not null) OR (optout is not null) THEN 1 ELSE 0 END) as is_optout,     
(CASE WHEN ((red_list_uuid is  null) AND (optout is  null)) and  (crm_subscription_below_90d =  1) and (tr_bool_open = 0) THEN 1 ELSE 0 END) inactif_recent,
(CASE WHEN ((red_list_uuid is  null) AND (optout is  null)) and (crm_subscription_below_90d =  1) and (tr_bool_open = 1) THEN 1 ELSE 0 END) actif_recent,
(CASE WHEN ((red_list_uuid is  null) AND (optout is  null)) and (crm_subscription_below_90d =  0) and (tr_bool_open = 0) THEN 1 ELSE 0 END) inactif,
(CASE WHEN ((red_list_uuid is  null) AND (optout is  null)) and (crm_subscription_below_90d =  0) and (tr_bool_open = 1) and (has_opened_below_90days =1)  THEN 1 ELSE 0 END) actif,
(CASE WHEN ((red_list_uuid is  null) AND (optout is  null)) and (crm_subscription_below_90d =  0) and (tr_bool_open = 1) and (has_opened_below_90days =0)  THEN 1 ELSE 0 END) endormi, 



FROM (

SELECT * FROM (

# A : 1° TABLE POUR NETTOYAGE, RACCORDEMENT IFNULL 

        # FE table UUID V1 
        SELECT  #EXCEPT(client, reacheteur, statut_acheteur, source_crm, total_paid, total_price, source)  , 
        crm_uuid, 
        crm_subscriptionDate, 
        IFNULL(delay_days_from_subscription, 0) as crm_delay_days_from_subscription,  
        IFNULL(delay_months_from_subscription, 0)as crm_delay_months_from_subscription, 

        IFNULL(crm_source, "inconnu") as crm_source, 
        IFNULL(orga_paid, "inconnu") as crm_orga_paid, 
        IFNULL(medium, "inconnu")  as crm_medium, 
        IFNULL(channel, "inconnu") as crm_channel, 
        IFNULL(campaign, "inconnu") as crm_campaign, 
        IFNULL(nb_events, 0) as nav_nb_event, 
        IFNULL(nb_distinct_session_days, 0) as nav_nb_distinct_session_days, 
        IFNULL(nb_distinct_session_months, 0) as nav_nb_distinct_session_months, 
        IFNULL(sum_degre_chaleur, 0)as nav_sum_degre_chaleur, 
        IFNULL(nb_step_1_product_list, 0)as nav_nb_step_1_product_list, 
        IFNULL(nb_step_2_product_page, 0)as nav_nb_step_2_product_page,  
        IFNULL(nb_step_3_select_trip_settings, 0)as nav_nb_step_3_select_trip_settings,  
        IFNULL(nb_step_4_quotationPage_result, 0)as nav_nb_step_4_quotationPage_result,  
        IFNULL(nb_step_5_payment_page, 0)as nav_nb_step_5_payment_page, 
        IFNULL(nb_step_6_payment_confirmation, 0)as nav_nb_step_6_payment_confirmation,  
        IFNULL(step_1_product_list, 0)as nav_step_1_product_list, 
        IFNULL(step_2_product_page, 0)as nav_step_2_product_page, 
        IFNULL(step_3_select_trip_settings, 0)as nav_step_3_select_trip_settings,  
        IFNULL(step_4_quotationPage_result, 0)as nav_step_4_quotationPage_result, 
        IFNULL(step_5_payment_page, 0)as nav_step_5_payment_page,  
        IFNULL(step_6_payment_confirmation, 0)as nav_step_6_payment_confirmation, 
        IFNULL(mean_degre_chaleur, 0)as nav_mean_degre_chaleur, 
        IFNULL(mean_degre_chaleur_pondere_day, 0)as nav_mean_degre_chaleur_pondere_day,  
        IFNULL(mean_degre_chaleur_pondere_month, 0)as nav_mean_degre_chaleur_pondere_month, 
        IFNULL(ratio_sessions_days_on_days_delay_from_subscription	, 0)as nav_ratio_sessions_days_on_days_delay_from_subscription,  
        IFNULL(engagement_score_month, 0)as nav_engagement_score_month, 
        IFNULL(engagement_score_1_month, 0)as nav_engagement_score_1_month,  
        IFNULL(engagement_score_3_month, 0)as nav_engagement_score_3_month,  
        engagement_score_3_month as nav_engagement_score_3_month_not_fullbase,  

        IFNULL(avg_ratio_sessions_days_and_months_from_subscription, 0)as nav_avg_ratio_sessions_days_and_months_from_subscription,  

        total_paid as tr_total_paid, 
        IFNULL(total_paid, 0) as tr_total_paid_full_base,  
        total_price as tr_total_price, 
        IFNULL(total_price, 0) as tr_total_price_full_base,  
        IFNULL(nb_transac, 0) as tr_nb_transac, 
        (CASE WHEN  nb_transac > 0 THEN 1 ELSE 0  END) as tr_client, 
        (CASE WHEN nb_transac > 1 THEN 1 ELSE 0  END) as tr_reacheteur, 
        (CASE  WHEN nb_transac = 1 THEN "mono-acheteur"  WHEN nb_transac > 1 THEN "multi-acheteur" ELSE "prospect" END ) as tr_statut_acheteur , 
        IFNULL(brandcode, "inconnu") as tr_brandcode, 

        dst_reac_campaign as re_dst_reac_campaign, 
        dst_first_event_timestamp_per_campaign as re_dst_first_event_timestamp_per_campaign , 
        dst_first_event_day_per_campaign as re_dst_first_event_day_per_campaign ,  
        dst_first_event_month_per_campaign as re_dst_first_event_month_per_campaign ,  
        Sent as re_Sent ,  
        Open as re_Open ,  
        Clic as re_Clic ,  
        nb_sent as re_nb_sent ,  
        nb_open as re_nb_open ,  
        nb_clic as re_nb_clic , 
        ratio_sent as re_ratio_sent , 
        ratio_open as re_ratio_open ,  
        ratio_clic as re_ratio_clic ,  
        ratio_sent_open as re_ratio_sent_open , 
        ratio_sent_clic as re_ratio_sent_clic , 
        avg_open_on_unique_open_ratio as re_avg_open_on_unique_open_ratio , 
        avg_clic_on_unique_clic_ratio as re_avg_clic_on_unique_clic_ratio , 
        DATE_DIFF(  "2019-10-31" ,  crm_subscriptionDate , DAY)  as re_delay_from_subscription , 
        (CASE WHEN (DATE_DIFF(  "2019-10-31"  ,  crm_subscriptionDate , DAY) ) <= 90 then 1 else 0 END ) as re_delay_from_subscription_below_90d, 
        last_open_date as re_last_open_date , 
        avg_delay_days_between_open re_avg_delay_days_between_open , 
        avg_delay_distinct_days_between_open as re_avg_delay_distinct_days_between_open ,
        first_open_date as re_first_open_date, 
        
        
        #DATE_DIFF( cast(re_endormi_max_open_date as date), cast(crm_subscriptionDate as date), DAY) as re_endormi_delai_souscription_max_open_date_endormissement, 
        DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) as re_endormi_max_open_date_more_90_days ,


        # Vrai date d'endormissement de l'endormi confirmé, null si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) END) as re_endormi_confirmed_endormissement_date , #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

        # Vraie date du last open de l'endormi confirmé 
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN  re_endormi_max_open_date END) as re_endormi_confirmed_last_open_date_before_endormi , #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

        # 1 si vraiment endormi, null si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN 1 END) as re_endormmi_confirmed_first_endormi_status, #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)


        # 1 si vraiment endormi, 0 si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN 1 ELSE 0 END) as re_endormmi_confirmed_first_endormi_status_fullbase, #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

        # Delai souscription à date du last open de l'endormi confirmé, null si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN DATE_DIFF( cast(re_endormi_max_open_date as date), cast(crm_subscriptionDate as date), DAY)  END) as re_endormi_delai_souscription_to_last_open_date_before_first_endormissement ,#donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

        # Delai souscription à date d'endormissement (donc last open du premier endormissement +3 mois) de l'endormi confimé, null si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN DATE_DIFF( DATE_ADD( cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ), cast(crm_subscriptionDate as date), DAY )  
        END ) as re_endormi_delai_souscription_to_confirmed_first_endormissement_date, #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

# first and second transactions 
tr_uuid_postcode, tr_uuid_city, tr_uuid_country, first_uuid, first_shop, first_brandcode, first_partnercode, first_destinationregion, first_destinationcountry, first_productname, first_resort, first_numberofdays, first_nb_adults, first_nb_children, first_nb_infants, first_numberofpassengers, first_device, first_bookingreference, first_delay_lead_time, first_nb_femmes, first_nb_hommes, first_booking_date, first_departuredate, first_returndate, first_totalprice, first_totalpaid, second_uuid, second_shop, second_brandcode, second_partnercode, second_destinationregion, second_destinationcountry, second_productname, second_resort, second_numberofdays, second_nb_adults, second_nb_children, second_nb_infants, second_numberofpassengers, second_device, second_bookingreference, second_delay_lead_time, second_nb_femmes, second_nb_hommes, second_booking_date, second_departuredate, second_returndate, second_totalprice, second_totalpaid, second_delay_btw_order_date, second_delay_btw_departure_date, 

# red list  / optout 
red_list_uuid, optout


        FROM `perfectstay-crm-staging.master_table_uuid.master_uuid_af_v1`

        ) a 

# A : 2° TABLE DE CREATION DES SEGMENTS inactifs / actifs / endormis etc SUR LA 1° TABLE (oui, c'est redondant) 

LEFT JOIN 
(SELECT * EXCEPT (crm_uuid, crm_subscriptionDate, crm_delay_days_from_subscription, re_last_open_date) ,  crm_uuid as uuid FROM (

    SELECT * , 
    
    #(CASE WHEN (crm_subscription_below_90d =  1) and (tr_bool_open = 0) THEN 1 ELSE 0 END) inactif_recent,
    #(CASE WHEN (crm_subscription_below_90d =  1) and (tr_bool_open = 1) THEN 1 ELSE 0 END) actif_recent,
    #(CASE WHEN (crm_subscription_below_90d =  0) and (tr_bool_open = 0) THEN 1 ELSE 0 END) inactif,
    #(CASE WHEN (crm_subscription_below_90d =  0) and (tr_bool_open = 1) and (has_opened_below_90days =1)  THEN 1 ELSE 0 END) actif,
    #(CASE WHEN (crm_subscription_below_90d =  0) and (tr_bool_open = 1) and (has_opened_below_90days =0)  THEN 1 ELSE 0 END) endormi, 


    (CASE WHEN (crm_subscription_below_90d =  1) and (tr_bool_open = 0) THEN "inactif_recent" 
    WHEN (crm_subscription_below_90d =  1) and (tr_bool_open = 1) THEN "actif_recent" 
    WHEN (crm_subscription_below_90d =  0) and (tr_bool_open = 0) THEN "inactif" 
    WHEN (crm_subscription_below_90d =  0) and (tr_bool_open = 1) and (has_opened_below_90days =1)  THEN "actif"
    WHEN (crm_subscription_below_90d =  0) and (tr_bool_open = 1) and (has_opened_below_90days =0)  THEN "endormi"
    ELSE "autre" END) as segment,
    


    

    FROM (
    SELECT crm_uuid, crm_subscriptionDate, crm_delay_days_from_subscription, 
    (CASE WHEN crm_delay_days_from_subscription <= 90 THEN 1 ELSE 0 END) as crm_subscription_below_90d, 
    (CASE WHEN re_open > 0 THEN 1 ELSE 0 END) as tr_bool_open 
    ,  re_last_open_date, 
    DATE_DIFF ("2019-10-31" , EXTRACT(DATE FROM ( cast(re_last_open_date as timestamp)  )) , DAY) as delay_from_last_open, 
    (CASE WHEN  DATE_DIFF ("2019-10-31" , EXTRACT(DATE FROM ( cast(re_last_open_date as timestamp)  )) , DAY)   <= 90 THEN 1 
    ELSE 0 END) as has_opened_below_90days

    from (SELECT  #EXCEPT(client, reacheteur, statut_acheteur, source_crm, total_paid, total_price, source)  , 
            crm_uuid, 
            crm_subscriptionDate, 
            IFNULL(delay_days_from_subscription, 0) as crm_delay_days_from_subscription,  
            IFNULL(delay_months_from_subscription, 0)as crm_delay_months_from_subscription, 

            IFNULL(crm_source, "inconnu") as crm_source, 
            IFNULL(orga_paid, "inconnu") as crm_orga_paid, 
            IFNULL(medium, "inconnu")  as crm_medium, 
            IFNULL(channel, "inconnu") as crm_channel, 
            IFNULL(campaign, "inconnu") as crm_campaign, 
            IFNULL(nb_events, 0) as nav_nb_event, 
            IFNULL(nb_distinct_session_days, 0) as nav_nb_distinct_session_days, 
            IFNULL(nb_distinct_session_months, 0) as nav_nb_distinct_session_months, 
            IFNULL(sum_degre_chaleur, 0)as nav_sum_degre_chaleur, 
            IFNULL(nb_step_1_product_list, 0)as nav_nb_step_1_product_list, 
            IFNULL(nb_step_2_product_page, 0)as nav_nb_step_2_product_page,  
            IFNULL(nb_step_3_select_trip_settings, 0)as nav_nb_step_3_select_trip_settings,  
            IFNULL(nb_step_4_quotationPage_result, 0)as nav_nb_step_4_quotationPage_result,  
            IFNULL(nb_step_5_payment_page, 0)as nav_nb_step_5_payment_page, 
            IFNULL(nb_step_6_payment_confirmation, 0)as nav_nb_step_6_payment_confirmation,  
            IFNULL(step_1_product_list, 0)as nav_step_1_product_list, 
            IFNULL(step_2_product_page, 0)as nav_step_2_product_page, 
            IFNULL(step_3_select_trip_settings, 0)as nav_step_3_select_trip_settings,  
            IFNULL(step_4_quotationPage_result, 0)as nav_step_4_quotationPage_result, 
            IFNULL(step_5_payment_page, 0)as nav_step_5_payment_page,  
            IFNULL(step_6_payment_confirmation, 0)as nav_step_6_payment_confirmation, 
            IFNULL(mean_degre_chaleur, 0)as nav_mean_degre_chaleur, 
            IFNULL(mean_degre_chaleur_pondere_day, 0)as nav_mean_degre_chaleur_pondere_day,  
            IFNULL(mean_degre_chaleur_pondere_month, 0)as nav_mean_degre_chaleur_pondere_month, 
            IFNULL(ratio_sessions_days_on_days_delay_from_subscription	, 0)as nav_ratio_sessions_days_on_days_delay_from_subscription,  
            IFNULL(engagement_score_month, 0)as nav_engagement_score_month, 
            IFNULL(engagement_score_1_month, 0)as nav_engagement_score_1_month,  
            IFNULL(engagement_score_3_month, 0)as nav_engagement_score_3_month,  
            IFNULL(avg_ratio_sessions_days_and_months_from_subscription, 0)as nav_avg_ratio_sessions_days_and_months_from_subscription,  
            engagement_score_3_month as nav_engagement_score_3_month_not_fullbase,  

            total_paid as tr_total_paid, 
            IFNULL(total_paid, 0) as tr_total_paid_full_base,  
            total_price as tr_total_price, 
            IFNULL(total_price, 0) as tr_total_price_full_base,  
            IFNULL(nb_transac, 0) as tr_nb_transac, 
            (CASE WHEN  nb_transac > 0 THEN 1 ELSE 0  END) as tr_client, 
            (CASE WHEN nb_transac > 1 THEN 1 ELSE 0  END) as tr_reacheteur, 
            (CASE  WHEN nb_transac = 1 THEN "mono-acheteur"  WHEN nb_transac > 1 THEN "multi-acheteur" ELSE "prospect" END ) as tr_statut_acheteur , 

            dst_reac_campaign as re_dst_reac_campaign, 
            dst_first_event_timestamp_per_campaign as re_dst_first_event_timestamp_per_campaign , 
            dst_first_event_day_per_campaign as re_dst_first_event_day_per_campaign ,  
            dst_first_event_month_per_campaign as re_dst_first_event_month_per_campaign ,  
            Sent as re_Sent ,  
            Open as re_Open ,  
            Clic as re_Clic ,  
            nb_sent as re_nb_sent ,  
            nb_open as re_nb_open ,  
            nb_clic as re_nb_clic , 
            ratio_sent as re_ratio_sent , 
            ratio_open as re_ratio_open ,  
            ratio_clic as re_ratio_clic ,  
            ratio_sent_open as re_ratio_sent_open , 
            ratio_sent_clic as re_ratio_sent_clic , 
            avg_open_on_unique_open_ratio as re_avg_open_on_unique_open_ratio , 
            avg_clic_on_unique_clic_ratio as re_avg_clic_on_unique_clic_ratio , 
            DATE_DIFF(  "2019-10-31" ,  crm_subscriptionDate , DAY)  as re_delay_from_subscription , 
            (CASE WHEN (DATE_DIFF(  "2019-10-31"  ,  crm_subscriptionDate , DAY) ) <= 90 then 1 else 0 END ) as re_delay_from_subscription_below_90d, 
            last_open_date as re_last_open_date , 
            avg_delay_days_between_open re_avg_delay_days_between_open , 
            avg_delay_distinct_days_between_open as re_avg_delay_distinct_days_between_open ,
            first_open_date as re_first_open_date, 




        
        #DATE_DIFF( cast(re_endormi_max_open_date as date), cast(crm_subscriptionDate as date), DAY) as re_endormi_delai_souscription_max_open_date_endormissement, 
        DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) as re_endormi_max_open_date_more_90_days ,


        # Vrai date d'endormissement de l'endormi confirmé, null si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) END) as re_endormi_confirmed_endormissement_date , #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

        # Vraie date du last open de l'endormi confirmé 
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN  re_endormi_max_open_date END) as re_endormi_confirmed_last_open_date_before_endormi , #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

        # 1 si vraiment endormi, null si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN 1 END) as re_endormmi_confirmed_first_endormi_status, #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

        # 1 si vraiment endormi, 0 si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN 1 ELSE 0 END) as re_endormmi_confirmed_first_endormi_status_fullbase, #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

        # Delai souscription à date du last open de l'endormi confirmé, null si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN DATE_DIFF( cast(re_endormi_max_open_date as date), cast(crm_subscriptionDate as date), DAY)  END) as re_endormi_delai_souscription_to_last_open_date_before_first_endormissement ,#donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)

        # Delai souscription à date d'endormissement (donc last open du premier endormissement +3 mois) de l'endormi confimé, null si on ne sait pas car on suspend notre jugement car glissant sur les derniers jours avant la last date du 31/10/2019
        (CASE WHEN DATE_ADD(cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ) < "2019-10-31" 
        THEN DATE_DIFF( DATE_ADD( cast(re_endormi_max_open_date as date),INTERVAL 90 DAY ), cast(crm_subscriptionDate as date), DAY )  
        END ) as re_endormi_delai_souscription_to_confirmed_first_endormissement_date, #donc nul et non comptabilisé si on sait pas car <90 jours // last day glissant (ici 31/10/2019)
        
# first and second transactions 
tr_uuid_postcode, tr_uuid_city, tr_uuid_country, first_uuid, first_shop, first_brandcode, first_partnercode, first_destinationregion, first_destinationcountry, first_productname, first_resort, first_numberofdays, first_nb_adults, first_nb_children, first_nb_infants, first_numberofpassengers, first_device, first_bookingreference, first_delay_lead_time, first_nb_femmes, first_nb_hommes, first_booking_date, first_departuredate, first_returndate, first_totalprice, first_totalpaid, second_uuid, second_shop, second_brandcode, second_partnercode, second_destinationregion, second_destinationcountry, second_productname, second_resort, second_numberofdays, second_nb_adults, second_nb_children, second_nb_infants, second_numberofpassengers, second_device, second_bookingreference, second_delay_lead_time, second_nb_femmes, second_nb_hommes, second_booking_date, second_departuredate, second_returndate, second_totalprice, second_totalpaid, second_delay_btw_order_date, second_delay_btw_departure_date, 

# red list  / optout 
red_list_uuid, optout



            FROM `perfectstay-crm-staging.master_table_uuid.master_uuid_af_v1`
            )
    ) 

 ) 
    ) b 
    on a.crm_uuid = b.uuid
    
    ) C
  


LEFT JOIN (

# TABLE REACTIVITE AGG QUI PREND LES CAMPAGNES DES "PREMIERS last_open_date" des désendormis 
    SELECT * 
  FROM (
# TABLE REACTIVITE BRUTE DE TOUTES LES CAMPAGNES AYANT REVEILLE / DESENDORMI 
            #SELECT  uuid, max(last_open_date) as last_open_date, 
            SELECT  uuid as d_uuid, last_open_date as re_reveil_last_open_date, Nom_Envoi as re_reveil_Nom_Envoi, Type_Envoi as re_reveil_Type_Envoi,  Meta_Campagne as re_reveil_Meta_Campagne, 
            delay_days_between_last_open as re_reveil_delay_from_last_open, 
             

            #(CASE WHEN  max(delay_days_between_last_open) > 90 THEN 1 ELSE 0 END) AS endormi_reveille
            #(CASE WHEN  max(delay_days_between_last_open) > 90 THEN 1 ELSE 0 END) AS endormi_reveille    # avg(delay_days_between_last_open) as avg_delay_days_between_open, 
           ROW_NUMBER() OVER(PARTITION BY  uuid ) as re_reveil_step_desendormissement_per_uuid

           FROM ( 
              SELECT uuid, last_open_date,  Nom_Envoi,Type_Envoi, Meta_Campagne, 
              (LAG(EXTRACT(DATE FROM cast(last_open_date as timestamp) ),1) OVER (PARTITION BY uuid order by last_open_date))  as previous_first_event_date , 
              DATE_DIFF( EXTRACT(DATE FROM cast(last_open_date as timestamp)), 
              (LAG(EXTRACT(DATE FROM cast(last_open_date as timestamp) ),1) OVER (PARTITION BY uuid order by last_open_date )), DAY) as delay_days_between_last_open
              FROM `perfectstay-crm-staging.clean_sources.reac_4_af_all_table` 
              where last_event_type = "open"  #and uuid = "577a442e-4fd5-422f-9cac-4fb77df31cd9"  
              #and (uuid = "001cd5a9-c3b3-45e5-8164-de26a493c02f") or (uuid =  "00f014ad-78eb-4c0c-beac-34079ac7a26b")
              order by uuid, last_open_date 
            ) 
          where delay_days_between_last_open > 90

        #  ) where endormi_reveille = 1
    ) 
    where  re_reveil_step_desendormissement_per_uuid = 1 
    ) D
    
    on C.uuid = D.d_uuid