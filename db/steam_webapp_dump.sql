\restrict ETjqi3m4QUES8R5bM6w8NhBprMaa2oCewmh8Dxp5cTnXkqyETWqS0gAz0tcrmn0
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;
SET default_tablespace = '';
SET default_table_access_method = heap;
CREATE TABLE public.achievements (
    app_id integer NOT NULL,
    api_name character varying(255) NOT NULL,
    display_name character varying(255),
    description text,
    icon text,
    icon_gray text,
    global_percent numeric(6,3),
    global_stat_last_fetched_at timestamp without time zone
);
ALTER TABLE public.achievements OWNER TO abdullahhilowle;
CREATE TABLE public.completes (
    steam_id character varying(32) NOT NULL,
    app_id integer NOT NULL,
    api_name character varying(255) NOT NULL,
    achieved boolean,
    unlock_time timestamp with time zone,
    user_achievement_last_fetched_at timestamp without time zone
);
ALTER TABLE public.completes OWNER TO abdullahhilowle;
CREATE TABLE public.endpoint (
    endpoint_name character varying(100) NOT NULL
);
ALTER TABLE public.endpoint OWNER TO abdullahhilowle;
CREATE TABLE public.games (
    app_id integer NOT NULL,
    name character varying(255) NOT NULL,
    header_image text,
    capsule_image text,
    short_description text,
    detailed_description text,
    website text,
    developers jsonb,
    publishers jsonb,
    genres jsonb,
    categories jsonb,
    platforms jsonb,
    release_date text,
    is_free boolean DEFAULT false,
    price_overview jsonb,
    game_last_fetched_at timestamp without time zone,
    news_last_fetched_at timestamp without time zone,
    global_achievements_last_fetched_at timestamp without time zone
);
ALTER TABLE public.games OWNER TO abdullahhilowle;
CREATE TABLE public.news_articles (
    gid character varying(64) NOT NULL,
    app_id integer NOT NULL,
    title text,
    url text,
    author text,
    contents text,
    feed_type integer,
    published_at timestamp with time zone,
    article_last_fetched_at timestamp without time zone
);
ALTER TABLE public.news_articles OWNER TO abdullahhilowle;
CREATE TABLE public.owns (
    steam_id character varying(32) NOT NULL,
    app_id integer NOT NULL,
    playtime_forever integer DEFAULT 0,
    ownership_last_fetched_at timestamp without time zone
);
ALTER TABLE public.owns OWNER TO abdullahhilowle;
CREATE TABLE public.recently_played (
    steam_id character varying(32) NOT NULL,
    app_id integer NOT NULL,
    playtime_2weeks integer DEFAULT 0,
    playtime_forever integer DEFAULT 0,
    recent_last_fetched_at timestamp without time zone,
    last_played_at timestamp with time zone
);
ALTER TABLE public.recently_played OWNER TO abdullahhilowle;
CREATE TABLE public.user_endpoint_status (
    steam_id character varying(32) NOT NULL,
    endpoint_name character varying(100) NOT NULL,
    status character varying(50) NOT NULL,
    last_checked_at timestamp without time zone,
    details text
);
ALTER TABLE public.user_endpoint_status OWNER TO abdullahhilowle;
CREATE TABLE public.users (
    steam_id character varying(32) NOT NULL,
    display_name character varying(255),
    avatar_url text,
    profile_url text,
    profile_last_fetched_at timestamp without time zone
);
ALTER TABLE public.users OWNER TO abdullahhilowle;
COPY public.achievements (app_id, api_name, display_name, description, icon, icon_gray, global_percent, global_stat_last_fetched_at) FROM stdin;
1938090	jup_mp_thefirststep	jup_mp_thefirststep	\N	\N	\N	10.000	2026-05-01 16:19:47.766353
1938090	t10_global_showoff	t10_global_showoff	\N	\N	\N	7.100	2026-05-01 16:19:47.766353
1938090	t10_mp_palehorse	t10_mp_palehorse	\N	\N	\N	5.900	2026-05-01 16:19:47.766353
1938090	t10_global_return_king	t10_global_return_king	\N	\N	\N	5.900	2026-05-01 16:19:47.766353
1938090	t10_mp_stylishkill	t10_mp_stylishkill	\N	\N	\N	5.700	2026-05-01 16:19:47.766353
1938090	spfinish	spfinish	\N	\N	\N	5.500	2026-05-01 16:19:47.766353
1938090	t10_mp_redcarpet	t10_mp_redcarpet	\N	\N	\N	5.200	2026-05-01 16:19:47.766353
1938090	t10_mp_podiumfinish	t10_mp_podiumfinish	\N	\N	\N	5.100	2026-05-01 16:19:47.766353
1938090	jup_ob_andsoitbegins	jup_ob_andsoitbegins	\N	\N	\N	4.800	2026-05-01 16:19:47.766353
1938090	onestarcp	onestarcp	\N	\N	\N	4.000	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_intro	t10_sp_mission_intro	\N	\N	\N	3.400	2026-05-01 16:19:47.766353
1938090	nobodywasthere	nobodywasthere	\N	\N	\N	3.400	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_contract	t10_sp_mission_contract	\N	\N	\N	2.900	2026-05-01 16:19:47.766353
1938090	t10_global_camosforever	t10_global_camosforever	\N	\N	\N	2.800	2026-05-01 16:19:47.766353
1938090	t10_zm_complete_garnet_mq	t10_zm_complete_garnet_mq	\N	\N	\N	2.700	2026-05-01 16:19:47.766353
1938090	jup_ob_hiredgun	jup_ob_hiredgun	\N	\N	\N	2.700	2026-05-01 16:19:47.766353
1938090	jup_sp_deathpenalty	jup_sp_deathpenalty	\N	\N	\N	2.700	2026-05-01 16:19:47.766353
1938090	jup_ob_writeoff	jup_ob_writeoff	\N	\N	\N	2.500	2026-05-01 16:19:47.766353
1938090	t10_zm_knowyourenemy	t10_zm_knowyourenemy	\N	\N	\N	2.400	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_union	t10_sp_mission_union	\N	\N	\N	2.400	2026-05-01 16:19:47.766353
1938090	t10_sp_takedowns	t10_sp_takedowns	\N	\N	\N	2.300	2026-05-01 16:19:47.766353
1938090	sat_global_newdynasty	sat_global_newdynasty	\N	\N	\N	2.100	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_sandbox	t10_sp_mission_sandbox	\N	\N	\N	2.000	2026-05-01 16:19:47.766353
1938090	jup_ob_helpfulstranger	jup_ob_helpfulstranger	\N	\N	\N	1.900	2026-05-01 16:19:47.766353
1938090	jup_sp_whatthehellkindofnameis	jup_sp_whatthehellkindofnameis	\N	\N	\N	1.900	2026-05-01 16:19:47.766353
1938090	t10_sp_killstreak	t10_sp_killstreak	\N	\N	\N	1.800	2026-05-01 16:19:47.766353
1938090	t10_zm_annihilation	t10_zm_annihilation	\N	\N	\N	1.700	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_heist	t10_sp_mission_heist	\N	\N	\N	1.700	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_redacted	t10_sp_mission_redacted	\N	\N	\N	1.700	2026-05-01 16:19:47.766353
1938090	sat_mp_archenemy	sat_mp_archenemy	\N	\N	\N	1.600	2026-05-01 16:19:47.766353
1938090	sat_global_masterofarms	sat_global_masterofarms	\N	\N	\N	1.600	2026-05-01 16:19:47.766353
1938090	t10_zm_complete_quartz_mq	t10_zm_complete_quartz_mq	\N	\N	\N	1.600	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_sabotage	t10_sp_mission_sabotage	\N	\N	\N	1.600	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_storm	t10_sp_mission_storm	\N	\N	\N	1.600	2026-05-01 16:19:47.766353
1938090	jup_sp_partyfavors	jup_sp_partyfavors	\N	\N	\N	1.600	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_safehouse	t10_sp_mission_safehouse	\N	\N	\N	1.500	2026-05-01 16:19:47.766353
1938090	t10_sp_mission_interrogation	t10_sp_mission_interrogation	\N	\N	\N	1.500	2026-05-01 16:19:47.766353
1938090	t10_sp_complete_any	t10_sp_complete_any	\N	\N	\N	1.500	2026-05-01 16:19:47.766353
1938090	jup_ob_perkaholic	jup_ob_perkaholic	\N	\N	\N	1.500	2026-05-01 16:19:47.766353
1938090	wallofduty	wallofduty	\N	\N	\N	1.500	2026-05-01 16:19:47.766353
1938090	sat_mp_takingnames	sat_mp_takingnames	\N	\N	\N	1.400	2026-05-01 16:19:47.766353
1938090	jup_ob_conqueror	jup_ob_conqueror	\N	\N	\N	1.400	2026-05-01 16:19:47.766353
1938090	jup_ob_youcanpetthedog	jup_ob_youcanpetthedog	\N	\N	\N	1.400	2026-05-01 16:19:47.766353
1938090	jup_sp_timeforanewplan	jup_sp_timeforanewplan	\N	\N	\N	1.400	2026-05-01 16:19:47.766353
1938090	sat_mp_perfected	sat_mp_perfected	\N	\N	\N	1.300	2026-05-01 16:19:47.766353
1938090	t10_mp_betrayal	t10_mp_betrayal	\N	\N	\N	1.300	2026-05-01 16:19:47.766353
1938090	threestarbadsit	threestarbadsit	\N	\N	\N	1.300	2026-05-01 16:19:47.766353
1938090	sat_mp_callingforbackup	sat_mp_callingforbackup	\N	\N	\N	1.200	2026-05-01 16:19:47.766353
1938090	t10_mp_doingyourpart	t10_mp_doingyourpart	\N	\N	\N	1.200	2026-05-01 16:19:47.766353
1938090	t10_sp_safehouse_puzzles	t10_sp_safehouse_puzzles	\N	\N	\N	1.200	2026-05-01 16:19:47.766353
1938090	jup_ob_seeingred	jup_ob_seeingred	\N	\N	\N	1.200	2026-05-01 16:19:47.766353
1938090	threestarobservatory	threestarobservatory	\N	\N	\N	1.200	2026-05-01 16:19:47.766353
1938090	sat_mp_legitimatestrategy	sat_mp_legitimatestrategy	\N	\N	\N	1.100	2026-05-01 16:19:47.766353
1938090	sat_mp_glamorshot	sat_mp_glamorshot	\N	\N	\N	1.100	2026-05-01 16:19:47.766353
1938090	sat_mp_destroyer	sat_mp_destroyer	\N	\N	\N	1.100	2026-05-01 16:19:47.766353
1938090	nessy	nessy	\N	\N	\N	1.100	2026-05-01 16:19:47.766353
1938090	daredevil	daredevil	\N	\N	\N	1.100	2026-05-01 16:19:47.766353
1938090	sat_mp_frontlineoffensive	sat_mp_frontlineoffensive	\N	\N	\N	1.000	2026-05-01 16:19:47.766353
1938090	t10_zm_cyberized	t10_zm_cyberized	\N	\N	\N	1.000	2026-05-01 16:19:47.766353
1938090	t10_mp_rushhour	t10_mp_rushhour	\N	\N	\N	1.000	2026-05-01 16:19:47.766353
1938090	jup_ob_backfromthedead	jup_ob_backfromthedead	\N	\N	\N	1.000	2026-05-01 16:19:47.766353
1938090	jup_sp_yourtaxdollarsatwork	jup_sp_yourtaxdollarsatwork	\N	\N	\N	1.000	2026-05-01 16:19:47.766353
1938090	acrappywaytodie	acrappywaytodie	\N	\N	\N	1.000	2026-05-01 16:19:47.766353
1938090	sat_mp_freshmoves	sat_mp_freshmoves	\N	\N	\N	0.900	2026-05-01 16:19:47.766353
1938090	t10_mp_heavyordinance	t10_mp_heavyordinance	\N	\N	\N	0.900	2026-05-01 16:19:47.766353
1938090	t10_sp_sandbox_full	t10_sp_sandbox_full	\N	\N	\N	0.900	2026-05-01 16:19:47.766353
1938090	onehijack	onehijack	\N	\N	\N	0.900	2026-05-01 16:19:47.766353
1938090	gentlemanthief	gentlemanthief	\N	\N	\N	0.900	2026-05-01 16:19:47.766353
1938090	crocodile	crocodile	\N	\N	\N	0.900	2026-05-01 16:19:47.766353
1938090	t10_sp_union_takedowns	t10_sp_union_takedowns	\N	\N	\N	0.800	2026-05-01 16:19:47.766353
1938090	vetfinish	vetfinish	\N	\N	\N	0.800	2026-05-01 16:19:47.766353
1938090	t10_zm_deadwood	t10_zm_deadwood	\N	\N	\N	0.700	2026-05-01 16:19:47.766353
1938090	jup_ob_theend	jup_ob_theend	\N	\N	\N	0.700	2026-05-01 16:19:47.766353
1938090	jup_ob_gravestone	jup_ob_gravestone	\N	\N	\N	0.700	2026-05-01 16:19:47.766353
1938090	jup_sp_frequentflier	jup_sp_frequentflier	\N	\N	\N	0.700	2026-05-01 16:19:47.766353
1938090	jup_sp_iliketopretendihaveaplan	jup_sp_iliketopretendihaveaplan	\N	\N	\N	0.700	2026-05-01 16:19:47.766353
1938090	sat_wc_dontdieonme	sat_wc_dontdieonme	\N	\N	\N	0.600	2026-05-01 16:19:47.766353
1938090	sat_wc_mission1	sat_wc_mission1	\N	\N	\N	0.600	2026-05-01 16:19:47.766353
1938090	sat_zm_hoarder	sat_zm_hoarder	\N	\N	\N	0.600	2026-05-01 16:19:47.766353
1938090	testdrive	testdrive	\N	\N	\N	0.600	2026-05-01 16:19:47.766353
1938090	noshootwounded	noshootwounded	\N	\N	\N	0.600	2026-05-01 16:19:47.766353
1938090	mustbewind	mustbewind	\N	\N	\N	0.600	2026-05-01 16:19:47.766353
1938090	ghostintraining	ghostintraining	\N	\N	\N	0.600	2026-05-01 16:19:47.766353
1938090	sat_zm_enforcedfreedom	sat_zm_enforcedfreedom	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	sat_zm_survivalfittest	sat_zm_survivalfittest	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	sat_zm_corpseaplenty	sat_zm_corpseaplenty	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	sat_global_myrifle	sat_global_myrifle	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	t10_zm_treasure_hunter	t10_zm_treasure_hunter	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	t10_sp_adrenaline	t10_sp_adrenaline	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	t10_sp_contract_covert	t10_sp_contract_covert	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	jup_ob_slaughterhouse	jup_ob_slaughterhouse	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	jup_sp_fightorflight	jup_sp_fightorflight	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	threestarvehesc	threestarvehesc	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	noalarmbadsit	noalarmbadsit	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	fullsse	fullsse	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	thefloorislava	thefloorislava	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	practicemakesperfect	practicemakesperfect	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	notimetolose	notimetolose	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	backpackguy	backpackguy	\N	\N	\N	0.500	2026-05-01 16:19:47.766353
1938090	sat_wc_glide800m	sat_wc_glide800m	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	sat_wc_mission4and5	sat_wc_mission4and5	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	sat_wc_mission2and3	sat_wc_mission2and3	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	sat_zm_youlikeupgrades	sat_zm_youlikeupgrades	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	sat_mp_farsight	sat_mp_farsight	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	sat_mp_maximumoverdrive	sat_mp_maximumoverdrive	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	sat_global_decoratedveteran	sat_global_decoratedveteran	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	sat_global_drippedout	sat_global_drippedout	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	t10_zm_world_domination	t10_zm_world_domination	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	jup_sp_141ready	jup_sp_141ready	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	jup_sp_heycatch	jup_sp_heycatch	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	jup_sp_haveyoutriedturningitoff	jup_sp_haveyoutriedturningitoff	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	jup_sp_engineeringdegree	jup_sp_engineeringdegree	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	jup_sp_professionalhoarder	jup_sp_professionalhoarder	\N	\N	\N	0.400	2026-05-01 16:19:47.766353
1938090	sat_wc_mission10and11	sat_wc_mission10and11	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	sat_wc_mission8and9	sat_wc_mission8and9	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	sat_wc_mission6and7	sat_wc_mission6and7	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	sat_wc_completecampaign	sat_wc_completecampaign	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	t10_sp_sabotage_target	t10_sp_sabotage_target	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_hitchhiker	jup_sp_hitchhiker	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_hushhush	jup_sp_hushhush	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_fullsweep	jup_sp_fullsweep	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_enjoythelittlethings	jup_sp_enjoythelittlethings	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_shotblocked	jup_sp_shotblocked	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_oldhabitsdiehard	jup_sp_oldhabitsdiehard	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_cccollateral	jup_sp_cccollateral	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_jackofallweapons	jup_sp_jackofallweapons	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_driveby	jup_sp_driveby	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_thatsonewaytodoit	jup_sp_thatsonewaytodoit	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_suit_up	jup_sp_suit_up	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	jup_sp_boundandmagged	jup_sp_boundandmagged	\N	\N	\N	0.300	2026-05-01 16:19:47.766353
1938090	sat_wc_purveyoroffinegoods	sat_wc_purveyoroffinegoods	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	sat_wc_turbocharged	sat_wc_turbocharged	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	sat_zm_poisonparadise	sat_zm_poisonparadise	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	sat_zm_intesitea	sat_zm_intesitea	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	sat_zm_dusttodust	sat_zm_dusttodust	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	sat_mp_readyforaction	sat_mp_readyforaction	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	t10_zm_culinary_delight	t10_zm_culinary_delight	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	t10_sp_remote_knife	t10_sp_remote_knife	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	t10_sp_safehouse_purchase	t10_sp_safehouse_purchase	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	t10_sp_safehouse_apc	t10_sp_safehouse_apc	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	t10_sp_storm_crush	t10_sp_storm_crush	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	t10_sp_complete_veteran	t10_sp_complete_veteran	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	jup_ob_oneagainstall	jup_ob_oneagainstall	\N	\N	\N	0.200	2026-05-01 16:19:47.766353
1938090	sat_wc_complete10assignments	sat_wc_complete10assignments	\N	\N	\N	0.100	2026-05-01 16:19:47.766353
1938090	sat_doa_foreverfated	sat_doa_foreverfated	\N	\N	\N	0.100	2026-05-01 16:19:47.766353
1938090	sat_zm_scientificbreakthrough	sat_zm_scientificbreakthrough	\N	\N	\N	0.100	2026-05-01 16:19:47.766353
1938090	sat_zm_yoursoulismine	sat_zm_yoursoulismine	\N	\N	\N	0.100	2026-05-01 16:19:47.766353
1938090	sat_zm_chewonthis	sat_zm_chewonthis	\N	\N	\N	0.100	2026-05-01 16:19:47.766353
1938090	sat_zm_expertcurator	sat_zm_expertcurator	\N	\N	\N	0.100	2026-05-01 16:19:47.766353
1938090	sat_mp_pathfinder	sat_mp_pathfinder	\N	\N	\N	0.100	2026-05-01 16:19:47.766353
1938090	sat_mp_notinmyhouse	sat_mp_notinmyhouse	\N	\N	\N	0.100	2026-05-01 16:19:47.766353
1938090	sat_wc_capricorn_stealth	sat_wc_capricorn_stealth	\N	\N	\N	0.000	2026-05-01 16:19:47.766353
1938090	sat_wc_loremaster	sat_wc_loremaster	\N	\N	\N	0.000	2026-05-01 16:19:47.766353
1938090	sat_doa_fowlfivepiece	sat_doa_fowlfivepiece	\N	\N	\N	0.000	2026-05-01 16:19:47.766353
1938090	sat_doa_reunited	sat_doa_reunited	\N	\N	\N	0.000	2026-05-01 16:19:47.766353
1938090	sat_zm_goodsoldiers	sat_zm_goodsoldiers	\N	\N	\N	0.000	2026-05-01 16:19:47.766353
1938090	sat_zm_mixologist	sat_zm_mixologist	\N	\N	\N	0.000	2026-05-01 16:19:47.766353
2567870	UNDERWORLD_ACHIEVEMENT	UNDERWORLD_ACHIEVEMENT	\N	\N	\N	94.200	2026-05-01 16:42:28.41812
2567870	HELLCLIFFS_ACHIEVEMENT	HELLCLIFFS_ACHIEVEMENT	\N	\N	\N	86.400	2026-05-01 16:42:28.41812
2567870	THECARRACE_ACHIEVEMENT	THECARRACE_ACHIEVEMENT	\N	\N	\N	77.900	2026-05-01 16:42:28.41812
2567870	THEMYSTERIOUSCAVE_ACHIEVEMENT	THEMYSTERIOUSCAVE_ACHIEVEMENT	\N	\N	\N	73.800	2026-05-01 16:42:28.41812
2567870	THESUBWAYSTATION_ACHIEVEMENT	THESUBWAYSTATION_ACHIEVEMENT	\N	\N	\N	62.600	2026-05-01 16:42:28.41812
2567870	THECITY_ACHIEVEMENT	THECITY_ACHIEVEMENT	\N	\N	\N	52.900	2026-05-01 16:42:28.41812
2567870	THEWAREHOUSE_ACHIEVEMENT	THEWAREHOUSE_ACHIEVEMENT	\N	\N	\N	42.700	2026-05-01 16:42:28.41812
2567870	OVERTHEBUILDINGS_ACHIEVEMENT	OVERTHEBUILDINGS_ACHIEVEMENT	\N	\N	\N	45.300	2026-05-01 16:42:28.41812
2567870	THEHARBOR_ACHIEVEMENT	THEHARBOR_ACHIEVEMENT	\N	\N	\N	40.600	2026-05-01 16:42:28.41812
2567870	THETEMPLE_ACHIEVEMENT	THETEMPLE_ACHIEVEMENT	\N	\N	\N	34.500	2026-05-01 16:42:28.41812
2567870	THEASIANSHRINE_ACHIEVEMENT	THEASIANSHRINE_ACHIEVEMENT	\N	\N	\N	33.700	2026-05-01 16:42:28.41812
2567870	THEDEITIES_ACHIEVEMENT	THEDEITIES_ACHIEVEMENT	\N	\N	\N	30.600	2026-05-01 16:42:28.41812
2567870	THEGARDEN_ACHIEVEMENT	THEGARDEN_ACHIEVEMENT	\N	\N	\N	28.000	2026-05-01 16:42:28.41812
2567870	WINGS_ACHIEVEMENT	WINGS_ACHIEVEMENT	\N	\N	\N	3.200	2026-05-01 16:42:28.41812
2567870	TIME_ACHIEVEMENT	TIME_ACHIEVEMENT	\N	\N	\N	2.000	2026-05-01 16:42:28.41812
2567870	LAVA_ACHIEVEMENT	LAVA_ACHIEVEMENT	\N	\N	\N	0.500	2026-05-01 16:42:28.41812
1245620	ACH39	ACH39	\N	\N	\N	75.200	2026-05-01 16:44:56.716983
1245620	ACH25	ACH25	\N	\N	\N	71.100	2026-05-01 16:44:56.716983
1245620	ACH04	ACH04	\N	\N	\N	65.200	2026-05-01 16:44:56.716983
1245620	ACH40	ACH40	\N	\N	\N	60.700	2026-05-01 16:44:56.716983
1245620	ACH26	ACH26	\N	\N	\N	59.400	2026-05-01 16:44:56.716983
1245620	ACH18	ACH18	\N	\N	\N	58.000	2026-05-01 16:44:56.716983
1245620	ACH34	ACH34	\N	\N	\N	57.800	2026-05-01 16:44:56.716983
1245620	ACH35	ACH35	\N	\N	\N	55.600	2026-05-01 16:44:56.716983
1245620	ACH05	ACH05	\N	\N	\N	53.300	2026-05-01 16:44:56.716983
1245620	ACH31	ACH31	\N	\N	\N	50.900	2026-05-01 16:44:56.716983
1245620	ACH29	ACH29	\N	\N	\N	50.000	2026-05-01 16:44:56.716983
1245620	ACH06	ACH06	\N	\N	\N	49.600	2026-05-01 16:44:56.716983
1245620	ACH28	ACH28	\N	\N	\N	48.000	2026-05-01 16:44:56.716983
1245620	ACH13	ACH13	\N	\N	\N	45.500	2026-05-01 16:44:56.716983
1245620	ACH21	ACH21	\N	\N	\N	44.900	2026-05-01 16:44:56.716983
1245620	ACH41	ACH41	\N	\N	\N	44.100	2026-05-01 16:44:56.716983
1245620	ACH38	ACH38	\N	\N	\N	44.000	2026-05-01 16:44:56.716983
1245620	ACH07	ACH07	\N	\N	\N	43.500	2026-05-01 16:44:56.716983
1245620	ACH33	ACH33	\N	\N	\N	43.400	2026-05-01 16:44:56.716983
1245620	ACH20	ACH20	\N	\N	\N	43.100	2026-05-01 16:44:56.716983
1245620	ACH27	ACH27	\N	\N	\N	42.900	2026-05-01 16:44:56.716983
1245620	ACH37	ACH37	\N	\N	\N	41.800	2026-05-01 16:44:56.716983
1245620	ACH10	ACH10	\N	\N	\N	41.500	2026-05-01 16:44:56.716983
1245620	ACH09	ACH09	\N	\N	\N	40.600	2026-05-01 16:44:56.716983
1245620	ACH11	ACH11	\N	\N	\N	40.400	2026-05-01 16:44:56.716983
1245620	ACH24	ACH24	\N	\N	\N	39.900	2026-05-01 16:44:56.716983
1245620	ACH32	ACH32	\N	\N	\N	39.700	2026-05-01 16:44:56.716983
1245620	ACH36	ACH36	\N	\N	\N	39.600	2026-05-01 16:44:56.716983
1245620	ACH22	ACH22	\N	\N	\N	39.200	2026-05-01 16:44:56.716983
1245620	ACH23	ACH23	\N	\N	\N	38.000	2026-05-01 16:44:56.716983
1245620	ACH08	ACH08	\N	\N	\N	36.300	2026-05-01 16:44:56.716983
1245620	ACH30	ACH30	\N	\N	\N	34.700	2026-05-01 16:44:56.716983
1245620	ACH12	ACH12	\N	\N	\N	30.000	2026-05-01 16:44:56.716983
1245620	ACH19	ACH19	\N	\N	\N	29.000	2026-05-01 16:44:56.716983
1245620	ACH02	ACH02	\N	\N	\N	28.100	2026-05-01 16:44:56.716983
1245620	ACH01	ACH01	\N	\N	\N	23.700	2026-05-01 16:44:56.716983
1245620	ACH14	ACH14	\N	\N	\N	18.100	2026-05-01 16:44:56.716983
1245620	ACH17	ACH17	\N	\N	\N	17.600	2026-05-01 16:44:56.716983
1245620	ACH15	ACH15	\N	\N	\N	17.600	2026-05-01 16:44:56.716983
1245620	ACH16	ACH16	\N	\N	\N	17.100	2026-05-01 16:44:56.716983
1245620	ACH03	ACH03	\N	\N	\N	16.300	2026-05-01 16:44:56.716983
1245620	ACH00	ACH00	\N	\N	\N	10.300	2026-05-01 16:44:56.716983
1145350	AchClearErebus	AchClearErebus	\N	\N	\N	64.600	2026-05-01 17:44:17.895521
1145350	AchClearOceanus	AchClearOceanus	\N	\N	\N	58.500	2026-05-01 17:44:17.895521
1145350	AchClearFields	AchClearFields	\N	\N	\N	54.800	2026-05-01 17:44:17.895521
1145350	AchClearEphyra	AchClearEphyra	\N	\N	\N	49.000	2026-05-01 17:44:17.895521
1145350	AchClearThessaly	AchClearThessaly	\N	\N	\N	45.600	2026-05-01 17:44:17.895521
1145350	AchBathHouse	AchBathHouse	\N	\N	\N	45.200	2026-05-01 17:44:17.895521
1145350	AchAllWeapons	AchAllWeapons	\N	\N	\N	43.900	2026-05-01 17:44:17.895521
1145350	AchClearTartarus	AchClearTartarus	\N	\N	\N	43.900	2026-05-01 17:44:17.895521
1145350	AchClearOlympus	AchClearOlympus	\N	\N	\N	40.800	2026-05-01 17:44:17.895521
1145350	AchCauldronSpells1	AchCauldronSpells1	\N	\N	\N	40.700	2026-05-01 17:44:17.895521
1145350	AchKillWitchAsSheep	AchKillWitchAsSheep	\N	\N	\N	39.500	2026-05-01 17:44:17.895521
1145350	AchAllArcana	AchAllArcana	\N	\N	\N	36.800	2026-05-01 17:44:17.895521
1145350	AchConfideFrinos	AchConfideFrinos	\N	\N	\N	35.300	2026-05-01 17:44:17.895521
1145350	AchFishingPier	AchFishingPier	\N	\N	\N	34.900	2026-05-01 17:44:17.895521
1145350	AchClearSummit	AchClearSummit	\N	\N	\N	34.600	2026-05-01 17:44:17.895521
1145350	AchTaverna	AchTaverna	\N	\N	\N	32.300	2026-05-01 17:44:17.895521
1145350	AchMaxMem	AchMaxMem	\N	\N	\N	32.000	2026-05-01 17:44:17.895521
1145350	AchBeatHecateNoArcana	AchBeatHecateNoArcana	\N	\N	\N	29.000	2026-05-01 17:44:17.895521
1145350	AchTrueEnding	AchTrueEnding	\N	\N	\N	25.300	2026-05-01 17:44:17.895521
1145350	AchAllFamiliars	AchAllFamiliars	\N	\N	\N	23.900	2026-05-01 17:44:17.895521
1145350	AchEarnStatue1	AchEarnStatue1	\N	\N	\N	23.300	2026-05-01 17:44:17.895521
1145350	AchSummonSiren	AchSummonSiren	\N	\N	\N	22.500	2026-05-01 17:44:17.895521
1145350	AchEarnPrestige1	AchEarnPrestige1	\N	\N	\N	17.900	2026-05-01 17:44:17.895521
1145350	AchEarnStatue2	AchEarnStatue2	\N	\N	\N	15.800	2026-05-01 17:44:17.895521
1145350	AchHelpDora	AchHelpDora	\N	\N	\N	15.700	2026-05-01 17:44:17.895521
1145350	AchWinSecretContest	AchWinSecretContest	\N	\N	\N	15.400	2026-05-01 17:44:17.895521
1145350	AchBeatChronosWithArcana	AchBeatChronosWithArcana	\N	\N	\N	15.000	2026-05-01 17:44:17.895521
1145350	AchHelpHypnos	AchHelpHypnos	\N	\N	\N	15.000	2026-05-01 17:44:17.895521
1145350	AchCatchFish	AchCatchFish	\N	\N	\N	14.300	2026-05-01 17:44:17.895521
1145350	AchNemesisCombat	AchNemesisCombat	\N	\N	\N	13.500	2026-05-01 17:44:17.895521
1145350	AchBeatTyphonWithWeapons	AchBeatTyphonWithWeapons	\N	\N	\N	12.700	2026-05-01 17:44:17.895521
1145350	AchProphecies1	AchProphecies1	\N	\N	\N	11.600	2026-05-01 17:44:17.895521
1145350	AchForgeBonds	AchForgeBonds	\N	\N	\N	11.400	2026-05-01 17:44:17.895521
1145350	AchAllArcanaMax	AchAllArcanaMax	\N	\N	\N	11.300	2026-05-01 17:44:17.895521
1145350	AchTartarusInDress	AchTartarusInDress	\N	\N	\N	11.100	2026-05-01 17:44:17.895521
1145350	AchHelpNarcissusAndEcho	AchHelpNarcissusAndEcho	\N	\N	\N	11.000	2026-05-01 17:44:17.895521
1145350	AchClearChaosQuest	AchClearChaosQuest	\N	\N	\N	10.800	2026-05-01 17:44:17.895521
1145350	AchAllKeepsakes	AchAllKeepsakes	\N	\N	\N	10.400	2026-05-01 17:44:17.895521
1145350	AchAllAspects	AchAllAspects	\N	\N	\N	9.500	2026-05-01 17:44:17.895521
1145350	AchBeatRivalsVow1	AchBeatRivalsVow1	\N	\N	\N	9.400	2026-05-01 17:44:17.895521
1145350	AchBounties1	AchBounties1	\N	\N	\N	9.200	2026-05-01 17:44:17.895521
1145350	AchEpilogue	AchEpilogue	\N	\N	\N	8.400	2026-05-01 17:44:17.895521
1145350	AchAllFamiliarsMax	AchAllFamiliarsMax	\N	\N	\N	8.200	2026-05-01 17:44:17.895521
1145350	AchHelpOdysseus	AchHelpOdysseus	\N	\N	\N	7.200	2026-05-01 17:44:17.895521
1145350	AchFamiliarCostumes	AchFamiliarCostumes	\N	\N	\N	6.400	2026-05-01 17:44:17.895521
1145350	AchHelpArachne	AchHelpArachne	\N	\N	\N	6.300	2026-05-01 17:44:17.895521
1145350	AchClearWithAllAspects	AchClearWithAllAspects	\N	\N	\N	5.500	2026-05-01 17:44:17.895521
1145350	AchAllRandomStreak	AchAllRandomStreak	\N	\N	\N	4.900	2026-05-01 17:44:17.895521
1145350	AchAllRandomUnderworld	AchAllRandomUnderworld	\N	\N	\N	4.400	2026-05-01 17:44:17.895521
1145350	AchAllOtherAch	AchAllOtherAch	\N	\N	\N	3.600	2026-05-01 17:44:17.895521
\.
COPY public.completes (steam_id, app_id, api_name, achieved, unlock_time, user_achievement_last_fetched_at) FROM stdin;
76561199744319624	2567870	WINGS_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	TIME_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	LAVA_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	UNDERWORLD_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	HELLCLIFFS_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THECARRACE_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THEMYSTERIOUSCAVE_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THESUBWAYSTATION_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THECITY_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	OVERTHEBUILDINGS_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THEWAREHOUSE_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THEHARBOR_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THETEMPLE_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THEASIANSHRINE_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THEDEITIES_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
76561199744319624	2567870	THEGARDEN_ACHIEVEMENT	f	\N	2026-05-01 16:42:28.487665
\.
COPY public.endpoint (endpoint_name) FROM stdin;
owned_games
recently_played
player_achievements
\.
COPY public.games (app_id, name, header_image, capsule_image, short_description, detailed_description, website, developers, publishers, genres, categories, platforms, release_date, is_free, price_overview, game_last_fetched_at, news_last_fetched_at, global_achievements_last_fetched_at) FROM stdin;
2721690	Cod Quest!	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2721690/17d4d813d79fa4326b0fc6244661491b30f0e0ab/capsule_231x87.jpg?t=1746394319	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 699, "initial": 699, "currency": "USD"}	\N	\N	\N
311210	Call of Duty®: Black Ops III	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/311210/capsule_231x87.jpg?t=1748022663	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 5999, "initial": 5999, "currency": "USD"}	\N	\N	\N
3606480	Call of Duty®: Black Ops 7	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/3606480/e265efebec95c52bb0c662532a51b6bdf45ccd37/capsule_231x87.jpg?t=1776875198	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 6999, "initial": 6999, "currency": "USD"}	\N	\N	\N
1962663	Call of Duty®: Warzone™	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1962663/d7a8b3e9a239f79f28a88bfa70aa51943597e0f7/capsule_231x87_alt_assets_17.jpg?t=1776875850	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N
2000950	Call of Duty®: Modern Warfare®	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2000950/capsule_231x87.jpg?t=1776876020	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 5999, "initial": 5999, "currency": "USD"}	\N	\N	\N
202970	Call of Duty®: Black Ops II	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/202970/capsule_231x87.jpg?t=1748037715	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 5999, "initial": 5999, "currency": "USD"}	\N	\N	\N
42700	Call of Duty®: Black Ops	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/42700/capsule_231x87.jpg?t=1748040520	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 3999, "initial": 3999, "currency": "USD"}	\N	\N	\N
10180	Call of Duty®: Modern Warfare® 2 (2009)	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/10180/capsule_231x87.jpg?t=1748044299	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 1999, "initial": 1999, "currency": "USD"}	\N	\N	\N
1938090	Call of Duty®	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1938090/06107605348820087bb51ca89ed620c22fe559aa/header.jpg?t=1776875071	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1938090/e76dfab7877b025104a66ef5261cd30a545874c3/capsule_231x87.jpg?t=1776875071	The Call of Duty® experience supports Call of Duty®: Black Ops 7, Call of Duty®: Black Ops 6, and Call of Duty®: Warzone™.	<p class="bb_paragraph" >The Call of Duty® experience supports Call of Duty®: Black Ops 7, Call of Duty®: Black Ops 6, and Call of Duty®: Warzone™.</p><p class="bb_paragraph" >In Call of Duty®: Black Ops 7, Treyarch and Raven Software are bringing players the biggest Black Ops ever.</p><p class="bb_paragraph" >Call of Duty®: Black Ops 6 is signature Black Ops across a cinematic single-player Campaign, a best-in-class Multiplayer experience and with the epic return of Round-Based Zombies.</p><p class="bb_paragraph" >Call of Duty®: Warzone™ is the massive free-to-play combat arena, featuring Battle Royale, Resurgence, and now introducing Black Ops Royale, a new free mode inspired by Blackout and reimagined for today’s Warzone™.</p><p class="bb_paragraph" >Call of Duty® Points (CP*) are the in-game currency that can be used in Black Ops 7, Black Ops 6, Modern Warfare® III, Modern Warfare® II and Call of Duty®: Warzone™ to obtain new content.</p><p class="bb_paragraph" >Call of Duty®: Black Ops 7, Call of Duty®: Black Ops 6, Call of Duty®: Modern Warfare® III, Call of Duty®: Modern Warfare® II or Call of Duty®: Warzone™ required to redeem. Sold / downloaded separately.</p><p class="bb_paragraph" >CP purchased may also be used to obtain in-game content in certain Call of Duty® games with CP functionality enabled*. Each game sold separately.</p>	https://www.callofduty.com/	["Treyarch", "Raven Software", "Beenox", "High Moon Studios", "Sledgehammer Games", "Infinity Ward", "Activision Shanghai", "Demonware"]	["Activision"]	[{"id": "1", "description": "Action"}]	[{"id": 2, "description": "Single-player"}, {"id": 1, "description": "Multi-player"}, {"id": 49, "description": "PvP"}, {"id": 36, "description": "Online PvP"}, {"id": 9, "description": "Co-op"}, {"id": 38, "description": "Online Co-op"}, {"id": 27, "description": "Cross-Platform Multiplayer"}, {"id": 22, "description": "Steam Achievements"}, {"id": 13, "description": "Captions available"}, {"id": 35, "description": "In-App Purchases"}, {"id": 64, "description": "Adjustable Text Size"}, {"id": 67, "description": "Camera Comfort"}, {"id": 66, "description": "Color Alternatives"}, {"id": 68, "description": "Custom Volume Controls"}, {"id": 74, "description": "Playable without Timed Input"}, {"id": 69, "description": "Stereo Sound"}, {"id": 65, "description": "Subtitle Options"}, {"id": 70, "description": "Surround Sound"}, {"id": 18, "description": "Partial Controller Support"}, {"id": 61, "description": "HDR available"}]	{"mac": false, "linux": false, "windows": true}	Oct 27, 2022	f	null	2026-05-01 16:19:47.52161	2026-05-01 16:19:47.710091	2026-05-01 16:19:47.766353
2567870	Chained Together	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/header.jpg?t=1732288374	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/capsule_231x87.jpg?t=1732288374	From the depths of hell, climb chained to your friends through diverse worlds. Solo or co-op, try to reach the summit and discover what awaits you there...	<h2 class="bb_tag" ><strong>Dive into the epic adventure of &quot;Chained Together&quot;</strong></h2>Begin your journey in the depths of hell, chained to your companions. Your mission is to escape hell by climbing as high as possible.<br>Each jump requires perfect coordination to scale the platforms and escape the scorching heat. Traverse a multitude of worlds, each offering unique challenges.<br><br><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/extras/1fee78a5b13d46bb283eacfd81cb908d.poster.avif?t=1732288374" width=480 height=270 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/extras/1fee78a5b13d46bb283eacfd81cb908d.webm?t=1732288374" type="video/webm; codecs=vp9"><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/extras/1fee78a5b13d46bb283eacfd81cb908d.mp4?t=1732288374" type="video/mp4"></video></span><h2 class="bb_tag" >Diverse Worlds to Explore</h2>Each world introduces new challenges.<h2 class="bb_tag" >Solo or Multiplayer Mode</h2>Whether you're going it alone or teaming up with friends locally, the game adapts to fit the number of players, supporting local multiplayer for up to 4 players.<h2 class="bb_tag" >Realistic Chain Physics</h2>The chain is not just a visual element. It is governed by a physics simulation that allows it to wrap around platforms.<h2 class="bb_tag" >3 Game Modes</h2>The game features several difficulty modes: Beginner, Normal, and Lava mode.<br><br><ul class="bb_ul"><li>Beginner: An option in the pause menu allows you to teleport back to the highest point you reached before a significant fall.<br></li><li>Normal: No specific help, you fall in case of failure and must start over.<br></li><li>Lava: You must climb quickly before the lava engulfs you.</li></ul><i>The leaderboard and Steam achievements are only valid in Normal and Lava modes.</i><h2 class="bb_tag" >Leaderboards</h2>Track your escape speeds with leaderboards that compare completion times across different player configurations.<br><br><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/extras/94720fcb6dd88c49b094adbddafceb94.poster.avif?t=1732288374" width=480 height=270 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/extras/94720fcb6dd88c49b094adbddafceb94.webm?t=1732288374" type="video/webm; codecs=vp9"><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/extras/94720fcb6dd88c49b094adbddafceb94.mp4?t=1732288374" type="video/mp4"></video></span><br><br>Whether <strong>solo</strong> or in <strong>cooperation with up to 4 players in multiplayer mode</strong>, each step brings you closer to the summit!<br><br><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/extras/dd9124abe6bf6bd35dcf2aaae8e252b0.poster.avif?t=1732288374" width=736 height=60 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/extras/dd9124abe6bf6bd35dcf2aaae8e252b0.webm?t=1732288374" type="video/webm; codecs=vp9"><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2567870/extras/dd9124abe6bf6bd35dcf2aaae8e252b0.mp4?t=1732288374" type="video/mp4"></video></span>	https://linktr.ee/AnegarGames	["Anegar Games"]	["Anegar Games"]	[{"id": "25", "description": "Adventure"}, {"id": "4", "description": "Casual"}, {"id": "23", "description": "Indie"}, {"id": "28", "description": "Simulation"}]	[{"id": 2, "description": "Single-player"}, {"id": 1, "description": "Multi-player"}, {"id": 9, "description": "Co-op"}, {"id": 38, "description": "Online Co-op"}, {"id": 39, "description": "Shared/Split Screen Co-op"}, {"id": 24, "description": "Shared/Split Screen"}, {"id": 18, "description": "Partial Controller Support"}, {"id": 44, "description": "Remote Play Together"}, {"id": 62, "description": "Family Sharing"}]	{"mac": false, "linux": false, "windows": true}	Jun 19, 2024	f	{"final": 499, "initial": 499, "currency": "USD", "final_formatted": "$4.99", "discount_percent": 0, "initial_formatted": ""}	2026-05-01 16:42:28.194542	2026-05-01 16:42:28.35472	2026-05-01 16:42:28.41812
2622380	ELDEN RING NIGHTREIGN	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2622380/8ebc4260af27bc55ba8b88982fd7eb7f970d43c9/capsule_231x87.jpg?t=1773099036	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 3999, "initial": 3999, "currency": "USD"}	\N	\N	\N
1145360	Hades	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1145360/capsule_231x87.jpg?t=1758127023	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 2499, "initial": 2499, "currency": "USD"}	\N	\N	\N
755800	Hades' Star	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/755800/capsule_231x87.jpg?t=1760538814	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N
3695570	H.A.D.E.S Zero	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/3695570/b3c38ac7bef7070cc4877a5f09e158f16e7563d7/capsule_231x87.jpg?t=1775321517	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 779, "initial": 1199, "currency": "USD"}	\N	\N	\N
826460	The Road to Hades	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/826460/capsule_231x87.jpg?t=1523540778	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	{"final": 99, "initial": 99, "currency": "USD"}	\N	\N	\N
3653720	Hades Harem	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/3653720/50d70d6be19137e0d64f709760a991ceb389bdfa/capsule_231x87.jpg?t=1745523649	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N
4516620	Hades Hinderance	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/4516620/460ee36d6dfcc8c27e0ddf97652704e874248517/capsule_231x87.jpg?t=1776787425	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N
4524240	Orpheus: Echo of Hades	\N	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/4524240/9af85e9b2115e2ad0e13338f90fd5d70718b7038/capsule_231x87.jpg?t=1777591094	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N
1145350	Hades II	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1145350/91ac334a2c137d08968ccc0bc474a02579602100/header.jpg?t=1765831644	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1145350/10c9138570a8d7ac9144f601ab0f2ccbc820337e/capsule_231x87.jpg?t=1765831644	Battle beyond the Underworld using dark sorcery to take on the Titan of Time in this bewitching sequel to the award-winning rogue-like dungeon crawler.	<p class="bb_paragraph" ><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline crossorigin="anonymous" poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1145350/extras/9eb5e37616fb72c42d6c8e8e918f78d8.poster.avif?t=1765831644" width=780 height=439 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1145350/extras/9eb5e37616fb72c42d6c8e8e918f78d8.webm?t=1765831644" type="video/webm; codecs=vp9"></video></span>The first-ever sequel from Supergiant Games builds on the best aspects of the original <i>god-like </i>rogue-like dungeon crawler in an all-new, action-packed, endlessly replayable experience rooted in the Underworld of Greek myth and its deep connections to the dawn of witchcraft. </p><h2 class="bb_tag" >BATTLE BEYOND THE UNDERWORLD</h2><p class="bb_paragraph" >As the immortal Princess of the Underworld, you'll explore a bigger, deeper mythic world, vanquishing the forces of the Titan of Time with the full might of Olympus behind you, in a sweeping story that continually unfolds through your every setback and accomplishment. </p><h2 class="bb_tag" >MASTER WITCHCRAFT AND DARK SORCERY</h2><p class="bb_paragraph" >Infuse your legendary weapons of Night with ancient magick, so that none may stand in your way. Become stronger still with powerful Boons from more than a dozen Olympian gods, from Apollo to Zeus. There are nearly limitless ways to build your abilities.</p><p class="bb_paragraph" ><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline crossorigin="anonymous" poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1145350/extras/43c056f0768d57fb1610417dc3f0dbe2.poster.avif?t=1765831644" width=1170 height=659 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1145350/extras/43c056f0768d57fb1610417dc3f0dbe2.webm?t=1765831644" type="video/webm; codecs=vp9"></video></span></p><h2 class="bb_tag" >MINGLE WITH (MORE) GODS, GHOSTS, AND MONSTERS</h2><p class="bb_paragraph" >Meet a cast of dozens of fully-voiced, larger-than-life characters, including plenty of new faces and some old friends. Grow closer to them through a variety of new interactions, and experience countless unique story events based on how your journey unfolds.</p><h2 class="bb_tag" >EVERY RUN IS ITS OWN ADVENTURE</h2><p class="bb_paragraph" >New locations, challenges, upgrade systems, and surprises await as you delve into the ever-shifting Underworld again and again. Reveal the mysteries of the Altar of Ashes, tame witchy familiars, and gather reagents using Tools of the Unseen to get closer to your goal. </p><h2 class="bb_tag" >THE PERKS OF IMMORTALITY</h2><p class="bb_paragraph" >Thanks to a variety of permanent upgrades and the return of God Mode, you don't have to be a god yourself to experience what <strong>Hades II</strong> has to offer. But if you happen to be one, you can brave escalating challenges for greater rewards, and prove just how divine you really are. </p><p class="bb_paragraph" ><span class="bb_img_ctn"><img class="bb_img" src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1145350/extras/47ef79096a49518c61cc4a7e6aaae855.avif?t=1765831644" width=1170 height=410 /></span></p><h2 class="bb_tag" >SIGNATURE SUPERGIANT STYLE</h2><p class="bb_paragraph" >Rich, atmospheric presentation and storytelling fused with responsive action is the hallmark of Supergiant's titles. Vivid new hand-painted environments, even smoother real-time 3D characters, and an electrifying original score make this mythic world burst with life.</p>	http://www.supergiantgames.com	["Supergiant Games"]	["Supergiant Games"]	[{"id": "1", "description": "Action"}, {"id": "23", "description": "Indie"}, {"id": "3", "description": "RPG"}]	[{"id": 2, "description": "Single-player"}, {"id": 22, "description": "Steam Achievements"}, {"id": 28, "description": "Full controller support"}, {"id": 29, "description": "Steam Trading Cards"}, {"id": 13, "description": "Captions available"}, {"id": 23, "description": "Steam Cloud"}, {"id": 62, "description": "Family Sharing"}]	{"mac": true, "linux": false, "windows": true}	Sep 25, 2025	f	{"final": 2999, "initial": 2999, "currency": "USD"}	2026-05-01 17:44:17.515779	2026-05-01 17:44:17.791371	2026-05-01 17:44:17.895521
1245620	ELDEN RING	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/header.jpg?t=1767883716	https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/capsule_231x87.jpg?t=1767883716	THE CRITICALLY ACCLAIMED FANTASY ACTION RPG. Rise, Tarnished, and be guided by grace to brandish the power of the Elden Ring and become an Elden Lord in the Lands Between.	<h1>ELDEN RING Shadow of the Erdtree Edition</h1><p><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/6e68c7bbe71819c202f190579f8d4f12.poster.avif?t=1767883716" width=616 height=346 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/6e68c7bbe71819c202f190579f8d4f12.webm?t=1767883716" type="video/webm; codecs=vp9"><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/6e68c7bbe71819c202f190579f8d4f12.mp4?t=1767883716" type="video/mp4"></video></span><br>ELDEN RING Shadow of the Erdtree Edition includes:<br><ul class="bb_ul"><li>ELDEN RING<br></li><li>ELDEN RING Shadow of the Erdtree expansion</li></ul></p><br><h1>ELDEN RING Shadow of the Erdtree Deluxe Edition</h1><p><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/0856a96484c4fb0a35eee2db28320da2.poster.avif?t=1767883716" width=616 height=346 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/0856a96484c4fb0a35eee2db28320da2.webm?t=1767883716" type="video/webm; codecs=vp9"><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/0856a96484c4fb0a35eee2db28320da2.mp4?t=1767883716" type="video/mp4"></video></span><br>ELDEN RING Shadow of the Erdtree Deluxe Edition includes:<br><ul class="bb_ul"><li>ELDEN RING<br></li><li>ELDEN RING Shadow of the Erdtree expansion<br></li><li>ELDEN RING Digital Artbook &amp; Original Soundtrack<br></li><li>ELDEN RING Shadow of the Erdtree Artbook &amp; Soundtrack</li></ul></p><br><h1>About the Game</h1><strong>THE CRITICALLY ACCLAIMED FANTASY ACTION RPG</strong><br><i>Rise, Tarnished, and be guided by grace to brandish the power of the Elden Ring.</i><h2 class="bb_tag" >• A Breathtaking World Full of Excitement and Mystery</h2>The Lands Between are part of a vast continent where magnificent open fields and huge dungeons with complex and three-dimensional designs are seamlessly connected. As you explore, the joy of discovering unknown and overwhelming threats awaits you.<br>Mastery of the terrain and knowledge of its secrets can help you overcome enemies and defeat formidable bosses or lead invading players into traps.<br><br><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline crossorigin="anonymous" poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/b2d503549e33e6603c86b6bd7babdb38.poster.avif?t=1767883716" width=780 height=320 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/b2d503549e33e6603c86b6bd7babdb38.webm?t=1767883716" type="video/webm; codecs=vp9"></video></span><h2 class="bb_tag" >• Defeat Challenging Foes in Intense Combat</h2>Combat in ELDEN RING is simple to learn yet offers hidden depths of mastery. As you seek to become the Elden Lord, you’ll need to explore the balance between attacking and avoiding damage, use a wide variety of weapons, spells, &amp; summons, and perfect your timing to take advantage of your opponents’ weaknesses.<br><br><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline crossorigin="anonymous" poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/61c24948423742d3f67e094fe7be4119.poster.avif?t=1767883716" width=780 height=320 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/61c24948423742d3f67e094fe7be4119.webm?t=1767883716" type="video/webm; codecs=vp9"></video></span><h2 class="bb_tag" >• Create and Build Your Own Character</h2>In addition to customizing the appearance of your character, there are countless ways to combine the weapons, armor, usable items, and magic that you equip. You can develop your character according to your play style.<br>No matter if you prefer bold physical confrontation, tactical spellcasting, or the subtle art of stealth, you’ll be able to find gear that supports your choices.<br><br><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline crossorigin="anonymous" poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/bb8df835b8ac3e772150d98c157e0c41.poster.avif?t=1767883716" width=780 height=320 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/bb8df835b8ac3e772150d98c157e0c41.webm?t=1767883716" type="video/webm; codecs=vp9"></video></span><h2 class="bb_tag" >• An Epic Drama Born from a Myth Created by George R.R. Martin</h2>The founding mythology of Elden Ring was written by George R. R. Martin and adapted into a rich multilayered story. Intersecting goals and desires between the characters create an intense narrative that weaves throughout the Lands Between. The events of the game can unravel in many ways, depending on your interventions.<br><br><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline crossorigin="anonymous" poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/8b612e65bf3ad3c2ee96140999ce5881.poster.avif?t=1767883716" width=780 height=320 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/8b612e65bf3ad3c2ee96140999ce5881.webm?t=1767883716" type="video/webm; codecs=vp9"></video></span><h2 class="bb_tag" >• Play Alongside a Massive Worldwide Community</h2>The Tarnished community is massive and active. Your friends may already be among them. You can play with up to two other Tarnished as your cooperative teammates, either by inviting them using a shared password or by summoning them from a pool of nearby community members.<br>There are also ample opportunities to face off against other players, either through co-op invasions, invited duels, or the many player battle options available in the three Colosseums.<br><br><span class="bb_img_ctn"><video class="bb_img" autoplay muted loop playsinline crossorigin="anonymous" poster="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/8bed670f075526277b71e13a1c614f51.poster.avif?t=1767883716" width=780 height=320 ><source src="https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1245620/extras/8bed670f075526277b71e13a1c614f51.webm?t=1767883716" type="video/webm; codecs=vp9"></video></span>	\N	["FromSoftware, Inc."]	["FromSoftware, Inc.", "Bandai Namco Entertainment"]	[{"id": "1", "description": "Action"}, {"id": "3", "description": "RPG"}]	[{"id": 2, "description": "Single-player"}, {"id": 1, "description": "Multi-player"}, {"id": 49, "description": "PvP"}, {"id": 36, "description": "Online PvP"}, {"id": 9, "description": "Co-op"}, {"id": 38, "description": "Online Co-op"}, {"id": 22, "description": "Steam Achievements"}, {"id": 28, "description": "Full controller support"}, {"id": 29, "description": "Steam Trading Cards"}, {"id": 67, "description": "Camera Comfort"}, {"id": 68, "description": "Custom Volume Controls"}, {"id": 74, "description": "Playable without Timed Input"}, {"id": 79, "description": "Save Anytime"}, {"id": 69, "description": "Stereo Sound"}, {"id": 70, "description": "Surround Sound"}, {"id": 23, "description": "Steam Cloud"}, {"id": 62, "description": "Family Sharing"}]	{"mac": false, "linux": false, "windows": true}	Feb 24, 2022	f	{"final": 5999, "initial": 5999, "currency": "USD"}	2026-05-01 16:44:56.472099	2026-05-01 16:44:56.655052	2026-05-01 16:44:56.716983
\.
COPY public.news_articles (gid, app_id, title, url, author, contents, feed_type, published_at, article_last_fetched_at) FROM stdin;
1830797770234051	1938090	Reloaded Recon: Black Ops 7 and Call of Duty: Warzone Season 03	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1830797770234051	ATVI_Dov	Raise the Stakes The ongoing battle between JSOC and The Guild heats up as the balance of power shifts. With guidance from Karma, expert infiltrator Cole “Javelin” Donovan has successfully hacked into The Guild’s system using his C-Link device, allowing JSOC to turn The Guild’s own defenses against ...	1	2026-04-23 12:10:39-07	2026-05-01 16:19:47.710091
1828894815567371	1938090	Steam Global Top Sellers for week of 31 Mar — 7 April 2026	https://steamstore-a.akamaihd.net/news/externalpost/SteamDB/1828894815567371	SteamDB	<a href="https://steamdb.info/topsellers/2026W15/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS"> </a> * <a href="https://steamdb.info/app/3321460/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Crimson Desert</a>; * <a href="https://steamdb.info/app/2868840/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Slay the Spire 2</a>; * <a href="https://steamdb.info/app/2050650/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Resident Evil 4</a>; * <a href="https://steamdb.info/app/2479810/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Gray Zone Warfare</a>; * <a href="https://steamdb.info/app/1808500/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">ARC Raiders</a>; * <a href="https://steamdb.info/app/3784030/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">RACCOIN: Coin Pusher Roguelike</a>; * <a href="https://steamdb.info/app/1174180/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Red Dead Redemption 2</a>; * <a href="https://steamdb.info/app/3240220/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Grand Theft Auto V Enhanced</a>; * <a href="https://steamdb.info/app/3472040/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">NBA 2K26</a>; * <a href="https://steamdb.info/app/1938090/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Call of Duty®</a>; <i>* excluding free to play games</i> <a href="https://steamdb.info/topsellers/2026W15/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">View top 100 on SteamDB</a>	0	2026-04-07 02:00:00-07	2026-05-01 16:19:47.710091
1828894815558305	1938090	Call of Duty: Black Ops 7 and Warzone - Season 3 - Live Now	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1828894815558305	RedBruto	Declassified, Unleashed: Black Ops Season 03 is Here! The Story So Far In their next move against The Guild, Karma sends in Cole “Javelin” Donovan. Dropping from international airspace toward a Guild facility over the Arctic Circle, Javelin expertly neutralizes the enemy threats… until Victoria Atwo...	1	2026-04-02 10:59:45-07	2026-05-01 16:19:47.710091
1828894815553243	1938090	Introducing the Season 03 Battle Pass, BlackCell, and New Store Bundles	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1828894815553243	ATVI_Dov	Raise the Stakes with the Season 03 Battle Pass!JSOC enlists Cole “Javelin” Donovan to infiltrate The Guild, sending the aerial tactician to a frozen facility in the Arctic Circle with instructions to hack into the company’s systems, wreaking havoc. Press the advantage with help from a brand-new Bat...	1	2026-03-31 16:49:42-07	2026-05-01 16:19:47.710091
1827626365768524	1938090	Trials of Avalon ignites the all-new Black Ops Royale, March 23-25	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1827626365768524	RedBruto	192 creators battle for $6SK. Days 1-2: 48 invited teams compete in a best-of series. Top 25 reach Match Point Finals; top 150 clash in the coveted Solo Yolo.Live Now!	1	2026-03-25 09:07:20-07	2026-05-01 16:19:47.710091
1827626365766132	1938090	Trials of Avalon ignites the all-new Black Ops Royale, March 23-25	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1827626365766132	RedBruto	192 creators battle for $6SK. Days 1-2: 48 invited teams compete in a best-of series. Top 25 reach Match Point Finals; top 150 clash in the coveted Solo Yolo.Live Now!	1	2026-03-24 08:40:10-07	2026-05-01 16:19:47.710091
1826992588594466	1938090	Call of Duty: Warzone - Introducing Black Ops Royale	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1826992588594466	RedBruto	Learn how Black Ops Royale works before your first drop 🪂 Start with a pistol, scavenge for gear, upgrade your weapons, and build your power as the match unfolds. No loadouts, no problem 🔥Welcome to Black Ops RoyaleBLACK OPS ROYALE SUMMARYBlack Ops Royale: This is an original Blackout-inspired Battl...	1	2026-03-12 20:59:21-07	2026-05-01 16:19:47.710091
1826362059922866	1938090	Call of Duty: Black Ops 7 and Call of Duty: Warzone Season 02 Reloaded	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1826362059922866	RedBruto	Season 02 Reloaded: Incoming Intel Outloot. Outlast.As Alden Dorne and The Guild continue their offensive in Avalon, a new inroad to the city appears. Prepare for the highly anticipated Black Ops Royale, arriving shortly after the Mid-Season launch, supporting 100 players looting from scratch and fi...	1	2026-03-05 18:25:03-07	2026-05-01 16:19:47.710091
6250522009527743849	2567870	V 1.8.6	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/6250522009527743849	PixelPilgrim	Hello everyone, here is a minor update (1.8.6): Fixed synchronization of rotating objects in workshop maps. Added the ability to change materials on Triggered Objects (level editor). Thank you and have fun!	1	2024-09-16 06:20:00-07	2026-05-01 16:42:28.35472
1816849002008983	2567870	Sure, why not: The next videogame movie will adapt friendship-ending indie Chained Together	https://steamstore-a.akamaihd.net/news/externalpost/PC Gamer/1816849002008983	Justin Wagner	I have a feeling that someone, somewhere is trying to get every ounce of value they can out of a prop rental for a set of four comically oversized manacles. That's the only explanation I've landed on for why <a href="https://www.pcgamer.com/games/action/the-latest-friendship-ruining-co-op-game-on-steam-is-a-punishing-platformer-where-youre-chained-to-your-pals-and-its-about-to-crack-100000-concurrent-players/">Chained Together</a>, an ultra-hard co-op platformer about four characters being, well, chained ...	0	2025-11-19 13:13:26-07	2026-05-01 16:42:28.35472
6250522009509726120	2567870	Patch 1.8.5	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/6250522009509726120	PixelPilgrim	Hello everyone, here is update 1.8.5: We have fixed the display of ratings for maps on the workshop. We now enforce adding a title to new workshop mods. We've made some minor fixes to the level editor. We have adjusted the volume of certain sound effects that couldn’t be changed. We’ve added a link ...	1	2024-09-11 07:42:28-07	2026-05-01 16:42:28.35472
6242640076615010502	2567870	Patch Notes – Version 1.8.4	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/6242640076615010502	PixelPilgrim	Hello everyone! After more than a month of work, we are excited to present version 1.8.4 of Chained Together, which introduces a brand new feature many have been waiting for: the creation and sharing of custom maps! This update is designed to unleash your creativity and introduce you to new experien...	1	2024-09-10 06:35:09-07	2026-05-01 16:42:28.35472
5963414363384604308	2567870	Steam Global Top Sellers for week of 30 Jul — 6 August 2024	https://steamstore-a.akamaihd.net/news/externalpost/SteamDB/5963414363384604308	SteamDB	<a href="https://steamdb.info/topsellers/2024W32/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS"> </a> * <a href="https://steamdb.info/app/1675200/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Steam Deck</a>; * <a href="https://steamdb.info/app/2358720/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Black Myth: Wukong</a>; * <a href="https://steamdb.info/app/1245620/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">ELDEN RING</a>; * <a href="https://steamdb.info/app/381210/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Dead by Daylight</a>; * <a href="https://steamdb.info/app/271590/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Grand Theft Auto V</a>; * <a href="https://steamdb.info/app/1086940/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Baldur's Gate 3</a>; * <a href="https://steamdb.info/app/1938090/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Call of Duty®</a>; * <a href="https://steamdb.info/app/2567870/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Chained Together</a>; * <a href="https://steamdb.info/app/2778580/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">ELDEN RING Shadow of the Erdtree</a>; * <a href="https://steamdb.info/app/252490/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Rust</a>; <i>* excluding free to play games</i> <a href="https://steamdb.info/topsellers/2024W32/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">View top 100 on SteamDB</a>	0	2024-08-06 02:00:00-07	2026-05-01 16:42:28.35472
5963413728329229256	2567870	Steam Global Top Sellers for week of 23 Jul — 30 July 2024	https://steamstore-a.akamaihd.net/news/externalpost/SteamDB/5963413728329229256	SteamDB	<a href="https://steamdb.info/topsellers/2024W31/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS"> </a> * <a href="https://steamdb.info/app/1675200/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Steam Deck</a>; * <a href="https://steamdb.info/app/1245620/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">ELDEN RING</a>; * <a href="https://steamdb.info/app/1938090/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Call of Duty®</a>; * <a href="https://steamdb.info/app/2291060/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">EARTH DEFENSE FORCE 6</a>; * <a href="https://steamdb.info/app/275850/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">No Man's Sky</a>; * <a href="https://steamdb.info/app/381210/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Dead by Daylight</a>; * <a href="https://steamdb.info/app/2567870/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Chained Together</a>; * <a href="https://steamdb.info/app/2790720/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Call of Duty®: Modern Warfare® III - BlackCell (Season 5)</a>; * <a href="https://steamdb.info/app/2358720/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Black Myth: Wukong</a>; * <a href="https://steamdb.info/app/1174180/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Red Dead Redemption 2</a>; <i>* excluding free to play games</i> <a href="https://steamdb.info/topsellers/2024W31/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">View top 100 on SteamDB</a>	0	2024-07-30 02:00:00-07	2026-05-01 16:42:28.35472
5969041959983682615	2567870	Development Update	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/5969041959983682615	PixelPilgrim	Hello everyone! It's been a while since we've shared any news here. We are fully committed to developing our in-game level editor and integrating the Steam Workshop into the game. Today, we want to give you a sneak peek of our level editor. It might look chaotic, but our goal here is to test each el...	1	2024-07-23 10:35:51-07	2026-05-01 16:42:28.35472
5969041959958898303	2567870	Steam Global Top Sellers for week of 9 Jul — 16 July 2024	https://steamstore-a.akamaihd.net/news/externalpost/SteamDB/5969041959958898303	SteamDB	<a href="https://steamdb.info/topsellers/2024W29/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS"> </a> * <a href="https://steamdb.info/app/1675200/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Steam Deck</a>; * <a href="https://steamdb.info/app/1245620/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">ELDEN RING</a>; * <a href="https://steamdb.info/app/1086940/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Baldur's Gate 3</a>; * <a href="https://steamdb.info/app/2778580/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">ELDEN RING Shadow of the Erdtree</a>; * <a href="https://steamdb.info/app/2567870/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Chained Together</a>; * <a href="https://steamdb.info/app/1091500/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Cyberpunk 2077</a>; * <a href="https://steamdb.info/app/271590/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Grand Theft Auto V</a>; * <a href="https://steamdb.info/app/2358720/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Black Myth: Wukong</a>; * <a href="https://steamdb.info/app/1174180/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Red Dead Redemption 2</a>; * <a href="https://steamdb.info/app/1293830/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Forza Horizon 4</a>; <i>* excluding free to play games</i> <a href="https://steamdb.info/topsellers/2024W29/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">View top 100 on SteamDB</a>	0	2024-07-16 02:00:00-07	2026-05-01 16:42:28.35472
1830163047259363	1245620	ELDEN RING: SHADOW OF THE ERDTREE – Official Vinyl Soundtrack	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1830163047259363	[BNE] *****	Follow in the foosteps of Miquella once more with this exclusive 2 disc vinyl collection, celebrating the sweeping, emotional journey of Shadow of the Erdtree. Presented with the reverence merited by a legendary expansion, this premium set is crafted for collectors, audiophiles, and Tarnished who se...	1	2026-04-17 01:00:23-07	2026-05-01 16:44:56.655052
1828894815562916	1245620	Have a gander at this cut Elden Ring scene showing a smidge of DLC boss Miquella's past	https://steamstore-a.akamaihd.net/news/externalpost/Rock, Paper, Shotgun/1828894815562916	\N	FromSoftware has an obvious penchant for secrets, their games are just littered with them. This is probably best exemplified in <a href="https://www.rockpapershotgun.com/elden-ring-boss-locations">Elden Ring</a> for the simple fact that the game is unapproachably massive, you're more than likely to find at least one secret somewhere along the line even just by accident. ...	0	2026-04-04 13:27:02-07	2026-05-01 16:44:56.655052
1826992588602001	1245620	"We don't reuse enough": Far Cry 4 director says developers need to stop doing "pointless work" and learn lessons from Elden Ring and Like A Dragon	https://steamstore-a.akamaihd.net/news/externalpost/Rock, Paper, Shotgun/1826992588602001	\N	No matter how many times you walk through the Like A Dragon series' nearly ever-present stomping ground of Kamurocho, odds are you'll never get sick of seeing its streets and alleyways. RGG Studio are among many studios - <a href="https://www.rockpapershotgun.com/elden-ring-boss-locations">Elden Ring</a> developers Fromsoftware included - who've seen their creative asset...	0	2026-03-16 09:15:53-07	2026-05-01 16:44:56.655052
1823191198601680	1245620	Discover the ELDEN RING Blaidd The Half-Wolf Lamp	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1823191198601680	[BNE] *****	Summon the legendary warrior into your world with the Blaidd The Half-Wolf Lamp, a handcrafted, LED-powered tribute to one of ELDEN RING’s most iconic character. Designed for collectors, lore enthusiasts, and Tarnished alike, this unique night lamp captures the tragic loyalty and silent strength of ...	1	2026-01-29 02:00:43-07	2026-05-01 16:44:56.655052
1819386365104358	1245620	Steam Global Top Sellers for week of 16 Dec — 23 December 2025	https://steamstore-a.akamaihd.net/news/externalpost/SteamDB/1819386365104358	SteamDB	<a href="https://steamdb.info/topsellers/2025W52/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS"> </a> * <a href="https://steamdb.info/app/1808500/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">ARC Raiders</a>; * <a href="https://steamdb.info/app/1675200/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Steam Deck</a>; * <a href="https://steamdb.info/app/1903340/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Clair Obscur: Expedition 33</a>; * <a href="https://steamdb.info/app/1086940/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Baldur's Gate 3</a>; * <a href="https://steamdb.info/app/2807960/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Battlefield™ 6</a>; * <a href="https://steamdb.info/app/1771300/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Kingdom Come: Deliverance II</a>; * <a href="https://steamdb.info/app/3405690/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">EA SPORTS FC™ 26</a>; * <a href="https://steamdb.info/app/2694490/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Path of Exile 2</a>; * <a href="https://steamdb.info/app/2592160/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">Dispatch</a>; * <a href="https://steamdb.info/app/1245620/charts/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">ELDEN RING</a>; <i>* excluding free to play games</i> <a href="https://steamdb.info/topsellers/2025W52/?utm_source=Steam&utm_medium=Steam&utm_campaign=SteamRSS">View top 100 on SteamDB</a>	0	2025-12-23 02:00:00-07	2026-05-01 16:44:56.655052
1818752592134836	1245620	Release Note for 2025/12/16	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1818752592134836	katsuki_honjo	To address the security vulnerability announced by Unity Technologies on October 3, 2025, an update to some pre-order bonuses, as well as the artwork & soundtrack application was distributed.The main game is not impacted by the security vulnerability and the update.Thank you for your understanding.	1	2025-12-16 00:05:57-07	2026-05-01 16:44:56.655052
1815580768356470	1245620	Elden Ring's most comprehensive and faithful fan-made overhaul launches its biggest update yet, with full multiplayer	https://steamstore-a.akamaihd.net/news/externalpost/PCGamesN/1815580768356470	editor@pcgamesn.com	Nightreign might be the hot topic now, but there are still plenty of reasons to return to <strong>Elden Ring</strong> proper, especially when the <a href="https://www.pcgamesn.com/elden-ring/mods-best">best Elden Ring mods</a> are involved. One of the finest among them is Elden Ring Reforged, which sits behind only Seamless Co-Op, the item randomizer, and The Convergence whe...	0	2025-11-09 04:21:47-07	2026-05-01 16:44:56.655052
1814309641464555	1245620	Elden Ring: Tarnished Edition для Nintendo Switch 2 перенесли на 2026 год — нужно устранить проблемы с производительностью	https://steamstore-a.akamaihd.net/news/externalpost/Gamemag.ru/1814309641464555	Семен Страндов	<strong>FromSoftware</strong> и <strong>Bandai Namco </strong>приняли решение о переносе <strong>Elden Ring: Tarnished Edition </strong>для <strong>Nintendo Switch 2</strong> на 2026 год. Разработчикам потребовалось дополнительное время на оптимизацию и улучшение производительности — <a href="https://gamemag.ru/news/195731/ign-elden-ring-on-switch-2-is-a-disaster-in-handheld-mode"><strong>демоверсию с Gamescom 2025 обозреватели и игроки критиковали</strong></a>. 	0	2025-10-23 16:57:00-07	2026-05-01 16:44:56.655052
1830797770233956	1145350	Post-Launch Patch 2 - Hotfix 2	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1830797770233956	kid_zomb	· During Dream Dives, increased the chance of Boons being offered in Shops in Tartarus or the Summit if either of these is the first or second Region · During Dream Dives, slightly increased how much Gold you will earn from Encounters in Tartarus or the Summit if either of these is the first or seco...	1	2026-04-23 11:14:42-07	2026-05-01 17:44:17.791371
1830163047269309	1145350	"Mythology, by its nature, is told and retold": Hades 2 dev on changing its controversial ending	https://steamstore-a.akamaihd.net/news/externalpost/Rock, Paper, Shotgun/1830163047269309	\N	Last year, <a href="https://www.rockpapershotgun.com/games/hades-2">Hades 2</a> left early access, and <a href="https://www.rockpapershotgun.com/hades-2-10-review">Mark liked it</a>! He did note, however, that its ending was potentially going to end up polarising, and with the accuracy of The Fates, this came to pass: <a href="https://www.rockpapershotgun.com/hades-2-post-launch-patch-1-revamps-melinoes-true-ending-and-is-out-now-in-steam-preview-form">Supergiant changed the game's true ending a month after its 1.0 launch</a> because enough people didn't like i...	0	2026-04-21 11:00:00-07	2026-05-01 17:44:17.791371
1830163047255984	1145350	Post-Launch Patch 2 - Hotfix 1	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1830163047255984	kid_zomb	· Fixed various rare crashes reported since Post-Launch Patch 2 · Fixed an issue where you could not interact with Nemesis while a Night Bloom servant was present · Fixed one of Aphrodite's new dialogue events occurring earlier than intended · Fixed rewards appearing out of bounds during Dream Dives...	1	2026-04-15 13:58:12-07	2026-05-01 17:44:17.791371
1830163047254985	1145350	Hades 2 update leaves its biggest secret out of the patch notes: a new game mode	https://steamstore-a.akamaihd.net/news/externalpost/PCGamesN/1830163047254985	editor@pcgamesn.com	The latest <strong>Hades 2</strong> update has introduced an entirely new game mode, but you wouldn't know it from reading the patch notes. I love it when developers sneak a surprise into their games without telling players up-front, but if you've already wrapped up your time with the <a href="https://www.pcgamesn.com/best-roguelike-games-pc">roguelike</a> you could be forgiven...	0	2026-04-15 04:52:36-07	2026-05-01 17:44:17.791371
1829528821318790	1145350	Hades 2's second post-launch patch adds in more prophecy conclusions and flirtier friends	https://steamstore-a.akamaihd.net/news/externalpost/Rock, Paper, Shotgun/1829528821318790	\N	The work of an early access game, even when it's hit 1.0, is never truly done. That is certainly the case for <a href="https://www.rockpapershotgun.com/games/hades-2">Hades 2</a>, which has received its second post-launch patch today. Nothing mind blowing has been added in with this one, but there does seem to be a few more narrative threads tied up, and a nu...	0	2026-04-14 11:00:03-07	2026-05-01 17:44:17.791371
1829528821318255	1145350	Post-Launch Patch 2 Notes	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1829528821318255	kid_zomb	We're very grateful for all your support of Hades II since our v1.0 launch last fall, and all through our Early Access development before then! With that in mind, we're pleased to present our second Post-Launch Patch, which includes some bonus content and quality-of-life improvements we've been work...	1	2026-04-14 09:07:13-07	2026-05-01 17:44:17.791371
1819386365120818	1145350	Hades II Earns 'Best Game on Steam Deck' Award!	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1819386365120818	kid_zomb	We're thrilled and honored to see Hades II named Best Game on Steam Deck in the Steam Awards!! {STEAM_CLAN_IMAGE}/43315153/649355cc33b8569ecc1c6648fc90cfe6dded0a45.png Thanks so much to everyone who voted, as your votes determined the nominees in each category and ultimately the winners. So many gre...	1	2026-01-03 11:34:35-07	2026-05-01 17:44:17.791371
1819386365102594	1145350	Yuletide Greetings from Supergiant!	https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/1819386365102594	kid_zomb	As the year draws to a close, we wanted to reflect on the times gone by, but mostly to say THANK YOU for supporting Hades II and our team! {STEAM_CLAN_IMAGE}/43315153/6c6d6b770fca9546e0b214a4a7e0d379bfd911a6.png Featured here are some of the familiar faces from the Crossroads, under more-festive cir...	1	2025-12-22 11:19:47-07	2026-05-01 17:44:17.791371
\.
COPY public.owns (steam_id, app_id, playtime_forever, ownership_last_fetched_at) FROM stdin;
76561199744319624	2567870	1	2026-05-01 16:42:25.889922
\.
COPY public.recently_played (steam_id, app_id, playtime_2weeks, playtime_forever, recent_last_fetched_at, last_played_at) FROM stdin;
\.
COPY public.user_endpoint_status (steam_id, endpoint_name, status, last_checked_at, details) FROM stdin;
76561199744319624	recently_played	private	2026-05-01 16:42:25.888378	Steam did not return recently played data for this user.
76561199744319624	owned_games	available	2026-05-01 16:42:25.889922	\N
76561199744319624	player_achievements	private	2026-05-01 16:45:23.66531	Steam did not return player achievement data for this game.
\.
COPY public.users (steam_id, display_name, avatar_url, profile_url, profile_last_fetched_at) FROM stdin;
76561199744319624	ABDULLA_ABDULLA	https://avatars.steamstatic.com/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg	https://steamcommunity.com/profiles/76561199744319624/	2026-05-01 18:06:28.420276
\.
ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (app_id, api_name);
ALTER TABLE ONLY public.completes
    ADD CONSTRAINT completes_pkey PRIMARY KEY (steam_id, app_id, api_name);
