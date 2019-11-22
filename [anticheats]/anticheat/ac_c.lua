
BlacklistedWeapons = { -- weapons that will get people banned
	"WEAPON_BALL",
	"WEAPON_RAILGUN",
	"WEAPON_GARBAGEBAG",
}

CageObjs = {
	"P_Spinning_Anus_S_Main",
	"P_Spinning_Anus_S_Root",
	"p_spinning_anus_s"
}

--[[
CageObjs = {
	"prop_gold_cont_01",
	"p_cablecar_s",
	"stt_prop_stunt_tube_l",
	"stt_prop_stunt_track_dwuturn",
	"hei_prop_carrier_radar_1_l1",
	"v_res_mexball",
	"prop_rock_1_a",
	"prop_rock_1_b",
	"prop_rock_1_c",
	"prop_rock_1_d",
	"prop_player_gasmask",
	"prop_rock_1_e",
	"prop_rock_1_f",
	"prop_rock_1_g",
	"prop_rock_1_h",
	"prop_test_boulder_01",
	"prop_test_boulder_02",
	"prop_test_boulder_03",
	"prop_test_boulder_04",
	"apa_mp_apa_crashed_usaf_01a",
	"ex_prop_exec_crashdp",
	"apa_mp_apa_yacht_o1_rail_a",
	"apa_mp_apa_yacht_o1_rail_b",
	"apa_mp_h_yacht_armchair_01",
	"apa_mp_h_yacht_armchair_03",
	"apa_mp_h_yacht_armchair_04",
	"apa_mp_h_yacht_barstool_01",
	"apa_mp_h_yacht_bed_01",
	"apa_mp_h_yacht_bed_02",
	"apa_mp_h_yacht_coffee_table_01",
	"apa_mp_h_yacht_coffee_table_02",
	"apa_mp_h_yacht_floor_lamp_01",
	"apa_mp_h_yacht_side_table_01",
	"apa_mp_h_yacht_side_table_02",
	"apa_mp_h_yacht_sofa_01",
	"apa_mp_h_yacht_sofa_02",
	"apa_mp_h_yacht_stool_01",
	"apa_mp_h_yacht_strip_chair_01",
	"apa_mp_h_yacht_table_lamp_01",
	"apa_mp_h_yacht_table_lamp_02",
	"apa_mp_h_yacht_table_lamp_03",
	"prop_flag_columbia",
	"apa_mp_apa_yacht_o2_rail_a",
	"apa_mp_apa_yacht_o2_rail_b",
	"apa_mp_apa_yacht_o3_rail_a",
	"apa_mp_apa_yacht_o3_rail_b",
	"apa_mp_apa_yacht_option1",
	"proc_searock_01",
	"apa_mp_h_yacht_",
	"apa_mp_apa_yacht_option1_cola",
	"apa_mp_apa_yacht_option2",
	"apa_mp_apa_yacht_option2_cola",
	"apa_mp_apa_yacht_option2_colb",
	"apa_mp_apa_yacht_option3",
	"apa_mp_apa_yacht_option3_cola",
	"apa_mp_apa_yacht_option3_colb",
	"apa_mp_apa_yacht_option3_colc",
	"apa_mp_apa_yacht_option3_cold",
	"apa_mp_apa_yacht_option3_cole",
	"apa_mp_apa_yacht_jacuzzi_cam",
	"apa_mp_apa_yacht_jacuzzi_ripple003",
	"apa_mp_apa_yacht_jacuzzi_ripple1",
	"apa_mp_apa_yacht_jacuzzi_ripple2",
	"apa_mp_apa_yacht_radar_01a",
	"apa_mp_apa_yacht_win",
	"prop_crashed_heli",
	"apa_mp_apa_yacht_door",
	"prop_shamal_crash",
	"xm_prop_x17_shamal_crash",
	"apa_mp_apa_yacht_door2",
	"apa_mp_apa_yacht",
	"prop_flagpole_2b",
	"prop_flagpole_2c",
	"prop_flag_canada",
	"apa_prop_yacht_float_1a",
	"apa_prop_yacht_float_1b",
	"apa_prop_yacht_glass_01",
	"apa_prop_yacht_glass_02",
	"apa_prop_yacht_glass_03",
	"apa_prop_yacht_glass_04",
	"apa_prop_yacht_glass_05",
	"apa_prop_yacht_glass_06",
	"apa_prop_yacht_glass_07",
	"apa_prop_yacht_glass_08",
	"apa_prop_yacht_glass_09",
	"apa_prop_yacht_glass_10",
	"prop_flag_canada_s",
	"prop_flag_eu",
	"prop_flag_eu_s",
	"prop_target_blue_arrow",
	"prop_target_orange_arrow",
	"prop_target_purp_arrow",
	"prop_target_red_arrow",
	"apa_prop_flag_argentina",
	"apa_prop_flag_australia",
	"apa_prop_flag_austria",
	"apa_prop_flag_belgium",
	"apa_prop_flag_brazil",
	"apa_prop_flag_canadat_yt",
	"apa_prop_flag_china",
	"apa_prop_flag_columbia",
	"apa_prop_flag_croatia",
	"apa_prop_flag_czechrep",
	"apa_prop_flag_denmark",
	"apa_prop_flag_england",
	"apa_prop_flag_eu_yt",
	"apa_prop_flag_finland",
	"apa_prop_flag_france",
	"apa_prop_flag_german_yt",
	"apa_prop_flag_hungary",
	"apa_prop_flag_ireland",
	"apa_prop_flag_israel",
	"apa_prop_flag_italy",
	"apa_prop_flag_jamaica",
	"apa_prop_flag_japan_yt",
	"apa_prop_flag_canada_yt",
	"apa_prop_flag_lstein",
	"apa_prop_flag_malta",
	"apa_prop_flag_mexico_yt",
	"apa_prop_flag_netherlands",
	"apa_prop_flag_newzealand",
	"apa_prop_flag_nigeria",
	"apa_prop_flag_norway",
	"apa_prop_flag_palestine",
	"apa_prop_flag_poland",
	"apa_prop_flag_portugal",
	"apa_prop_flag_puertorico",
	"apa_prop_flag_russia_yt",
	"apa_prop_flag_scotland_yt",
	"apa_prop_flag_script",
	"apa_prop_flag_slovakia",
	"apa_prop_flag_slovenia",
	"apa_prop_flag_southafrica",
	"apa_prop_flag_southkorea",
	"apa_prop_flag_spain",
	"apa_prop_flag_sweden",
	"apa_prop_flag_switzerland",
	"apa_prop_flag_turkey",
	"apa_prop_flag_uk_yt",
	"apa_prop_flag_us_yt",
	"apa_prop_flag_wales",
	"prop_flag_uk",
	"prop_flag_uk_s",
	"prop_flag_us",
	"prop_flag_usboat",
	"prop_flag_us_r",
	"prop_flag_us_s",
	"prop_flag_france",
	"prop_flag_france_s",
	"prop_flag_german",
	"prop_flag_german_s",
	"prop_flag_ireland",
	"prop_flag_ireland_s",
	"prop_flag_japan",
	"prop_flag_japan_s",
	"prop_flag_ls",
	"prop_flag_lsfd",
	"prop_flag_lsfd_s",
	"prop_flag_lsservices",
	"prop_flag_lsservices_s",
	"prop_flag_ls_s",
	"prop_flag_mexico",
	"prop_flag_mexico_s",
	"prop_flag_russia",
	"prop_flag_russia_s",
	"prop_flag_s",
	"prop_flag_sa",
	"prop_flag_sapd",
	"prop_flag_sapd_s",
	"prop_flag_sa_s",
	"prop_flag_scotland",
	"prop_flag_scotland_s",
	"prop_flag_sheriff",
	"prop_flag_sheriff_s",
	"prop_flag_uk",
	"prop_flag_uk_s",
	"prop_flag_us",
	"prop_flag_usboat",
	"prop_flag_us_r",
	"prop_flag_us_s",
	"prop_flamingo",
	"prop_swiss_ball_01",
	"prop_air_bigradar_l1",
	"prop_air_bigradar_l2",
	"prop_air_bigradar_slod",
	"p_fib_rubble_s",
	"prop_money_bag_01",
	"p_cs_mp_jet_01_s",
	"prop_poly_bag_money",
	"prop_air_radar_01",
	"hei_prop_carrier_radar_1",
	"prop_air_bigradar",
	"prop_carrier_radar_1_l1",
	"prop_asteroid_01",
	"prop_xmas_ext",
	"p_oil_pjack_01_amo",
	"p_oil_pjack_01_s",
	"p_oil_pjack_02_amo",
	"p_oil_pjack_03_amo",
	"p_oil_pjack_02_s",
	"p_oil_pjack_03_s",
	"prop_aircon_l_03",
	"prop_med_jet_01",
	"p_med_jet_01_s",
	"hei_prop_carrier_jet",
	"bkr_prop_biker_bblock_huge_01",
	"bkr_prop_biker_bblock_huge_02",
	"bkr_prop_biker_bblock_huge_04",
	"bkr_prop_biker_bblock_huge_05",
	"hei_prop_heist_emp",
	"prop_weed_01",
	"prop_air_bigradar",
	"prop_juicestand",
	"prop_lev_des_barge_02",
	"hei_prop_carrier_defense_01",
	"prop_aircon_m_04",
	"prop_mp_ramp_03",
	"stt_prop_stunt_track_dwuturn",
	"ch3_12_animplane1_lod",
	"ch3_12_animplane2_lod",
	"hei_prop_hei_pic_pb_plane",
	"light_plane_rig",
	"prop_cs_plane_int_01",
	"prop_dummy_plane",
	"prop_mk_plane",
	"v_44_planeticket",
	"prop_planer_01",
	"ch3_03_cliffrocks03b_lod",
	"ch3_04_rock_lod_02",
	"csx_coastsmalrock_01_",
	"csx_coastsmalrock_02_",
	"csx_coastsmalrock_03_",
	"csx_coastsmalrock_04_",
	"mp_player_introck",
	"Heist_Yacht",
	"csx_coastsmalrock_05_",
	"mp_player_int_rock",
	"mp_player_introck",
	"prop_flagpole_1a",
	"prop_flagpole_2a",
	"prop_flagpole_3a",
	"prop_a4_pile_01",
	"cs2_10_sea_rocks_lod",
	"cs2_11_sea_marina_xr_rocks_03_lod",
	"prop_gold_cont_01",
	"prop_hydro_platform",
	"ch3_04_viewplatform_slod",
	"ch2_03c_rnchstones_lod",
	"proc_mntn_stone01",
	"prop_beachflag_le",
	"proc_mntn_stone02",
	"cs2_10_sea_shipwreck_lod",
	"des_shipsink_02",
	"prop_dock_shippad",
	"des_shipsink_03",
	"des_shipsink_04",
	"prop_mk_flag",
	"prop_mk_flag_2",
	"proc_mntn_stone03",
	"FreeModeMale01",
	"rsn_os_specialfloatymetal_n",
	"rsn_os_specialfloatymetal",
	"cs1_09_sea_ufo",
	"rsn_os_specialfloaty2_light2",
	"rsn_os_specialfloaty2_light",
	"rsn_os_specialfloaty2",
	"rsn_os_specialfloatymetal_n",
	"rsn_os_specialfloatymetal",
	"P_Spinning_Anus_S_Main",
	"P_Spinning_Anus_S_Root",
	"cs3_08b_rsn_db_aliencover_0001cs3_08b_rsn_db_aliencover_0001_a",
	"sc1_04_rnmo_paintoverlaysc1_04_rnmo_paintoverlay_a",
	"rnbj_wallsigns_0001",
	"proc_sml_stones01",
	"proc_sml_stones02",
	"maverick",
	"Miljet",
	"proc_sml_stones03",
	"proc_stones_01",
	"proc_stones_02",
	"proc_stones_03",
	"proc_stones_04",
	"proc_stones_05",
	"proc_stones_06",
	"prop_coral_stone_03",
	"prop_coral_stone_04",
	"prop_gravestones_01a",
	"prop_gravestones_02a",
	"prop_gravestones_03a",
	"prop_gravestones_04a",
	"prop_gravestones_05a",
	"prop_gravestones_06a",
	"prop_gravestones_07a",
	"prop_gravestones_08a",
	"prop_gravestones_09a",
	"prop_gravestones_10a",
	"prop_prlg_gravestone_05a_l1",
	"prop_prlg_gravestone_06a",
	"test_prop_gravestones_04a",
	"test_prop_gravestones_05a",
	"test_prop_gravestones_07a",
	"test_prop_gravestones_08a",
	"test_prop_gravestones_09a",
	"prop_prlg_gravestone_01a",
	"prop_prlg_gravestone_02a",
	"prop_prlg_gravestone_03a",
	"prop_prlg_gravestone_04a",
	"prop_stoneshroom1",
	"prop_stoneshroom2",
	"v_res_fa_stones01",
	"test_prop_gravestones_01a",
	"test_prop_gravestones_02a",
	"prop_prlg_gravestone_05a",
	"FreemodeFemale01",
	"p_cablecar_s",
	"stt_prop_stunt_tube_l",
	"stt_prop_stunt_track_dwuturn",
	"p_spinning_anus_s",
	"prop_windmill_01",
	"hei_prop_heist_tug",
	"prop_air_bigradar",
	"p_oil_slick_01",
	"prop_dummy_01",
	"hei_prop_heist_emp",
	"p_tram_cash_s",
	"hw1_blimp_ce2",
	"prop_fire_exting_1a",
	"prop_fire_exting_1b",
	"prop_fire_exting_2a",
	"prop_fire_exting_3a",
	"hw1_blimp_ce2_lod",
	"hw1_blimp_ce_lod",
	"hw1_blimp_cpr003",
	"hw1_blimp_cpr_null",
	"hw1_blimp_cpr_null2",
	"prop_lev_des_barage_02",
	"hei_prop_carrier_defense_01",
	"prop_juicestand",
	"S_M_M_MovAlien_01",
	"s_m_m_movalien_01",
	"s_m_m_movallien_01",
	"u_m_y_babyd",
	"CS_Orleans",
	"A_M_Y_ACult_01",
	"S_M_M_MovSpace_01",
	"U_M_Y_Zombie_01",
	"s_m_y_blackops_01",
	"a_f_y_topless_01",
	"a_c_boar",
	"a_c_cat_01",
	"a_c_chickenhawk",
	"a_c_chimp",
	"s_f_y_hooker_03",
	"a_c_chop",
	"a_c_cormorant",
	"a_c_cow",
	"a_c_coyote",
	"v_ilev_found_cranebucket",
	"a_c_crow",
	"a_c_dolphin",
	"a_c_fish",
	--"hei_prop_heist_hook_01",
	--"prop_rope_hook_01",
	--"prop_sub_crane_hook",
	"s_f_y_hooker_01",
	--"prop_vehicle_hook",
	--"prop_v_hook_s",
	--"prop_dock_crane_02_hook",
	--"prop_winch_hook_long",
	"a_c_hen",
	"a_c_humpback",
	"a_c_husky",
	"a_c_killerwhale",
	"a_c_mtlion",
	"a_c_pigeon",
	"a_c_poodle",
	--"prop_coathook_01",
	--"prop_cs_sub_hook_01",
	"a_c_pug",
	"a_c_rabbit_01",
	"a_c_rat",
	"a_c_retriever",
	"a_c_rhesus",
	"a_c_rottweiler",
	"a_c_sharkhammer",
	"a_c_sharktiger",
	"a_c_shepherd",
	"a_c_stingray",
	"a_c_westy",
	"CS_Orleans",
	"prop_windmill_01",
	"prop_Ld_ferris_wheel",
	"p_tram_crash_s",
	"p_oil_slick_01",
	"p_ld_stinger_s",
	"p_ld_soc_ball_01",
	"p_parachute1_s",
	"p_cablecar_s",
	"prop_beach_fire",
	"prop_lev_des_barge_02",
	"prop_lev_des_barge_01",
	"prop_sculpt_fix",
	"prop_flagpole_2b",
	"prop_flagpole_2c",
	--"prop_winch_hook_short",
	"prop_flag_canada",
	"prop_flag_canada_s",
	"prop_flag_eu",
	"prop_flag_eu_s",
	"prop_flag_france",
	"prop_flag_france_s",
	"prop_flag_german",
	--"prop_ld_hook",
	"prop_flag_german_s",
	"prop_flag_ireland",
	"prop_flag_ireland_s",
	"prop_flag_japan",
	"prop_flag_japan_s",
	"prop_flag_ls",
	"prop_flag_lsfd",
	"prop_flag_lsfd_s",
	--"prop_cable_hook_01",
	"prop_flag_lsservices",
	"prop_flag_lsservices_s",
	"prop_flag_ls_s",
	"prop_flag_mexico",
	"prop_flag_mexico_s",
	"csx_coastboulder_00",
	"des_tankercrash_01",
	"des_tankerexplosion_01",
	"des_tankerexplosion_02",
	"des_trailerparka_02",
	"des_trailerparkb_02",
	"des_trailerparkc_02",
	"des_trailerparkd_02",
	"des_traincrash_root2",
	"des_traincrash_root3",
	"des_traincrash_root4",
	"des_traincrash_root5",
	"des_finale_vault_end",
	"des_finale_vault_root001",
	"des_finale_vault_root002",
	"des_finale_vault_root003",
	"des_finale_vault_root004",
	"des_finale_vault_start",
	"des_vaultdoor001_root001",
	"des_vaultdoor001_root002",
	"des_vaultdoor001_root003",
	"des_vaultdoor001_root004",
	"des_vaultdoor001_root005",
	"des_vaultdoor001_root006",
	"des_vaultdoor001_skin001",
	"des_vaultdoor001_start",
	"des_traincrash_root6",
	"prop_ld_vault_door",
	"prop_vault_door_scene",
	"prop_vault_door_scene",
	"prop_vault_shutter",
	"p_fin_vaultdoor_s",
	"v_ilev_bk_vaultdoor",
	"prop_gold_vault_fence_l",
	"prop_gold_vault_fence_r",
	"prop_gold_vault_gate_01",
	"prop_const_fence02b",
	"prop_bank_vaultdoor",
	"des_traincrash_root7",
	"prop_flag_russia",
	"prop_flag_russia_s",
	"prop_flag_s",
	"ch2_03c_props_rrlwindmill_lod",
	"prop_flag_sa",
	"prop_flag_sapd",
	"prop_flag_sapd_s",
	"prop_flag_sa_s",
	"prop_flag_scotland",
	"prop_flag_scotland_s",
	"prop_flag_sheriff",
	"prop_flag_sheriff_s",
	"prop_flag_uk",
	"prop_yacht_lounger",
	"prop_yacht_seat_01",
	"prop_yacht_seat_02",
	"prop_yacht_seat_03",
	"marina_xr_rocks_02",
	"marina_xr_rocks_03",
	"prop_test_rocks01",
	"prop_test_rocks02",
	"prop_test_rocks03",
	"prop_test_rocks04",
	"marina_xr_rocks_04",
	"marina_xr_rocks_05",
	"marina_xr_rocks_06",
	"prop_yacht_table_01",
	"csx_searocks_02",
	"csx_searocks_03",
	"csx_searocks_04",
	"csx_searocks_05",
	"csx_searocks_06",
	"p_yacht_chair_01_s",
	"p_yacht_sofa_01_s",
	"prop_yacht_table_02",
	"csx_coastboulder_00",
	"csx_coastboulder_01",
	"csx_coastboulder_02",
	"csx_coastboulder_03",
	"csx_coastboulder_04",
	"csx_coastboulder_05",
	"csx_coastboulder_06",
	"csx_coastboulder_07",
	"csx_coastrok1",
	"csx_coastrok2",
	"csx_coastrok3",
	"csx_coastrok4",
	"csx_coastsmalrock_01",
	"csx_coastsmalrock_02",
	"csx_coastsmalrock_03",
	"csx_coastsmalrock_04",
	"csx_coastsmalrock_05",
	"prop_yacht_table_03",
	"prop_flag_uk_s",
	"prop_flag_us",
	"prop_flag_usboat",
	"prop_flag_us_r",
	"prop_flag_us_s",
	"p_gasmask_s",
	"prop_flamingo"
}]]

