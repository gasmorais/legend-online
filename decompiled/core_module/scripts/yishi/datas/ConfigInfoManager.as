package yishi.datas
{
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleDictionary;
   
   public class ConfigInfoManager
   {
      
      private static var _instance:ConfigInfoManager;
      
      public function ConfigInfoManager()
      {
         super();
      }
      
      public static function get instance() : ConfigInfoManager
      {
         if(!_instance)
         {
            _instance = new ConfigInfoManager();
         }
         return _instance;
      }
      
      public function getGoldPoints() : Array
      {
         return getKeyToArr("Gold_Points");
      }
      
      public function getSoulPoints() : Array
      {
         return getKeyToArr("Soul_Points");
      }
      
      public function getBottlePrice() : Array
      {
         return getKeyToArr("Bottle_Price");
      }
      
      public function getCattoysPoint() : int
      {
         return getKeyToInt("Cattoys_Point");
      }
      
      public function getActiveVehicleMountId() : int
      {
         return getKeyToInt("snow_vehicle_mount_id");
      }
      
      public function gettheseusdungeon() : Array
      {
         return getKeyToArr("t_s_theseusdungeon_pay",",");
      }
      
      public function getMailCheckPrize() : Array
      {
         return getKeyToArr("mail_rewards","|");
      }
      
      public function getRentalBagDayCost() : Array
      {
         return getKeyToArr2("rental_bag_day_cost");
      }
      
      public function getStackHeadAttackBuff() : Array
      {
         return getKeyToArr("stack_head_attack_buff",",");
      }
      
      public function getStackHeadDefenceBuff() : Array
      {
         return getKeyToArr("stack_head_defence_buff",",");
      }
      
      public function getStackHeadReadyBuffMax() : int
      {
         return getKeyToInt("stack_head_ready_buff_max");
      }
      
      public function getStackHeadWeekUnion() : Array
      {
         return getKeyToArr("stack_head_week_union",",");
      }
      
      public function getStackHeadJoinFee() : int
      {
         return getKeyToInt("stack_head_join_fee");
      }
      
      public function getStackHeadSeniorGeneralBuff() : Array
      {
         return getKeyToArr("stack_head_senior_general_buff",",");
      }
      
      public function getStackHeadActionPoint() : Array
      {
         return getKeyToArr("stack_head_action_point","|");
      }
      
      public function getStackHeadChargePoint() : int
      {
         return getKeyToInt("stack_head_charge_point");
      }
      
      public function getHugeHeadBattleMaxScore() : int
      {
         return getKeyToInt("huge_head_node_battle_max_score");
      }
      
      public function hugeHeadExploreChargePoint() : Array
      {
         return getKeyToArr("huge_head_explore_charge_point",",");
      }
      
      public function hugeHeadDaliyReward() : Array
      {
         return getKeyToArr("huge_head_daliy_reward","|");
      }
      
      public function getHugeHeadExploreDiceCost() : int
      {
         return getKeyToInt("huge_head_explore_dice_cost");
      }
      
      public function getHugeHeadExplorePoint() : int
      {
         return getKeyToInt("huge_head_explore_point");
      }
      
      public function getHugeHeadExploreEnterCost() : int
      {
         return getKeyToInt("huge_head_explore_enter_point");
      }
      
      public function getHugeHeadAttackCount() : int
      {
         return getKeyToInt("huge_head_attack_count");
      }
      
      public function getHugeHeadOpenTime() : Array
      {
         return getKeyToArr("huge_head_open_time","|");
      }
      
      public function getStackHeadOpenTime() : Array
      {
         return getKeyToArr("stack_head_open_time","|");
      }
      
      public function getTitanOpenTime() : Array
      {
         return getKeyToArr("huge_titan_open_time","|");
      }
      
      public function getTitanLandSkill() : Array
      {
         return getKeyToArr("titanland_skill",",");
      }
      
      public function getTitanLandBuff() : Array
      {
         return getKeyToArr("titanland_buff","|");
      }
      
      public function getTitanLandFightCount() : Array
      {
         return getKeyToArr("titanland_fightcount_buy",",");
      }
      
      public function getTitanLandSkillCount() : Array
      {
         return getKeyToArr("titanland_skillcount_buy","|");
      }
      
      public function getBingoBuy() : Array
      {
         return getKeyToArr("bingo_buy",",");
      }
      
      public function getBingoPondInit() : int
      {
         return getKeyToInt("bingo_pond_init");
      }
      
      public function getBingoPondAddition() : Array
      {
         return getKeyToArr("bingo_pond_addition","|");
      }
      
      public function getBingoPLimit() : Array
      {
         return getKeyToArr("bingo_p_limit",",");
      }
      
      public function getShuttleResetFree() : int
      {
         return getKeyToInt("shuttle_reset_free");
      }
      
      public function getShuttleReset() : Array
      {
         return getKeyToArr("shuttle_reset",",");
      }
      
      public function getShuttleRefresh() : Array
      {
         return getKeyToArr("shuttle_refresh",",");
      }
      
      public function getArcaneZoneMax() : int
      {
         return getKeyToInt("arcane_zone_max");
      }
      
      public function getArcaneZoneBuyCount() : Array
      {
         return getKeyToArr("arcane_zone_buy_count",",");
      }
      
      public function getArcaneZoneBossTempId() : Array
      {
         return getKeyToArr("arcane_zone_boss_temp_id","|");
      }
      
      public function getArchaeologyMonsterMaxCount() : int
      {
         return getKeyToInt("world_map_archaeology_monster_max_count");
      }
      
      public function getArchaeologyMonsterEscapeTime() : int
      {
         return getKeyToInt("world_map_archaeology_monster_escape_time");
      }
      
      public function getArchaeologyMonsterMaxKill() : int
      {
         return getKeyToInt("world_map_archaeology_monster_max_kill");
      }
      
      public function getMagicPubPresentCount() : int
      {
         return getKeyToInt("magic_pub_present_count");
      }
      
      public function getPetUpApt() : int
      {
         return getKeyToInt("pet_up_apt");
      }
      
      public function getNavigationStrengthMax() : int
      {
         return getKeyToInt("navigation_strength_default");
      }
      
      public function getNavigationStrengthShipping() : int
      {
         return getKeyToInt("navigation_strength_shipping");
      }
      
      public function getNavigationStrengthBuyPoint() : int
      {
         return getKeyToInt("navigation_strength_buy_point");
      }
      
      public function getNavigationStrengthBuyNum() : int
      {
         return getKeyToInt("navigation_strength_buy_num");
      }
      
      public function getNavigationStrengthAssistSpeedup() : int
      {
         return getKeyToInt("navigation_strength_assist_speedup");
      }
      
      public function getNavigationPortTaskRefreshPoint() : int
      {
         return getKeyToInt("navigation_port_task_refresh_point");
      }
      
      public function getNavigationPortTaskRefreshCd() : int
      {
         return getKeyToInt("navigation_port_task_refresh_cd");
      }
      
      public function getNavigationBoaActivatePoint() : int
      {
         return getKeyToInt("navigation_boat_activate_point");
      }
      
      public function getNavigationBoatStoppingCd() : int
      {
         return getKeyToInt("navigation_boat_stopping_cd");
      }
      
      public function getNavigationBoatShippingCd() : int
      {
         return getKeyToInt("navigation_boat_shipping_cd");
      }
      
      public function getNavigationBoatUpgradeCd() : int
      {
         return getKeyToInt("navigation_boat_upgrade_cd");
      }
      
      public function getNavigationBoatUpgradeInviteNum() : int
      {
         return getKeyToInt("navigation_boat_upgrade_invite_num");
      }
      
      public function getNavigationBoatUpgradeAssistNum() : int
      {
         return getKeyToInt("navigation_boat_upgrade_assist_num");
      }
      
      public function getNavigationBoatUpgradeSpeedupCd() : int
      {
         return getKeyToInt("navigation_boat_upgrade_speedup_cd");
      }
      
      public function getNavigationCurrencyAssistSpeedup() : int
      {
         return getKeyToInt("navigation_currency_assist_speedup");
      }
      
      public function getNavigationShopBuyNum() : int
      {
         return getKeyToInt("navigation_shop_buy_num");
      }
      
      public function getNavigationShopRefreshPoint() : int
      {
         return getKeyToInt("navigation_shop_refresh_point");
      }
      
      public function getNavigationShopRefreshCd() : int
      {
         return getKeyToInt("navigation_shop_refresh_cd");
      }
      
      public function getTattooEnhanceConsumeItem() : Array
      {
         return getKeyToArr2("tattoo_enhance_consume_item");
      }
      
      public function getTattooEnhanceWishPoint() : int
      {
         return getKeyToInt("tattoo_enhance_wish_point");
      }
      
      public function getChildTransPoint() : int
      {
         return getKeyToInt("Trans_Point");
      }
      
      public function getOpenConsortiaDemonCost() : int
      {
         return getKeyToInt("Consortia_OpenAltar1_Offer");
      }
      
      public function getMatelordsJoinCost() : int
      {
         return getKeyToInt("Mate_Join");
      }
      
      public function getMatelordsInspireCost() : int
      {
         return getKeyToInt("Mate_Inspire");
      }
      
      public function getMatelordsTeamSorce() : Array
      {
         return getKeyToArr("Mate_TeamType");
      }
      
      public function getFashionBoxArr() : Array
      {
         return getKeyToArr2("fashion_lottery_buy");
      }
      
      public function getMountBoxArr() : Array
      {
         return getKeyToArr2("mount_lottery_buy");
      }
      
      public function getRvrMatchTime() : Array
      {
         return getKeyToArr2("cross_war_open_time");
      }
      
      public function getPvpMatchTime() : Array
      {
         return getKeyToArr2("MatchTime");
      }
      
      public function getVehicleMatchTime() : Array
      {
         return getKeyToArr2("MatchOfVehicleTime");
      }
      
      public function getMultiMatchTime() : Array
      {
         return getKeyToArr2("Multi_Match");
      }
      
      public function getChildArenaMatchTime() : Array
      {
         return getKeyToArr2("GuardScuffleOpenTime");
      }
      
      public function getPokerOpenTime() : Array
      {
         return getKeyToArr2("poker_open_time");
      }
      
      public function getGiftWillTime() : Array
      {
         return getKeyToArr2("Gift_Times");
      }
      
      public function getGiftWillTime2() : Array
      {
         return getKeyToArr("Gift_Times","|");
      }
      
      public function getFragPoint() : int
      {
         return getKeyToInt("Frag_Point");
      }
      
      public function getDayLightOpenTime() : Array
      {
         return getKeyToArr2("daylight_open_time");
      }
      
      public function getCrossGuildWinRewards() : Array
      {
         return getKeyToArr2("cross_guild_single_reward_win");
      }
      
      public function getCrossGuildLostRewards() : Array
      {
         return getKeyToArr2("cross_guild_single_reward_lost");
      }
      
      public function getCrossGuildSignCost() : int
      {
         return getKeyToInt("cross_guild_sign_in_offer");
      }
      
      public function getCrossGuildMaxScore() : int
      {
         return getKeyToInt("cross_guild_war_score_max");
      }
      
      public function getCrossGuildMoveCost() : int
      {
         return getKeyToInt("cross_guild_point_move_cost");
      }
      
      public function getCrossGuildMaxPoint() : int
      {
         return getKeyToInt("cross_guild_point_max");
      }
      
      public function getCrossGuildInspire() : Array
      {
         return getKeyToArr("cross_guild_buff_self");
      }
      
      public function getCrossGuildNodeInspire() : Array
      {
         return getKeyToArr("cross_guild_buff_node");
      }
      
      public function getCrossGuildActionPointCost() : Array
      {
         return getKeyToArr("cross_guild_point_charge");
      }
      
      public function getCrossGuildSpeedCost() : Array
      {
         return getKeyToArr("cross_guild_skill_cost_speed");
      }
      
      public function getCrossGuildDisturbCost() : Array
      {
         return getKeyToArr("cross_guild_skill_cost_disturb");
      }
      
      public function getCrossGuildStrikeCost() : Array
      {
         return getKeyToArr("cross_guild_skill_cost_strike");
      }
      
      public function getCrossGuildPointRestore() : Array
      {
         return getKeyToArr2("cross_guild_point_restore");
      }
      
      public function getAresNeedGold() : int
      {
         return getKeyToInt("Ares_NeedGold");
      }
      
      public function getAresReward() : Array
      {
         return getKeyToArr("Ares_TeamReward");
      }
      
      public function getAresRefreshSkillCost() : int
      {
         return getKeyToInt("Ares_Skill");
      }
      
      public function getAresScoreLess() : int
      {
         return getKeyToInt("Ares_ScoreLess");
      }
      
      public function getAresTeamScore() : Array
      {
         return getKeyToArr("Ares_TeamType");
      }
      
      public function getFantasyMatrixBoxTempId() : int
      {
         return getKeyToInt("fantasy_matrix_box_temp_id");
      }
      
      public function getCrossGuildStoneTempId() : int
      {
         return getKeyToInt("cross_guild_point_stone");
      }
      
      public function getFantasyMatrixScoreReward() : Array
      {
         return getKeyToArr2("fantasy_matrix_score_reward");
      }
      
      public function getBraveLegSignUpGold() : int
      {
         return getKeyToInt("Brave_NeedGold");
      }
      
      public function getBraveLegTeamScore() : Array
      {
         return getKeyToArr("Brave_TeamType");
      }
      
      public function getBraveLegInspireGold() : int
      {
         return getKeyToInt("Brave_Inspire");
      }
      
      public function getPetHallowsInscriptionLockArr() : Array
      {
         return getKeyToArr("Lock_PetHallow");
      }
      
      public function getChildNsLifeWheelExp() : Array
      {
         return getKeyToArr("life_wheel_gps");
      }
      
      public function getChildNsExpLockMaxCount() : int
      {
         return getKeyToInt("life_wheel_lock_gp_count");
      }
      
      public function getPetChallengeGroupArr() : Array
      {
         return getKeyToArr("Pet_Challenge_Default_Score_Line");
      }
      
      public function getPetChallengeMaxCount() : int
      {
         if(checkIsConfigExist("Pet_Challenge_Count"))
         {
            return getKeyToInt("Pet_Challenge_Count");
         }
         return 10;
      }
      
      public function getPerkibnRobMaxCount() : int
      {
         if(checkIsConfigExist("perkin_lab_rob_count"))
         {
            return getKeyToInt("perkin_lab_rob_count");
         }
         return 5;
      }
      
      public function getPerkinRobCdCost() : int
      {
         if(checkIsConfigExist("perkin_lab_rob_count"))
         {
            return getKeyToInt("perkin_lab_rob_count");
         }
         return 5;
      }
      
      public function getPerkinRipTime() : Array
      {
         if(checkIsConfigExist("perkin_lab_harvest_hour"))
         {
            return getKeyToArr("perkin_lab_harvest_hour");
         }
         return [3,1];
      }
      
      public function getPerkinCdRobCost() : Array
      {
         if(checkIsConfigExist("perkin_lab_rob_cool_need_point"))
         {
            return getKeyToArr("perkin_lab_rob_cool_need_point");
         }
         return [1,1];
      }
      
      public function getIsExploreSpeedItem() : Array
      {
         if(checkIsConfigExist("explore_prop"))
         {
            return getKeyToArr2("explore_prop");
         }
         return ["-400,100,60","-500,200,120"];
      }
      
      public function getTitanSkillGroupCost() : int
      {
         if(checkIsConfigExist("titan_open_page_need_point"))
         {
            return getKeyToInt("titan_open_page_need_point");
         }
         return 200;
      }
      
      public function getTitanSkillItemCost() : Array
      {
         if(checkIsConfigExist("titan_open_slot_need_item"))
         {
            return getKeyToArr("titan_open_slot_need_item");
         }
         return [212013,100];
      }
      
      public function getChildWarBossBuffByDif(param1:int) : Array
      {
         if(checkIsConfigExist("guard_war_boss_buff" + param1))
         {
            return getKeyToArr2("guard_war_boss_buff" + param1);
         }
         return ["590001,212009,10","590002,212009,10","590003,212009,10","590004,212009,10"];
      }
      
      public function getChildPvpTimes() : Array
      {
         if(checkIsConfigExist("guard_pvp_gimes"))
         {
            return getKeyToArr("guard_pvp_gimes");
         }
         return ["15:00","00:00","01:00","14:00","14:40"];
      }
      
      public function getChildPvpBetGold() : int
      {
         if(checkIsConfigExist("guard_pvp_bet_need_gold"))
         {
            return getKeyToInt("guard_pvp_bet_need_gold");
         }
         return 1000000;
      }
      
      public function getConsortiaRentalBagDayCost() : Array
      {
         return getKeyToArr2("consortia_storage_offer");
      }
      
      public function getAlchemicalSpeedMaxCount() : int
      {
         if(checkIsConfigExist("alchemyworkshop_max_speedup_times"))
         {
            return getKeyToInt("alchemyworkshop_max_speedup_times");
         }
         return 5;
      }
      
      public function getAlchemicalSpeedCostPoint() : Array
      {
         if(checkIsConfigExist("alchemyworkshop_speed_up_cost"))
         {
            return getKeyToArr("alchemyworkshop_speed_up_cost");
         }
         return [5,10];
      }
      
      public function getAlchemicalFormulaMaxTime() : int
      {
         if(checkIsConfigExist("alchemyworkshop_share_outtime"))
         {
            return getKeyToInt("alchemyworkshop_share_outtime");
         }
         return 24;
      }
      
      public function getAlchemicalFullScoreReward() : Array
      {
         if(checkIsConfigExist("alchemyworkshop_cycle_score"))
         {
            return getKeyToArr("alchemyworkshop_cycle_score");
         }
         return [300,3];
      }
      
      public function checkIsConfigExist(param1:String) : Boolean
      {
         if(TempleteManager.instance.getConfigInfoByConfigName(param1))
         {
            return true;
         }
         return false;
      }
      
      public function getKeyToInt(param1:String) : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName(param1).ConfigValue);
      }
      
      public function getKeyToString(param1:String) : String
      {
         return TempleteManager.instance.getConfigInfoByConfigName(param1).ConfigValue;
      }
      
      public function getKeyToArr(param1:String, param2:String = ",") : Array
      {
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName(param1);
         if(!_loc3_ || !_loc3_.ConfigValue)
         {
            return [];
         }
         return _loc3_.ConfigValue.split(param2);
      }
      
      public function getKeyToArr2(param1:String, param2:String = "|") : Array
      {
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName(param1);
         if(!_loc3_ || !_loc3_.ConfigValue)
         {
            return [];
         }
         return _loc3_.ConfigValue.split(param2);
      }
      
      public function getAssaultwarSignMoney() : int
      {
         if(checkIsConfigExist("Assault_sign_gold"))
         {
            return getKeyToInt("Assault_sign_gold");
         }
         return 500000;
      }
      
      public function getUnrealshootingTime() : String
      {
         if(checkIsConfigExist("unrealshooting_time"))
         {
            return TempleteManager.instance.getConfigInfoByConfigName("unrealshooting_time").ConfigValue;
         }
         return "16:00,16:15|21:00,21:15";
      }
      
      public function getUnrealshootingBuffer() : String
      {
         if(checkIsConfigExist("unreal_buffer"))
         {
            return TempleteManager.instance.getConfigInfoByConfigName("unreal_buffer").ConfigValue;
         }
         return "570303,1200|570304,1600|570305,1600|570306,1200|570307,2400";
      }
      
      public function getEquipAdvPoint() : Array
      {
         if(checkIsConfigExist("EquipAdv_Points"))
         {
            return getKeyToArr2("EquipAdv_Points",",");
         }
         return [30,10,90,30];
      }
      
      public function getMountStarPoint() : int
      {
         if(checkIsConfigExist("Mount_Star_Point"))
         {
            return getKeyToInt("Mount_Star_Point");
         }
         return 10;
      }
      
      public function getDragonTalkerInfoUpgradeConfig() : Array
      {
         if(checkIsConfigExist("DragonTalker_Gp_Item_Config"))
         {
            return getKeyToArr2("DragonTalker_Gp_Item_Config",",");
         }
         return [208066,10,208067,30];
      }
      
      public function getLeedDayConfig() : Array
      {
         if(checkIsConfigExist("leed_daily_config"))
         {
            return getKeyToArr2("leed_daily_config");
         }
         return ["1,100","2,150","3,200","4,250","5,300"];
      }
      
      public function getLeedWeekConfig() : Array
      {
         if(checkIsConfigExist("leed_weekly_config"))
         {
            return getKeyToArr2("leed_weekly_config");
         }
         return ["1,100","2,150"];
      }
      
      public function getGodsInspireCost() : int
      {
         if(checkIsConfigExist("gods_inspire"))
         {
            return getKeyToInt("gods_inspire");
         }
         return 100;
      }
      
      public function getChildArenaAutoSignVipGrade() : int
      {
         if(checkIsConfigExist("GuardPvp_AutoSign_VipGrade"))
         {
            return getKeyToInt("GuardPvp_AutoSign_VipGrade");
         }
         return 4;
      }
      
      public function getMountRefiningSoulTempId() : int
      {
         if(checkIsConfigExist("mount_refining_soul_item_temp_id"))
         {
            return getKeyToInt("mount_refining_soul_item_temp_id");
         }
         return 208070;
      }
      
      public function getMagicSpringOpenGrade() : int
      {
         if(checkIsConfigExist("magic_spring_open_grade"))
         {
            return getKeyToInt("magic_spring_open_grade");
         }
         return 50;
      }
      
      public function getMagicSpringItemTempId() : Array
      {
         if(checkIsConfigExist("magic_spring_item_tempid"))
         {
            return getKeyToArr("magic_spring_item_tempid");
         }
         return [250001,250002,250003,250004,250005,250006];
      }
      
      public function getMagicSpringSlotOpenCount() : Array
      {
         if(checkIsConfigExist("magic_spring_slot_open_count"))
         {
            return getKeyToArr2("magic_spring_slot_open_count");
         }
         return ["5,3,1","10,6,3","20,12,6","40,24,12"];
      }
      
      public function getMagicSpringOpenSlotCost() : Array
      {
         if(checkIsConfigExist("magic_spring_slot_open_forward_cost"))
         {
            return getKeyToArr("magic_spring_slot_open_forward_cost");
         }
         return [100,200,300,400];
      }
      
      public function getEclipticPalaceBackLayerHour() : int
      {
         if(checkIsConfigExist("ecliptic_palace_decline_layer_hour"))
         {
            return getKeyToInt("ecliptic_palace_decline_layer_hour");
         }
         return 8;
      }
      
      public function getEclipticPalaceSpiritMax() : int
      {
         if(checkIsConfigExist("ecliptic_palace_spirit_max"))
         {
            return getKeyToInt("ecliptic_palace_spirit_max");
         }
         return 200;
      }
      
      public function getEclipticPalaceRecoverPerHour() : int
      {
         if(checkIsConfigExist("ecliptic_palace_spirit_recover_per_hour"))
         {
            return getKeyToInt("ecliptic_palace_spirit_recover_per_hour");
         }
         return 15;
      }
      
      public function getEclipticPalaceSpiritBuyCost() : int
      {
         if(checkIsConfigExist("ecliptic_palace_spirit_buy_cost"))
         {
            return getKeyToInt("ecliptic_palace_spirit_buy_cost");
         }
         return 200;
      }
      
      public function getEclipticPalaceSpiritBuyCountMax() : int
      {
         if(checkIsConfigExist("ecliptic_palace_spirit_buy_count_max"))
         {
            return getKeyToInt("ecliptic_palace_spirit_buy_count_max");
         }
         return 5;
      }
      
      public function getMountRefiningSoulMaxValue() : int
      {
         if(checkIsConfigExist("mount_refining_soul_value_max"))
         {
            return getKeyToInt("mount_refining_soul_value_max");
         }
         return 200000;
      }
      
      public function getBattleGoddessMaxBelief() : int
      {
         if(checkIsConfigExist("goddess_belief_max"))
         {
            return getKeyToInt("goddess_belief_max");
         }
         return 120;
      }
      
      public function getLandMineItems() : Array
      {
         if(checkIsConfigExist("land_mine_items"))
         {
            return getKeyToArr2("land_mine_items");
         }
         return ["2030101,1","2030102,1","2030103,1","2030104,1"];
      }
      
      public function getLandMineMaxRewardCount() : int
      {
         if(checkIsConfigExist("land_mine_max_reward_count"))
         {
            return getKeyToInt("land_mine_max_reward_count");
         }
         return 1;
      }
      
      public function getNavigationFishingInterval() : int
      {
         if(checkIsConfigExist("navigation_fishing_reward_interval"))
         {
            return getKeyToInt("navigation_fishing_reward_interval");
         }
         return 120;
      }
      
      public function getNavigationFishingRewardMax() : int
      {
         if(checkIsConfigExist("navigation_fishing_reward_max"))
         {
            return getKeyToInt("navigation_fishing_reward_max");
         }
         return 10;
      }
      
      public function getNavigationFishingTime() : Array
      {
         if(checkIsConfigExist("navigation_fishing_time"))
         {
            return getKeyToArr2("navigation_fishing_time");
         }
         return ["11:30,12:00","18:00,18:30"];
      }
      
      public function getAltarReputationCost() : Array
      {
         if(checkIsConfigExist("Altar_Reputation_Cost"))
         {
            return getKeyToArr("Altar_Reputation_Cost");
         }
         return [0,20,30];
      }
      
      public function getCrossGuildSignWealth() : int
      {
         if(checkIsConfigExist("consortia_war_sign_offer"))
         {
            return getKeyToInt("consortia_war_sign_offer");
         }
         return 10000;
      }
      
      public function getCrossGuildSpiritConfig() : Array
      {
         if(checkIsConfigExist("consortia_war_sprite_config"))
         {
            return getKeyToArr("consortia_war_sprite_config");
         }
         return [100,5,10];
      }
      
      public function getCrossGuildWarDefend() : Array
      {
         if(checkIsConfigExist("consortia_war_defence"))
         {
            return getKeyToArr2("consortia_war_defence");
         }
         return ["1,3,1500,500","4,6,1200,400","7,10,900,300"];
      }
      
      public function getCrossGuildWarSkin() : Array
      {
         if(checkIsConfigExist("consortia_war_defence_skin"))
         {
            return getKeyToArr2("consortia_war_defence_skin");
         }
         return ["1,2,1","3,4,2","5,7,3","8,10,4"];
      }
      
      public function getCrossGuildAttackConfig() : Array
      {
         if(checkIsConfigExist("consortia_war_attack_config"))
         {
            return getKeyToArr("consortia_war_attack_config");
         }
         return [1,2,1,5];
      }
      
      public function getMonsterCallConifg() : Array
      {
         if(checkIsConfigExist("monster_call_config"))
         {
            return getKeyToArr2("monster_call_config");
         }
         return ["3,120","4,240","5,480"];
      }
      
      public function getMonsterCallPointConfig() : Array
      {
         if(checkIsConfigExist("monster_call_point_config"))
         {
            return getKeyToArr("monster_call_point_config");
         }
         return [100,200,500,1000];
      }
      
      public function getMonsterCookConfig() : Array
      {
         if(checkIsConfigExist("monster_cook_config"))
         {
            return getKeyToArr("monster_cook_config");
         }
         return [30,60,120];
      }
      
      public function getMonsterCookPointConfig() : Array
      {
         if(checkIsConfigExist("monster_cook_point_config"))
         {
            return getKeyToArr("monster_cook_point_config");
         }
         return [100,200,500,1000];
      }
      
      public function getMonsterFastFightConfig() : Array
      {
         if(checkIsConfigExist("monster_explore_fast_config"))
         {
            return getKeyToArr("monster_explore_fast_config");
         }
         return [2,120,1000];
      }
      
      public function getMonsterSkillLvBreak(param1:int) : Array
      {
         var _loc2_:String = "moster_skill_lv" + param1 + "break";
         if(checkIsConfigExist(_loc2_))
         {
            return getKeyToArr2(_loc2_);
         }
         return ["2330002,20;2330003,10;2330004,10;2330005,15","2330002,10;2330003,20;2330004,10;2330006,15","2330002,10;2330003,10;2330004,20;2330007,15"];
      }
      
      public function getMonsterExploreBossMaxCount() : int
      {
         if(checkIsConfigExist("monster_explore_boss_max_count"))
         {
            return getKeyToInt("monster_explore_boss_max_count");
         }
         return 10;
      }
      
      public function getMonsterOwnMaxCount() : int
      {
         if(checkIsConfigExist("monster_max_count "))
         {
            return getKeyToInt("monster_max_count ");
         }
         return 40;
      }
      
      public function getMvpShopRewardScale() : int
      {
         if(checkIsConfigExist("mvp_shop_reward_scale"))
         {
            return getKeyToInt("mvp_shop_reward_scale");
         }
         return 2;
      }
      
      public function getAntaeusFunCost() : Array
      {
         if(checkIsConfigExist("antaeus_money"))
         {
            return getKeyToArr("antaeus_money");
         }
         return [40,50,20,10];
      }
      
      public function getDreamArenaScoreConfig() : Array
      {
         if(checkIsConfigExist("dream_arena_score_config"))
         {
            return getKeyToArr("dream_arena_score_config");
         }
         return [100,20,5,10];
      }
      
      public function getDreamArenaStartTime() : String
      {
         if(checkIsConfigExist("dream_arena_start_date"))
         {
            return getKeyToString("dream_arena_start_date");
         }
         return "2018-11-1 00:00:00";
      }
      
      public function getDreamArenaStopTime() : String
      {
         if(checkIsConfigExist("dream_arena_stop_date"))
         {
            return getKeyToString("dream_arena_stop_date");
         }
         return "2018-11-11 00:00:00";
      }
      
      public function getDreamArenaFightTime() : Array
      {
         if(checkIsConfigExist("dream_arena_fight_time"))
         {
            return getKeyToArr("dream_arena_fight_time");
         }
         return ["1:00","23:00"];
      }
      
      public function getDreamArenaTicket() : int
      {
         if(checkIsConfigExist("dreamarean_ticket_id"))
         {
            return getKeyToInt("dreamarean_ticket_id");
         }
         return 208111;
      }
      
      public function getEastOpenTime() : String
      {
         if(checkIsConfigExist("east_open_date"))
         {
            return getKeyToString("east_open_date");
         }
         return "2018-11-11 00:00:00";
      }
      
      public function getAirGardenUpCd() : int
      {
         if(checkIsConfigExist("air_garden_up_cd"))
         {
            return getKeyToInt("air_garden_up_cd");
         }
         return 240;
      }
      
      public function getAirGardenPartyCost() : int
      {
         if(checkIsConfigExist("air_garden_party_cost"))
         {
            return getKeyToInt("air_garden_party_cost");
         }
         return 2000;
      }
      
      public function getAirGardenSelfUpMaxCount() : int
      {
         if(checkIsConfigExist("air_garden_up_single_max_count"))
         {
            return getKeyToInt("air_garden_up_single_max_count");
         }
         return 10;
      }
      
      public function getAirGardenUpMaxCount() : int
      {
         if(checkIsConfigExist("air_garden_up_max_count"))
         {
            return getKeyToInt("air_garden_up_max_count");
         }
         return 10;
      }
      
      public function getAirGardenGameCounts() : Array
      {
         if(checkIsConfigExist("air_garden_game_count"))
         {
            return getKeyToArr("air_garden_game_count");
         }
         return [9,9,9];
      }
      
      public function getAirGardenPartyTime() : Array
      {
         if(checkIsConfigExist("air_garden_party_time"))
         {
            return getKeyToArr("air_garden_party_time");
         }
         return ["4#14:00","5#18:00"];
      }
      
      public function getEasterLotteryEggCount() : int
      {
         if(checkIsConfigExist("easter_lottery_egg_count"))
         {
            return getKeyToInt("easter_lottery_egg_count");
         }
         return 1;
      }
      
      public function getEasterTicketConfig() : String
      {
         if(checkIsConfigExist("easter_ticket_config"))
         {
            return getKeyToString("easter_ticket_config");
         }
         return "100,10,5,5";
      }
      
      public function getEasterBufferConfig() : String
      {
         if(checkIsConfigExist("easter_egg_buff_config"))
         {
            return getKeyToString("easter_egg_buff_config");
         }
         return "3,1000,35,6";
      }
      
      public function getMountFlyPrice() : int
      {
         if(checkIsConfigExist("mount_buy_fly_point"))
         {
            return getKeyToInt("mount_buy_fly_point");
         }
         return 1000;
      }
      
      public function getConsortiaWarAttackBuffConfig() : String
      {
         if(checkIsConfigExist("consortia_war_attack_buff"))
         {
            return getKeyToString("consortia_war_attack_buff");
         }
         return "2,10";
      }
      
      public function getConsortiaWarightTime() : String
      {
         if(checkIsConfigExist("consortia_war_fight_time"))
         {
            return getKeyToString("consortia_war_fight_time");
         }
         return "5:00,23:00";
      }
      
      public function getLeedBuyBuffPoint() : int
      {
         if(checkIsConfigExist("leed_buy_buff_point"))
         {
            return getKeyToInt("leed_buy_buff_point");
         }
         return 1000;
      }
      
      public function getRedemptionRoadLayerConfig() : Array
      {
         if(checkIsConfigExist("redemption_road_layers"))
         {
            return getKeyToArr("redemption_road_layers");
         }
         return [1,2,3,2,3,2,3,2,3,1];
      }
      
      public function getRedemptionRoadReward1() : Array
      {
         if(checkIsConfigExist("redemption_road_reward_1"))
         {
            return GoodsHelp.getCommonRewardAry(getKeyToString("redemption_road_reward_1"));
         }
         return [];
      }
      
      public function getRedemptionRoadReward2() : Array
      {
         if(checkIsConfigExist("redemption_road_reward_2"))
         {
            return GoodsHelp.getCommonRewardAry(getKeyToString("redemption_road_reward_2"));
         }
         return [];
      }
      
      public function getRedemptionRoadReward3() : Array
      {
         if(checkIsConfigExist("redemption_road_reward_3"))
         {
            return GoodsHelp.getCommonRewardAry(getKeyToString("redemption_road_reward_3"));
         }
         return [];
      }
      
      public function getRedemptionRoadCd() : Array
      {
         if(checkIsConfigExist("edemption_road_cd"))
         {
            return getKeyToArr("edemption_road_cd");
         }
         return [60,120];
      }
      
      public function getRedemptionRoadCostPoint() : int
      {
         if(checkIsConfigExist("redemption_road_point"))
         {
            return getKeyToInt("redemption_road_point");
         }
         return 100;
      }
      
      public function getNsTreasureMostRefreshCount() : Array
      {
         if(checkIsConfigExist("spirit_refresh_config"))
         {
            return getKeyToArr("spirit_refresh_config");
         }
         return [5,10,15,20,25,5];
      }
      
      public function getGoddessEquipmentDoubleStartTime() : String
      {
         if(checkIsConfigExist("goddess_equiment_double_start_date"))
         {
            return getKeyToString("goddess_equiment_double_start_date");
         }
         return "2019-01-01 00:00:00";
      }
      
      public function getGoddessEquipmentDoubleStopTime() : String
      {
         if(checkIsConfigExist("goddess_equiment_double_stop_date"))
         {
            return getKeyToString("goddess_equiment_double_stop_date");
         }
         return "2019-11-11 00:00:00";
      }
      
      public function getGuildWantedSelfBoxScore() : Array
      {
         if(checkIsConfigExist("consortia_want_personal_box_score"))
         {
            return getKeyToArr("consortia_want_personal_box_score");
         }
         return [50,100,150,200,250,300];
      }
      
      public function getGuildWantedGuildBoxScore() : Array
      {
         if(checkIsConfigExist("consortia_want_consortia_box_score"))
         {
            return getKeyToArr("consortia_want_consortia_box_score");
         }
         return [50,100,150,200,250,300];
      }
      
      public function getGuildWantedRefreshPoint() : int
      {
         if(checkIsConfigExist("consortia_want_refresh_cost"))
         {
            return getKeyToInt("consortia_want_refresh_cost");
         }
         return 20;
      }
      
      public function getSevenYearBuyGrade() : Array
      {
         if(checkIsConfigExist("seven_year_buy_grade_config"))
         {
            return getKeyToArr2("seven_year_buy_grade_config");
         }
         return ["25,1000","15,300","5,100"];
      }
      
      public function getSevenYearGradeScore() : int
      {
         if(checkIsConfigExist("seven_year_grade_score"))
         {
            return getKeyToInt("seven_year_grade_score");
         }
         return 1000;
      }
      
      public function getSevenYearGameScore() : int
      {
         if(checkIsConfigExist("seven_year_game_score"))
         {
            return getKeyToInt("seven_year_game_score");
         }
         return 200;
      }
      
      public function getActiveVehicleCampaignId() : int
      {
         return getKeyToInt("snow_vehicle_campaign_id");
      }
      
      public function getSnowVehicleOpenTime() : Array
      {
         if(checkIsConfigExist("snow_vehicle_open_time"))
         {
            return getKeyToArr2("snow_vehicle_open_time");
         }
         return ["2018-11-24 05:00","2018-12-28 05:00"];
      }
      
      public function getSnowVehicleDailyRewardMax() : int
      {
         if(checkIsConfigExist("snow_vehicle_daily_reward_max"))
         {
            return getKeyToInt("snow_vehicle_daily_reward_max");
         }
         return 500;
      }
      
      public function getSnowVehicleMatchMax() : int
      {
         if(checkIsConfigExist("snow_vehicle_match_max"))
         {
            return getKeyToInt("snow_vehicle_match_max");
         }
         return 8;
      }
      
      public function getSnowVehicleOrderReward() : Array
      {
         if(checkIsConfigExist("snow_vehicle_order_reward"))
         {
            return getKeyToArr2("snow_vehicle_order_reward");
         }
         return ["1,80","2,70","3,60","4,50","5,40","6,30","7,20","8,5"];
      }
      
      public function getSnowVehicleKillReward() : Array
      {
         if(checkIsConfigExist("snow_vehicle_kill_reward"))
         {
            return getKeyToArr2("snow_vehicle_kill_reward");
         }
         return ["1,10","2,40","3,60","4,80","5,100","6,120","7,140"];
      }
      
      public function getSnowVehicleDamageReward() : Array
      {
         if(checkIsConfigExist("snow_vehicle_damage_reward"))
         {
            return getKeyToArr2("snow_vehicle_damage_reward");
         }
         return ["1,1","10,10","20,20","30,30","40,40","50,50","60,60","70,70","80,80","90,90","100,100"];
      }
      
      public function getSnowVehiclePickSKillReward() : Array
      {
         if(checkIsConfigExist("snow_vehicle_pick_skill_reward"))
         {
            return getKeyToArr2("snow_vehicle_pick_skill_reward");
         }
         return ["1,10","2,20","3,30","4,40","5,50","6,60","7,70","8,80","9,90","10,100","11,110","12,120"];
      }
      
      public function getForecastAward() : int
      {
         if(checkIsConfigExist("glory_bet_best_count"))
         {
            return getKeyToInt("glory_bet_best_count");
         }
         return 100;
      }
      
      public function getSevenYearFlagBuyCost() : Array
      {
         if(checkIsConfigExist("seven_year_buy_flag_point"))
         {
            return getKeyToArr("seven_year_buy_flag_point");
         }
         return [100,1000,2000];
      }
      
      public function getSevenYearFlagBgConfig() : Array
      {
         if(checkIsConfigExist("seven_year_flag_bgimg"))
         {
            return getKeyToArr2("seven_year_flag_bgimg");
         }
         return ["10,1","30,2","50,3","100,4","200,5"];
      }
      
      public function getSevenYearBuyFlagAward1() : Array
      {
         if(checkIsConfigExist("seven_year_flag_award_view1"))
         {
            return getKeyToArr2("seven_year_flag_award_view1");
         }
         return ["212029,5","212029,5","212029,5","212029,5","212029,5"];
      }
      
      public function getSevenYearBuyFlagAward40() : Array
      {
         if(checkIsConfigExist("seven_year_flag_award_view40"))
         {
            return getKeyToArr2("seven_year_flag_award_view40");
         }
         return ["212029,5","212029,5","212029,5","212029,5","212029,5"];
      }
      
      public function getDragonEnchantGold() : int
      {
         if(checkIsConfigExist("dragon_enchant_gold"))
         {
            return getKeyToInt("dragon_enchant_gold");
         }
         return 2000;
      }
      
      public function getIncreasinglyRoadRefreshCost() : String
      {
         if(checkIsConfigExist("demonroad_energy_refresh"))
         {
            return getKeyToString("demonroad_energy_refresh");
         }
         return "10,20,30";
      }
      
      public function getIncreasinglyEnergyBuy() : Array
      {
         if(checkIsConfigExist("demonroad_energy_buy"))
         {
            return getKeyToArr2("demonroad_energy_buy");
         }
         return ["10,100","20,150","30,200"];
      }
      
      public function getIncreasinglyTips(param1:int) : String
      {
         var _loc2_:String = "demonroad_level_" + param1;
         if(checkIsConfigExist(_loc2_))
         {
            return getKeyToString(_loc2_);
         }
         return "本层物品刷新概率";
      }
      
      public function getExpeditionMaxEnergy() : int
      {
         if(checkIsConfigExist("expedition_max_energy"))
         {
            return getKeyToInt("expedition_max_energy");
         }
         return 100;
      }
      
      public function getExpeditionCdPoint() : Array
      {
         if(checkIsConfigExist("expedition_cd_point"))
         {
            return getKeyToArr("expedition_cd_point");
         }
         return [10,5];
      }
      
      public function getExpeditionCdMinute() : int
      {
         if(checkIsConfigExist("expedition_cd_minute"))
         {
            return getKeyToInt("expedition_cd_minute");
         }
         return 300;
      }
      
      public function getChildCampSneakCount2() : int
      {
         if(checkIsConfigExist("childcamp_sneakcount2"))
         {
            return getKeyToInt("childcamp_sneakcount2");
         }
         return 3;
      }
      
      public function getChildCampSneakCount3() : int
      {
         if(checkIsConfigExist("childcamp_sneakcount3"))
         {
            return getKeyToInt("childcamp_sneakcount3");
         }
         return 6;
      }
      
      public function getDarkMazeConfigTime() : Array
      {
         if(checkIsConfigExist("dark_maze_config_time"))
         {
            return getKeyToArr2("dark_maze_config_time");
         }
         return ["2020-04-07 05:00","2020-04-08 05:00","2020-04-09 05:00","2020-04-10 05:00"];
      }
      
      public function getDarkMazeCostDiamond() : int
      {
         if(checkIsConfigExist("dark_maze_revive_point"))
         {
            return getKeyToInt("dark_maze_revive_point");
         }
         return 100;
      }
      
      public function getDarkMazeResetTime() : Array
      {
         if(checkIsConfigExist("dark_maze_reset_time"))
         {
            return getKeyToArr2("dark_maze_reset_time");
         }
         return ["2020-05-24 00:00:00","2020-06-22 00:00:00"];
      }
      
      public function getRemainsExploreTinderBuy() : Array
      {
         if(checkIsConfigExist("remainsexplore_tinder_buy"))
         {
            return getKeyToArr2("remainsexplore_tinder_buy");
         }
         return ["10,100","20,150","30,200"];
      }
      
      public function getRemainsExploreTinderTotal() : int
      {
         var _loc1_:Array = null;
         if(checkIsConfigExist("remainsexplore_config"))
         {
            _loc1_ = getKeyToArr("remainsexplore_config");
            return _loc1_[1];
         }
         return 250;
      }
      
      public function getRemainsDayBoxValues() : Array
      {
         if(checkIsConfigExist("remains_daybox_values"))
         {
            return getKeyToArr("remains_daybox_values");
         }
         return [20,40,60,80,100];
      }
      
      public function getRemainsWeekBoxValues() : Array
      {
         if(checkIsConfigExist("remains_weekbox_values"))
         {
            return getKeyToArr("remains_weekbox_values");
         }
         return [20,40,60,80,100];
      }
      
      public function getFisrtChangeVPReward() : Array
      {
         if(checkIsConfigExist("vice_password_reward"))
         {
            return getKeyToArr2("vice_password_reward");
         }
         return ["-400,10","-800,10"];
      }
      
      public function getConsortiaNewBossBufferData() : Array
      {
         if(checkIsConfigExist("consortia_newboss_buff_shop"))
         {
            return GoodsHelp.getCommonRewardAry(getKeyToString("consortia_newboss_buff_shop"));
         }
         return [];
      }
      
      public function getConsortiaNewBossRefreshTime() : Array
      {
         if(checkIsConfigExist("consortia_newboss_challenges_refreshtime"))
         {
            return getKeyToArr("consortia_newboss_challenges_refreshtime");
         }
         return ["12:00:00","16:00:00","20:00:00"];
      }
      
      public function getConsortiaNewbossBuffTime() : int
      {
         return getKeyToInt("consortia_newboss_buff_times");
      }
      
      public function getConsortiaNewbuffCount() : int
      {
         return getKeyToInt("consortia_newboss_buff_count");
      }
      
      public function getForbiddenBossBelongMax() : int
      {
         if(checkIsConfigExist("ForbiddenBoss_participationRewards_max"))
         {
            return getKeyToInt("ForbiddenBoss_participationRewards_max");
         }
         return 5;
      }
      
      public function getForbiddenBossJoinMax() : int
      {
         if(checkIsConfigExist("ForbiddenBoss_relegationRewards_max"))
         {
            return getKeyToInt("ForbiddenBoss_relegationRewards_max");
         }
         return 5;
      }
      
      public function getForbiddenBossBelongLimit() : SimpleDictionary
      {
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc4_:SimpleDictionary = new SimpleDictionary();
         if(checkIsConfigExist("ForbiddenBoss_relegationRewards_limit"))
         {
            _loc1_ = getKeyToArr2("ForbiddenBoss_relegationRewards_limit");
         }
         else
         {
            _loc1_ = ["1,5","2,10","3,-1","4,-1"];
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_].split(",");
            if(_loc2_ && _loc2_.length == 2)
            {
               _loc4_.add(_loc2_[0],_loc2_[1]);
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function getForbiddenBossJoinLimit() : SimpleDictionary
      {
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc4_:SimpleDictionary = new SimpleDictionary();
         if(checkIsConfigExist("ForbiddenBoss_participationRewards_limit"))
         {
            _loc1_ = getKeyToArr2("ForbiddenBoss_participationRewards_limit");
         }
         else
         {
            _loc1_ = ["1,10","2,15","3,-1","4,-1"];
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_].split(",");
            if(_loc2_ && _loc2_.length == 2)
            {
               _loc4_.add(_loc2_[0],_loc2_[1]);
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function getForbiddenBossTime() : Array
      {
         var _loc1_:Array = [];
         if(checkIsConfigExist("ForbiddenBoss_time"))
         {
            _loc1_ = getKeyToArr2("ForbiddenBoss_time");
         }
         else
         {
            _loc1_ = ["10:00:00","23:59:59"];
         }
         return _loc1_;
      }
      
      public function getSecretyAdventureTime() : Array
      {
         var _loc1_:Array = [];
         if(checkIsConfigExist("Secret_time"))
         {
            _loc1_ = getKeyToArr2("Secret_time",",");
         }
         else
         {
            _loc1_ = ["0","23:30:00|23:59:59"];
         }
         return _loc1_;
      }
      
      public function get newMemoryCardBuyTimes() : int
      {
         if(checkIsConfigExist("memorycard_buytimes"))
         {
            return getKeyToInt("memorycard_buytimes");
         }
         return 10;
      }
      
      public function get newMemoryCardCostdiamond() : int
      {
         if(checkIsConfigExist("memorycard_costdiamond"))
         {
            return getKeyToInt("memorycard_costdiamond");
         }
         return 50;
      }
      
      public function get newMemoryCardLimitTimes() : int
      {
         if(checkIsConfigExist("memorycard_limittimes"))
         {
            return getKeyToInt("memorycard_limittimes");
         }
         return 99;
      }
      
      public function get newMemoryCardMaxTimes() : int
      {
         if(checkIsConfigExist("memorycard_maxtimes"))
         {
            return getKeyToInt("memorycard_maxtimes");
         }
         return 10;
      }
      
      public function get treasureMeltingConst() : Array
      {
         if(checkIsConfigExist("theseus_treasure_melting_const"))
         {
            return getKeyToArr("theseus_treasure_melting_const");
         }
         return [1,2,4,8];
      }
      
      public function getFinalRoadRefreshTime() : Array
      {
         var _loc1_:Array = [];
         if(checkIsConfigExist("FinalroadRefreshTime"))
         {
            _loc1_ = getKeyToArr2("FinalroadRefreshTime",",");
         }
         else
         {
            _loc1_ = ["0","23:30:00|23:59:59"];
         }
         return _loc1_;
      }
      
      public function getFinalRoadChallengePrice() : Array
      {
         var _loc1_:Array = [];
         if(checkIsConfigExist("FinalroadChallengePrice"))
         {
            _loc1_ = getKeyToArr2("FinalroadChallengePrice",",");
         }
         else
         {
            _loc1_ = [100,200,300,400];
         }
         return _loc1_;
      }
      
      public function get finalRoadRepeatChallengePrice() : int
      {
         if(checkIsConfigExist("FinalroadRepeatChallengePrice"))
         {
            return getKeyToInt("FinalroadRepeatChallengePrice");
         }
         return 100;
      }
      
      public function get allianceDelaydays() : int
      {
         if(checkIsConfigExist("alliance_delaydays"))
         {
            return getKeyToInt("alliance_delaydays");
         }
         return 7;
      }
      
      public function get secretwarRefreshLimitTimes() : int
      {
         if(checkIsConfigExist("exploits_shop_random_Limit_times"))
         {
            return getKeyToInt("exploits_shop_random_Limit_times");
         }
         return 10;
      }
      
      public function get secretwarRefreshPrice() : int
      {
         if(checkIsConfigExist("exploits_shop_random_Price"))
         {
            return getKeyToInt("exploits_shop_random_Price");
         }
         return 500;
      }
      
      public function get navigationRefreshPrice() : int
      {
         if(checkIsConfigExist("navigation_refresh_consumption"))
         {
            return getKeyToInt("navigation_refresh_consumption");
         }
         return 100;
      }
      
      public function get navigationShipConsumption() : Array
      {
         var _loc1_:Array = [];
         if(checkIsConfigExist("navigation_ship_consumption"))
         {
            _loc1_ = getKeyToArr2("navigation_ship_consumption",",");
         }
         else
         {
            _loc1_ = [100,200,300,400,500];
         }
         return _loc1_;
      }
      
      public function get commerceSupplyTotalQuantity() : int
      {
         if(checkIsConfigExist("commerce_supply_TotalQuantity"))
         {
            return getKeyToInt("commerce_supply_TotalQuantity");
         }
         return 12;
      }
      
      public function get commerceSupplyDeblocking() : Array
      {
         var _loc1_:Array = [];
         if(checkIsConfigExist("commerce_supply_deblocking"))
         {
            _loc1_ = getKeyToArr2("commerce_supply_deblocking",",");
         }
         else
         {
            _loc1_ = [100,100,100,100,100,100,120,120,120,120,120,120];
         }
         return _loc1_;
      }
      
      public function get commerceBusinessCondition() : int
      {
         if(checkIsConfigExist("commerce_business_condition"))
         {
            return getKeyToInt("commerce_business_condition");
         }
         return 6;
      }
      
      public function get commerceBusinessRandom() : Array
      {
         var _loc1_:Array = [];
         if(checkIsConfigExist("commerce_business_random"))
         {
            _loc1_ = getKeyToArr2("commerce_business_random",",");
         }
         else
         {
            _loc1_ = [100,6];
         }
         return _loc1_;
      }
      
      public function get commerceTime() : Array
      {
         var _loc1_:Array = [];
         if(checkIsConfigExist("commerce_time"))
         {
            _loc1_ = getKeyToArr2("commerce_time");
         }
         else
         {
            _loc1_ = ["1,00:00","3,24:00","4,00:00","7,24:00"];
         }
         return _loc1_;
      }
      
      public function get christmasLight() : int
      {
         if(checkIsConfigExist("christmas_light"))
         {
            return getKeyToInt("christmas_light");
         }
         return 5;
      }
      
      public function get christmasWish() : Array
      {
         if(checkIsConfigExist("christmas_wish"))
         {
            return getKeyToArr("christmas_wish");
         }
         return ["-400","100"];
      }
      
      public function get christmasAnswerCount() : int
      {
         if(checkIsConfigExist("christmas_answer_count"))
         {
            return getKeyToInt("christmas_answer_count");
         }
         return 15;
      }
      
      public function get christmasAnswerTime() : Array
      {
         if(checkIsConfigExist("christmas_answer_time"))
         {
            return getKeyToArr2("christmas_answer_time");
         }
         return ["12:00,14:00","19:00,21:00"];
      }
      
      public function get christmasJackpot() : Array
      {
         if(checkIsConfigExist("christmas_jackpot"))
         {
            return getKeyToArr("christmas_jackpot");
         }
         return ["-400","100"];
      }
      
      public function get christmasRebate() : Array
      {
         if(checkIsConfigExist("christmas_rebate"))
         {
            return getKeyToArr("christmas_rebate");
         }
         return ["100","300","1000","2000"];
      }
      
      public function get christmasActionPower() : int
      {
         var _loc1_:Array = [];
         if(checkIsConfigExist("christmas_actionpower"))
         {
            _loc1_ = getKeyToArr("christmas_actionpower");
         }
         else
         {
            _loc1_ = ["1000","100","100"];
         }
         return _loc1_[1];
      }
   }
}