ALTER TABLE ONLY public.endpoint
    ADD CONSTRAINT endpoint_pkey PRIMARY KEY (endpoint_name);
ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (app_id);
ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_pkey PRIMARY KEY (gid);
ALTER TABLE ONLY public.owns
    ADD CONSTRAINT owns_pkey PRIMARY KEY (steam_id, app_id);
ALTER TABLE ONLY public.recently_played
    ADD CONSTRAINT recently_played_pkey PRIMARY KEY (steam_id, app_id);
ALTER TABLE ONLY public.user_endpoint_status
    ADD CONSTRAINT user_endpoint_status_pkey PRIMARY KEY (steam_id, endpoint_name);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (steam_id);
CREATE INDEX idx_achievements_app_id ON public.achievements USING btree (app_id);
CREATE INDEX idx_completes_lookup ON public.completes USING btree (steam_id, app_id);
CREATE INDEX idx_games_name_lower ON public.games USING btree (lower((name)::text));
CREATE INDEX idx_news_articles_app_id ON public.news_articles USING btree (app_id);
CREATE INDEX idx_news_articles_published_at ON public.news_articles USING btree (published_at DESC);
CREATE INDEX idx_owns_steam_id ON public.owns USING btree (steam_id);
CREATE INDEX idx_recently_played_steam_id ON public.recently_played USING btree (steam_id);
ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_app_id_fkey FOREIGN KEY (app_id) REFERENCES public.games(app_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.completes
    ADD CONSTRAINT completes_app_id_api_name_fkey FOREIGN KEY (app_id, api_name) REFERENCES public.achievements(app_id, api_name) ON DELETE CASCADE;
ALTER TABLE ONLY public.completes
    ADD CONSTRAINT completes_steam_id_fkey FOREIGN KEY (steam_id) REFERENCES public.users(steam_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_app_id_fkey FOREIGN KEY (app_id) REFERENCES public.games(app_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.owns
    ADD CONSTRAINT owns_app_id_fkey FOREIGN KEY (app_id) REFERENCES public.games(app_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.owns
    ADD CONSTRAINT owns_steam_id_fkey FOREIGN KEY (steam_id) REFERENCES public.users(steam_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.recently_played
    ADD CONSTRAINT recently_played_app_id_fkey FOREIGN KEY (app_id) REFERENCES public.games(app_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.recently_played
    ADD CONSTRAINT recently_played_steam_id_fkey FOREIGN KEY (steam_id) REFERENCES public.users(steam_id) ON DELETE CASCADE;
ALTER TABLE ONLY public.user_endpoint_status
    ADD CONSTRAINT user_endpoint_status_endpoint_name_fkey FOREIGN KEY (endpoint_name) REFERENCES public.endpoint(endpoint_name) ON DELETE CASCADE;
ALTER TABLE ONLY public.user_endpoint_status
    ADD CONSTRAINT user_endpoint_status_steam_id_fkey FOREIGN KEY (steam_id) REFERENCES public.users(steam_id) ON DELETE CASCADE;
\unrestrict ETjqi3m4QUES8R5bM6w8NhBprMaa2oCewmh8Dxp5cTnXkqyETWqS0gAz0tcrmn0