keys_blacklist = {
	--[[0, -- TECLADO:[INPUT_NEXT_CAMERA] -- MANDO:[INPUT_NEXT_CAMERA]
1, -- TECLADO:[INPUT_LOOK_LR] -- MANDO:[INPUT_LOOK_LR]
2, -- TECLADO:[INPUT_LOOK_UD] -- MANDO:[INPUT_LOOK_UD]
3, -- TECLADO:[INPUT_LOOK_UP_ONLY] -- MANDO:[INPUT_LOOK_UP_ONLY]
4, -- TECLADO:[INPUT_LOOK_DOWN_ONLY] -- MANDO:[INPUT_LOOK_DOWN_ONLY]
5, -- TECLADO:[INPUT_LOOK_LEFT_ONLY] -- MANDO:[INPUT_LOOK_LEFT_ONLY]
6, -- TECLADO:[INPUT_LOOK_RIGHT_ONLY] -- MANDO:[INPUT_LOOK_RIGHT_ONLY]
7, -- TECLADO:[INPUT_CINEMATIC_SLOWMO] -- MANDO:[INPUT_CINEMATIC_SLOWMO]
8, -- TECLADO:[INPUT_SCRIPTED_FLY_UD] -- MANDO:[INPUT_SCRIPTED_FLY_UD]
9, -- TECLADO:[INPUT_SCRIPTED_FLY_LR] -- MANDO:[INPUT_SCRIPTED_FLY_LR]
10, -- TECLADO:[INPUT_SCRIPTED_FLY_ZUP] -- MANDO:[INPUT_SCRIPTED_FLY_ZUP]
11, -- TECLADO:[INPUT_SCRIPTED_FLY_ZDOWN] -- MANDO:[INPUT_SCRIPTED_FLY_ZDOWN]
12, -- TECLADO:[INPUT_WEAPON_WHEEL_UD] -- MANDO:[INPUT_WEAPON_WHEEL_UD]
13, -- TECLADO:[INPUT_WEAPON_WHEEL_LR] -- MANDO:[INPUT_WEAPON_WHEEL_LR]
14, -- TECLADO:[INPUT_WEAPON_WHEEL_NEXT] -- MANDO:[INPUT_WEAPON_WHEEL_NEXT]
15, -- TECLADO:[INPUT_WEAPON_WHEEL_PREV] -- MANDO:[INPUT_WEAPON_WHEEL_PREV]
16, -- TECLADO:[INPUT_SELECT_NEXT_WEAPON] -- MANDO:[INPUT_SELECT_NEXT_WEAPON]
17, -- TECLADO:[INPUT_SELECT_PREV_WEAPON] -- MANDO:[INPUT_SELECT_PREV_WEAPON]
18, -- TECLADO:[INPUT_SKIP_CUTSCENE] -- MANDO:[INPUT_SKIP_CUTSCENE]
19, -- TECLADO:[INPUT_CHARACTER_WHEEL] -- MANDO:[INPUT_CHARACTER_WHEEL]
20, -- TECLADO:[INPUT_MULTIPLAYER_INFO] -- MANDO:[INPUT_MULTIPLAYER_INFO]
21, -- TECLADO:[INPUT_SPRINT] -- MANDO:[INPUT_SPRINT]
22, -- TECLADO:[INPUT_JUMP] -- MANDO:[INPUT_JUMP]
23, -- TECLADO:[INPUT_ENTER] -- MANDO:[INPUT_ENTER]
24, -- TECLADO:[INPUT_ATTACK] -- MANDO:[INPUT_ATTACK]
25, -- TECLADO:[INPUT_AIM] -- MANDO:[INPUT_AIM]
26, -- TECLADO:[INPUT_LOOK_BEHIND] -- MANDO:[INPUT_LOOK_BEHIND]
27, -- TECLADO:[INPUT_PHONE] -- MANDO:[INPUT_PHONE]
28, -- TECLADO:[INPUT_SPECIAL_ABILITY] -- MANDO:[INPUT_SPECIAL_ABILITY]
29, -- TECLADO:[INPUT_SPECIAL_ABILITY_SECONDARY] -- MANDO:[INPUT_SPECIAL_ABILITY_SECONDARY]
30, -- TECLADO:[INPUT_MOVE_LR] -- MANDO:[INPUT_MOVE_LR]
31, -- TECLADO:[INPUT_MOVE_UD] -- MANDO:[INPUT_MOVE_UD]
32, -- TECLADO:[INPUT_MOVE_UP_ONLY] -- MANDO:[INPUT_MOVE_UP_ONLY]
33, -- TECLADO:[INPUT_MOVE_DOWN_ONLY] -- MANDO:[INPUT_MOVE_DOWN_ONLY]
34, -- TECLADO:[INPUT_MOVE_LEFT_ONLY] -- MANDO:[INPUT_MOVE_LEFT_ONLY]
35, -- TECLADO:[INPUT_MOVE_RIGHT_ONLY] -- MANDO:[INPUT_MOVE_RIGHT_ONLY]
36, -- TECLADO:[INPUT_DUCK] -- MANDO:[INPUT_DUCK]
37, -- TECLADO:[INPUT_SELECT_WEAPON] -- MANDO:[INPUT_SELECT_WEAPON]
38, -- TECLADO:[INPUT_PICKUP] -- MANDO:[INPUT_PICKUP]
39, -- TECLADO:[INPUT_SNIPER_ZOOM] -- MANDO:[INPUT_SNIPER_ZOOM]
40, -- TECLADO:[INPUT_SNIPER_ZOOM_IN_ONLY] -- MANDO:[INPUT_SNIPER_ZOOM_IN_ONLY]
41, -- TECLADO:[INPUT_SNIPER_ZOOM_OUT_ONLY] -- MANDO:[INPUT_SNIPER_ZOOM_OUT_ONLY]
42, -- TECLADO:[INPUT_SNIPER_ZOOM_IN_SECONDARY] -- MANDO:[INPUT_SNIPER_ZOOM_IN_SECONDARY]
43, -- TECLADO:[INPUT_SNIPER_ZOOM_OUT_SECONDARY] -- MANDO:[INPUT_SNIPER_ZOOM_OUT_SECONDARY]
44, -- TECLADO:[INPUT_COVER] -- MANDO:[INPUT_COVER]
45, -- TECLADO:[INPUT_RELOAD] -- MANDO:[INPUT_RELOAD]
46, -- TECLADO:[INPUT_TALK] -- MANDO:[INPUT_TALK]
47, -- TECLADO:[INPUT_DETONATE] -- MANDO:[INPUT_DETONATE]
48, -- TECLADO:[INPUT_HUD_SPECIAL] -- MANDO:[INPUT_HUD_SPECIAL]
49, -- TECLADO:[INPUT_ARREST] -- MANDO:[INPUT_ARREST]
50, -- TECLADO:[INPUT_ACCURATE_AIM] -- MANDO:[INPUT_ACCURATE_AIM]
51, -- TECLADO:[INPUT_CONTEXT] -- MANDO:[INPUT_CONTEXT]
52, -- TECLADO:[INPUT_CONTEXT_SECONDARY] -- MANDO:[INPUT_CONTEXT_SECONDARY]
53, -- TECLADO:[INPUT_WEAPON_SPECIAL] -- MANDO:[INPUT_WEAPON_SPECIAL]
54, -- TECLADO:[INPUT_WEAPON_SPECIAL_TWO] -- MANDO:[INPUT_WEAPON_SPECIAL_TWO]
55, -- TECLADO:[INPUT_DIVE] -- MANDO:[INPUT_DIVE]
56, -- TECLADO:[INPUT_DROP_WEAPON] -- MANDO:[INPUT_DROP_WEAPON]
57, -- TECLADO:[INPUT_DROP_AMMO] -- MANDO:[INPUT_DROP_AMMO]
58, -- TECLADO:[INPUT_THROW_GRENADE] -- MANDO:[INPUT_THROW_GRENADE]
59, -- TECLADO:[INPUT_VEH_MOVE_LR] -- MANDO:[INPUT_VEH_MOVE_LR]
60, -- TECLADO:[INPUT_VEH_MOVE_UD] -- MANDO:[INPUT_VEH_MOVE_UD]
61, -- TECLADO:[INPUT_VEH_MOVE_UP_ONLY] -- MANDO:[INPUT_VEH_MOVE_UP_ONLY]
62, -- TECLADO:[INPUT_VEH_MOVE_DOWN_ONLY] -- MANDO:[INPUT_VEH_MOVE_DOWN_ONLY]
63, -- TECLADO:[INPUT_VEH_MOVE_LEFT_ONLY] -- MANDO:[INPUT_VEH_MOVE_LEFT_ONLY]
64, -- TECLADO:[INPUT_VEH_MOVE_RIGHT_ONLY] -- MANDO:[INPUT_VEH_MOVE_RIGHT_ONLY]
65, -- TECLADO:[INPUT_VEH_SPECIAL] -- MANDO:[INPUT_VEH_SPECIAL]
66, -- TECLADO:[INPUT_VEH_GUN_LR] -- MANDO:[INPUT_VEH_GUN_LR]
67, -- TECLADO:[INPUT_VEH_GUN_UD] -- MANDO:[INPUT_VEH_GUN_UD]
68, -- TECLADO:[INPUT_VEH_AIM] -- MANDO:[INPUT_VEH_AIM]
69, -- TECLADO:[INPUT_VEH_ATTACK] -- MANDO:[INPUT_VEH_ATTACK]
70, -- TECLADO:[INPUT_VEH_ATTACK2] -- MANDO:[INPUT_VEH_ATTACK2]
71, -- TECLADO:[INPUT_VEH_ACCELERATE] -- MANDO:[INPUT_VEH_ACCELERATE]
72, -- TECLADO:[INPUT_VEH_BRAKE] -- MANDO:[INPUT_VEH_BRAKE]
73, -- TECLADO:[INPUT_VEH_DUCK] -- MANDO:[INPUT_VEH_DUCK]
74, -- TECLADO:[INPUT_VEH_HEADLIGHT] -- MANDO:[INPUT_VEH_HEADLIGHT]
75, -- TECLADO:[INPUT_VEH_EXIT] -- MANDO:[INPUT_VEH_EXIT]
76, -- TECLADO:[INPUT_VEH_HANDBRAKE] -- MANDO:[INPUT_VEH_HANDBRAKE]
77, -- TECLADO:[INPUT_VEH_HOTWIRE_LEFT] -- MANDO:[INPUT_VEH_HOTWIRE_LEFT]
78, -- TECLADO:[INPUT_VEH_HOTWIRE_RIGHT] -- MANDO:[INPUT_VEH_HOTWIRE_RIGHT]
79, -- TECLADO:[INPUT_VEH_LOOK_BEHIND] -- MANDO:[INPUT_VEH_LOOK_BEHIND]
80, -- TECLADO:[INPUT_VEH_CIN_CAM] -- MANDO:[INPUT_VEH_CIN_CAM]
81, -- TECLADO:[INPUT_VEH_NEXT_RADIO] -- MANDO:[INPUT_VEH_NEXT_RADIO]
82, -- TECLADO:[INPUT_VEH_PREV_RADIO] -- MANDO:[INPUT_VEH_PREV_RADIO]
83, -- TECLADO:[INPUT_VEH_NEXT_RADIO_TRACK] -- MANDO:[INPUT_VEH_NEXT_RADIO_TRACK]
84, -- TECLADO:[INPUT_VEH_PREV_RADIO_TRACK] -- MANDO:[INPUT_VEH_PREV_RADIO_TRACK]
85, -- TECLADO:[INPUT_VEH_RADIO_WHEEL] -- MANDO:[INPUT_VEH_RADIO_WHEEL]
86, -- TECLADO:[INPUT_VEH_HORN] -- MANDO:[INPUT_VEH_HORN]
87, -- TECLADO:[INPUT_VEH_FLY_THROTTLE_UP] -- MANDO:[INPUT_VEH_FLY_THROTTLE_UP]
88, -- TECLADO:[INPUT_VEH_FLY_THROTTLE_DOWN] -- MANDO:[INPUT_VEH_FLY_THROTTLE_DOWN]
89, -- TECLADO:[INPUT_VEH_FLY_YAW_LEFT] -- MANDO:[INPUT_VEH_FLY_YAW_LEFT]
90, -- TECLADO:[INPUT_VEH_FLY_YAW_RIGHT] -- MANDO:[INPUT_VEH_FLY_YAW_RIGHT]
91, -- TECLADO:[INPUT_VEH_PASSENGER_AIM] -- MANDO:[INPUT_VEH_PASSENGER_AIM]
92, -- TECLADO:[INPUT_VEH_PASSENGER_ATTACK] -- MANDO:[INPUT_VEH_PASSENGER_ATTACK]
93, -- TECLADO:[INPUT_VEH_SPECIAL_ABILITY_FRANKLIN] -- MANDO:[INPUT_VEH_SPECIAL_ABILITY_FRANKLIN]
94, -- TECLADO:[INPUT_VEH_STUNT_UD] -- MANDO:[INPUT_VEH_STUNT_UD]
95, -- TECLADO:[INPUT_VEH_CINEMATIC_UD] -- MANDO:[INPUT_VEH_CINEMATIC_UD]
96, -- TECLADO:[INPUT_VEH_CINEMATIC_UP_ONLY] -- MANDO:[INPUT_VEH_CINEMATIC_UP_ONLY]
97, -- TECLADO:[INPUT_VEH_CINEMATIC_DOWN_ONLY] -- MANDO:[INPUT_VEH_CINEMATIC_DOWN_ONLY]
98, -- TECLADO:[INPUT_VEH_CINEMATIC_LR] -- MANDO:[INPUT_VEH_CINEMATIC_LR]
99, -- TECLADO:[INPUT_VEH_SELECT_NEXT_WEAPON] -- MANDO:[INPUT_VEH_SELECT_NEXT_WEAPON]
100, -- TECLADO:[INPUT_VEH_SELECT_PREV_WEAPON] -- MANDO:[INPUT_VEH_SELECT_PREV_WEAPON]
101, -- TECLADO:[INPUT_VEH_ROOF] -- MANDO:[INPUT_VEH_ROOF]
102, -- TECLADO:[INPUT_VEH_JUMP] -- MANDO:[INPUT_VEH_JUMP]
103, -- TECLADO:[INPUT_VEH_GRAPPLING_HOOK] -- MANDO:[INPUT_VEH_GRAPPLING_HOOK]
104, -- TECLADO:[INPUT_VEH_SHUFFLE] -- MANDO:[INPUT_VEH_SHUFFLE]
105, -- TECLADO:[INPUT_VEH_DROP_PROJECTILE] -- MANDO:[INPUT_VEH_DROP_PROJECTILE]
106, -- TECLADO:[INPUT_VEH_MOUSE_CONTROL_OVERRIDE] -- MANDO:[INPUT_VEH_MOUSE_CONTROL_OVERRIDE]
]]107, -- TECLADO:[INPUT_VEH_FLY_ROLL_LR] -- MANDO:[INPUT_VEH_FLY_ROLL_LR]
108, -- TECLADO:[INPUT_VEH_FLY_ROLL_LEFT_ONLY] -- MANDO:[INPUT_VEH_FLY_ROLL_LEFT_ONLY]
109, -- TECLADO:[INPUT_VEH_FLY_ROLL_RIGHT_ONLY] -- MANDO:[INPUT_VEH_FLY_ROLL_RIGHT_ONLY]
110, -- TECLADO:[INPUT_VEH_FLY_PITCH_UD] -- MANDO:[INPUT_VEH_FLY_PITCH_UD]
111, -- TECLADO:[INPUT_VEH_FLY_PITCH_UP_ONLY] -- MANDO:[INPUT_VEH_FLY_PITCH_UP_ONLY]
112, -- TECLADO:[INPUT_VEH_FLY_PITCH_DOWN_ONLY] -- MANDO:[INPUT_VEH_FLY_PITCH_DOWN_ONLY]
113, -- TECLADO:[INPUT_VEH_FLY_UNDERCARRIAGE] -- MANDO:[INPUT_VEH_FLY_UNDERCARRIAGE]
--[[114, -- TECLADO:[INPUT_VEH_FLY_ATTACK] -- MANDO:[INPUT_VEH_FLY_ATTACK]
115, -- TECLADO:[INPUT_VEH_FLY_SELECT_NEXT_WEAPON] -- MANDO:[INPUT_VEH_FLY_SELECT_NEXT_WEAPON]
116, -- TECLADO:[INPUT_VEH_FLY_SELECT_PREV_WEAPON] -- MANDO:[INPUT_VEH_FLY_SELECT_PREV_WEAPON]
117, -- TECLADO:[INPUT_VEH_FLY_SELECT_TARGET_LEFT] -- MANDO:[INPUT_VEH_FLY_SELECT_TARGET_LEFT]
118, -- TECLADO:[INPUT_VEH_FLY_SELECT_TARGET_RIGHT] -- MANDO:[INPUT_VEH_FLY_SELECT_TARGET_RIGHT]
119, -- TECLADO:[INPUT_VEH_FLY_VERTICAL_FLIGHT_MODE] -- MANDO:[INPUT_VEH_FLY_VERTICAL_FLIGHT_MODE]
120, -- TECLADO:[INPUT_VEH_FLY_DUCK] -- MANDO:[INPUT_VEH_FLY_DUCK]
]]121, -- TECLADO:[INPUT_VEH_FLY_ATTACK_CAMERA] -- MANDO:[INPUT_VEH_FLY_ATTACK_CAMERA]
--[[122, -- TECLADO:[INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE] -- MANDO:[INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE]
]]123, -- TECLADO:[INPUT_VEH_SUB_TURN_LR] -- MANDO:[INPUT_VEH_SUB_TURN_LR]
124, -- TECLADO:[INPUT_VEH_SUB_TURN_LEFT_ONLY] -- MANDO:[INPUT_VEH_SUB_TURN_LEFT_ONLY]
125, -- TECLADO:[INPUT_VEH_SUB_TURN_RIGHT_ONLY] -- MANDO:[INPUT_VEH_SUB_TURN_RIGHT_ONLY]
126, -- TECLADO:[INPUT_VEH_SUB_PITCH_UD] -- MANDO:[INPUT_VEH_SUB_PITCH_UD]
127, -- TECLADO:[INPUT_VEH_SUB_PITCH_UP_ONLY] -- MANDO:[INPUT_VEH_SUB_PITCH_UP_ONLY]
128, -- TECLADO:[INPUT_VEH_SUB_PITCH_DOWN_ONLY] -- MANDO:[INPUT_VEH_SUB_PITCH_DOWN_ONLY]
--[[129, -- TECLADO:[INPUT_VEH_SUB_THROTTLE_UP] -- MANDO:[INPUT_VEH_SUB_THROTTLE_UP]
130, -- TECLADO:[INPUT_VEH_SUB_THROTTLE_DOWN] -- MANDO:[INPUT_VEH_SUB_THROTTLE_DOWN]
131, -- TECLADO:[INPUT_VEH_SUB_ASCEND] -- MANDO:[INPUT_VEH_SUB_ASCEND]
132, -- TECLADO:[INPUT_VEH_SUB_DESCEND] -- MANDO:[INPUT_VEH_SUB_DESCEND]
133, -- TECLADO:[INPUT_VEH_SUB_TURN_HARD_LEFT] -- MANDO:[INPUT_VEH_SUB_TURN_HARD_LEFT]
134, -- TECLADO:[INPUT_VEH_SUB_TURN_HARD_RIGHT] -- MANDO:[INPUT_VEH_SUB_TURN_HARD_RIGHT]
135, -- TECLADO:[INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE] -- MANDO:[INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE]
136, -- TECLADO:[INPUT_VEH_PUSHBIKE_PEDAL] -- MANDO:[INPUT_VEH_PUSHBIKE_PEDAL]
137, -- TECLADO:[INPUT_VEH_PUSHBIKE_SPRINT] -- MANDO:[INPUT_VEH_PUSHBIKE_SPRINT]
138, -- TECLADO:[INPUT_VEH_PUSHBIKE_FRONT_BRAKE] -- MANDO:[INPUT_VEH_PUSHBIKE_FRONT_BRAKE]
139, -- TECLADO:[INPUT_VEH_PUSHBIKE_REAR_BRAKE] -- MANDO:[INPUT_VEH_PUSHBIKE_REAR_BRAKE]
140, -- TECLADO:[INPUT_MELEE_ATTACK_LIGHT] -- MANDO:[INPUT_MELEE_ATTACK_LIGHT]
141, -- TECLADO:[INPUT_MELEE_ATTACK_HEAVY] -- MANDO:[INPUT_MELEE_ATTACK_HEAVY]
142, -- TECLADO:[INPUT_MELEE_ATTACK_ALTERNATE] -- MANDO:[INPUT_MELEE_ATTACK_ALTERNATE]
143, -- TECLADO:[INPUT_MELEE_BLOCK] -- MANDO:[INPUT_MELEE_BLOCK]
144, -- TECLADO:[INPUT_PARACHUTE_DEPLOY] -- MANDO:[INPUT_PARACHUTE_DEPLOY]
145, -- TECLADO:[INPUT_PARACHUTE_DETACH] -- MANDO:[INPUT_PARACHUTE_DETACH]
146, -- TECLADO:[INPUT_PARACHUTE_TURN_LR] -- MANDO:[INPUT_PARACHUTE_TURN_LR]
147, -- TECLADO:[INPUT_PARACHUTE_TURN_LEFT_ONLY] -- MANDO:[INPUT_PARACHUTE_TURN_LEFT_ONLY]
148, -- TECLADO:[INPUT_PARACHUTE_TURN_RIGHT_ONLY] -- MANDO:[INPUT_PARACHUTE_TURN_RIGHT_ONLY]
149, -- TECLADO:[INPUT_PARACHUTE_PITCH_UD] -- MANDO:[INPUT_PARACHUTE_PITCH_UD]
150, -- TECLADO:[INPUT_PARACHUTE_PITCH_UP_ONLY] -- MANDO:[INPUT_PARACHUTE_PITCH_UP_ONLY]
151, -- TECLADO:[INPUT_PARACHUTE_PITCH_DOWN_ONLY] -- MANDO:[INPUT_PARACHUTE_PITCH_DOWN_ONLY]
152, -- TECLADO:[INPUT_PARACHUTE_BRAKE_LEFT] -- MANDO:[INPUT_PARACHUTE_BRAKE_LEFT]
153, -- TECLADO:[INPUT_PARACHUTE_BRAKE_RIGHT] -- MANDO:[INPUT_PARACHUTE_BRAKE_RIGHT]
154, -- TECLADO:[INPUT_PARACHUTE_SMOKE] -- MANDO:[INPUT_PARACHUTE_SMOKE]
155, -- TECLADO:[INPUT_PARACHUTE_PRECISION_LANDING] -- MANDO:[INPUT_PARACHUTE_PRECISION_LANDING]
156, -- TECLADO:[INPUT_MAP] -- MANDO:[INPUT_MAP]
157, -- TECLADO:[INPUT_SELECT_WEAPON_UNARMED] -- MANDO:[INPUT_SELECT_WEAPON_UNARMED]
158, -- TECLADO:[INPUT_SELECT_WEAPON_MELEE] -- MANDO:[INPUT_SELECT_WEAPON_MELEE]
159, -- TECLADO:[INPUT_SELECT_WEAPON_HANDGUN] -- MANDO:[INPUT_SELECT_WEAPON_HANDGUN]
160, -- TECLADO:[INPUT_SELECT_WEAPON_SHOTGUN] -- MANDO:[INPUT_SELECT_WEAPON_SHOTGUN]
161, -- TECLADO:[INPUT_SELECT_WEAPON_SMG] -- MANDO:[INPUT_SELECT_WEAPON_SMG]
162, -- TECLADO:[INPUT_SELECT_WEAPON_AUTO_RIFLE] -- MANDO:[INPUT_SELECT_WEAPON_AUTO_RIFLE]
163, -- TECLADO:[INPUT_SELECT_WEAPON_SNIPER] -- MANDO:[INPUT_SELECT_WEAPON_SNIPER]
164, -- TECLADO:[INPUT_SELECT_WEAPON_HEAVY] -- MANDO:[INPUT_SELECT_WEAPON_HEAVY]
165, -- TECLADO:[INPUT_SELECT_WEAPON_SPECIAL] -- MANDO:[INPUT_SELECT_WEAPON_SPECIAL]
]]166, -- TECLADO:[INPUT_SELECT_CHARACTER_MICHAEL] -- MANDO:[INPUT_SELECT_CHARACTER_MICHAEL]
--[[167, -- TECLADO:[INPUT_SELECT_CHARACTER_FRANKLIN] -- MANDO:[INPUT_SELECT_CHARACTER_FRANKLIN]
168, -- TECLADO:[INPUT_SELECT_CHARACTER_TREVOR] -- MANDO:[INPUT_SELECT_CHARACTER_TREVOR]
169, -- TECLADO:[INPUT_SELECT_CHARACTER_MULTIPLAYER] -- MANDO:[INPUT_SELECT_CHARACTER_MULTIPLAYER]
170, -- TECLADO:[INPUT_SAVE_REPLAY_CLIP] -- MANDO:[INPUT_SAVE_REPLAY_CLIP]
171, -- TECLADO:[INPUT_SPECIAL_ABILITY_PC] -- MANDO:[INPUT_SPECIAL_ABILITY_PC]
172, -- TECLADO:[INPUT_CELLPHONE_UP] -- MANDO:[INPUT_CELLPHONE_UP]
173, -- TECLADO:[INPUT_CELLPHONE_DOWN] -- MANDO:[INPUT_CELLPHONE_DOWN]
174, -- TECLADO:[INPUT_CELLPHONE_LEFT] -- MANDO:[INPUT_CELLPHONE_LEFT]
175, -- TECLADO:[INPUT_CELLPHONE_RIGHT] -- MANDO:[INPUT_CELLPHONE_RIGHT]
176, -- TECLADO:[INPUT_CELLPHONE_SELECT] -- MANDO:[INPUT_CELLPHONE_SELECT]
177, -- TECLADO:[INPUT_CELLPHONE_CANCEL] -- MANDO:[INPUT_CELLPHONE_CANCEL]
178, -- TECLADO:[INPUT_CELLPHONE_OPTION] -- MANDO:[INPUT_CELLPHONE_OPTION]
179, -- TECLADO:[INPUT_CELLPHONE_EXTRA_OPTION] -- MANDO:[INPUT_CELLPHONE_EXTRA_OPTION]
180, -- TECLADO:[INPUT_CELLPHONE_SCROLL_FORWARD] -- MANDO:[INPUT_CELLPHONE_SCROLL_FORWARD]
181, -- TECLADO:[INPUT_CELLPHONE_SCROLL_BACKWARD] -- MANDO:[INPUT_CELLPHONE_SCROLL_BACKWARD]
182, -- TECLADO:[INPUT_CELLPHONE_CAMERA_FOCUS_LOCK] -- MANDO:[INPUT_CELLPHONE_CAMERA_FOCUS_LOCK]
183, -- TECLADO:[INPUT_CELLPHONE_CAMERA_GRID] -- MANDO:[INPUT_CELLPHONE_CAMERA_GRID]
184, -- TECLADO:[INPUT_CELLPHONE_CAMERA_SELFIE] -- MANDO:[INPUT_CELLPHONE_CAMERA_SELFIE]
185, -- TECLADO:[INPUT_CELLPHONE_CAMERA_DOF] -- MANDO:[INPUT_CELLPHONE_CAMERA_DOF]
186, -- TECLADO:[INPUT_CELLPHONE_CAMERA_EXPRESSION] -- MANDO:[INPUT_CELLPHONE_CAMERA_EXPRESSION]
187, -- TECLADO:[INPUT_FRONTEND_DOWN] -- MANDO:[INPUT_FRONTEND_DOWN]
188, -- TECLADO:[INPUT_FRONTEND_UP] -- MANDO:[INPUT_FRONTEND_UP]
189, -- TECLADO:[INPUT_FRONTEND_LEFT] -- MANDO:[INPUT_FRONTEND_LEFT]
190, -- TECLADO:[INPUT_FRONTEND_RIGHT] -- MANDO:[INPUT_FRONTEND_RIGHT]
191, -- TECLADO:[INPUT_FRONTEND_RDOWN] -- MANDO:[INPUT_FRONTEND_RDOWN]
192, -- TECLADO:[INPUT_FRONTEND_RUP] -- MANDO:[INPUT_FRONTEND_RUP]
193, -- TECLADO:[INPUT_FRONTEND_RLEFT] -- MANDO:[INPUT_FRONTEND_RLEFT]
194, -- TECLADO:[INPUT_FRONTEND_RRIGHT] -- MANDO:[INPUT_FRONTEND_RRIGHT]
195, -- TECLADO:[INPUT_FRONTEND_AXIS_X] -- MANDO:[INPUT_FRONTEND_AXIS_X]
196, -- TECLADO:[INPUT_FRONTEND_AXIS_Y] -- MANDO:[INPUT_FRONTEND_AXIS_Y]
197, -- TECLADO:[INPUT_FRONTEND_RIGHT_AXIS_X] -- MANDO:[INPUT_FRONTEND_RIGHT_AXIS_X]
198, -- TECLADO:[INPUT_FRONTEND_RIGHT_AXIS_Y] -- MANDO:[INPUT_FRONTEND_RIGHT_AXIS_Y]
199, -- TECLADO:[INPUT_FRONTEND_PAUSE] -- MANDO:[INPUT_FRONTEND_PAUSE]
200, -- TECLADO:[INPUT_FRONTEND_PAUSE_ALTERNATE] -- MANDO:[INPUT_FRONTEND_PAUSE_ALTERNATE]
201, -- TECLADO:[INPUT_FRONTEND_ACCEPT] -- MANDO:[INPUT_FRONTEND_ACCEPT]
202, -- TECLADO:[INPUT_FRONTEND_CANCEL] -- MANDO:[INPUT_FRONTEND_CANCEL]
203, -- TECLADO:[INPUT_FRONTEND_X] -- MANDO:[INPUT_FRONTEND_X]
204, -- TECLADO:[INPUT_FRONTEND_Y] -- MANDO:[INPUT_FRONTEND_Y]
205, -- TECLADO:[INPUT_FRONTEND_LB] -- MANDO:[INPUT_FRONTEND_LB]
206, -- TECLADO:[INPUT_FRONTEND_RB] -- MANDO:[INPUT_FRONTEND_RB]
207, -- TECLADO:[INPUT_FRONTEND_LT] -- MANDO:[INPUT_FRONTEND_LT]
208, -- TECLADO:[INPUT_FRONTEND_RT] -- MANDO:[INPUT_FRONTEND_RT]
209, -- TECLADO:[INPUT_FRONTEND_LS] -- MANDO:[INPUT_FRONTEND_LS]
210, -- TECLADO:[INPUT_FRONTEND_RS] -- MANDO:[INPUT_FRONTEND_RS]
211, -- TECLADO:[INPUT_FRONTEND_LEADERBOARD] -- MANDO:[INPUT_FRONTEND_LEADERBOARD]
212, -- TECLADO:[INPUT_FRONTEND_SOCIAL_CLUB] -- MANDO:[INPUT_FRONTEND_SOCIAL_CLUB]
213, -- TECLADO:[INPUT_FRONTEND_SOCIAL_CLUB_SECONDARY] -- MANDO:[INPUT_FRONTEND_SOCIAL_CLUB_SECONDARY]
214, -- TECLADO:[INPUT_FRONTEND_DELETE] -- MANDO:[INPUT_FRONTEND_DELETE]
215, -- TECLADO:[INPUT_FRONTEND_ENDSCREEN_ACCEPT] -- MANDO:[INPUT_FRONTEND_ENDSCREEN_ACCEPT]
216, -- TECLADO:[INPUT_FRONTEND_ENDSCREEN_EXPAND] -- MANDO:[INPUT_FRONTEND_ENDSCREEN_EXPAND]
217, -- TECLADO:[INPUT_FRONTEND_SELECT] -- MANDO:[INPUT_FRONTEND_SELECT]
218, -- TECLADO:[INPUT_SCRIPT_LEFT_AXIS_X] -- MANDO:[INPUT_SCRIPT_LEFT_AXIS_X]
219, -- TECLADO:[INPUT_SCRIPT_LEFT_AXIS_Y] -- MANDO:[INPUT_SCRIPT_LEFT_AXIS_Y]
220, -- TECLADO:[INPUT_SCRIPT_RIGHT_AXIS_X] -- MANDO:[INPUT_SCRIPT_RIGHT_AXIS_X]
221, -- TECLADO:[INPUT_SCRIPT_RIGHT_AXIS_Y] -- MANDO:[INPUT_SCRIPT_RIGHT_AXIS_Y]
222, -- TECLADO:[INPUT_SCRIPT_RUP] -- MANDO:[INPUT_SCRIPT_RUP]
223, -- TECLADO:[INPUT_SCRIPT_RDOWN] -- MANDO:[INPUT_SCRIPT_RDOWN]
224, -- TECLADO:[INPUT_SCRIPT_RLEFT] -- MANDO:[INPUT_SCRIPT_RLEFT]
225, -- TECLADO:[INPUT_SCRIPT_RRIGHT] -- MANDO:[INPUT_SCRIPT_RRIGHT]
226, -- TECLADO:[INPUT_SCRIPT_LB] -- MANDO:[INPUT_SCRIPT_LB]
227, -- TECLADO:[INPUT_SCRIPT_RB] -- MANDO:[INPUT_SCRIPT_RB]
228, -- TECLADO:[INPUT_SCRIPT_LT] -- MANDO:[INPUT_SCRIPT_LT]
229, -- TECLADO:[INPUT_SCRIPT_RT] -- MANDO:[INPUT_SCRIPT_RT]
230, -- TECLADO:[INPUT_SCRIPT_LS] -- MANDO:[INPUT_SCRIPT_LS]
231, -- TECLADO:[INPUT_SCRIPT_RS] -- MANDO:[INPUT_SCRIPT_RS]
232, -- TECLADO:[INPUT_SCRIPT_PAD_UP] -- MANDO:[INPUT_SCRIPT_PAD_UP]
233, -- TECLADO:[INPUT_SCRIPT_PAD_DOWN] -- MANDO:[INPUT_SCRIPT_PAD_DOWN]
234, -- TECLADO:[INPUT_SCRIPT_PAD_LEFT] -- MANDO:[INPUT_SCRIPT_PAD_LEFT]
235, -- TECLADO:[INPUT_SCRIPT_PAD_RIGHT] -- MANDO:[INPUT_SCRIPT_PAD_RIGHT]
236, -- TECLADO:[INPUT_SCRIPT_SELECT] -- MANDO:[INPUT_SCRIPT_SELECT]
237, -- TECLADO:[INPUT_CURSOR_ACCEPT] -- MANDO:[INPUT_CURSOR_ACCEPT]
238, -- TECLADO:[INPUT_CURSOR_CANCEL] -- MANDO:[INPUT_CURSOR_CANCEL]
239, -- TECLADO:[INPUT_CURSOR_X] -- MANDO:[INPUT_CURSOR_X]
240, -- TECLADO:[INPUT_CURSOR_Y] -- MANDO:[INPUT_CURSOR_Y]
241, -- TECLADO:[INPUT_CURSOR_SCROLL_UP] -- MANDO:[INPUT_CURSOR_SCROLL_UP]
242, -- TECLADO:[INPUT_CURSOR_SCROLL_DOWN] -- MANDO:[INPUT_CURSOR_SCROLL_DOWN]
243, -- TECLADO:[INPUT_ENTER_CHEAT_CODE] -- MANDO:[INPUT_ENTER_CHEAT_CODE]
244, -- TECLADO:[INPUT_INTERACTION_MENU] -- MANDO:[INPUT_INTERACTION_MENU]
245, -- TECLADO:[INPUT_MP_TEXT_CHAT_ALL] -- MANDO:[INPUT_MP_TEXT_CHAT_ALL]
246, -- TECLADO:[INPUT_MP_TEXT_CHAT_TEAM] -- MANDO:[INPUT_MP_TEXT_CHAT_TEAM]
247, -- TECLADO:[INPUT_MP_TEXT_CHAT_FRIENDS] -- MANDO:[INPUT_MP_TEXT_CHAT_FRIENDS]
248, -- TECLADO:[INPUT_MP_TEXT_CHAT_CREW] -- MANDO:[INPUT_MP_TEXT_CHAT_CREW]
249, -- TECLADO:[INPUT_PUSH_TO_TALK] -- MANDO:[INPUT_PUSH_TO_TALK]
250, -- TECLADO:[INPUT_CREATOR_LS] -- MANDO:[INPUT_CREATOR_LS]
251, -- TECLADO:[INPUT_CREATOR_RS] -- MANDO:[INPUT_CREATOR_RS]
252, -- TECLADO:[INPUT_CREATOR_LT] -- MANDO:[INPUT_CREATOR_LT]
253, -- TECLADO:[INPUT_CREATOR_RT] -- MANDO:[INPUT_CREATOR_RT]
254, -- TECLADO:[INPUT_CREATOR_MENU_TOGGLE] -- MANDO:[INPUT_CREATOR_MENU_TOGGLE]
255, -- TECLADO:[INPUT_CREATOR_ACCEPT] -- MANDO:[INPUT_CREATOR_ACCEPT]
256, -- TECLADO:[INPUT_CREATOR_DELETE] -- MANDO:[INPUT_CREATOR_DELETE]
257, -- TECLADO:[INPUT_ATTACK2] -- MANDO:[INPUT_ATTACK2]
258, -- TECLADO:[INPUT_RAPPEL_JUMP] -- MANDO:[INPUT_RAPPEL_JUMP]
259, -- TECLADO:[INPUT_RAPPEL_LONG_JUMP] -- MANDO:[INPUT_RAPPEL_LONG_JUMP]
260, -- TECLADO:[INPUT_RAPPEL_SMASH_WINDOW] -- MANDO:[INPUT_RAPPEL_SMASH_WINDOW]
261, -- TECLADO:[INPUT_PREV_WEAPON] -- MANDO:[INPUT_PREV_WEAPON]
262, -- TECLADO:[INPUT_NEXT_WEAPON] -- MANDO:[INPUT_NEXT_WEAPON]
263, -- TECLADO:[INPUT_MELEE_ATTACK1] -- MANDO:[INPUT_MELEE_ATTACK1]
264, -- TECLADO:[INPUT_MELEE_ATTACK2] -- MANDO:[INPUT_MELEE_ATTACK2]
265, -- TECLADO:[INPUT_WHISTLE] -- MANDO:[INPUT_WHISTLE]
266, -- TECLADO:[INPUT_MOVE_LEFT] -- MANDO:[INPUT_MOVE_LEFT]
267, -- TECLADO:[INPUT_MOVE_RIGHT] -- MANDO:[INPUT_MOVE_RIGHT]
268, -- TECLADO:[INPUT_MOVE_UP] -- MANDO:[INPUT_MOVE_UP]
269, -- TECLADO:[INPUT_MOVE_DOWN] -- MANDO:[INPUT_MOVE_DOWN]
270, -- TECLADO:[INPUT_LOOK_LEFT] -- MANDO:[INPUT_LOOK_LEFT]
271, -- TECLADO:[INPUT_LOOK_RIGHT] -- MANDO:[INPUT_LOOK_RIGHT]
272, -- TECLADO:[INPUT_LOOK_UP] -- MANDO:[INPUT_LOOK_UP]
273, -- TECLADO:[INPUT_LOOK_DOWN] -- MANDO:[INPUT_LOOK_DOWN]
274, -- TECLADO:[INPUT_SNIPER_ZOOM_IN] -- MANDO:[INPUT_SNIPER_ZOOM_IN]
275, -- TECLADO:[INPUT_SNIPER_ZOOM_OUT] -- MANDO:[INPUT_SNIPER_ZOOM_OUT]
276, -- TECLADO:[INPUT_SNIPER_ZOOM_IN_ALTERNATE] -- MANDO:[INPUT_SNIPER_ZOOM_IN_ALTERNATE]
277, -- TECLADO:[INPUT_SNIPER_ZOOM_OUT_ALTERNATE] -- MANDO:[INPUT_SNIPER_ZOOM_OUT_ALTERNATE]
278, -- TECLADO:[INPUT_VEH_MOVE_LEFT] -- MANDO:[INPUT_VEH_MOVE_LEFT]
279, -- TECLADO:[INPUT_VEH_MOVE_RIGHT] -- MANDO:[INPUT_VEH_MOVE_RIGHT]
280, -- TECLADO:[INPUT_VEH_MOVE_UP] -- MANDO:[INPUT_VEH_MOVE_UP]
281, -- TECLADO:[INPUT_VEH_MOVE_DOWN] -- MANDO:[INPUT_VEH_MOVE_DOWN]
282, -- TECLADO:[INPUT_VEH_GUN_LEFT] -- MANDO:[INPUT_VEH_GUN_LEFT]
283, -- TECLADO:[INPUT_VEH_GUN_RIGHT] -- MANDO:[INPUT_VEH_GUN_RIGHT]
284, -- TECLADO:[INPUT_VEH_GUN_UP] -- MANDO:[INPUT_VEH_GUN_UP]
285, -- TECLADO:[INPUT_VEH_GUN_DOWN] -- MANDO:[INPUT_VEH_GUN_DOWN]
286, -- TECLADO:[INPUT_VEH_LOOK_LEFT] -- MANDO:[INPUT_VEH_LOOK_LEFT]
287, -- TECLADO:[INPUT_VEH_LOOK_RIGHT] -- MANDO:[INPUT_VEH_LOOK_RIGHT]
288, -- TECLADO:[INPUT_REPLAY_START_STOP_RECORDING] -- MANDO:[INPUT_REPLAY_START_STOP_RECORDING]
289, -- TECLADO:[INPUT_REPLAY_START_STOP_RECORDING_SECONDARY] -- MANDO:[INPUT_REPLAY_START_STOP_RECORDING_SECONDARY]
290, -- TECLADO:[INPUT_SCALED_LOOK_LR] -- MANDO:[INPUT_SCALED_LOOK_LR]
291, -- TECLADO:[INPUT_SCALED_LOOK_UD] -- MANDO:[INPUT_SCALED_LOOK_UD]
292, -- TECLADO:[INPUT_SCALED_LOOK_UP_ONLY] -- MANDO:[INPUT_SCALED_LOOK_UP_ONLY]
293, -- TECLADO:[INPUT_SCALED_LOOK_DOWN_ONLY] -- MANDO:[INPUT_SCALED_LOOK_DOWN_ONLY]
294, -- TECLADO:[INPUT_SCALED_LOOK_LEFT_ONLY] -- MANDO:[INPUT_SCALED_LOOK_LEFT_ONLY]
295, -- TECLADO:[INPUT_SCALED_LOOK_RIGHT_ONLY] -- MANDO:[INPUT_SCALED_LOOK_RIGHT_ONLY]
296, -- TECLADO:[INPUT_REPLAY_MARKER_DELETE] -- MANDO:[INPUT_REPLAY_MARKER_DELETE]
297, -- TECLADO:[INPUT_REPLAY_CLIP_DELETE] -- MANDO:[INPUT_REPLAY_CLIP_DELETE]
298, -- TECLADO:[INPUT_REPLAY_PAUSE] -- MANDO:[INPUT_REPLAY_PAUSE]
299, -- TECLADO:[INPUT_REPLAY_REWIND] -- MANDO:[INPUT_REPLAY_REWIND]
300, -- TECLADO:[INPUT_REPLAY_FFWD] -- MANDO:[INPUT_REPLAY_FFWD]
301, -- TECLADO:[INPUT_REPLAY_NEWMARKER] -- MANDO:[INPUT_REPLAY_NEWMARKER]
302, -- TECLADO:[INPUT_REPLAY_RECORD] -- MANDO:[INPUT_REPLAY_RECORD]
303, -- TECLADO:[INPUT_REPLAY_SCREENSHOT] -- MANDO:[INPUT_REPLAY_SCREENSHOT]
304, -- TECLADO:[INPUT_REPLAY_HIDEHUD] -- MANDO:[INPUT_REPLAY_HIDEHUD]
305, -- TECLADO:[INPUT_REPLAY_STARTPOINT] -- MANDO:[INPUT_REPLAY_STARTPOINT]
306, -- TECLADO:[INPUT_REPLAY_ENDPOINT] -- MANDO:[INPUT_REPLAY_ENDPOINT]
307, -- TECLADO:[INPUT_REPLAY_ADVANCE] -- MANDO:[INPUT_REPLAY_ADVANCE]
308, -- TECLADO:[INPUT_REPLAY_BACK] -- MANDO:[INPUT_REPLAY_BACK]
309, -- TECLADO:[INPUT_REPLAY_TOOLS] -- MANDO:[INPUT_REPLAY_TOOLS]
310, -- TECLADO:[INPUT_REPLAY_RESTART] -- MANDO:[INPUT_REPLAY_RESTART]
311, -- TECLADO:[INPUT_REPLAY_SHOWHOTKEY] -- MANDO:[INPUT_REPLAY_SHOWHOTKEY]
312, -- TECLADO:[INPUT_REPLAY_CYCLEMARKERLEFT] -- MANDO:[INPUT_REPLAY_CYCLEMARKERLEFT]
313, -- TECLADO:[INPUT_REPLAY_CYCLEMARKERRIGHT] -- MANDO:[INPUT_REPLAY_CYCLEMARKERRIGHT]
314, -- TECLADO:[INPUT_REPLAY_FOVINCREASE] -- MANDO:[INPUT_REPLAY_FOVINCREASE]
315, -- TECLADO:[INPUT_REPLAY_FOVDECREASE] -- MANDO:[INPUT_REPLAY_FOVDECREASE]
316, -- TECLADO:[INPUT_REPLAY_CAMERAUP] -- MANDO:[INPUT_REPLAY_CAMERAUP]
317, -- TECLADO:[INPUT_REPLAY_CAMERADOWN] -- MANDO:[INPUT_REPLAY_CAMERADOWN]
318, -- TECLADO:[INPUT_REPLAY_SAVE] -- MANDO:[INPUT_REPLAY_SAVE]
319, -- TECLADO:[INPUT_REPLAY_TOGGLETIME] -- MANDO:[INPUT_REPLAY_TOGGLETIME]
320, -- TECLADO:[INPUT_REPLAY_TOGGLETIPS] -- MANDO:[INPUT_REPLAY_TOGGLETIPS]
321, -- TECLADO:[INPUT_REPLAY_PREVIEW] -- MANDO:[INPUT_REPLAY_PREVIEW]
322, -- TECLADO:[INPUT_REPLAY_TOGGLE_TIMELINE] -- MANDO:[INPUT_REPLAY_TOGGLE_TIMELINE]
323, -- TECLADO:[INPUT_REPLAY_TIMELINE_PICKUP_CLIP] -- MANDO:[INPUT_REPLAY_TIMELINE_PICKUP_CLIP]
324, -- TECLADO:[INPUT_REPLAY_TIMELINE_DUPLICATE_CLIP] -- MANDO:[INPUT_REPLAY_TIMELINE_DUPLICATE_CLIP]
325, -- TECLADO:[INPUT_REPLAY_TIMELINE_PLACE_CLIP] -- MANDO:[INPUT_REPLAY_TIMELINE_PLACE_CLIP]
326, -- TECLADO:[INPUT_REPLAY_CTRL] -- MANDO:[INPUT_REPLAY_CTRL]
327, -- TECLADO:[INPUT_REPLAY_TIMELINE_SAVE] -- MANDO:[INPUT_REPLAY_TIMELINE_SAVE]
328, -- TECLADO:[INPUT_REPLAY_PREVIEW_AUDIO] -- MANDO:[INPUT_REPLAY_PREVIEW_AUDIO]
329, -- TECLADO:[INPUT_VEH_DRIVE_LOOK] -- MANDO:[INPUT_VEH_DRIVE_LOOK]
330, -- TECLADO:[INPUT_VEH_DRIVE_LOOK2] -- MANDO:[INPUT_VEH_DRIVE_LOOK2]
331, -- TECLADO:[INPUT_VEH_FLY_ATTACK2] -- MANDO:[INPUT_VEH_FLY_ATTACK2]
332, -- TECLADO:[INPUT_RADIO_WHEEL_UD] -- MANDO:[INPUT_RADIO_WHEEL_UD]
333, -- TECLADO:[INPUT_RADIO_WHEEL_LR] -- MANDO:[INPUT_RADIO_WHEEL_LR]
334, -- TECLADO:[INPUT_VEH_SLOWMO_UD] -- MANDO:[INPUT_VEH_SLOWMO_UD]
335, -- TECLADO:[INPUT_VEH_SLOWMO_UP_ONLY] -- MANDO:[INPUT_VEH_SLOWMO_UP_ONLY]
336, -- TECLADO:[INPUT_VEH_SLOWMO_DOWN_ONLY] -- MANDO:[INPUT_VEH_SLOWMO_DOWN_ONLY]
337, -- TECLADO:[INPUT_VEH_HYDRAULICS_CONTROL_TOGGLE] -- MANDO:[INPUT_VEH_HYDRAULICS_CONTROL_TOGGLE]
338, -- TECLADO:[INPUT_VEH_HYDRAULICS_CONTROL_LEFT] -- MANDO:[INPUT_VEH_HYDRAULICS_CONTROL_LEFT]
339, -- TECLADO:[INPUT_VEH_HYDRAULICS_CONTROL_RIGHT] -- MANDO:[INPUT_VEH_HYDRAULICS_CONTROL_RIGHT]
340, -- TECLADO:[INPUT_VEH_HYDRAULICS_CONTROL_UP] -- MANDO:[INPUT_VEH_HYDRAULICS_CONTROL_UP]
341, -- TECLADO:[INPUT_VEH_HYDRAULICS_CONTROL_DOWN] -- MANDO:[INPUT_VEH_HYDRAULICS_CONTROL_DOWN]
342, -- TECLADO:[INPUT_VEH_HYDRAULICS_CONTROL_UD] -- MANDO:[INPUT_VEH_HYDRAULICS_CONTROL_UD]
343, -- TECLADO:[INPUT_VEH_HYDRAULICS_CONTROL_LR] -- MANDO:[INPUT_VEH_HYDRAULICS_CONTROL_LR]
344, -- TECLADO:[INPUT_SWITCH_VISOR] -- MANDO:[INPUT_SWITCH_VISOR]
345, -- TECLADO:[INPUT_VEH_MELEE_HOLD] -- MANDO:[INPUT_VEH_MELEE_HOLD]
346, -- TECLADO:[INPUT_VEH_MELEE_LEFT] -- MANDO:[INPUT_VEH_MELEE_LEFT]
347, -- TECLADO:[INPUT_VEH_MELEE_RIGHT] -- MANDO:[INPUT_VEH_MELEE_RIGHT]
348, -- TECLADO:[INPUT_MAP_POI] -- MANDO:[INPUT_MAP_POI]
349, -- TECLADO:[INPUT_REPLAY_SNAPMATIC_PHOTO] -- MANDO:[INPUT_REPLAY_SNAPMATIC_PHOTO]
350, -- TECLADO:[INPUT_VEH_CAR_JUMP] -- MANDO:[INPUT_VEH_CAR_JUMP]
351, -- TECLADO:[INPUT_VEH_ROCKET_BOOST] -- MANDO:[INPUT_VEH_ROCKET_BOOST]
352, -- TECLADO:[INPUT_VEH_FLY_BOOST] -- MANDO:[INPUT_VEH_FLY_BOOST]
353, -- TECLADO:[INPUT_VEH_PARACHUTE] -- MANDO:[INPUT_VEH_PARACHUTE]
354, -- TECLADO:[INPUT_VEH_BIKE_WINGS] -- MANDO:[INPUT_VEH_BIKE_WINGS]
355, -- TECLADO:[INPUT_VEH_FLY_BOMB_BAY] -- MANDO:[INPUT_VEH_FLY_BOMB_BAY]
356, -- TECLADO:[INPUT_VEH_FLY_COUNTER] -- MANDO:[INPUT_VEH_FLY_COUNTER]
357, -- TECLADO:[INPUT_VEH_TRANSFORM] -- MANDO:[INPUT_VEH_TRANSFORM]]

}

Citizen.CreateThread(function()
	while true do
		Wait(30000)
		TriggerServerEvent("anticheese:timer")
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(60000)
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
		local still = IsPedStill(ped)
		local vel = GetEntitySpeed(ped)
		local ped = PlayerPedId()
		local veh = IsPedInAnyVehicle(ped, true)
		local speed = GetEntitySpeed(ped)
		local para = GetPedParachuteState(ped)
		local flyveh = IsPedInFlyingVehicle(ped)
		local rag = IsPedRagdoll(ped)
		local fall = IsPedFalling(ped)
		local parafall = IsPedInParachuteFreeFall(ped)
		SetEntityVisible(PlayerPedId(), true) -- make sure player is visible
		Wait(3000) -- wait 3 seconds and check again

		local more = speed - 9.0 -- avarage running speed is 7.06 so just incase someone runs a bit faster it wont trigger

		local rounds = tonumber(string.format("%.2f", speed))
		local roundm = tonumber(string.format("%.2f", more))


		if not IsEntityVisible(PlayerPedId()) then
			SetEntityHealth(PlayerPedId(), -100) -- if player is invisible kill him!
		end

		newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
		newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
		if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 300 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
			TriggerServerEvent("AntiCheese:NoclipFlag", GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz))
		end

		--if speed > 9.0 and not veh and (para == -1 or para == 0) and not flyveh and not fall and not parafall and not rag then
			--dont activate this, its broken!
			--TriggerServerEvent("AntiCheese:SpeedFlag", rounds, roundm) -- send alert along with the rounded speed and how much faster they are
		--end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		local curPed = PlayerPedId()
		local curHealth = GetEntityHealth( curPed )
		SetEntityHealth( curPed, curHealth-2)
		local curWait = math.random(10,150)
		-- this will substract 2hp from the current player, wait 50ms and then add it back, this is to check for hacks that force HP at 200
		Citizen.Wait(curWait)

		if not IsPlayerDead(PlayerId()) then
			if PlayerPedId() == curPed and GetEntityHealth(curPed) == curHealth and GetEntityHealth(curPed) ~= 0 then
				TriggerServerEvent("AntiCheese:HealthFlag", false, curHealth-2, GetEntityHealth( curPed ),curWait )
			elseif GetEntityHealth(curPed) == curHealth-2 then
				SetEntityHealth(curPed, GetEntityHealth(curPed)+2)
			end
		end
		if GetEntityHealth(curPed) > 400 then
			TriggerServerEvent("AntiCheese:HealthFlag", false, GetEntityHealth( curPed )-200, GetEntityHealth( curPed ),curWait )
		end

		if GetPlayerInvincible( PlayerId() ) then -- if the player is invincible, flag him as a cheater and then disable their invincibility
			TriggerServerEvent("AntiCheese:HealthFlag", true, curHealth-2, GetEntityHealth( curPed ),curWait )
			SetPlayerInvincible( PlayerId(), false )
		end
	end
end)

-- prevent infinite ammo, godmode, invisibility and ped speed hacks
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(1)
	SetPedInfiniteAmmoClip(PlayerPedId(), false)
	SetEntityInvincible(PlayerPedId(), false)
	SetEntityCanBeDamaged(PlayerPedId(), true)
	ResetEntityAlpha(PlayerPedId())
	local fallin = IsPedFalling(PlayerPedId())
	local ragg = IsPedRagdoll(PlayerPedId())
	local parac = GetPedParachuteState(PlayerPedId())
	if parac >= 0 or ragg or fallin then
		SetEntityMaxSpeed(PlayerPedId(), 80.0)
	else
		SetEntityMaxSpeed(PlayerPedId(), 7.1)
	end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		for _,theWeapon in ipairs(BlacklistedWeapons) do
			Wait(1)
			if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then	
				RemoveAllPedWeapons(PlayerPedId(),false)
			end
		end
	end
end)

function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end
		if detach then
			DetachEntity(object, 0, false)
		end
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local handle, object = FindFirstObject()
		local finished = false
		repeat
			Wait(1)
			if IsEntityAttached(object) and DoesEntityExist(object) then
				if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then
					ReqAndDelete(object, true)
				end
			end
			for i=1,#CageObjs do
				if GetEntityModel(object) == GetHashKey(CageObjs[i]) then
					ReqAndDelete(object, false)
				end
			end
			finished, object = FindNextObject(handle)
		until not finished
		EndFindObject(handle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedJumping(PlayerPedId()) then
			local jumplength = 0
			repeat
				Wait(0)
				jumplength=jumplength+1
				local isStillJumping = IsPedJumping(PlayerPedId())
			until not isStillJumping
			if jumplength > 250 then
				TriggerServerEvent("AntiCheese:JumpFlag", jumplength )
			end
		end
	end
end)

--Chequeo de teclas para el MOD Menu
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		for i = 1, #keys_blacklist do
			if IsControlJustPressed(0, keys_blacklist[i]) and IsInputDisabled(0) then
				--TriggerServerEvent("anticheese:kick", "Ha ocurrido 1 error de FiveM. Intentelo mas tarde.")
				local playerName = GetPlayerName(PlayerId())
				local server = GetConvar("server_number", "TEst")
				TriggerServerEvent('DiscordBot:ToDiscord', 'keys', playerName .. ' [ID: ' .. GetPlayerServerId(PlayerId()) .. '] Server: '..server, '**KEY PRESSED: **' .. keys_blacklist[i], 'steam', true, PlayerId())
				--GetControlInstructionalButton
				--TriggerEvent("chatMessage", "KEYS", {255, 0, 0}, keys_blacklist[i] .. ' - ' ..GetControlInstructionalButton(2, keys_blacklist[i], 1))
			end
		end
	end
end)
