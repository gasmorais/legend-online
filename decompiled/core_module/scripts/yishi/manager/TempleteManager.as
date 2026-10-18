package yishi.manager
{
   import battle.skillsys.mode.ActionTemplateData;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import mvc.module.consortia.ConsortiaTemplete;
   import mvc.module.outercityshop.OuterCityShopGoodsInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.task.TaskTemplate;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.OfferRewardConditionTemplateResolve;
   import yishi.datas.templates.OfferRewardGoodsTemplateResolve;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.datas.templates.OfferRewardTemplateResolve;
   import yishi.datas.templates.PetComposeGoodsTemplete;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.datas.templates.cate.AbysmDropTempCate;
   import yishi.datas.templates.cate.AbysmHellDropTempCate;
   import yishi.datas.templates.cate.AchievementTaskBuyDropTemplateCate;
   import yishi.datas.templates.cate.AchievementTaskTemplateCate;
   import yishi.datas.templates.cate.ActiveTemplateCate;
   import yishi.datas.templates.cate.ActonTemplateCate;
   import yishi.datas.templates.cate.AirGardenBedTempCate;
   import yishi.datas.templates.cate.AlchemicalFormulaTempCate;
   import yishi.datas.templates.cate.AlchemicalMineTempCate;
   import yishi.datas.templates.cate.ApexRewardDropTempCate;
   import yishi.datas.templates.cate.AppellInfoTemplateCate;
   import yishi.datas.templates.cate.ArchaeologyBookTemplateCate;
   import yishi.datas.templates.cate.ArchaeologyItemTemplateCate;
   import yishi.datas.templates.cate.AreaMapDropTemplateCate;
   import yishi.datas.templates.cate.ArmoryTempCate;
   import yishi.datas.templates.cate.ArtifactTemplateCate;
   import yishi.datas.templates.cate.AssistantTemplates;
   import yishi.datas.templates.cate.AvengerBodyTempCate;
   import yishi.datas.templates.cate.AvengerCommonTempCate;
   import yishi.datas.templates.cate.AvengerSkillTempCate;
   import yishi.datas.templates.cate.Bag360DropTemplateCate;
   import yishi.datas.templates.cate.BoxItemTemplateCate;
   import yishi.datas.templates.cate.BufferTemplateCate;
   import yishi.datas.templates.cate.BuildTemplateCate;
   import yishi.datas.templates.cate.CampaignBufferTemplateCate;
   import yishi.datas.templates.cate.CarnivalDailyChallengeTemplateCate;
   import yishi.datas.templates.cate.CarnivalLuckDrawTemplateCate;
   import yishi.datas.templates.cate.CarnivalPlayGroundTemplateCate;
   import yishi.datas.templates.cate.CarnivalPointExchangeTemplateCate;
   import yishi.datas.templates.cate.CatHouseTemplateCate;
   import yishi.datas.templates.cate.ChessPvpFightDropCate;
   import yishi.datas.templates.cate.ChessPvpRankDropCate;
   import yishi.datas.templates.cate.ChildArenaRewardTempCate;
   import yishi.datas.templates.cate.ChildAssistUpgradeTemplateCate;
   import yishi.datas.templates.cate.ChildCampTempCate;
   import yishi.datas.templates.cate.ChildComposeTemplateCate;
   import yishi.datas.templates.cate.ChildNswarTaskTempCate;
   import yishi.datas.templates.cate.ChildNswarTempCate;
   import yishi.datas.templates.cate.ChildPatrolMissionTemplateCate;
   import yishi.datas.templates.cate.ChildPveBossTemplateCate;
   import yishi.datas.templates.cate.ChildTemplateCate;
   import yishi.datas.templates.cate.ChildTypeTemplateCate;
   import yishi.datas.templates.cate.ChristmasAchievementsTempCate;
   import yishi.datas.templates.cate.ChristmasActivitiesTempCate;
   import yishi.datas.templates.cate.ChristmasAnswersTempCate;
   import yishi.datas.templates.cate.ChristmasLotteryTempCate;
   import yishi.datas.templates.cate.ChristmasTreeItemsTemplateCate;
   import yishi.datas.templates.cate.CollectionGetDrop;
   import yishi.datas.templates.cate.CollectionOpenDrop;
   import yishi.datas.templates.cate.CollectionRewardTempCate;
   import yishi.datas.templates.cate.CollectionSuitTempCate;
   import yishi.datas.templates.cate.CollectionTempCate;
   import yishi.datas.templates.cate.ConsortiaBossTemplateCate;
   import yishi.datas.templates.cate.ConsortiaBusinessTempCate;
   import yishi.datas.templates.cate.ConsortiaCommerceShopTempCate;
   import yishi.datas.templates.cate.ConsortiaDropTemplateCate;
   import yishi.datas.templates.cate.ConsortiaNewBossDamageRewardTempCate;
   import yishi.datas.templates.cate.ConsortiaNewBossRankRewardTempCate;
   import yishi.datas.templates.cate.ConsortiaNewBossTemplateCate;
   import yishi.datas.templates.cate.ConsortiaQuestConditionTempCate;
   import yishi.datas.templates.cate.ConsortiaQuestTempCate;
   import yishi.datas.templates.cate.ConsortiaTreasureTemplateCate;
   import yishi.datas.templates.cate.CountLoginDropTemplateCate;
   import yishi.datas.templates.cate.CrossGuildContributionRewardTempCate;
   import yishi.datas.templates.cate.CrossGuildNodeTemplateCate;
   import yishi.datas.templates.cate.CrossGuildRewardTempCate;
   import yishi.datas.templates.cate.CrossGuildSingleRewardTempCate;
   import yishi.datas.templates.cate.CrossGuildWarQuestTempCate;
   import yishi.datas.templates.cate.DarkMazeChildTempCate;
   import yishi.datas.templates.cate.DarkMazeEventTempCate;
   import yishi.datas.templates.cate.DayGuideDropTemplateCate;
   import yishi.datas.templates.cate.DemonLandBoxDropTemplateCate;
   import yishi.datas.templates.cate.DemonLandDropTemplateCate;
   import yishi.datas.templates.cate.DemonLandTemplateCate;
   import yishi.datas.templates.cate.DistrictSSSTemplateCate;
   import yishi.datas.templates.cate.DistrictTemplateCate;
   import yishi.datas.templates.cate.DitchTemplateCate;
   import yishi.datas.templates.cate.DragonTalkerFightMountTempcate;
   import yishi.datas.templates.cate.DragonTitanTemplateCate;
   import yishi.datas.templates.cate.DreamArenaRewardTempCate;
   import yishi.datas.templates.cate.DreamArenaTempCate;
   import yishi.datas.templates.cate.EclipticPalaceRewardCate;
   import yishi.datas.templates.cate.EclipticPalaceTempCate;
   import yishi.datas.templates.cate.EffectTemplateCate;
   import yishi.datas.templates.cate.ExchargeRankTemplateCate;
   import yishi.datas.templates.cate.FaceBookTemplateCate;
   import yishi.datas.templates.cate.FashionPolishTemplateCate;
   import yishi.datas.templates.cate.FinalRoadChapterTempCate;
   import yishi.datas.templates.cate.FinalRoadEventTempCate;
   import yishi.datas.templates.cate.FinalRoadGroupTempCate;
   import yishi.datas.templates.cate.FirstPayDropTempalteCate;
   import yishi.datas.templates.cate.FishTemplateCate;
   import yishi.datas.templates.cate.ForbiddenBossBelongDropCate;
   import yishi.datas.templates.cate.ForbiddenBossJoinDropCate;
   import yishi.datas.templates.cate.ForbiddenBossTempCate;
   import yishi.datas.templates.cate.FurnitureShopTemplateCate;
   import yishi.datas.templates.cate.FurnitureTemplateCate;
   import yishi.datas.templates.cate.GameBoxShopTemplateCate;
   import yishi.datas.templates.cate.GameHallEastTemplateCate;
   import yishi.datas.templates.cate.GameHallTemplateCate;
   import yishi.datas.templates.cate.GameHeroTemplateCate;
   import yishi.datas.templates.cate.GamehallEastShopTempCate;
   import yishi.datas.templates.cate.GloryRewardDropCate;
   import yishi.datas.templates.cate.GodArriveTemplateCate;
   import yishi.datas.templates.cate.GodTreasureTemplateCate;
   import yishi.datas.templates.cate.GoddessAdvanceTempCate;
   import yishi.datas.templates.cate.GoddessDediactionTempCate;
   import yishi.datas.templates.cate.GoddessEquipTempCate;
   import yishi.datas.templates.cate.GoddessFormationSkillTempCate;
   import yishi.datas.templates.cate.GoddessFormationTempCate;
   import yishi.datas.templates.cate.GoddessLevelTempCate;
   import yishi.datas.templates.cate.GoddessTemplateCate;
   import yishi.datas.templates.cate.GoodsTemplateCate;
   import yishi.datas.templates.cate.GuardPveExploreTemplateCate;
   import yishi.datas.templates.cate.GuildFBDropTempCate;
   import yishi.datas.templates.cate.GuildFBPveRankDropTempCate;
   import yishi.datas.templates.cate.GuildFBTemplateCate;
   import yishi.datas.templates.cate.GuildWantedDropTempCate;
   import yishi.datas.templates.cate.HeartTemplateCate;
   import yishi.datas.templates.cate.HeroAISTemplateCate;
   import yishi.datas.templates.cate.HeroRoadTemplateCate;
   import yishi.datas.templates.cate.KingContraceCate;
   import yishi.datas.templates.cate.KingbackTemplateCate;
   import yishi.datas.templates.cate.LeedDropTemplateCate;
   import yishi.datas.templates.cate.LeedTemplateCate;
   import yishi.datas.templates.cate.LordTrialTempCate;
   import yishi.datas.templates.cate.MagicCardTemplateCate;
   import yishi.datas.templates.cate.MagicPubChatTemplateCate;
   import yishi.datas.templates.cate.MagicPubNpcTemplateCate;
   import yishi.datas.templates.cate.MagicSpringFormulaTempCate;
   import yishi.datas.templates.cate.MapPhysicsTempleteCate;
   import yishi.datas.templates.cate.MaptemplateCate;
   import yishi.datas.templates.cate.MarryQualityTemplateCate;
   import yishi.datas.templates.cate.MinosLevelCate;
   import yishi.datas.templates.cate.MinosNodeCate;
   import yishi.datas.templates.cate.MinosRewardCate;
   import yishi.datas.templates.cate.MonsterCookDropTempCate;
   import yishi.datas.templates.cate.MonsterExploreDropTempCate;
   import yishi.datas.templates.cate.MonsterExploreTemplateCate;
   import yishi.datas.templates.cate.MonsterRecipeTemplateCate;
   import yishi.datas.templates.cate.MonsterTemplateCate;
   import yishi.datas.templates.cate.NavigationShopTemplateCate;
   import yishi.datas.templates.cate.NavigationTaskTemplateCate;
   import yishi.datas.templates.cate.NewActiveLeedCate;
   import yishi.datas.templates.cate.NewActiveLeedDailyCate;
   import yishi.datas.templates.cate.NewActiveLeedWeekCate;
   import yishi.datas.templates.cate.NewFirstPayDropCate;
   import yishi.datas.templates.cate.NewFirstPlayCate;
   import yishi.datas.templates.cate.NoviceboxTemplateCate;
   import yishi.datas.templates.cate.OldPlayerReturnPrivilegeTempCate;
   import yishi.datas.templates.cate.OldPlayerReturnRewardTempCate;
   import yishi.datas.templates.cate.OldPlayerReturnShopTempCate;
   import yishi.datas.templates.cate.OldPlayerReturnTaskTempCate;
   import yishi.datas.templates.cate.OuterCityShopCostTemplateCate;
   import yishi.datas.templates.cate.OutyardShuttleRewardTemplateCate;
   import yishi.datas.templates.cate.OutyardShuttleTemplateCate;
   import yishi.datas.templates.cate.OutyardTitanTemplateCate;
   import yishi.datas.templates.cate.PawnSpecialTemplateCate;
   import yishi.datas.templates.cate.PawnTemplateCate;
   import yishi.datas.templates.cate.PetChallengeRewardCate;
   import yishi.datas.templates.cate.PetContracTemplateCate;
   import yishi.datas.templates.cate.PetHallowsTemplateCate;
   import yishi.datas.templates.cate.PetTemplateCate;
   import yishi.datas.templates.cate.PlaneCrisisEventTempCate;
   import yishi.datas.templates.cate.PlaneCrisisGoodTempCate;
   import yishi.datas.templates.cate.PlaneCrisisTempCate;
   import yishi.datas.templates.cate.PlanesEventsTemplateCate;
   import yishi.datas.templates.cate.PlanesFuncTemplateCate;
   import yishi.datas.templates.cate.PlanesLayerTemplateCate;
   import yishi.datas.templates.cate.PlanesTemplateCate;
   import yishi.datas.templates.cate.PoseidonShopCate;
   import yishi.datas.templates.cate.ProficiencyTempCate;
   import yishi.datas.templates.cate.QuestionDropTempCate;
   import yishi.datas.templates.cate.QuestionTempCate;
   import yishi.datas.templates.cate.RaceAgainstTimeDropTempCate;
   import yishi.datas.templates.cate.RapidThroughRewardCate;
   import yishi.datas.templates.cate.RegressTemplateCate;
   import yishi.datas.templates.cate.RemainsExploreActivityDropTempCate;
   import yishi.datas.templates.cate.RemainsExploreActivityTempCate;
   import yishi.datas.templates.cate.RemainsExploreChapterTempCate;
   import yishi.datas.templates.cate.RemainsExploreDropTempCate;
   import yishi.datas.templates.cate.RemainsExploreEventTempCate;
   import yishi.datas.templates.cate.RemainsExploreTempCate;
   import yishi.datas.templates.cate.RemotePetTemplateCate;
   import yishi.datas.templates.cate.ResolveTemplateCate;
   import yishi.datas.templates.cate.ResolveitemsortTemplateCate;
   import yishi.datas.templates.cate.RevengeRoadAreaBoxTempCate;
   import yishi.datas.templates.cate.RevengeRoadDropTempCate;
   import yishi.datas.templates.cate.RevengeRoadTemplateCate;
   import yishi.datas.templates.cate.RondamBossTemplateCate;
   import yishi.datas.templates.cate.RoyaltyBossTempCate;
   import yishi.datas.templates.cate.RoyaltyTempCate;
   import yishi.datas.templates.cate.RuneFsgainTempInfoCate;
   import yishi.datas.templates.cate.RuneGemTempInfoCate;
   import yishi.datas.templates.cate.RuneHoleTempInfoCate;
   import yishi.datas.templates.cate.SecretEventCate;
   import yishi.datas.templates.cate.SecretMapDataCate;
   import yishi.datas.templates.cate.SecretMapLevelCate;
   import yishi.datas.templates.cate.SecretSonLevelCate;
   import yishi.datas.templates.cate.SecretwarShopTempCate;
   import yishi.datas.templates.cate.SelfChessBuffTampCate;
   import yishi.datas.templates.cate.SelfChessTempCate;
   import yishi.datas.templates.cate.ServenLeadRewardTemplateCate;
   import yishi.datas.templates.cate.SevenYearAchievementTempCate;
   import yishi.datas.templates.cate.SevenYearFreeRewardDropCate;
   import yishi.datas.templates.cate.SevenYearQuestionTempCate;
   import yishi.datas.templates.cate.SevenYearRewardDropCate;
   import yishi.datas.templates.cate.SevenYearTreasureBoxDropCate;
   import yishi.datas.templates.cate.ShadowLandBoxDropTempCate;
   import yishi.datas.templates.cate.ShadowLandFightDropTempCate;
   import yishi.datas.templates.cate.ShadowLandTempCate;
   import yishi.datas.templates.cate.SignDropTemplateCate;
   import yishi.datas.templates.cate.SimpleTaskTemplateCate;
   import yishi.datas.templates.cate.SingleCampaignDataTempCate;
   import yishi.datas.templates.cate.SinglePassAreaRewardTemplateCate;
   import yishi.datas.templates.cate.SinglePassBossRewardTemplateCate;
   import yishi.datas.templates.cate.SkillPropertyTemplateCate;
   import yishi.datas.templates.cate.SkyBoxRoadRankRewardTempCate;
   import yishi.datas.templates.cate.SkyBoxRoadTimeRewardTempCate;
   import yishi.datas.templates.cate.SkyStepDropTempCate;
   import yishi.datas.templates.cate.SkyTrialPortalTemplateCate;
   import yishi.datas.templates.cate.SkytrialeventTemplateCate;
   import yishi.datas.templates.cate.SkytriallayerTemplateCate;
   import yishi.datas.templates.cate.SpeicalRewardTempCate;
   import yishi.datas.templates.cate.SpiritExpeditionFightDropTempCate;
   import yishi.datas.templates.cate.SpiritExpeditionStarDropTempCate;
   import yishi.datas.templates.cate.SpiritExpeditionTempCate;
   import yishi.datas.templates.cate.StarAreaDropCate;
   import yishi.datas.templates.cate.StarGazingDropTempCate;
   import yishi.datas.templates.cate.StarTempalteCate;
   import yishi.datas.templates.cate.StarareaRoadsTempCate;
   import yishi.datas.templates.cate.StelaPropertyTemplateCate;
   import yishi.datas.templates.cate.StelaResistTemplateCate;
   import yishi.datas.templates.cate.StelaStepTemplateCate;
   import yishi.datas.templates.cate.StelaTemplateCate;
   import yishi.datas.templates.cate.SuitTemplateCate;
   import yishi.datas.templates.cate.TalentTemplateCate;
   import yishi.datas.templates.cate.TheseusDungeonCate;
   import yishi.datas.templates.cate.TheseusDungeonEventCate;
   import yishi.datas.templates.cate.TheseusDungeonTaskCate;
   import yishi.datas.templates.cate.TheseusEquipSuiteTempCate;
   import yishi.datas.templates.cate.TheseusMultiPvpIntegralTempCate;
   import yishi.datas.templates.cate.TheseusMultiPvpTaskTempCate;
   import yishi.datas.templates.cate.TheseusMultiPvpTempCate;
   import yishi.datas.templates.cate.TheseusPvpIntegralTempCate;
   import yishi.datas.templates.cate.TheseusPvpTaskTempCate;
   import yishi.datas.templates.cate.TheseusPvpTempCate;
   import yishi.datas.templates.cate.TheseusRageSuiteTempCate;
   import yishi.datas.templates.cate.TheseusRageTempCate;
   import yishi.datas.templates.cate.TheseusSlateCate;
   import yishi.datas.templates.cate.TheseusSlateTaskCate;
   import yishi.datas.templates.cate.TheseusSlateUpgradeCate;
   import yishi.datas.templates.cate.TheseusTreasureCoreCate;
   import yishi.datas.templates.cate.TheseusTreasureGrowupCate;
   import yishi.datas.templates.cate.TheseusTreasureHokeCate;
   import yishi.datas.templates.cate.ThessBoxMapCate;
   import yishi.datas.templates.cate.ThessBoxTempCate;
   import yishi.datas.templates.cate.ThessTowerTempCate;
   import yishi.datas.templates.cate.TimeBoxTemplateCate;
   import yishi.datas.templates.cate.TimeVortexDropTemplateCate;
   import yishi.datas.templates.cate.TollgateRewardCate;
   import yishi.datas.templates.cate.TopToolBtnTempCate;
   import yishi.datas.templates.cate.TransformBackTemplateCate;
   import yishi.datas.templates.cate.UnrealShootingRewardTempCate;
   import yishi.datas.templates.cate.UpgradePresentBoxDropTempCate;
   import yishi.datas.templates.cate.VehicleAdditionTemplateCate;
   import yishi.datas.templates.cate.VehicleObjectTempInfoCate;
   import yishi.datas.templates.cate.VehicleSkillBuffTemplateCate;
   import yishi.datas.templates.cate.VehicleSkillTempInfoCate;
   import yishi.datas.templates.cate.VipDropTemplateCate;
   import yishi.datas.templates.cate.VipPrerogativeTemplateCate;
   import yishi.datas.templates.cate.WarSoulReformTempCate;
   import yishi.datas.templates.cate.WarSoulStarTempCate;
   import yishi.datas.templates.cate.WarSoulStrengthenTempCate;
   import yishi.datas.templates.cate.WarSoulTempCate;
   import yishi.datas.templates.cate.WarSoulTowerLevelTempCate;
   import yishi.datas.templates.cate.WarSoulTowerStageTempCate;
   import yishi.datas.templates.cate.YearActiveDropCate;
   import yishi.resolve.ActionTemplateInfoResolveII;
   import yishi.resolve.CampaignTemplateResolve;
   import yishi.resolve.ComposeTemInfoResolve;
   import yishi.resolve.ConfigInfosTemplateInfoResolve;
   import yishi.resolve.ConsortiaTempInfoResolve;
   import yishi.resolve.MountTemplateResolve;
   import yishi.resolve.OuterCityShopTemplateResolve;
   import yishi.resolve.PetComposeTemInfoResolve;
   import yishi.resolve.RuneTempInfoResolve;
   import yishi.resolve.ShopGoodsInfoResolve;
   import yishi.resolve.SkillTempInfoResolve;
   import yishi.resolve.SpaceTemplateResolve;
   import yishi.resolve.TaskCondictionTemplateResolve;
   import yishi.resolve.TaskGoodsTemplateResolve;
   import yishi.resolve.TaskTemplateResolve;
   import yishi.resolve.TemplateResolveQueue;
   import yishi.resolve.UpgradeTemplateResolve;
   import yishi.utils.SimpleDictionary;
   
   public class TempleteManager
   {
      
      private static var _instance:TempleteManager;
      
      private var _configInfoTemplateDic:Dictionary;
      
      private var _taskTemplateDic:Dictionary;
      
      private var _taskGoodTemplateList:Array;
      
      private var _taskCondictionInfoList:Array;
      
      private var _offerRewardTemplateDic:Dictionary;
      
      private var _offerRewardGoodsTemplateList:Array;
      
      private var _offerRewardConditionTemplateList:Array;
      
      private var _vipShopDic:Dictionary;
      
      private var _thessboxShopDic:Dictionary;
      
      private var _timeVortexDic:Dictionary;
      
      private var _campaignTemplateDic:Dictionary;
      
      private var _allCampaignDic:Dictionary;
      
      private var _worldBossDic:Dictionary;
      
      private var _pvpWarFightDic:Dictionary;
      
      private var _vehicleCampaignDic:Dictionary;
      
      private var _shopTemplateDic:Dictionary;
      
      private var _consortiaShopTemplateDic:Dictionary;
      
      private var _advConsortiaShopTemplateDic:Dictionary;
      
      private var _treasureConsortiaShopTemplateDic:Dictionary;
      
      private var _copyConsortiaShopTemplateDic:Dictionary;
      
      private var _mineralShopTemplateDic:Dictionary;
      
      private var _christmasShopTemplateDic:Dictionary;
      
      private var _fashionExchangeShopTemplateDic:Dictionary;
      
      private var _mountExchangeShopTemplateDic:Dictionary;
      
      private var _athleticsShopTemplateDic:Dictionary;
      
      private var _scoreShopTemplateDic:Dictionary;
      
      private var _warlordsShopTemplateDic:Dictionary;
      
      private var _dungenexShopTemplateDic:Dictionary;
      
      private var _apexShopTemplateDic:Dictionary;
      
      private var _antaeusShopTemplateDic:Dictionary;
      
      private var _multilordsShopTemplateDic:Dictionary;
      
      private var _matelordsShopTemplateDic:Dictionary;
      
      private var _mountShopTemplateDic:Dictionary;
      
      private var _outyardTemplateDic:Dictionary;
      
      private var _crossGvgShopTemplateDic:Dictionary;
      
      private var _petBossShopTemplateDic:Dictionary;
      
      private var _bloodShopTemplateDic:Dictionary;
      
      private var _shopMainTemplateDic:Dictionary;
      
      private var _mazeShopTemplateDic:Dictionary;
      
      private var _mysteryShopTemplateDic:Dictionary;
      
      private var _farmShopTemplateDic:Dictionary;
      
      private var _mysteryExchangeShopTemplateDic:Dictionary;
      
      private var _mountTemplateDic:Dictionary;
      
      private var _boxNoviceTemplateDic:Dictionary;
      
      private var _boxTimeTemplateDic:Dictionary;
      
      private var _skillTemplateDic:Dictionary;
      
      private var _runeTemplateDic:Dictionary;
      
      private var _composeTemplateDic:Dictionary;
      
      private var _theseusEquipQualityTmpl:TheseusEquipQualityTmpl;
      
      private var _theseusEquipStrengthenTmpl:TheseusEquipStrengthenTmpl;
      
      private var _petComposeTemplateDic:Dictionary;
      
      private var _upgradeTemplateDic:Dictionary;
      
      private var _allSpaceDic:Dictionary;
      
      private var _gloryShopDic:Dictionary;
      
      private var _isExploreShopTemplateDic:Dictionary;
      
      private var _assaultwarShopTemplateDic:Dictionary;
      
      private var _pumpingJoyShopTemplateDic:Dictionary;
      
      private var _crossGuildShopTemplateDic:Dictionary;
      
      private var _sevenYearShopTemplateDic:Dictionary;
      
      private var _yearactiveShop1Dic:Dictionary;
      
      private var _yearactiveShop2Dic:Dictionary;
      
      private var _minosShopDic:Dictionary;
      
      private var _chesspvpShopDic:Dictionary;
      
      private var _functions:Dictionary;
      
      private var _godsEveningShopTemplateDic:Dictionary;
      
      private var _callBack:Function;
      
      private var _rondamBossTemplateCate:RondamBossTemplateCate;
      
      private var _outerCityShopCostTemplateCate:OuterCityShopCostTemplateCate;
      
      private var _outerCityShopExchangeTemplateDic:Dictionary;
      
      private var _outerCityShopRandomTemplateDic:Dictionary;
      
      private var _planesTemplateDic:Dictionary;
      
      private var _svsShopTemplateDic:Dictionary;
      
      private var _planesTemplateCate:PlanesTemplateCate;
      
      private var _planesLayerTemplateCate:PlanesLayerTemplateCate;
      
      private var _planesEventsTemplateCate:PlanesEventsTemplateCate;
      
      private var _remotePetTemplateCate:RemotePetTemplateCate;
      
      private var _childTemplateCate:ChildTemplateCate;
      
      private var _childPveBossTemplateCate:ChildPveBossTemplateCate;
      
      private var _guardPveExploreTemplateCate:GuardPveExploreTemplateCate;
      
      private var _skytriallayerTemplateCate:SkytriallayerTemplateCate;
      
      private var _skyTrialPortalTemplateCate:SkyTrialPortalTemplateCate;
      
      private var _skytrialeventTemplateCate:SkytrialeventTemplateCate;
      
      private var _consortiaBossTemplateCate:ConsortiaBossTemplateCate;
      
      private var _gameBoxShopTemplateCate:GameBoxShopTemplateCate;
      
      private var _dichTemplateCate:DitchTemplateCate;
      
      private var _archaeologyBookTemplateCate:ArchaeologyBookTemplateCate;
      
      private var _archaeologyItemTemplateCate:ArchaeologyItemTemplateCate;
      
      private var _furnitureTemplateCate:FurnitureTemplateCate;
      
      private var _titanTemplateCate:DragonTitanTemplateCate;
      
      private var _childPatrolMissionTempCate:ChildPatrolMissionTemplateCate;
      
      private var _faceBookTempCate:FaceBookTemplateCate;
      
      private var _regressTemplateCate:RegressTemplateCate;
      
      private var _navigationShopTemplateCate:NavigationShopTemplateCate;
      
      private var _navigationTaskTemplateCate:NavigationTaskTemplateCate;
      
      private var _childTypeTemplateCate:ChildTypeTemplateCate;
      
      private var _outyardTemplateCate:OutyardTemplateCate;
      
      private var _outyardAreaTemplateCate:OutyardAreaTemplateCate;
      
      private var _crossGuildNodeTemplateCate:CrossGuildNodeTemplateCate;
      
      private var _outyardTitanTemplateCate:OutyardTitanTemplateCate;
      
      private var _outyardShuttleTemplateCate:OutyardShuttleTemplateCate;
      
      private var _outyardShuttleRewardTemplateCate:OutyardShuttleRewardTemplateCate;
      
      private var _magicPubNpcTemplateCate:MagicPubNpcTemplateCate;
      
      private var _magicPubChatTemplateCate:MagicPubChatTemplateCate;
      
      private var _heroRoadTemplateCate:HeroRoadTemplateCate;
      
      private var _artifactTemplateCate:ArtifactTemplateCate;
      
      private var _areaMapDropTemplateCate:AreaMapDropTemplateCate;
      
      private var _gloryRoadBufferTemplateCate:GloryRoadBufferTemplateCate;
      
      private var _gloryRoadDropTemplateCate:GloryRoadDropTemplateCate;
      
      private var _furnitureShopTemplateCate:FurnitureShopTemplateCate;
      
      private var _petHallowsTemplateCate:PetHallowsTemplateCate;
      
      private var _petContracTemplateCate:PetContracTemplateCate;
      
      private var _consortiaTreasureTemplateCate:ConsortiaTreasureTemplateCate;
      
      private var _rapidThroughRewardCate:RapidThroughRewardCate;
      
      private var _fashionPolishTemplateCate:FashionPolishTemplateCate;
      
      private var _planesFuncTemplateCate:PlanesFuncTemplateCate;
      
      private var _childComposeTemplateCate:ChildComposeTemplateCate;
      
      private var _topToolBtnTempCate:TopToolBtnTempCate;
      
      private var _lordTrialTempCate:LordTrialTempCate;
      
      private var _childArenaRewardTempCate:ChildArenaRewardTempCate;
      
      private var _alchemicalMineTempCate:AlchemicalMineTempCate;
      
      private var _alchemicalFormulaTempCate:AlchemicalFormulaTempCate;
      
      private var _armoryTempCate:ArmoryTempCate;
      
      private var _skyBoxRoadRankRewardTempCate:SkyBoxRoadRankRewardTempCate;
      
      private var _skyBoxRoadTimeRewardTempCate:SkyBoxRoadTimeRewardTempCate;
      
      private var _unrealShootingRewardTempCate:UnrealShootingRewardTempCate;
      
      private var _dragonTalkerFightMountTempcate:DragonTalkerFightMountTempcate;
      
      private var _starGazingDropTempCate:StarGazingDropTempCate;
      
      private var _planeCrisisTempCate:PlaneCrisisTempCate;
      
      private var _planeCrisisEventTempCate:PlaneCrisisEventTempCate;
      
      private var _planeCrisisGoodTempCate:PlaneCrisisGoodTempCate;
      
      private var _magicSpringTempCate:MagicSpringFormulaTempCate;
      
      private var _eclipticPalaceTempCate:EclipticPalaceTempCate;
      
      private var _eclipticPalaceRewardTempCate:EclipticPalaceRewardCate;
      
      private var _upgradePresentShopTemplateDic:Dictionary;
      
      private var _upgradePresentBoxDropTempCate:UpgradePresentBoxDropTempCate;
      
      private var _demonLandTemplateCate:DemonLandTemplateCate;
      
      private var _demonLandDropTemplateCate:DemonLandDropTemplateCate;
      
      private var _demonLandBoxDropTemplateCate:DemonLandBoxDropTemplateCate;
      
      private var _goddessTempCate:GoddessTemplateCate;
      
      private var _goddessLevelTempCate:GoddessLevelTempCate;
      
      private var _goddessAdvanceTempCate:GoddessAdvanceTempCate;
      
      private var _goddessDedicationTempCate:GoddessDediactionTempCate;
      
      private var _goddessFormationTempCate:GoddessFormationTempCate;
      
      private var _goddessFormationSkillTempCate:GoddessFormationSkillTempCate;
      
      private var _goddessEquipTempCate:GoddessEquipTempCate;
      
      private var _guildFbTempcate:GuildFBTemplateCate;
      
      private var _guildFbDropTempCate:GuildFBDropTempCate;
      
      private var _guildFbPveRankDropTempte:GuildFBPveRankDropTempCate;
      
      private var _consortiaQuestTempCate:ConsortiaQuestTempCate;
      
      private var _consortiaQuestConditionTempCate:ConsortiaQuestConditionTempCate;
      
      private var _consortiaBusinessTempCate:ConsortiaBusinessTempCate;
      
      private var _gameHallTemplateCate:GameHallTemplateCate;
      
      private var _resolveitemsortTemplateCate:ResolveitemsortTemplateCate;
      
      private var _crossGuildRewardTempCate:CrossGuildRewardTempCate;
      
      private var _crossGuildSingleRewardTempCate:CrossGuildSingleRewardTempCate;
      
      private var _crossGuildContributionRewardTempCate:CrossGuildContributionRewardTempCate;
      
      private var _apexRankRewardDropTempCate:ApexRewardDropTempCate;
      
      private var _crossGuildWarQuestTempCate:CrossGuildWarQuestTempCate;
      
      private var _guildWantedDropTempCate:GuildWantedDropTempCate;
      
      private var _tempDic:Dictionary;
      
      private var _upgradeMapDic:Dictionary;
      
      private var _monsterTempCate:MonsterTemplateCate;
      
      private var _monsterRecipeTempCate:MonsterRecipeTemplateCate;
      
      private var _monsterCookDropTempCate:MonsterCookDropTempCate;
      
      private var _monsterExploreTemplateCate:MonsterExploreTemplateCate;
      
      private var _monsterExploreDropCate:MonsterExploreDropTempCate;
      
      private var _dreamArenaRewardTempCate:DreamArenaRewardTempCate;
      
      private var _dreamArenaTempCate:DreamArenaTempCate;
      
      private var _airGardenBedTempCate:AirGardenBedTempCate;
      
      private var _airGardenPropTemplateDic:Dictionary;
      
      private var _gameHallEastTemplateCate:GameHallEastTemplateCate;
      
      private var _gamehallEastShopTempCate:GamehallEastShopTempCate;
      
      private var _avengerSkillTempCate:AvengerSkillTempCate;
      
      private var _avengerBodyTempCate:AvengerBodyTempCate;
      
      private var _revengeRoadTempCate:RevengeRoadTemplateCate;
      
      private var _revengeRoadAreaBoxCate:RevengeRoadAreaBoxTempCate;
      
      private var _revengeRoadDropCate:RevengeRoadDropTempCate;
      
      private var _proficiencyTempCate:ProficiencyTempCate;
      
      private var _kingbackTempCate:KingbackTemplateCate;
      
      private var _starareaRoadsTempCate:StarareaRoadsTempCate;
      
      private var _sevenYearAchievementTempCate:SevenYearAchievementTempCate;
      
      private var _sevenYearQuestionTempCate:SevenYearQuestionTempCate;
      
      private var _starAreaDropCate:StarAreaDropCate;
      
      private var _sevenYearRewardDropCate:SevenYearRewardDropCate;
      
      private var _sevenYearTreasureBoxDropCate:SevenYearTreasureBoxDropCate;
      
      private var _gloryRewardDropCate:GloryRewardDropCate;
      
      private var _abysmDropCate:AbysmDropTempCate;
      
      private var _abysmHellDropCate:AbysmHellDropTempCate;
      
      private var _avengerCommonTempCate:AvengerCommonTempCate;
      
      private var _resolveTempCate:ResolveTemplateCate;
      
      private var _raceAgainstTimeDropTempCate:RaceAgainstTimeDropTempCate;
      
      private var _childAssistUpgradeTemplateCate:ChildAssistUpgradeTemplateCate;
      
      private var _childCampTempCate:ChildCampTempCate;
      
      private var _flameTempleShopDic:Dictionary;
      
      private var _duskAreaShopDic:Dictionary;
      
      private var _demonRoadShopDic:Dictionary;
      
      private var _spiritExpeditionTempCate:SpiritExpeditionTempCate;
      
      private var _spiritExpeditionFightDropTempCate:SpiritExpeditionFightDropTempCate;
      
      private var _spiritExpeditionStarDropTempCate:SpiritExpeditionStarDropTempCate;
      
      private var _selfChessTempCate:SelfChessTempCate;
      
      private var _selfChessBuffTempCate:SelfChessBuffTampCate;
      
      private var _sevenYearFreeRewardDropCate:SevenYearFreeRewardDropCate;
      
      private var _shadowLandTempCate:ShadowLandTempCate;
      
      private var _shadowLandFightDropTempCate:ShadowLandFightDropTempCate;
      
      private var _shadowLandBoxDropTempCate:ShadowLandBoxDropTempCate;
      
      private var _darkMazeEventTempCate:DarkMazeEventTempCate;
      
      private var _darkMazeChildTempCate:DarkMazeChildTempCate;
      
      private var _stelaTempCate:StelaTemplateCate;
      
      private var _stelaStepTempCate:StelaStepTemplateCate;
      
      private var _stelaPropertyTempCate:StelaPropertyTemplateCate;
      
      private var _stelaResistTempCate:StelaResistTemplateCate;
      
      private var _darkmazeShopDic:Dictionary;
      
      private var _consortiaNewBossShopDic:Dictionary;
      
      private var _singleCampaignTempCate:SingleCampaignDataTempCate;
      
      private var _remainsExploreTempCate:RemainsExploreTempCate;
      
      private var _remainsExploreChapterTempCate:RemainsExploreChapterTempCate;
      
      private var _remainsExploreEventTempCate:RemainsExploreEventTempCate;
      
      private var _remainsExploreDropTempCate:RemainsExploreDropTempCate;
      
      private var _remainsExploreActivityTempCate:RemainsExploreActivityTempCate;
      
      private var _remainsExploreActivityDropTempCate:RemainsExploreActivityDropTempCate;
      
      private var _skyStepDropTempCate:SkyStepDropTempCate;
      
      private var _consortiaNewBossTempCate:ConsortiaNewBossTemplateCate;
      
      private var _consortiaNewBossRankRewardTempCate:ConsortiaNewBossRankRewardTempCate;
      
      private var _consortiaNewBossDamageRewardTempCate:ConsortiaNewBossDamageRewardTempCate;
      
      private var _achievementTaskTemplateCate:AchievementTaskTemplateCate;
      
      private var _achievementTaskBuyDropTemplateCate:AchievementTaskBuyDropTemplateCate;
      
      private var _newFirstPlayCate:NewFirstPlayCate;
      
      private var _newFirstPlayDropCate:NewFirstPayDropCate;
      
      private var _questionDropTempCate:QuestionDropTempCate;
      
      private var _questionTempCate:QuestionTempCate;
      
      private var _royaltyBossTempCate:RoyaltyBossTempCate;
      
      private var _royaltyTempCate:RoyaltyTempCate;
      
      private var _poseidonShopCate:PoseidonShopCate;
      
      private var _forbiddenBossTempCate:ForbiddenBossTempCate;
      
      private var _forbiddenBossBelongDropCate:ForbiddenBossBelongDropCate;
      
      private var _forbiddenBossJoinDropCate:ForbiddenBossJoinDropCate;
      
      private var _collectionSuitTempCate:CollectionSuitTempCate;
      
      private var _collectionTempCate:CollectionTempCate;
      
      private var _theseusEquipSuitCate:TheseusEquipSuiteTempCate;
      
      private var _theseusRageTempCate:TheseusRageTempCate;
      
      private var _theseusRageSuitTempCate:TheseusRageSuiteTempCate;
      
      private var _secretMapCate:SecretMapLevelCate;
      
      private var _secretsonLvCate:SecretSonLevelCate;
      
      private var _secretEventCate:SecretEventCate;
      
      private var _secretSonDataCate:SecretMapDataCate;
      
      private var _theseusTreasureHokeCate:TheseusTreasureHokeCate;
      
      private var _theseusTreasureCoreCate:TheseusTreasureCoreCate;
      
      private var _theseusTreasureGrowupCate:TheseusTreasureGrowupCate;
      
      private var _theseusSlateCate:TheseusSlateCate;
      
      private var _theseusSlateTaskCate:TheseusSlateTaskCate;
      
      private var _theseusSlateUpgradeCate:TheseusSlateUpgradeCate;
      
      private var _theseusDungeonCate:TheseusDungeonCate;
      
      private var _theseusDungeonEventCate:TheseusDungeonEventCate;
      
      private var _theseusDungeonTaskCate:TheseusDungeonTaskCate;
      
      private var _carnivalPointExchangeCate:CarnivalPointExchangeTemplateCate;
      
      private var _carnivalPlayGroundTemplateCate:CarnivalPlayGroundTemplateCate;
      
      private var _carnivalLuckDrawTemplateCate:CarnivalLuckDrawTemplateCate;
      
      private var _carnivalDailyChallengeTemplateCate:CarnivalDailyChallengeTemplateCate;
      
      private var _newActiveLeedCate:NewActiveLeedCate;
      
      private var _newActiveLeedDailyCate:NewActiveLeedDailyCate;
      
      private var _newActiveLeedWeekCate:NewActiveLeedWeekCate;
      
      private var _warSoulTowerLevelTempCate:WarSoulTowerLevelTempCate;
      
      private var _warSoulTowerStageTempCate:WarSoulTowerStageTempCate;
      
      private var _warsoulCate:WarSoulTempCate;
      
      private var _warsoulStarCate:WarSoulStarTempCate;
      
      private var _warsoulStrengthenCate:WarSoulStrengthenTempCate;
      
      private var _warsoulReformCate:WarSoulReformTempCate;
      
      private var _finalRoadGroupTempCate:FinalRoadGroupTempCate;
      
      private var _finalRoadEventTempCate:FinalRoadEventTempCate;
      
      private var _finalRoadChapterTempCate:FinalRoadChapterTempCate;
      
      private var _theseusPvpTempCate:TheseusPvpTempCate;
      
      private var _theseusPvpIntegralCate:TheseusPvpIntegralTempCate;
      
      private var _theseusPvpTaskCate:TheseusPvpTaskTempCate;
      
      private var _theseusMultiPvpTempCate:TheseusMultiPvpTempCate;
      
      private var _theseusMultiPvpIntegralCate:TheseusMultiPvpIntegralTempCate;
      
      private var _theseusMultiPvpTaskCate:TheseusMultiPvpTaskTempCate;
      
      private var _theseusPvpRewardCate:SpeicalRewardTempCate;
      
      private var _theseuspvpShopDic:Dictionary;
      
      private var _oldPlayerReturnTaskTempCate:OldPlayerReturnTaskTempCate;
      
      private var _oldPlayerReturnRewardTempCate:OldPlayerReturnRewardTempCate;
      
      private var _oldPlayerReturnShopTempCate:OldPlayerReturnShopTempCate;
      
      private var _oldPlayerReturnPrivilegeTempCate:OldPlayerReturnPrivilegeTempCate;
      
      private var _runeGemInfoCate:RuneGemTempInfoCate;
      
      private var _runeHoleInfoCate:RuneHoleTempInfoCate;
      
      private var _runeFsgainInfoCate:RuneFsgainTempInfoCate;
      
      private var _secretwarShopTempCate:SecretwarShopTempCate;
      
      private var _yearActiveDropCate:YearActiveDropCate;
      
      private var _minosLevelCate:MinosLevelCate;
      
      private var _minosNodeCate:MinosNodeCate;
      
      private var _minosRewardCate:MinosRewardCate;
      
      private var _consortiaCommerceShopTempCate:ConsortiaCommerceShopTempCate;
      
      private var _christmasLotteryTempCate:ChristmasLotteryTempCate;
      
      private var _christmasActivitiesTempCate:ChristmasActivitiesTempCate;
      
      private var _christmasAnswersTempCate:ChristmasAnswersTempCate;
      
      private var _christmasAchievementsTempCate:ChristmasAchievementsTempCate;
      
      private var _chesspvpRankDropCate:ChessPvpRankDropCate;
      
      private var _chesspvpFightDropCate:ChessPvpFightDropCate;
      
      private var _childNswarCate:ChildNswarTempCate;
      
      private var _childNswarTaskCate:ChildNswarTaskTempCate;
      
      private var _childNswarShopDic:Dictionary;
      
      private var _thessTowerCate:ThessTowerTempCate;
      
      private var _thessBoxCate:ThessBoxTempCate;
      
      private var _thessBoxMapCate:ThessBoxMapCate;
      
      private var queue:TemplateResolveQueue;
      
      private var tempData:Dictionary = new Dictionary();
      
      private var _consortialevelTemplate:Dictionary;
      
      private var _actionTemplate2:Dictionary;
      
      private var _petExchangeShopTemplateDic:Dictionary;
      
      private var _gameHeroTemplateCate:GameHeroTemplateCate;
      
      private var _pawnTemplateCate:PawnTemplateCate;
      
      private var _goodsTemplateCate:GoodsTemplateCate;
      
      private var _buildTemplateCate:BuildTemplateCate;
      
      private var _kingContraceCate:KingContraceCate;
      
      private var _actonTemplateCate:ActonTemplateCate;
      
      private var _collectionRewardTempCate:CollectionRewardTempCate;
      
      private var _bufferTemplateCate:BufferTemplateCate;
      
      private var _talentTemplateCate:TalentTemplateCate;
      
      private var _tollgateRewardCate:TollgateRewardCate;
      
      private var _effectTemplateCate:EffectTemplateCate;
      
      private var _campaignBufferTemplateCate:CampaignBufferTemplateCate;
      
      private var _mapTemplateCate:MaptemplateCate;
      
      private var _heroAISTemplateCate:HeroAISTemplateCate;
      
      private var _consortiaDropTemplateCate:ConsortiaDropTemplateCate;
      
      private var _dayGuideDropTemplateCate:DayGuideDropTemplateCate;
      
      private var _mapPhysicsTempleteCate:MapPhysicsTempleteCate;
      
      private var _pawnSpecialTemplateCate:PawnSpecialTemplateCate;
      
      private var _vipDropTemplateCate:VipDropTemplateCate;
      
      private var _vipPrerogativeTemplateCate:VipPrerogativeTemplateCate;
      
      private var _skillPropertyTemplateCate:SkillPropertyTemplateCate;
      
      private var _suitTemplateCate:SuitTemplateCate;
      
      private var _transformBackTemplateCate:TransformBackTemplateCate;
      
      private var _starTempalteCate:StarTempalteCate;
      
      private var _leedTemplateCate:LeedTemplateCate;
      
      private var _leedDropTemplateCate:LeedDropTemplateCate;
      
      private var _firstPayDropTempalteCate:FirstPayDropTempalteCate;
      
      private var _assistantTemplates:AssistantTemplates;
      
      private var _collectionGetDrop:CollectionGetDrop;
      
      private var _collectionOpenDrop:CollectionOpenDrop;
      
      private var _exchargeRankTemplateCate:ExchargeRankTemplateCate;
      
      private var _catHouseTemplateCate:CatHouseTemplateCate;
      
      private var _districtTemplateCate:DistrictTemplateCate;
      
      private var _districtSSSTemplateCate:DistrictSSSTemplateCate;
      
      private var _countLoginDropTemplateCate:CountLoginDropTemplateCate;
      
      private var _bag360DropTemplateCate:Bag360DropTemplateCate;
      
      private var _timeBoxTemplateCate:TimeBoxTemplateCate;
      
      private var _noviceboxTemplateCate:NoviceboxTemplateCate;
      
      private var _activeTemplateCate:ActiveTemplateCate;
      
      private var _signDropTemplateCate:SignDropTemplateCate;
      
      private var _vehicleNpcTempteCate:VehicleObjectTempInfoCate;
      
      private var _vehicleSkillTempteCate:VehicleSkillTempInfoCate;
      
      private var _appellInfoTemplateCate:AppellInfoTemplateCate;
      
      private var _vehicleSkillBuffTemplateCate:VehicleSkillBuffTemplateCate;
      
      private var _vehicleAdditionTemplateCate:VehicleAdditionTemplateCate;
      
      private var _petTemplateCate:PetTemplateCate;
      
      private var _petChallengeRewardCate:PetChallengeRewardCate;
      
      private var _godTreasureTemplateCate:GodTreasureTemplateCate;
      
      private var _simpleTaskTemplateCate:SimpleTaskTemplateCate;
      
      private var _servenLeadRewardTemplateCate:ServenLeadRewardTemplateCate;
      
      private var _godArriveTemplateCate:GodArriveTemplateCate;
      
      private var _heartTemplateCate:HeartTemplateCate;
      
      private var _marryQualityTemplateCate:MarryQualityTemplateCate;
      
      private var _singlePassAreaRewardTemplateCate:SinglePassAreaRewardTemplateCate;
      
      private var _singlePassBossRewardTemplateCate:SinglePassBossRewardTemplateCate;
      
      private var _magicCardTemplateCate:MagicCardTemplateCate;
      
      private var _fishTemplateCate:FishTemplateCate;
      
      private var _boxItemTemplateCate:BoxItemTemplateCate;
      
      private var _christmasTreeItemsTemplateCate:ChristmasTreeItemsTemplateCate;
      
      private var _timeVortexDropTemplateCate:TimeVortexDropTemplateCate;
      
      private var _yearactiveShopDic:Dictionary = new Dictionary();
      
      public function TempleteManager()
      {
         super();
      }
      
      public static function get instance() : TempleteManager
      {
         if(!_instance)
         {
            _instance = new TempleteManager();
         }
         return _instance;
      }
      
      public function clear() : void
      {
         if(queue)
         {
            queue.dispose();
         }
         queue = null;
      }
      
      public function setup(param1:ByteArray, param2:Function) : void
      {
         _callBack = param2;
         shiftTempInfo(param1);
         createTempleteCate();
         createTemplateResolveQueue();
      }
      
      private function shiftTempInfo(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _tempDic = new Dictionary();
         param1.position = 0;
         var _loc4_:uint = param1.readUnsignedInt();
         TempleteSaveManager.instance.checkVersions(_loc4_);
         while(param1.bytesAvailable > 0)
         {
            _loc3_ = param1.readByte();
            _loc2_ = param1.readUTFBytes(_loc3_);
            _loc5_ = param1.readInt();
            _loc6_ = param1.readUTFBytes(_loc5_);
            _tempDic[_loc2_] = _loc6_;
         }
         param1.clear();
         param1 = null;
      }
      
      private function getXmlListByName(param1:String) : XMLList
      {
         var _loc2_:String = _tempDic[param1];
         if(_loc2_ != null)
         {
            _tempDic[param1] = null;
            delete _tempDic[param1];
         }
         var _loc3_:XML = new XML(_loc2_);
         return _loc3_.children();
      }
      
      private function getXmlFromRoot(param1:String, param2:String, param3:Boolean = false) : XMLList
      {
         var _loc4_:String = _tempDic[param1];
         if(_loc4_ != null && param3)
         {
            _tempDic[param1] = null;
            delete _tempDic[param1];
         }
         var _loc5_:XML = new XML(_loc4_);
         return _loc5_[param2].children();
      }
      
      private function createTempleteCate() : void
      {
         var _loc1_:Number = getTimer();
         _gameHeroTemplateCate = new GameHeroTemplateCate(getXmlListByName("GameHeroTemp"));
         _pawnTemplateCate = new PawnTemplateCate(getXmlListByName("PawnTempInfos"));
         _goodsTemplateCate = new GoodsTemplateCate(getXmlListByName("ItemTempInfos"));
         _buildTemplateCate = new BuildTemplateCate(getXmlListByName("BuildingTempInfos"));
         _kingContraceCate = new KingContraceCate(getXmlListByName("KingContracts"));
         _actonTemplateCate = new ActonTemplateCate(getXmlListByName("ActionTempInfos"));
         _collectionRewardTempCate = new CollectionRewardTempCate(getXmlListByName("CollectionRewardTemplates"));
         _bufferTemplateCate = new BufferTemplateCate(getXmlListByName("SkillBufferTempInfos"));
         _effectTemplateCate = new EffectTemplateCate(getXmlListByName("EffectTempInfos"));
         _mapTemplateCate = new MaptemplateCate(getXmlListByName("MapInfos"));
         _heroAISTemplateCate = new HeroAISTemplateCate(getXmlListByName("HeroAis"));
         _mapPhysicsTempleteCate = new MapPhysicsTempleteCate(getXmlListByName("MapPhysicsTempInfos"));
         _pawnSpecialTemplateCate = new PawnSpecialTemplateCate(getXmlListByName("SpecialTempInfos"));
         _vipDropTemplateCate = new VipDropTemplateCate(getXmlListByName("VipDrop"));
         _suitTemplateCate = new SuitTemplateCate(getXmlListByName("SuiteTempInfos"));
         _activeTemplateCate = new ActiveTemplateCate(getXmlListByName("ActiveTempInfos"));
         _noviceboxTemplateCate = new NoviceboxTemplateCate(getXmlListByName("GradeDrop"));
         _timeBoxTemplateCate = new TimeBoxTemplateCate(getXmlListByName("TimeDrop"));
         _districtTemplateCate = new DistrictTemplateCate(getXmlListByName("DistrictDrop"));
         _districtSSSTemplateCate = new DistrictSSSTemplateCate(getXmlListByName("DistrictSSSDrop"));
         _leedDropTemplateCate = new LeedDropTemplateCate(getXmlListByName("LeedDrop"));
         _leedTemplateCate = new LeedTemplateCate(getXmlListByName("LeedTemp"));
         _signDropTemplateCate = new SignDropTemplateCate(getXmlListByName("SignDrop"));
         _starTempalteCate = new StarTempalteCate(getXmlListByName("starTempInfos"));
         _talentTemplateCate = new TalentTemplateCate(getXmlListByName("TalentEffectTempInfos"));
         _transformBackTemplateCate = new TransformBackTemplateCate(getXmlListByName("TransformInfos"));
         _consortiaDropTemplateCate = new ConsortiaDropTemplateCate(getXmlListByName("DropViewInfos"));
         _dayGuideDropTemplateCate = new DayGuideDropTemplateCate(getXmlListByName("LeadReward"));
         _campaignBufferTemplateCate = new CampaignBufferTemplateCate(getXmlListByName("CampaignBufferTemps"));
         _vipPrerogativeTemplateCate = new VipPrerogativeTemplateCate(getXmlListByName("VipPrerogativeTempInfos"));
         _skillPropertyTemplateCate = new SkillPropertyTemplateCate(getXmlListByName("SkillPropertyTempInfos"));
         _countLoginDropTemplateCate = new CountLoginDropTemplateCate(getXmlListByName("ReloginDrops"));
         _bag360DropTemplateCate = new Bag360DropTemplateCate(getXmlListByName("PrivilegeDrops"));
         _firstPayDropTempalteCate = new FirstPayDropTempalteCate(getXmlListByName("FirstChargeItems"));
         _appellInfoTemplateCate = new AppellInfoTemplateCate(getXmlListByName("AppellInfos"));
         _vehicleNpcTempteCate = new VehicleObjectTempInfoCate(getXmlListByName("VehicleObjectTempInfos"));
         _vehicleSkillTempteCate = new VehicleSkillTempInfoCate(getXmlListByName("VehicleSkillTempInfos"));
         _vehicleSkillBuffTemplateCate = new VehicleSkillBuffTemplateCate(getXmlListByName("VehicleBuffTempInfos"));
         _vehicleAdditionTemplateCate = new VehicleAdditionTemplateCate(getXmlListByName("VehicleProficiencyTempInfo"));
         _petTemplateCate = new PetTemplateCate(getXmlListByName("PetTempInfos"));
         _petChallengeRewardCate = new PetChallengeRewardCate(getXmlListByName("PetChallengeRewards"));
         _rapidThroughRewardCate = new RapidThroughRewardCate(getXmlListByName("QuickPassRewards"));
         _fashionPolishTemplateCate = new FashionPolishTemplateCate(getXmlListByName("FashionPolishs"));
         _simpleTaskTemplateCate = new SimpleTaskTemplateCate(getXmlListByName("SimpleTask"));
         _servenLeadRewardTemplateCate = new ServenLeadRewardTemplateCate(getXmlListByName("ServenLeadRewards"));
         _godArriveTemplateCate = new GodArriveTemplateCate(getXmlListByName("CampaignData"));
         _singlePassAreaRewardTemplateCate = new SinglePassAreaRewardTemplateCate(getXmlListByName("AreaReward"));
         _singlePassBossRewardTemplateCate = new SinglePassBossRewardTemplateCate(getXmlListByName("BossReward"));
         _magicCardTemplateCate = new MagicCardTemplateCate(getXmlListByName("MagicCardTempInfos"));
         _marryQualityTemplateCate = new MarryQualityTemplateCate(getXmlListByName("MarrySpecTempInfos"));
         _collectionGetDrop = new CollectionGetDrop(getXmlListByName("CollectionGetDrop"));
         _collectionOpenDrop = new CollectionOpenDrop(getXmlListByName("CollectionOpenDrop"));
         _assistantTemplates = new AssistantTemplates(getXmlListByName("AssistantTemplates"));
         _fishTemplateCate = new FishTemplateCate(getXmlListByName("FishTemplateInfos"));
         _boxItemTemplateCate = new BoxItemTemplateCate(getXmlListByName("BoxItems"));
         _heartTemplateCate = new HeartTemplateCate(getXmlListByName("HeartTempInfos"));
         _rondamBossTemplateCate = new RondamBossTemplateCate(getXmlListByName("RandomBossBuffInfos"));
         _outerCityShopCostTemplateCate = new OuterCityShopCostTemplateCate(getXmlListByName("MapShopCost"));
         _planesTemplateCate = new PlanesTemplateCate(getXmlListByName("PlanesTemplates"));
         _planesLayerTemplateCate = new PlanesLayerTemplateCate(getXmlListByName("PlanesLayers"));
         _planesEventsTemplateCate = new PlanesEventsTemplateCate(getXmlListByName("PlanesEvents"));
         _christmasTreeItemsTemplateCate = new ChristmasTreeItemsTemplateCate(getXmlListByName("ChristmasItems"));
         _tollgateRewardCate = new TollgateRewardCate(getXmlListByName("TollgateReward"));
         _exchargeRankTemplateCate = new ExchargeRankTemplateCate(getXmlListByName("ChargeRanks"));
         _remotePetTemplateCate = new RemotePetTemplateCate(getXmlListByName("RemotePetTempInfos"));
         _childTemplateCate = new ChildTemplateCate(getXmlListByName("ChildTempInfos"));
         _childPveBossTemplateCate = new ChildPveBossTemplateCate(getXmlFromRoot("GuardPVETemp","GuardPVEBossTempInfos"));
         _guardPveExploreTemplateCate = new GuardPveExploreTemplateCate(getXmlFromRoot("GuardPVETemp","GuardPveExploreRewardInfos",true));
         _skytriallayerTemplateCate = new SkytriallayerTemplateCate(getXmlListByName("SkyTrialLayerTempInfos"));
         _skyTrialPortalTemplateCate = new SkyTrialPortalTemplateCate(getXmlListByName("SkyTrialPortalTempInfos"));
         _skytrialeventTemplateCate = new SkytrialeventTemplateCate(getXmlListByName("SkyTrialEventTempInfos"));
         _consortiaBossTemplateCate = new ConsortiaBossTemplateCate(getXmlListByName("ConsortiaBossTempInfos"));
         _gameBoxShopTemplateCate = new GameBoxShopTemplateCate(getXmlListByName("GameBoxShopTempInfos"));
         _dichTemplateCate = new DitchTemplateCate(getXmlListByName("DitchTemplateInfos"));
         _archaeologyBookTemplateCate = new ArchaeologyBookTemplateCate(getXmlListByName("ArchaeologyBookTemps"));
         _archaeologyItemTemplateCate = new ArchaeologyItemTemplateCate(getXmlListByName("ArchaeologyItemTemps"));
         _catHouseTemplateCate = new CatHouseTemplateCate(getXmlListByName("CattoysTemplateInfos"));
         _furnitureTemplateCate = new FurnitureTemplateCate(getXmlListByName("FurnitureTempInfos"));
         _titanTemplateCate = new DragonTitanTemplateCate(getXmlListByName("TitanTempInfos"));
         _childPatrolMissionTempCate = new ChildPatrolMissionTemplateCate(getXmlListByName("ChildPatrolMissionTempInfos"));
         _faceBookTempCate = new FaceBookTemplateCate(getXmlListByName("ShareTemplateInfos"));
         _regressTemplateCate = new RegressTemplateCate(getXmlListByName("RegressTemplateInfos"));
         _navigationShopTemplateCate = new NavigationShopTemplateCate(getXmlListByName("NavigationShopTempInfos"));
         _navigationTaskTemplateCate = new NavigationTaskTemplateCate(getXmlListByName("NavigationTaskTempInfos"));
         _childTypeTemplateCate = new ChildTypeTemplateCate(getXmlListByName("ChildTypeTempInfos"));
         _outyardTemplateCate = new OutyardTemplateCate(getXmlListByName("HugeHeadMapNodeTempInfos"));
         _outyardAreaTemplateCate = new OutyardAreaTemplateCate(getXmlListByName("StackHeadExploreTempInfos"));
         _crossGuildNodeTemplateCate = new CrossGuildNodeTemplateCate(getXmlListByName("CrossGuildNodeTempInfos"));
         _outyardTitanTemplateCate = new OutyardTitanTemplateCate(getXmlListByName("TitanlandDrop"));
         _outyardShuttleTemplateCate = new OutyardShuttleTemplateCate(getXmlListByName("ShuttleTempInfos"));
         _outyardShuttleRewardTemplateCate = new OutyardShuttleRewardTemplateCate(getXmlListByName("ShuttleRewardTempInfos"));
         _magicPubNpcTemplateCate = new MagicPubNpcTemplateCate(getXmlListByName("MagicPubNpcInfos"));
         _magicPubChatTemplateCate = new MagicPubChatTemplateCate(getXmlListByName("MagicPubChatInfos"));
         _heroRoadTemplateCate = new HeroRoadTemplateCate(getXmlListByName("HeroRoadTempInfos"));
         _artifactTemplateCate = new ArtifactTemplateCate(getXmlListByName("ArtifactTemplateInfos"));
         _areaMapDropTemplateCate = new AreaMapDropTemplateCate(getXmlListByName("AreaMapDropInfos"));
         _gloryRoadBufferTemplateCate = new GloryRoadBufferTemplateCate(getXmlListByName("GloryRoadBufferInfos"));
         _gloryRoadDropTemplateCate = new GloryRoadDropTemplateCate(getXmlListByName("GloryRoadDrop"));
         _furnitureShopTemplateCate = new FurnitureShopTemplateCate(getXmlListByName("FurnitureShopTempInfos"));
         _petHallowsTemplateCate = new PetHallowsTemplateCate(getXmlListByName("PetHallowsTempInfos"));
         _petContracTemplateCate = new PetContracTemplateCate(getXmlListByName("PetContracTempInfos"));
         _consortiaTreasureTemplateCate = new ConsortiaTreasureTemplateCate(getXmlListByName("ConsortiaTreasureTempInfos"));
         _planesFuncTemplateCate = new PlanesFuncTemplateCate(getXmlListByName("PlanesFuncTempInfos"));
         _childComposeTemplateCate = new ChildComposeTemplateCate(getXmlListByName("ChildComposeTempInfos"));
         _topToolBtnTempCate = new TopToolBtnTempCate(getXmlListByName("TopToolBtnInfos"));
         _lordTrialTempCate = new LordTrialTempCate(getXmlListByName("LordTrialTempInfos"));
         _childArenaRewardTempCate = new ChildArenaRewardTempCate(getXmlListByName("GuardPvpDrop"));
         _alchemicalMineTempCate = new AlchemicalMineTempCate(getXmlListByName("AlchemyMineTemplates"));
         _alchemicalFormulaTempCate = new AlchemicalFormulaTempCate(getXmlListByName("AlchemyFormulaTemplates"));
         _armoryTempCate = new ArmoryTempCate(getXmlListByName("ArftiArmoryTemplateInfos"));
         _skyBoxRoadRankRewardTempCate = new SkyBoxRoadRankRewardTempCate(getXmlListByName("SkyOrderRewards"));
         _skyBoxRoadTimeRewardTempCate = new SkyBoxRoadTimeRewardTempCate(getXmlListByName("SkyRewards"));
         _timeVortexDropTemplateCate = new TimeVortexDropTemplateCate(getXmlListByName("TimeVortexRewards"));
         _unrealShootingRewardTempCate = new UnrealShootingRewardTempCate(getXmlListByName("UnrealWeekRewards"));
         _dragonTalkerFightMountTempcate = new DragonTalkerFightMountTempcate(getXmlListByName("DragonTalkerFightMountTemplates"));
         _starGazingDropTempCate = new StarGazingDropTempCate(getXmlListByName("StargazingDrop"));
         _planeCrisisTempCate = new PlaneCrisisTempCate(getXmlListByName("CrisisMapInfos"));
         _planeCrisisEventTempCate = new PlaneCrisisEventTempCate(getXmlListByName("CrisisEventInfos"));
         _planeCrisisGoodTempCate = new PlaneCrisisGoodTempCate(getXmlListByName("CrisisDrop"));
         _magicSpringTempCate = new MagicSpringFormulaTempCate(getXmlListByName("MagicSpringTempInfos"));
         _eclipticPalaceTempCate = new EclipticPalaceTempCate(getXmlListByName("EclipticPalaceTempInfos"));
         _eclipticPalaceRewardTempCate = new EclipticPalaceRewardCate(getXmlListByName("EclipticPalaceDrop"));
         _upgradePresentBoxDropTempCate = new UpgradePresentBoxDropTempCate(getXmlListByName("UpgradePresentBoxDrop"));
         _demonLandTemplateCate = new DemonLandTemplateCate(getXmlListByName("EvilLandTemplates"));
         _demonLandDropTemplateCate = new DemonLandDropTemplateCate(getXmlListByName("EvilLandDrop"));
         _demonLandBoxDropTemplateCate = new DemonLandBoxDropTemplateCate(getXmlListByName("EvilLandBoxDrop"));
         _goddessTempCate = new GoddessTemplateCate(getXmlListByName("GoddessTemplateInfos"));
         _goddessLevelTempCate = new GoddessLevelTempCate(getXmlListByName("GoddessUpgradeTemplates"));
         _goddessAdvanceTempCate = new GoddessAdvanceTempCate(getXmlListByName("GoddessStepTemplates"));
         _goddessDedicationTempCate = new GoddessDediactionTempCate(getXmlListByName("GoddessDevoteTemplates"));
         _goddessFormationTempCate = new GoddessFormationTempCate(getXmlListByName("GoddessUnitedResiTemplates"));
         _goddessFormationSkillTempCate = new GoddessFormationSkillTempCate(getXmlListByName("GoddessUnitedSkillTemplates"));
         _goddessEquipTempCate = new GoddessEquipTempCate(getXmlListByName("GoddessEquipmentTempInfos"));
         _guildFbTempcate = new GuildFBTemplateCate(getXmlListByName("ConsortiaPveTemplates"));
         _guildFbDropTempCate = new GuildFBDropTempCate(getXmlListByName("ConsortiaPveDrop"));
         _guildFbPveRankDropTempte = new GuildFBPveRankDropTempCate(getXmlListByName("ConsortiaPveRankDrop"));
         _consortiaQuestTempCate = new ConsortiaQuestTempCate(getXmlListByName("ConsortiaQuestTempInfos"));
         _consortiaQuestConditionTempCate = new ConsortiaQuestConditionTempCate(getXmlListByName("ConsortiaQuestConditionTempInfos"));
         _consortiaBusinessTempCate = new ConsortiaBusinessTempCate(getXmlListByName("ConsortiaShopTempInfos"));
         _gameHallTemplateCate = new GameHallTemplateCate(getXmlListByName("GameHallTemplates"));
         _resolveitemsortTemplateCate = new ResolveitemsortTemplateCate(getXmlListByName("ItemResolveSortTemplates"));
         _apexRankRewardDropTempCate = new ApexRewardDropTempCate(getXmlListByName("ApexRewardDrop"));
         _crossGuildRewardTempCate = new CrossGuildRewardTempCate(getXmlListByName("ConsortiaWarSeasonDrop"));
         _crossGuildSingleRewardTempCate = new CrossGuildSingleRewardTempCate(getXmlListByName("ConsortiaWarFightDrop"));
         _crossGuildContributionRewardTempCate = new CrossGuildContributionRewardTempCate(getXmlListByName("ConsortiaWarUserDrop"));
         _crossGuildWarQuestTempCate = new CrossGuildWarQuestTempCate(getXmlListByName("ConsortiaWarQuestTemplates"));
         _monsterTempCate = new MonsterTemplateCate(getXmlListByName("MonsterTemplates"));
         _monsterRecipeTempCate = new MonsterRecipeTemplateCate(getXmlListByName("RecipeTemplates"));
         _monsterCookDropTempCate = new MonsterCookDropTempCate(getXmlListByName("MonsterCookDrop"));
         _monsterExploreTemplateCate = new MonsterExploreTemplateCate(getXmlListByName("MonsterExploreTemplates"));
         _monsterExploreDropCate = new MonsterExploreDropTempCate(getXmlListByName("MonsterExploreDrop"));
         _dreamArenaRewardTempCate = new DreamArenaRewardTempCate(getXmlListByName("DreamArenaDrop"));
         _dreamArenaTempCate = new DreamArenaTempCate(getXmlListByName("DreamArenaTemplates"));
         _airGardenBedTempCate = new AirGardenBedTempCate(getXmlListByName("AirGardenNodeTemplates"));
         _gameHallEastTemplateCate = new GameHallEastTemplateCate(getXmlListByName("EasterTemplates"));
         _gamehallEastShopTempCate = new GamehallEastShopTempCate(getXmlListByName("EasterLotteryDrop"));
         _avengerSkillTempCate = new AvengerSkillTempCate(getXmlListByName("AvengerSkillTemplates"));
         _avengerBodyTempCate = new AvengerBodyTempCate(getXmlListByName("AvengerBodyTemplates"));
         _selfChessTempCate = new SelfChessTempCate(getXmlListByName("AutoChessHeroInfos"));
         _selfChessBuffTempCate = new SelfChessBuffTampCate(getXmlListByName("AutoChessBuffInfos"));
         _sevenYearFreeRewardDropCate = new SevenYearFreeRewardDropCate(getXmlListByName("SevenYearFreeRewardDrop"));
         _revengeRoadTempCate = new RevengeRoadTemplateCate(getXmlListByName("RevengeRoadTemplates"));
         _revengeRoadAreaBoxCate = new RevengeRoadAreaBoxTempCate(getXmlListByName("RevengeRoadBoxDrop"));
         _revengeRoadDropCate = new RevengeRoadDropTempCate(getXmlListByName("RevengeRoadDrop"));
         _proficiencyTempCate = new ProficiencyTempCate(getXmlListByName("ProficiencyTemplates"));
         _kingbackTempCate = new KingbackTemplateCate(getXmlListByName("OlderRefluxTempInfos"));
         _starareaRoadsTempCate = new StarareaRoadsTempCate(getXmlListByName("StarAreaRoadInfos"));
         _starAreaDropCate = new StarAreaDropCate(getXmlListByName("StarAreaDrop"));
         _sevenYearAchievementTempCate = new SevenYearAchievementTempCate(getXmlListByName("SevenYearAchievementTemplates"));
         _sevenYearQuestionTempCate = new SevenYearQuestionTempCate(getXmlListByName("SevenYearQuestionTemplates"));
         _sevenYearRewardDropCate = new SevenYearRewardDropCate(getXmlListByName("SevenYearRewardDrop"));
         _sevenYearTreasureBoxDropCate = new SevenYearTreasureBoxDropCate(getXmlListByName("TreasureBoxDrop"));
         _gloryRewardDropCate = new GloryRewardDropCate(getXmlListByName("GloryRewardDrop"));
         _guildWantedDropTempCate = new GuildWantedDropTempCate(getXmlListByName("ConsortiaWantDrop"));
         _abysmDropCate = new AbysmDropTempCate(getXmlListByName("GuardEndlessDrop"));
         _abysmHellDropCate = new AbysmHellDropTempCate(getXmlListByName("GuardEndlessHorribleDrop"));
         _avengerCommonTempCate = new AvengerCommonTempCate(getXmlListByName("AvengerHoleTemplates"));
         _resolveTempCate = new ResolveTemplateCate(getXmlListByName("ItemResolveTemplates"));
         _raceAgainstTimeDropTempCate = new RaceAgainstTimeDropTempCate(getXmlListByName("RushCampaignDrop"));
         _spiritExpeditionTempCate = new SpiritExpeditionTempCate(getXmlListByName("ExpeditionTemplates"));
         _spiritExpeditionFightDropTempCate = new SpiritExpeditionFightDropTempCate(getXmlListByName("ExpeditionFightDrop"));
         _spiritExpeditionStarDropTempCate = new SpiritExpeditionStarDropTempCate(getXmlListByName("ExpeditionStarDrop"));
         _childAssistUpgradeTemplateCate = new ChildAssistUpgradeTemplateCate(getXmlListByName("ChildAssistUpgradeTemplates"));
         _childCampTempCate = new ChildCampTempCate(getXmlListByName("ChildCampTemps"));
         _shadowLandTempCate = new ShadowLandTempCate(getXmlListByName("ShadowLandTemplates"));
         _shadowLandFightDropTempCate = new ShadowLandFightDropTempCate(getXmlListByName("ShadowLandFightDrop"));
         _shadowLandBoxDropTempCate = new ShadowLandBoxDropTempCate(getXmlListByName("ShadowLandBoxDrop"));
         _darkMazeEventTempCate = new DarkMazeEventTempCate(getXmlListByName("DarkMazeEventTemplates"));
         _darkMazeChildTempCate = new DarkMazeChildTempCate(getXmlListByName("DarkMazeChildTemplates"));
         _singleCampaignTempCate = new SingleCampaignDataTempCate(getXmlListByName("SingleCampaignDatas"));
         _theseusEquipStrengthenTmpl = new TheseusEquipStrengthenTmpl(getXmlListByName("TheseusEquipStrengthenTmpls"));
         _theseusEquipQualityTmpl = new TheseusEquipQualityTmpl(getXmlListByName("TheseusEquipQualityTmpls"));
         _stelaTempCate = new StelaTemplateCate(getXmlListByName("StelaTemplates"));
         _stelaStepTempCate = new StelaStepTemplateCate(getXmlListByName("StelaStepTemplates"));
         _stelaPropertyTempCate = new StelaPropertyTemplateCate(getXmlListByName("StelaPropertyTemplates"));
         _stelaResistTempCate = new StelaResistTemplateCate(getXmlListByName("StelaResistTemplates"));
         _remainsExploreTempCate = new RemainsExploreTempCate(getXmlListByName("RemainsExploreNodeTemps"));
         _remainsExploreChapterTempCate = new RemainsExploreChapterTempCate(getXmlListByName("RemainsExploreChapterTemps"));
         _remainsExploreEventTempCate = new RemainsExploreEventTempCate(getXmlListByName("RemainsExploreEventTemps"));
         _remainsExploreDropTempCate = new RemainsExploreDropTempCate(getXmlListByName("RemainsExploreDrop"));
         _remainsExploreActivityTempCate = new RemainsExploreActivityTempCate(getXmlListByName("RemainsLeedTemps"));
         _remainsExploreActivityDropTempCate = new RemainsExploreActivityDropTempCate(getXmlListByName("RemainsExploreBox"));
         _skyStepDropTempCate = new SkyStepDropTempCate(getXmlListByName("SkyStepDrop"));
         _consortiaNewBossTempCate = new ConsortiaNewBossTemplateCate(getXmlListByName("ConsortiaNewBossTemplates"));
         _consortiaNewBossRankRewardTempCate = new ConsortiaNewBossRankRewardTempCate(getXmlListByName("ConsortiaNewBossReward"));
         _consortiaNewBossDamageRewardTempCate = new ConsortiaNewBossDamageRewardTempCate(getXmlListByName("ConsortiaNewBossDamageReward"));
         _achievementTaskTemplateCate = new AchievementTaskTemplateCate(getXmlListByName("AchievementTaskTemplates"));
         _achievementTaskBuyDropTemplateCate = new AchievementTaskBuyDropTemplateCate(getXmlListByName("AchievementTaskBuyDrop"));
         _newFirstPlayCate = new NewFirstPlayCate(getXmlListByName("FirstPayTemplates"));
         _newFirstPlayDropCate = new NewFirstPayDropCate(getXmlListByName("FirstPayDrop"));
         _questionDropTempCate = new QuestionDropTempCate(getXmlListByName("QuestionDrop"));
         _questionTempCate = new QuestionTempCate(getXmlListByName("QuestionTemplates"));
         _poseidonShopCate = new PoseidonShopCate(getXmlListByName("PoseidonShopTemplates"));
         _royaltyBossTempCate = new RoyaltyBossTempCate(getXmlListByName("RoyaltyBossTemplates"));
         _royaltyTempCate = new RoyaltyTempCate(getXmlListByName("RoyaltyTemplates"));
         _forbiddenBossTempCate = new ForbiddenBossTempCate(getXmlListByName("ForbiddenBossTemplates"));
         _forbiddenBossBelongDropCate = new ForbiddenBossBelongDropCate(getXmlListByName("ForbiddenBossBelongDrop"));
         _forbiddenBossJoinDropCate = new ForbiddenBossJoinDropCate(getXmlListByName("ForbiddenBossJoinDrop"));
         _theseusEquipSuitCate = new TheseusEquipSuiteTempCate(getXmlListByName("TheseusEquipSuiteTemplates"));
         _theseusRageTempCate = new TheseusRageTempCate(getXmlListByName("TheseusRageTemplates"));
         _theseusRageSuitTempCate = new TheseusRageSuiteTempCate(getXmlListByName("TheseusRageSuiteTemplates"));
         _collectionTempCate = new CollectionTempCate(getXmlListByName("CollectionTemplates"));
         _collectionSuitTempCate = new CollectionSuitTempCate(getXmlListByName("CollectionSuitTemplates"));
         _secretMapCate = new SecretMapLevelCate(getXmlListByName("SecretMapLevelTemplates"));
         _secretsonLvCate = new SecretSonLevelCate(getXmlListByName("SecretSonLevelTemplates"));
         _secretEventCate = new SecretEventCate(getXmlListByName("SecretEventTemplates"));
         _secretSonDataCate = new SecretMapDataCate(getXmlListByName("SecretMapDataTemplates"));
         _theseusTreasureHokeCate = new TheseusTreasureHokeCate(getXmlListByName("TheseusTreasureHokeTemplates"));
         _theseusTreasureCoreCate = new TheseusTreasureCoreCate(getXmlListByName("TheseusTreasureCoreTemplates"));
         _theseusTreasureGrowupCate = new TheseusTreasureGrowupCate(getXmlListByName("TheseusTreasureGrowupTemplates"));
         _theseusSlateCate = new TheseusSlateCate(getXmlListByName("SlateTmpls"));
         _theseusSlateTaskCate = new TheseusSlateTaskCate(getXmlListByName("SlateTaskTmpls"));
         _theseusSlateUpgradeCate = new TheseusSlateUpgradeCate(getXmlListByName("SlateUpgradeTmpls"));
         _theseusDungeonCate = new TheseusDungeonCate(getXmlListByName("TheseusDungeonTemplates"));
         _theseusDungeonEventCate = new TheseusDungeonEventCate(getXmlListByName("TheseusDungeonEventTemplates"));
         _theseusDungeonTaskCate = new TheseusDungeonTaskCate(getXmlListByName("TheseusDungeonTaskTemplates"));
         _carnivalPointExchangeCate = new CarnivalPointExchangeTemplateCate(getXmlListByName("CarnivalPointExchangeTemplates"));
         _carnivalPlayGroundTemplateCate = new CarnivalPlayGroundTemplateCate(getXmlListByName("CarnivalPlayGroundTemplates"));
         _carnivalLuckDrawTemplateCate = new CarnivalLuckDrawTemplateCate(getXmlListByName("CarnivalLuckDrawTemplates"));
         _carnivalDailyChallengeTemplateCate = new CarnivalDailyChallengeTemplateCate(getXmlListByName("CarnivalDailyChallengeTemplates"));
         _newActiveLeedCate = new NewActiveLeedCate(getXmlListByName("ActivityDailyTemplates"));
         _newActiveLeedDailyCate = new NewActiveLeedDailyCate(getXmlListByName("ActivityDailyDrop"));
         _newActiveLeedWeekCate = new NewActiveLeedWeekCate(getXmlListByName("ActivityWeekDrop"));
         _warSoulTowerLevelTempCate = new WarSoulTowerLevelTempCate(getXmlListByName("WarSoulTowerLevelTemplates"));
         _warSoulTowerStageTempCate = new WarSoulTowerStageTempCate(getXmlListByName("WarSoulTowerStageRewardTemplates"));
         _warsoulCate = new WarSoulTempCate(getXmlListByName("WarSoulTmpls"));
         _warsoulStarCate = new WarSoulStarTempCate(getXmlListByName("WarSoulStarTmpls"));
         _warsoulStrengthenCate = new WarSoulStrengthenTempCate(getXmlListByName("WarSoulStrengthenTmpls"));
         _warsoulReformCate = new WarSoulReformTempCate(getXmlListByName("WarSoulReformTmpls"));
         _finalRoadGroupTempCate = new FinalRoadGroupTempCate(getXmlListByName("FinalRoadGroupTemplates"));
         _finalRoadEventTempCate = new FinalRoadEventTempCate(getXmlListByName("FinalRoadEventTemplates"));
         _finalRoadChapterTempCate = new FinalRoadChapterTempCate(getXmlListByName("FinalRoadChapterTemplates"));
         _theseusPvpTempCate = new TheseusPvpTempCate(getXmlListByName("TheseusPvpTmpls"));
         _theseusPvpIntegralCate = new TheseusPvpIntegralTempCate(getXmlListByName("TheseusPvpIntegralTmpls"));
         _theseusPvpTaskCate = new TheseusPvpTaskTempCate(getXmlListByName("TheseusPvpRewardTmpls"));
         _theseusMultiPvpTempCate = new TheseusMultiPvpTempCate(getXmlListByName("TheseusMultiPvpTmpls"));
         _theseusMultiPvpIntegralCate = new TheseusMultiPvpIntegralTempCate(getXmlListByName("TheseusMultiPvpIntegralTmpl"));
         _theseusMultiPvpTaskCate = new TheseusMultiPvpTaskTempCate(getXmlListByName("TheseusMultiPvpRewardTmpls"));
         _theseusPvpRewardCate = new SpeicalRewardTempCate(getXmlListByName("SpecialRewardTmpls"));
         _oldPlayerReturnTaskTempCate = new OldPlayerReturnTaskTempCate(getXmlListByName("AllianceActivityTasks"));
         _oldPlayerReturnRewardTempCate = new OldPlayerReturnRewardTempCate(getXmlListByName("AllianceRewardInfos"));
         _oldPlayerReturnShopTempCate = new OldPlayerReturnShopTempCate(getXmlListByName("AllianceShopInfos"));
         _oldPlayerReturnPrivilegeTempCate = new OldPlayerReturnPrivilegeTempCate(getXmlListByName("AlliancePrivileges"));
         _runeGemInfoCate = new RuneGemTempInfoCate(getXmlListByName("RuneGemInfos"));
         _runeHoleInfoCate = new RuneHoleTempInfoCate(getXmlListByName("RuneHoleInfos"));
         _runeFsgainInfoCate = new RuneFsgainTempInfoCate(getXmlListByName("RuneFsgainInfos"));
         _secretwarShopTempCate = new SecretwarShopTempCate(getXmlListByName("ExploitsShopTemplates"));
         _yearActiveDropCate = new YearActiveDropCate(getXmlListByName("YearEggDrop"));
         _minosLevelCate = new MinosLevelCate(getXmlListByName("MinosLevelTmpls"));
         _minosNodeCate = new MinosNodeCate(getXmlListByName("MinosNodeTmpls"));
         _minosRewardCate = new MinosRewardCate(getXmlListByName("MinosRewardTmpls"));
         _consortiaCommerceShopTempCate = new ConsortiaCommerceShopTempCate(getXmlListByName("CommerceShopTemplates"));
         _christmasLotteryTempCate = new ChristmasLotteryTempCate(getXmlListByName("ChristmasLotteryTemplates"));
         _christmasActivitiesTempCate = new ChristmasActivitiesTempCate(getXmlListByName("ChristmasActivitiesTemplates"));
         _christmasAnswersTempCate = new ChristmasAnswersTempCate(getXmlListByName("ChristmasAnswersTemplates"));
         _christmasAchievementsTempCate = new ChristmasAchievementsTempCate(getXmlListByName("ChristmasAchievementsTemplates"));
         _chesspvpRankDropCate = new ChessPvpRankDropCate(getXmlListByName("ChessPvpRankDrop"));
         _chesspvpFightDropCate = new ChessPvpFightDropCate(getXmlListByName("ChessPvpFightDrop"));
         _childNswarCate = new ChildNswarTempCate(getXmlListByName("ChildPvpTmpls"));
         _childNswarTaskCate = new ChildNswarTaskTempCate(getXmlListByName("ChildPvpRewardTmpls"));
         _thessTowerCate = new ThessTowerTempCate(getXmlListByName("TheseusTowerTmpls"));
         _thessBoxCate = new ThessBoxTempCate(getXmlListByName("StoreHouseChapterTmpls"));
         _thessBoxMapCate = new ThessBoxMapCate(getXmlListByName("StoreHouseMapTmpls"));
      }
      
      private function createTemplateResolveQueue() : void
      {
         var _loc1_:Number = getTimer();
         queue = new TemplateResolveQueue(_callBack);
         queue.addResolve(new ConfigInfosTemplateInfoResolve(getXmlListByName("ConfigInfos"),ConfigInfosBack));
         queue.addResolve(new TaskCondictionTemplateResolve(getXmlListByName("QuestCondictionInfos"),TaskCondictionTemplateBack));
         queue.addResolve(new TaskGoodsTemplateResolve(getXmlListByName("QuestGoods"),TaskGoodsTemplateBack));
         queue.addResolve(new TaskTemplateResolve(getXmlListByName("QuestTemps"),TaskTemplateBack));
         queue.addResolve(new OfferRewardConditionTemplateResolve(getXmlListByName("RewardCondictionInfos"),OfferRewardConditionTemplateBack));
         queue.addResolve(new OfferRewardGoodsTemplateResolve(getXmlListByName("RewardGoods"),OfferRewardGoodsTemplateBack));
         queue.addResolve(new OfferRewardTemplateResolve(getXmlListByName("RewardTemps"),OfferRewardTemplateBack));
         queue.addResolve(new SkillTempInfoResolve(getXmlListByName("SkillTempInfos"),SkillTempInfoResolveBack));
         queue.addResolve(new RuneTempInfoResolve(getXmlListByName("RuneTempInfos"),RuneTempInfoResolveBack));
         queue.addResolve(new MountTemplateResolve(getXmlListByName("MountTempInfos"),MountTemplateResolveBack));
         queue.addResolve(new CampaignTemplateResolve(getXmlListByName("Campaigns"),campaignTemplateBack));
         queue.addResolve(new ShopGoodsInfoResolve(getXmlListByName("ShopTempInfos"),ShopGoodsInfoBack));
         queue.addResolve(new ComposeTemInfoResolve(getXmlListByName("ComposeTempInfos"),ComposeTemInfoResolveBack));
         queue.addResolve(new UpgradeTemplateResolve(getXmlListByName("UpGradeTempInfos"),UpgradeTemplateResolveBack));
         queue.addResolve(new ActionTemplateInfoResolveII(getXmlListByName("ActionInfos"),ActionTemplateInfoResolveIIBack));
         queue.addResolve(new ConsortiaTempInfoResolve(getXmlListByName("ConsortiaLevelInfos"),ConsortiaTempInfoResolveBack));
         queue.addResolve(new SpaceTemplateResolve(getXmlListByName("MapNodeInfos"),spaceTemplateBack));
         queue.addResolve(new OuterCityShopTemplateResolve(getXmlListByName("MapShopItemTemplateInfos"),OuterCityShopTemplateBack));
         queue.addResolve(new PetComposeTemInfoResolve(getXmlListByName("PetComponseInfos"),PetComposeTemInfoResolveBack));
         queue.start();
      }
      
      public function initTemplate() : void
      {
         for each(var _loc1_:TaskTemplate in _taskTemplateDic)
         {
            _loc1_.initTask();
         }
         for each(var _loc3_:OfferRewardTemplate in _offerRewardTemplateDic)
         {
            _loc3_.addData();
         }
         for each(var _loc2_:ActionTemplateData in _actionTemplate2)
         {
            _loc2_.refreshMembers();
         }
      }
      
      public function get progress() : int
      {
         return queue ? queue.progress : 0;
      }
      
      public function getConfigInfoByConfigName(param1:String) : ConfigInfosTempInfo
      {
         return _configInfoTemplateDic[param1];
      }
      
      public function get taskCondictionInfoList() : Array
      {
         return _taskCondictionInfoList;
      }
      
      public function get taskGoodTemplateList() : Array
      {
         return _taskGoodTemplateList;
      }
      
      public function get taskTemplateDic() : Dictionary
      {
         return _taskTemplateDic;
      }
      
      public function get offerRewardConditionTemplateList() : Array
      {
         return _offerRewardConditionTemplateList;
      }
      
      public function get offerRewardGoodsTemplateList() : Array
      {
         return _offerRewardGoodsTemplateList;
      }
      
      public function get offerRewardTemplateDic() : Dictionary
      {
         return _offerRewardTemplateDic;
      }
      
      public function get mountTemplateDic() : Dictionary
      {
         return _mountTemplateDic;
      }
      
      public function get pvpWarFightDic() : Dictionary
      {
         return _pvpWarFightDic;
      }
      
      public function get campaignTemplateDic() : Dictionary
      {
         return _campaignTemplateDic;
      }
      
      public function get worldBossTemplateDict() : Dictionary
      {
         return _worldBossDic;
      }
      
      public function getTimeVortexTemplateById(param1:int) : CampaignTemplate
      {
         return _timeVortexDic[param1];
      }
      
      public function getCampaignTemplateById(param1:int) : CampaignTemplate
      {
         var _loc2_:Array = [];
         for each(var _loc3_:CampaignTemplate in _campaignTemplateDic)
         {
            if(_loc3_.CampaignId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getShopTempInfoList() : Dictionary
      {
         return _shopTemplateDic;
      }
      
      public function getConsortiaShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _consortiaShopTemplateDic[param1];
      }
      
      public function getConsortiaShopTempInfoList() : Dictionary
      {
         return _consortiaShopTemplateDic;
      }
      
      public function getAdvConsortiaShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _advConsortiaShopTemplateDic[param1];
      }
      
      public function getAdvConsortiaShopTempInfoList() : Dictionary
      {
         return _advConsortiaShopTemplateDic;
      }
      
      public function getTreasureConsortiaShopTempInfoList() : Dictionary
      {
         return _treasureConsortiaShopTemplateDic;
      }
      
      public function getCopyConsortiaShopTempInfoList() : Dictionary
      {
         return _copyConsortiaShopTemplateDic;
      }
      
      public function getSvsShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _svsShopTemplateDic[param1];
      }
      
      public function getSvsShopTempInfoList() : Dictionary
      {
         return _svsShopTemplateDic;
      }
      
      public function getMineralShopTempInfoList() : Dictionary
      {
         return _mineralShopTemplateDic;
      }
      
      public function getFashionExchangeShopTempInfoList() : Dictionary
      {
         return _fashionExchangeShopTemplateDic;
      }
      
      public function getMountExchangeShopTemplateDic() : Dictionary
      {
         return _mountExchangeShopTemplateDic;
      }
      
      public function getAthleticsShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _athleticsShopTemplateDic[param1];
      }
      
      public function getAthleticsShopTempInfoList() : Dictionary
      {
         return _athleticsShopTemplateDic;
      }
      
      public function getScoreShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _scoreShopTemplateDic[param1];
      }
      
      public function getScoreShopTempInfoList() : Dictionary
      {
         return _scoreShopTemplateDic;
      }
      
      public function getPetBossShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _petBossShopTemplateDic[param1];
      }
      
      public function getPetBossShopTempInfoDic() : Dictionary
      {
         return _petBossShopTemplateDic;
      }
      
      public function getWarlordsShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _warlordsShopTemplateDic[param1];
      }
      
      public function getWarlordsShopTempInfoList() : Dictionary
      {
         return _warlordsShopTemplateDic;
      }
      
      public function getdungenexShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _dungenexShopTemplateDic[param1];
      }
      
      public function getdungenexShopTempInfoList() : Dictionary
      {
         return _dungenexShopTemplateDic;
      }
      
      public function getMultilordsShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _multilordsShopTemplateDic[param1];
      }
      
      public function getMultilordsShopTempInfoList() : Dictionary
      {
         return _multilordsShopTemplateDic;
      }
      
      public function getMatelordsShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _matelordsShopTemplateDic[param1];
      }
      
      public function getMatelordsShopTempInfoList() : Dictionary
      {
         return _matelordsShopTemplateDic;
      }
      
      public function getMountShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _mountShopTemplateDic[param1];
      }
      
      public function getGodsEveningShopTempInfoList() : Dictionary
      {
         return _godsEveningShopTemplateDic;
      }
      
      public function getUpgradePresentShopTemplateDic() : Dictionary
      {
         return _upgradePresentShopTemplateDic;
      }
      
      public function getMountShopTempInfoList() : Dictionary
      {
         return _mountShopTemplateDic;
      }
      
      public function getOutyardTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _outyardTemplateDic[param1];
      }
      
      public function getOutyardTempInfoList() : Dictionary
      {
         return _outyardTemplateDic;
      }
      
      public function getCrossGvgShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _crossGvgShopTemplateDic[param1];
      }
      
      public function getCrossGvgShopTempInfoList() : Dictionary
      {
         return _crossGvgShopTemplateDic;
      }
      
      public function getMazeShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _mazeShopTemplateDic[param1];
      }
      
      public function getMazeShopTempInfoList() : Dictionary
      {
         return _mazeShopTemplateDic;
      }
      
      public function getFarmShopTemplateDic() : Dictionary
      {
         return _farmShopTemplateDic;
      }
      
      public function getBloodShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _bloodShopTemplateDic[param1];
      }
      
      public function getBloodShopTempInfoList() : Dictionary
      {
         return _bloodShopTemplateDic;
      }
      
      public function getMysteryShopTemplateDic() : Dictionary
      {
         return _mysteryShopTemplateDic;
      }
      
      public function getMysteryExchangeShopTemplateDic() : Dictionary
      {
         return _mysteryExchangeShopTemplateDic;
      }
      
      public function getPumpingJoyShopTempInfoList() : Dictionary
      {
         return _pumpingJoyShopTemplateDic;
      }
      
      public function getShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         for each(var _loc2_:ShopGoodsInfo in _shopTemplateDic)
         {
            if(_loc2_.ItemId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getShopInfoByItemIdAndArea(param1:int, param2:int) : ShopGoodsInfo
      {
         for each(var _loc3_:ShopGoodsInfo in _shopTemplateDic)
         {
            if(_loc3_.ItemId == param1 && _loc3_.Area == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getShopMainTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         for each(var _loc2_:ShopGoodsInfo in _shopMainTemplateDic)
         {
            if(_loc2_.ItemId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getShopMainInfoByItemId(param1:int) : ShopGoodsInfo
      {
         for each(var _loc2_:ShopGoodsInfo in _shopMainTemplateDic)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMysteryInfoByItemId(param1:int) : ShopGoodsInfo
      {
         for each(var _loc2_:ShopGoodsInfo in _mysteryShopTemplateDic)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getSkillTemplateInfoById(param1:int) : SkillTempInfo
      {
         return _skillTemplateDic[param1];
      }
      
      public function getMinSkillTemplateInfoByJob(param1:int) : SimpleDictionary
      {
         var _loc3_:int = 0;
         var _loc6_:SimpleDictionary = new SimpleDictionary(true);
         if(thane.isChangeJob)
         {
            if(param1 < 10)
            {
               _loc3_ = 420 + param1;
               for each(var _loc4_:SkillTempInfo in _skillTemplateDic)
               {
                  if(_loc4_.MasterType == _loc3_ && _loc4_.Grades == 1)
                  {
                     _loc6_.add(_loc4_.TemplateId,_loc4_);
                  }
               }
            }
            else
            {
               for each(var _loc5_:SkillTempInfo in _skillTemplateDic)
               {
                  if((_loc5_.MasterType == param1 * 10 + 1 || _loc5_.MasterType == param1 * 10 + 2 || _loc5_.MasterType == param1 * 10 + 3) && _loc5_.Grades == 1)
                  {
                     _loc6_.add(_loc5_.TemplateId,_loc5_);
                  }
               }
            }
         }
         else
         {
            for each(var _loc2_:SkillTempInfo in _skillTemplateDic)
            {
               if(_loc2_.MasterType == param1 && _loc2_.Grades == 1)
               {
                  _loc6_.add(_loc2_.Index,_loc2_);
               }
            }
         }
         return _loc6_;
      }
      
      public function getMinTalentTemplateInfoByJob(param1:int) : SimpleDictionary
      {
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc2_.MasterType == param1 && _loc2_.Grades == 1)
            {
               _loc3_.add(_loc2_.Index,_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getMinAdvTalentTemplateInfoByJob(param1:int) : SimpleDictionary
      {
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc2_.MasterType == param1 && _loc2_.Grades == 1)
            {
               _loc3_.add(_loc2_.Index,_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getMinSkillTemplateInfoBySonType(param1:int) : SkillTempInfo
      {
         for each(var _loc2_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc2_.SonType == param1 && _loc2_.Grades == 1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getSkillTemplateInfoBySonTypeAndGrade(param1:int, param2:int) : SkillTempInfo
      {
         for each(var _loc3_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc3_.SonType == param1 && _loc3_.Grades == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getSkillTemplateInfoByJobAndIdx(param1:int, param2:int) : SkillTempInfo
      {
         for each(var _loc3_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc3_.MasterType == param1 && _loc3_.Index == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getSkillTempByJobAndIdxAndGrade(param1:int, param2:int, param3:int) : SkillTempInfo
      {
         for each(var _loc4_:SkillTempInfo in TempleteManager.instance.skillTemplateDic)
         {
            if(_loc4_.Index == param2 && _loc4_.MasterType == param1 && _loc4_.Grades == param3)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getAllSkillTemplateInfoByJob(param1:int, param2:int = -1) : SimpleDictionary
      {
         var _loc8_:int = 0;
         var _loc4_:int = param1 + 30;
         if(param2 != -1)
         {
            _loc4_ = param2;
         }
         var _loc7_:SimpleDictionary = new SimpleDictionary(true);
         if(thane.isChangeJob)
         {
            if(param1 < 10)
            {
               _loc8_ = 420 + param1;
               for each(var _loc5_:SkillTempInfo in _skillTemplateDic)
               {
                  if(_loc5_.MasterType == _loc8_ || _loc5_.MasterType == 70)
                  {
                     _loc7_.add(_loc5_.TemplateId,_loc5_);
                  }
               }
            }
            else
            {
               for each(var _loc6_:SkillTempInfo in _skillTemplateDic)
               {
                  if(_loc6_.MasterType == param1 * 10 + 1 || _loc6_.MasterType == param1 * 10 + 2 || _loc6_.MasterType == param1 * 10 + 3 || _loc6_.MasterType == 70)
                  {
                     _loc7_.add(_loc6_.TemplateId,_loc6_);
                  }
               }
            }
         }
         else
         {
            for each(var _loc3_:SkillTempInfo in _skillTemplateDic)
            {
               if(_loc3_.MasterType == param1 || _loc3_.MasterType == _loc4_)
               {
                  _loc7_.add(_loc3_.TemplateId,_loc3_);
               }
            }
         }
         return _loc7_;
      }
      
      public function getSkillById(param1:int) : SkillTempInfo
      {
         var _loc3_:SkillTempInfo = null;
         for each(var _loc2_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc2_.TemplateId == param1)
            {
               _loc3_ = _loc2_;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getSkillsBySonType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc3_.SonType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getSkillsByMasterType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc3_.MasterType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function getMasterTypeByJob(param1:int) : int
      {
         return _childTemplateCate.getTemplateByJobAndGrades(param1,1).SkillMasterType;
      }
      
      public function getAllChildSkillByJobAndUseWay(param1:int, param2:int) : Vector.<SkillTempInfo>
      {
         var _loc4_:Vector.<SkillTempInfo> = new Vector.<SkillTempInfo>();
         for each(var _loc3_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc3_.MasterType == getMasterTypeByJob(param1) || _loc3_.MasterType == 44)
            {
               if(_loc3_.UseWay == param2 && _loc3_.Grades == 1)
               {
                  _loc4_.push(_loc3_);
               }
            }
         }
         return _loc4_;
      }
      
      public function getRemotePetSkill() : Vector.<SkillTempInfo>
      {
         var _loc2_:Vector.<SkillTempInfo> = new Vector.<SkillTempInfo>();
         for each(var _loc1_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc1_.MasterType == 200)
            {
               if(_loc1_.Grades == 1)
               {
                  _loc2_.push(_loc1_);
               }
            }
         }
         _loc2_.sort(sortRemotePetSkill);
         return _loc2_;
      }
      
      public function getChildPveSkillById(param1:Array) : Vector.<SkillTempInfo>
      {
         var _loc3_:Vector.<SkillTempInfo> = new Vector.<SkillTempInfo>();
         for each(var _loc2_:SkillTempInfo in _skillTemplateDic)
         {
            if(param1.indexOf(_loc2_.TemplateId) > -1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sort(sortRemotePetSkill);
         return _loc3_;
      }
      
      private function sortRemotePetSkill(param1:SkillTempInfo, param2:SkillTempInfo) : int
      {
         if(param1.TemplateId < param2.TemplateId)
         {
            return -1;
         }
         if(param1.TemplateId > param2.TemplateId)
         {
            return 1;
         }
         return 0;
      }
      
      public function getAllRemotePetSkill() : Vector.<SkillTempInfo>
      {
         var _loc2_:Vector.<SkillTempInfo> = new Vector.<SkillTempInfo>();
         for each(var _loc1_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc1_.MasterType == 200)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function getSkillTemplateInfoByIds(param1:String) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         if(!param1)
         {
            return _loc2_;
         }
         var _loc4_:Array = param1.split(",");
         if(_loc4_.length == 0)
         {
            return null;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_[_loc3_] = _skillTemplateDic[_loc4_[_loc3_]];
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getAllSkillsByMasterType(param1:int) : SimpleDictionary
      {
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc2_.MasterType == param1)
            {
               _loc3_.add(_loc2_.TemplateId,_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getChildSkillsByMasterTypeAndGrades(param1:int, param2:int) : Array
      {
         var _loc4_:Array = [];
         for each(var _loc3_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc3_.MasterType == param1 && _loc3_.Grades == param2)
            {
               _loc4_.push(_loc3_);
            }
         }
         _loc4_.sortOn("SonType",16);
         return _loc4_;
      }
      
      public function getChildSkillsByMasterTypeAndSonType(param1:int, param2:int) : Array
      {
         var _loc4_:Array = [];
         for each(var _loc3_:SkillTempInfo in _skillTemplateDic)
         {
            if(_loc3_.MasterType == param1 && _loc3_.SonType == param2)
            {
               _loc4_.push(_loc3_);
            }
         }
         _loc4_.sortOn("Grades",16);
         return _loc4_;
      }
      
      public function getRuneTemplateByTid(param1:int) : RuneTemplateInfo
      {
         return _runeTemplateDic[param1];
      }
      
      public function getMinRuneTemplateInfoByJob(param1:int, param2:int = 0) : SimpleDictionary
      {
         var _loc4_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc3_:RuneTemplateInfo in _runeTemplateDic)
         {
            if((_loc3_.Job.indexOf("0") >= 0 || _loc3_.Job.indexOf(param1.toString()) >= 0) && _loc3_.RuneGrade == 1 && _loc3_.Level == param2)
            {
               _loc4_.add(_loc3_.RuneIndex,_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getRuneTemplateByTypeAndLevel(param1:int, param2:int) : Array
      {
         var _loc5_:String = "RuneTemplateInfo_" + param1 + "_" + param2;
         var _loc3_:Array = tempData[_loc5_];
         if(!_loc3_)
         {
            _loc3_ = [];
            for each(var _loc4_:RuneTemplateInfo in _runeTemplateDic)
            {
               if(_loc4_.RuneType == param1 && _loc4_.Level == param2)
               {
                  _loc3_.push(_loc4_);
               }
            }
            _loc3_.sortOn("RuneGrade",16);
            tempData[_loc5_] = _loc3_;
         }
         return _loc3_;
      }
      
      public function getGradeRuneTemplateByTypeAndLevel(param1:int, param2:int, param3:int) : RuneTemplateInfo
      {
         var _loc4_:Array = getRuneTemplateByTypeAndLevel(param1,param2);
         for each(var _loc5_:RuneTemplateInfo in _loc4_)
         {
            if(_loc5_.RuneGrade == param3)
            {
               return _loc5_;
            }
         }
         return null;
      }
      
      public function getMinRuneTemplateInfoByRuneType(param1:int, param2:int = 0) : RuneTemplateInfo
      {
         var _loc3_:Array = getRuneTemplateByTypeAndLevel(param1,param2);
         return _loc3_[0];
      }
      
      public function getMaxRuneTemplateInfoByRuneType(param1:int, param2:int = 0) : RuneTemplateInfo
      {
         var _loc3_:Array = getRuneTemplateByTypeAndLevel(param1,param2);
         var _loc4_:int = int(_loc3_.length);
         if(_loc4_ > 0)
         {
            return _loc3_[_loc4_ - 1];
         }
         return null;
      }
      
      public function getAllRuneTemplateInfoByJob(param1:int) : SimpleDictionary
      {
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:RuneTemplateInfo in _runeTemplateDic)
         {
            if(int(_loc2_.Job) == 0 || _loc2_.Job.indexOf(param1.toString()) >= 0)
            {
               _loc3_.add(_loc2_.TemplateId,_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getComposeTempleteById(param1:int) : ComposeGoodsTemplete
      {
         return _composeTemplateDic[param1] as ComposeGoodsTemplete;
      }
      
      public function getComposeTempleteList() : Dictionary
      {
         return _composeTemplateDic;
      }
      
      public function getComposeTempleteByTempleteId(param1:int) : ComposeGoodsTemplete
      {
         for each(var _loc2_:ComposeGoodsTemplete in _composeTemplateDic)
         {
            if(_loc2_.NewMaterial == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getEquipUpdateComposeTempleteByMainMaterialId(param1:int) : ComposeGoodsTemplete
      {
         for each(var _loc2_:ComposeGoodsTemplete in _composeTemplateDic)
         {
            if(_loc2_.Material1 == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPetComposeTempleteById(param1:int) : PetComposeGoodsTemplete
      {
         return _petComposeTemplateDic[param1] as PetComposeGoodsTemplete;
      }
      
      public function getPetComposeTempleteList() : Dictionary
      {
         return _petComposeTemplateDic;
      }
      
      public function getTemplateByLevelAndType(param1:int, param2:int) : UpgradeTemplateInfo
      {
         var _loc3_:Array = getTemplatesByType(param2);
         for each(var _loc4_:UpgradeTemplateInfo in _loc3_)
         {
            if(_loc4_.Grades == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getTemplateByTypeAndLevelAndID(param1:int, param2:int, param3:int) : UpgradeTemplateInfo
      {
         for each(var _loc4_:UpgradeTemplateInfo in _upgradeTemplateDic)
         {
            if(_loc4_.Grades == param1 && _loc4_.Types == param2 && _loc4_.TemplateId == param3)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getTemplatesByType(param1:int) : Array
      {
         return _upgradeMapDic[param1] ? _upgradeMapDic[param1] : [];
      }
      
      public function getGradeByAdd(param1:int, param2:int) : Array
      {
         var _loc8_:int = 0;
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc10_:Array = getTemplatesByType(param1);
         var _loc5_:int;
         var _loc6_:int = _loc5_ = int(_loc10_.length);
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc3_ = _loc10_[_loc8_];
            if(param2 < _loc3_.Data)
            {
               _loc6_ = _loc3_.Grades - 1;
               _loc9_ = param2;
               _loc4_ = _loc3_.Data;
               break;
            }
            param2 -= _loc3_.Data;
            _loc8_++;
         }
         if(_loc6_ == _loc5_)
         {
            _loc7_ = 1;
         }
         return [_loc7_,_loc6_,_loc9_,_loc4_];
      }
      
      public function getUpgradeGradeBy(param1:int, param2:int) : int
      {
         var _loc6_:int = 0;
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc7_:Array = getTemplatesByType(param1);
         var _loc4_:int;
         var _loc5_:int = _loc4_ = int(_loc7_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc3_ = _loc7_[_loc6_];
            if(param2 < _loc3_.Data)
            {
               _loc5_ = _loc3_.Grades - 1;
               break;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function getNewUpgradeGradeBy(param1:int, param2:int) : Array
      {
         var _loc8_:int = 0;
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc10_:Array = getTemplatesByType(param1);
         var _loc5_:int;
         var _loc6_:int = _loc5_ = int(_loc10_.length);
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc3_ = _loc10_[_loc8_];
            if(param2 < _loc3_.Data)
            {
               _loc6_ = _loc3_.Grades;
               _loc9_ = param2;
               _loc4_ = _loc3_.Data;
               break;
            }
            param2 -= _loc3_.Data;
            _loc8_++;
         }
         if(_loc6_ == _loc5_)
         {
            _loc7_ = 1;
         }
         return [_loc7_,_loc6_,_loc9_,_loc4_];
      }
      
      public function getUpgradeTotalInfo(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc11_:int = 0;
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc9_:Array = getStageUpgradeAry(param1,param3,param4);
         var _loc7_:int = int(_loc9_.length);
         var _loc8_:int = param4;
         var _loc12_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         _loc11_ = 0;
         while(_loc11_ < _loc7_)
         {
            _loc5_ = _loc9_[_loc11_];
            if(param2 < _loc5_.Data)
            {
               _loc8_ = _loc5_.Grades;
               _loc12_ = param2;
               _loc6_ = _loc5_.Data;
               break;
            }
            param2 -= _loc5_.Data;
            _loc11_++;
         }
         if(_loc8_ == param4)
         {
            _loc10_ = 1;
         }
         return [_loc10_,_loc8_,_loc12_,_loc6_];
      }
      
      public function getStageUpgradeAry(param1:int, param2:int, param3:int) : Array
      {
         var _loc6_:int = 0;
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc7_:Array = getTemplatesByType(param1);
         var _loc4_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc7_.length)
         {
            _loc5_ = _loc7_[_loc6_];
            if(_loc5_.Grades >= param2 && _loc5_.Grades <= param3)
            {
               _loc4_.push(_loc5_);
            }
            _loc6_++;
         }
         _loc4_.sortOn("Grades",16);
         return _loc4_;
      }
      
      public function getUpgradeTempMaxGradeByType(param1:int) : int
      {
         var _loc2_:Array = getTemplatesByType(param1);
         _loc2_.sortOn("Grades",16);
         return _loc2_[_loc2_.length - 1].Grades;
      }
      
      public function getAllSpaceTemplateDic() : Dictionary
      {
         return _allSpaceDic;
      }
      
      public function getConsortiaTempleteById(param1:int) : ConsortiaTemplete
      {
         return _consortialevelTemplate[param1];
      }
      
      public function getConsortiaTempleteByTypeAndLevel(param1:int, param2:int) : ConsortiaTemplete
      {
         return _consortialevelTemplate[param1 + "_" + param2];
      }
      
      private function ConsortiaTempInfoResolveBack(param1:Dictionary) : void
      {
         _consortialevelTemplate = param1;
      }
      
      public function get actionTemplate2() : Dictionary
      {
         return _actionTemplate2;
      }
      
      private function ActionTemplateInfoResolveIIBack(param1:Dictionary) : void
      {
         _actionTemplate2 = param1;
      }
      
      private function UpgradeTemplateResolveBack(param1:Dictionary) : void
      {
         _upgradeTemplateDic = param1;
         _upgradeMapDic = new Dictionary();
         for each(var _loc2_:UpgradeTemplateInfo in _upgradeTemplateDic)
         {
            if(_upgradeMapDic[_loc2_.Types] == null)
            {
               _upgradeMapDic[_loc2_.Types] = [];
            }
            _upgradeMapDic[_loc2_.Types].push(_loc2_);
         }
         for each(var _loc3_:Array in _upgradeMapDic)
         {
            _loc3_.sortOn("Grades",16);
         }
      }
      
      private function ComposeTemInfoResolveBack(param1:Dictionary) : void
      {
         _composeTemplateDic = param1;
      }
      
      private function PetComposeTemInfoResolveBack(param1:Dictionary) : void
      {
         _petComposeTemplateDic = param1;
      }
      
      private function ConfigInfosBack(param1:Dictionary) : void
      {
         _configInfoTemplateDic = param1;
      }
      
      private function TaskCondictionTemplateBack(param1:Array) : void
      {
         _taskCondictionInfoList = param1;
      }
      
      private function TaskGoodsTemplateBack(param1:Array) : void
      {
         _taskGoodTemplateList = param1;
      }
      
      private function TaskTemplateBack(param1:Dictionary) : void
      {
         _taskTemplateDic = param1;
      }
      
      private function OfferRewardConditionTemplateBack(param1:Array) : void
      {
         _offerRewardConditionTemplateList = param1;
      }
      
      private function OfferRewardGoodsTemplateBack(param1:Array) : void
      {
         _offerRewardGoodsTemplateList = param1;
      }
      
      private function OfferRewardTemplateBack(param1:Dictionary) : void
      {
         _offerRewardTemplateDic = param1;
      }
      
      private function MountTemplateResolveBack(param1:Dictionary) : void
      {
         _mountTemplateDic = param1;
      }
      
      private function SkillTempInfoResolveBack(param1:Dictionary) : void
      {
         _skillTemplateDic = param1;
      }
      
      private function RuneTempInfoResolveBack(param1:Dictionary) : void
      {
         _runeTemplateDic = param1;
      }
      
      private function campaignTemplateBack(param1:Dictionary) : void
      {
         _allCampaignDic = param1;
         _timeVortexDic = new Dictionary();
         _campaignTemplateDic = new Dictionary();
         _pvpWarFightDic = new Dictionary();
         _worldBossDic = new Dictionary();
         _vehicleCampaignDic = new Dictionary();
         for each(var _loc2_:CampaignTemplate in _allCampaignDic)
         {
            if(_loc2_.Types == 0 || _loc2_.Types == 13 || _loc2_.Types == 51)
            {
               _campaignTemplateDic[_loc2_.CampaignId] = _loc2_;
            }
            else if(_loc2_.Types == 5 || _loc2_.Types == 50 || _loc2_.Types == 12)
            {
               _pvpWarFightDic[_loc2_.CampaignId] = _loc2_;
            }
            else if(_loc2_.Types == 9)
            {
               _vehicleCampaignDic[_loc2_.CampaignId] = _loc2_;
            }
            else if(_loc2_.Types == 26)
            {
               _timeVortexDic[_loc2_.CampaignId] = _loc2_;
            }
            else if(_loc2_.Types >= 1)
            {
               _worldBossDic[_loc2_.CampaignId] = _loc2_;
            }
         }
      }
      
      private function spaceTemplateBack(param1:Dictionary) : void
      {
         _allSpaceDic = param1;
      }
      
      private function ShopGoodsInfoBack(param1:Dictionary, param2:Dictionary, param3:Dictionary, param4:Dictionary, param5:Dictionary, param6:Dictionary, param7:Dictionary, param8:Dictionary, param9:Dictionary, param10:Dictionary, param11:Dictionary, param12:Dictionary, param13:Dictionary, param14:Dictionary, param15:Dictionary, param16:Dictionary, param17:Dictionary, param18:Dictionary, param19:Dictionary, param20:Dictionary, param21:Dictionary, param22:Dictionary, param23:Dictionary, param24:Dictionary, param25:Dictionary, param26:Dictionary, param27:Dictionary, param28:Dictionary, param29:Dictionary, param30:Dictionary, param31:Dictionary, param32:Dictionary, param33:Dictionary, param34:Dictionary, param35:Dictionary, param36:Dictionary, param37:Dictionary, param38:Dictionary, param39:Dictionary, param40:Dictionary, param41:Dictionary, param42:Dictionary, param43:Dictionary, param44:Dictionary, param45:Dictionary, param46:Dictionary, param47:Dictionary, param48:Dictionary, param49:Dictionary, param50:Dictionary) : void
      {
         _shopTemplateDic = param1;
         _consortiaShopTemplateDic = param2;
         _athleticsShopTemplateDic = param3;
         _bloodShopTemplateDic = param4;
         _mazeShopTemplateDic = param5;
         _mysteryShopTemplateDic = param6;
         _farmShopTemplateDic = param7;
         _shopMainTemplateDic = param8;
         _mysteryExchangeShopTemplateDic = param9;
         _warlordsShopTemplateDic = param10;
         _petExchangeShopTemplateDic = param11;
         _mineralShopTemplateDic = param12;
         _fashionExchangeShopTemplateDic = param13;
         _crossGvgShopTemplateDic = param14;
         _scoreShopTemplateDic = param15;
         _petBossShopTemplateDic = param16;
         _multilordsShopTemplateDic = param17;
         _advConsortiaShopTemplateDic = param18;
         _svsShopTemplateDic = param19;
         _mountExchangeShopTemplateDic = param20;
         _matelordsShopTemplateDic = param21;
         _mountShopTemplateDic = param22;
         _outyardTemplateDic = param23;
         _gloryShopDic = param24;
         _treasureConsortiaShopTemplateDic = param25;
         _isExploreShopTemplateDic = param26;
         _assaultwarShopTemplateDic = param27;
         _pumpingJoyShopTemplateDic = param28;
         _godsEveningShopTemplateDic = param29;
         _upgradePresentShopTemplateDic = param30;
         _copyConsortiaShopTemplateDic = param31;
         _apexShopTemplateDic = param32;
         _crossGuildShopTemplateDic = param33;
         _antaeusShopTemplateDic = param34;
         _airGardenPropTemplateDic = param35;
         _sevenYearShopTemplateDic = param36;
         _flameTempleShopDic = param37;
         _duskAreaShopDic = param38;
         _demonRoadShopDic = param39;
         _darkmazeShopDic = param40;
         _consortiaNewBossShopDic = param41;
         _theseuspvpShopDic = param42;
         _yearactiveShop1Dic = param43;
         _yearactiveShop2Dic = param44;
         _minosShopDic = param45;
         _chesspvpShopDic = param46;
         _childNswarShopDic = param47;
         _vipShopDic = param48;
         _thessboxShopDic = param49;
         _dungenexShopTemplateDic = param50;
      }
      
      private function OuterCityShopTemplateBack(param1:Dictionary, param2:Dictionary, param3:Dictionary) : void
      {
         _outerCityShopExchangeTemplateDic = param1;
         _outerCityShopRandomTemplateDic = param2;
         _planesTemplateDic = param3;
      }
      
      public function get outerCityShopExchangeTemplateDic() : Dictionary
      {
         return _outerCityShopExchangeTemplateDic;
      }
      
      public function get outerCityShopRandomTemplateDic() : Dictionary
      {
         return _outerCityShopRandomTemplateDic;
      }
      
      public function get planesTemplateDic() : Dictionary
      {
         return _planesTemplateDic;
      }
      
      public function getVIPShopTemplateDic() : Dictionary
      {
         return _vipShopDic;
      }
      
      public function getthessShopTemplateDic() : Dictionary
      {
         return _thessboxShopDic;
      }
      
      public function getouterCityShopRandomByMapShopId(param1:int) : OuterCityShopGoodsInfo
      {
         for each(var _loc2_:OuterCityShopGoodsInfo in _outerCityShopRandomTemplateDic)
         {
            if(_loc2_.MapShopId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPlanesGoodsByMapShopId(param1:int) : OuterCityShopGoodsInfo
      {
         for each(var _loc2_:OuterCityShopGoodsInfo in _planesTemplateDic)
         {
            if(_loc2_.MapShopId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get petExchangeShopTemplateDic() : Dictionary
      {
         return _petExchangeShopTemplateDic;
      }
      
      public function get skillTemplateDic() : Dictionary
      {
         return _skillTemplateDic;
      }
      
      public function get gameHeroTemplateCate() : GameHeroTemplateCate
      {
         return _gameHeroTemplateCate;
      }
      
      public function get pawnTemplateCate() : PawnTemplateCate
      {
         return _pawnTemplateCate;
      }
      
      public function get goodsTemplateCate() : GoodsTemplateCate
      {
         return _goodsTemplateCate;
      }
      
      public function get buildTemplateCate() : BuildTemplateCate
      {
         return _buildTemplateCate;
      }
      
      public function get kingContraceCate() : KingContraceCate
      {
         return _kingContraceCate;
      }
      
      public function get actonTemplateCate() : ActonTemplateCate
      {
         return _actonTemplateCate;
      }
      
      public function get collectionRewardTempCate() : CollectionRewardTempCate
      {
         return _collectionRewardTempCate;
      }
      
      public function get bufferTemplateCate() : BufferTemplateCate
      {
         return _bufferTemplateCate;
      }
      
      public function get talentTemplateCate() : TalentTemplateCate
      {
         return _talentTemplateCate;
      }
      
      public function get tollgateRewardCate() : TollgateRewardCate
      {
         return _tollgateRewardCate;
      }
      
      public function get effectTemplateCate() : EffectTemplateCate
      {
         return _effectTemplateCate;
      }
      
      public function get campaignBufferTemplate() : CampaignBufferTemplateCate
      {
         return _campaignBufferTemplateCate;
      }
      
      public function get mapTemplateCate() : MaptemplateCate
      {
         return _mapTemplateCate;
      }
      
      public function get heroAISTemplateCate() : HeroAISTemplateCate
      {
         return _heroAISTemplateCate;
      }
      
      public function get consortiaDropTemplateCate() : ConsortiaDropTemplateCate
      {
         return _consortiaDropTemplateCate;
      }
      
      public function get dayGuideDropTemplateCate() : DayGuideDropTemplateCate
      {
         return _dayGuideDropTemplateCate;
      }
      
      public function get mapPhysicsTempleteCate() : MapPhysicsTempleteCate
      {
         return _mapPhysicsTempleteCate;
      }
      
      public function get pawnSpecialTemplateCate() : PawnSpecialTemplateCate
      {
         return _pawnSpecialTemplateCate;
      }
      
      public function get vipDropTemplateCate() : VipDropTemplateCate
      {
         return _vipDropTemplateCate;
      }
      
      public function get vipPrerogativeTemplateCate() : VipPrerogativeTemplateCate
      {
         return _vipPrerogativeTemplateCate;
      }
      
      public function get skillPropertyTemplateCate() : SkillPropertyTemplateCate
      {
         return _skillPropertyTemplateCate;
      }
      
      public function get suitTemplateCate() : SuitTemplateCate
      {
         return _suitTemplateCate;
      }
      
      public function get transformBackTemplateCate() : TransformBackTemplateCate
      {
         return _transformBackTemplateCate;
      }
      
      public function get starTempalteCate() : StarTempalteCate
      {
         return _starTempalteCate;
      }
      
      public function get leedTemplateCate() : LeedTemplateCate
      {
         return _leedTemplateCate;
      }
      
      public function get leedDropTemplateCate() : LeedDropTemplateCate
      {
         return _leedDropTemplateCate;
      }
      
      public function get firstPayDropTempalteCate() : FirstPayDropTempalteCate
      {
         return _firstPayDropTempalteCate;
      }
      
      public function get assistantTemplates() : AssistantTemplates
      {
         return _assistantTemplates;
      }
      
      public function get collectionGetDrop() : CollectionGetDrop
      {
         return _collectionGetDrop;
      }
      
      public function get collectionOpenDrop() : CollectionOpenDrop
      {
         return _collectionOpenDrop;
      }
      
      public function get exchargeRankTemplateCate() : ExchargeRankTemplateCate
      {
         return _exchargeRankTemplateCate;
      }
      
      public function get catHouseTemplateCate() : CatHouseTemplateCate
      {
         return _catHouseTemplateCate;
      }
      
      public function get districtTemplateCate() : DistrictTemplateCate
      {
         return _districtTemplateCate;
      }
      
      public function get districtSSSTemplateCate() : DistrictSSSTemplateCate
      {
         return _districtSSSTemplateCate;
      }
      
      public function get countLoginDropTemplateCate() : CountLoginDropTemplateCate
      {
         return _countLoginDropTemplateCate;
      }
      
      public function get bag360DropTemplateCate() : Bag360DropTemplateCate
      {
         return _bag360DropTemplateCate;
      }
      
      public function get timeBoxTemplateCate() : TimeBoxTemplateCate
      {
         return _timeBoxTemplateCate;
      }
      
      public function get noviceboxTemplateCate() : NoviceboxTemplateCate
      {
         return _noviceboxTemplateCate;
      }
      
      public function get activeTemplateCate() : ActiveTemplateCate
      {
         return _activeTemplateCate;
      }
      
      public function get signDropTemplateCate() : SignDropTemplateCate
      {
         return _signDropTemplateCate;
      }
      
      public function get vehicleObjectTempInfoCate() : VehicleObjectTempInfoCate
      {
         return _vehicleNpcTempteCate;
      }
      
      public function get vehicleSkillTempteCate() : VehicleSkillTempInfoCate
      {
         return _vehicleSkillTempteCate;
      }
      
      public function get appellInfoTemplateCate() : AppellInfoTemplateCate
      {
         return _appellInfoTemplateCate;
      }
      
      public function get vehicleSkillBuffTemplateCate() : VehicleSkillBuffTemplateCate
      {
         return _vehicleSkillBuffTemplateCate;
      }
      
      public function get vehicleAdditionTemplateCate() : VehicleAdditionTemplateCate
      {
         return _vehicleAdditionTemplateCate;
      }
      
      public function get vehicleCampaignDic() : Dictionary
      {
         return _vehicleCampaignDic;
      }
      
      public function get petTemplateCate() : PetTemplateCate
      {
         return _petTemplateCate;
      }
      
      public function get petChallengeRewardCate() : PetChallengeRewardCate
      {
         return _petChallengeRewardCate;
      }
      
      public function get rapidThroughRewardCate() : RapidThroughRewardCate
      {
         return _rapidThroughRewardCate;
      }
      
      public function get fashionPolishTemplateCate() : FashionPolishTemplateCate
      {
         return _fashionPolishTemplateCate;
      }
      
      public function get godTreasureTemplateCate() : GodTreasureTemplateCate
      {
         return _godTreasureTemplateCate;
      }
      
      public function get simpleTaskTemplateCate() : SimpleTaskTemplateCate
      {
         return _simpleTaskTemplateCate;
      }
      
      public function get servenLeadRewardTemplateCate() : ServenLeadRewardTemplateCate
      {
         return _servenLeadRewardTemplateCate;
      }
      
      public function get godArriveTemplateCate() : GodArriveTemplateCate
      {
         return _godArriveTemplateCate;
      }
      
      public function get heartTemplateCate() : HeartTemplateCate
      {
         return _heartTemplateCate;
      }
      
      public function get getMarryQualityTemplateCate() : MarryQualityTemplateCate
      {
         return _marryQualityTemplateCate;
      }
      
      public function get singlePassAreaRewardTemplateCate() : SinglePassAreaRewardTemplateCate
      {
         return _singlePassAreaRewardTemplateCate;
      }
      
      public function get singlePassBossRewardTemplateCate() : SinglePassBossRewardTemplateCate
      {
         return _singlePassBossRewardTemplateCate;
      }
      
      public function get magicCardTemplateCate() : MagicCardTemplateCate
      {
         return _magicCardTemplateCate;
      }
      
      public function get fishTemplateCate() : FishTemplateCate
      {
         return _fishTemplateCate;
      }
      
      public function get randomBossTemplateCate() : RondamBossTemplateCate
      {
         return _rondamBossTemplateCate;
      }
      
      public function get outerCityShopCostTemplateCate() : OuterCityShopCostTemplateCate
      {
         return _outerCityShopCostTemplateCate;
      }
      
      public function get boxItemTemplateCate() : BoxItemTemplateCate
      {
         return _boxItemTemplateCate;
      }
      
      public function getConfigValue(param1:String) : int
      {
         var _loc3_:int = 10;
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName(param1);
         if(_loc2_)
         {
            _loc3_ = int(_loc2_.ConfigValue);
         }
         return _loc3_;
      }
      
      public function getDefaultMountTempByLevel(param1:int) : MountTemplate
      {
         var _loc2_:MountTemplate = null;
         for each(var _loc3_:MountTemplate in mountTemplateDic)
         {
            if(_loc3_.Property2 == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function get planesTemplateCate() : PlanesTemplateCate
      {
         return _planesTemplateCate;
      }
      
      public function get planesLayerTemplateCate() : PlanesLayerTemplateCate
      {
         return _planesLayerTemplateCate;
      }
      
      public function get planesEventsTemplateCate() : PlanesEventsTemplateCate
      {
         return _planesEventsTemplateCate;
      }
      
      public function get remotePetTemplateCate() : RemotePetTemplateCate
      {
         return _remotePetTemplateCate;
      }
      
      public function get childTemplateCate() : ChildTemplateCate
      {
         return _childTemplateCate;
      }
      
      public function get christmasTreeItemsTemplateCate() : ChristmasTreeItemsTemplateCate
      {
         return _christmasTreeItemsTemplateCate;
      }
      
      public function get childPveBossTemplateCate() : ChildPveBossTemplateCate
      {
         return _childPveBossTemplateCate;
      }
      
      public function get guardPveExploreTemplateCate() : GuardPveExploreTemplateCate
      {
         return _guardPveExploreTemplateCate;
      }
      
      public function get titanTemplateCate() : DragonTitanTemplateCate
      {
         return _titanTemplateCate;
      }
      
      public function get skytriallayerTemplateCate() : SkytriallayerTemplateCate
      {
         return _skytriallayerTemplateCate;
      }
      
      public function get skyTrialPortalTemplateCate() : SkyTrialPortalTemplateCate
      {
         return _skyTrialPortalTemplateCate;
      }
      
      public function get skytrialeventTemplateCate() : SkytrialeventTemplateCate
      {
         return _skytrialeventTemplateCate;
      }
      
      public function get consortiaBossTemplateCate() : ConsortiaBossTemplateCate
      {
         return _consortiaBossTemplateCate;
      }
      
      public function get gameBoxTemplateCate() : GameBoxShopTemplateCate
      {
         return _gameBoxShopTemplateCate;
      }
      
      public function get dichTemplateCate() : DitchTemplateCate
      {
         return _dichTemplateCate;
      }
      
      public function get archaeologyBookTemplateCate() : ArchaeologyBookTemplateCate
      {
         return _archaeologyBookTemplateCate;
      }
      
      public function get archaeologyItemTemplateCate() : ArchaeologyItemTemplateCate
      {
         return _archaeologyItemTemplateCate;
      }
      
      public function get furnitureTemplateCate() : FurnitureTemplateCate
      {
         return _furnitureTemplateCate;
      }
      
      public function get childPatrolMissionTemplateCate() : ChildPatrolMissionTemplateCate
      {
         return _childPatrolMissionTempCate;
      }
      
      public function get faceTemplateCate() : FaceBookTemplateCate
      {
         return _faceBookTempCate;
      }
      
      public function get regressTemplateCate() : RegressTemplateCate
      {
         return _regressTemplateCate;
      }
      
      public function get outyardTemplateCate() : OutyardTemplateCate
      {
         return _outyardTemplateCate;
      }
      
      public function get outyardAreaTemplateCate() : OutyardAreaTemplateCate
      {
         return _outyardAreaTemplateCate;
      }
      
      public function get outyardTitanTemplateCate() : OutyardTitanTemplateCate
      {
         return _outyardTitanTemplateCate;
      }
      
      public function get outyardShuttleTemplateCate() : OutyardShuttleTemplateCate
      {
         return _outyardShuttleTemplateCate;
      }
      
      public function get outyardShuttleRewardTemplateCate() : OutyardShuttleRewardTemplateCate
      {
         return _outyardShuttleRewardTemplateCate;
      }
      
      public function get magicPubNpcTemplateCate() : MagicPubNpcTemplateCate
      {
         return _magicPubNpcTemplateCate;
      }
      
      public function get magicPubChatTemplateCate() : MagicPubChatTemplateCate
      {
         return _magicPubChatTemplateCate;
      }
      
      public function get heroRoadTemplateCate() : HeroRoadTemplateCate
      {
         return _heroRoadTemplateCate;
      }
      
      public function get artifactTemplateCate() : ArtifactTemplateCate
      {
         return _artifactTemplateCate;
      }
      
      public function get areaMapDropTemplateCate() : AreaMapDropTemplateCate
      {
         return _areaMapDropTemplateCate;
      }
      
      public function get nagivationShopTemplateCate() : NavigationShopTemplateCate
      {
         return _navigationShopTemplateCate;
      }
      
      public function get navigationTaskTemplateCate() : NavigationTaskTemplateCate
      {
         return _navigationTaskTemplateCate;
      }
      
      public function get childTypeTemplateCate() : ChildTypeTemplateCate
      {
         return _childTypeTemplateCate;
      }
      
      public function get crossGuildNodeTemplateCate() : CrossGuildNodeTemplateCate
      {
         return _crossGuildNodeTemplateCate;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function getAreslordsShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _warlordsShopTemplateDic[param1];
      }
      
      public function getAreslordsShopTempInfoList() : Dictionary
      {
         return _warlordsShopTemplateDic;
      }
      
      public function getApexShopTempInfoList() : Dictionary
      {
         return _apexShopTemplateDic;
      }
      
      public function getAntaeusShopTemplateDicList() : Dictionary
      {
         return _antaeusShopTemplateDic;
      }
      
      public function getAirGardenPropTemplateDic() : Dictionary
      {
         return _airGardenPropTemplateDic;
      }
      
      public function getGloryShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _gloryShopDic[param1];
      }
      
      public function getGloryShopTempInfoList() : Dictionary
      {
         return _gloryShopDic;
      }
      
      public function getGloryRoadBufferTemplateCate() : GloryRoadBufferTemplateCate
      {
         return _gloryRoadBufferTemplateCate;
      }
      
      public function getGloryRoadDropTemplateCate() : GloryRoadDropTemplateCate
      {
         return _gloryRoadDropTemplateCate;
      }
      
      public function get furnitureShopTemplateCate() : FurnitureShopTemplateCate
      {
         return _furnitureShopTemplateCate;
      }
      
      public function get petHallowsTemplateCate() : PetHallowsTemplateCate
      {
         return _petHallowsTemplateCate;
      }
      
      public function get petContracTemplateCate() : PetContracTemplateCate
      {
         return _petContracTemplateCate;
      }
      
      public function get consortiaTreasureTemplateCate() : ConsortiaTreasureTemplateCate
      {
         return _consortiaTreasureTemplateCate;
      }
      
      public function get planesFuncTemplateCate() : PlanesFuncTemplateCate
      {
         return _planesFuncTemplateCate;
      }
      
      public function get childComposeTemplateCate() : ChildComposeTemplateCate
      {
         return _childComposeTemplateCate;
      }
      
      public function get topToolBtnTempCate() : TopToolBtnTempCate
      {
         return _topToolBtnTempCate;
      }
      
      public function get lordTrialTempCate() : LordTrialTempCate
      {
         return _lordTrialTempCate;
      }
      
      public function getIsExploreShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _isExploreShopTemplateDic[param1];
      }
      
      public function getIsExploreShopTempInfoList() : Dictionary
      {
         return _isExploreShopTemplateDic;
      }
      
      public function getAssaultwarShopTempInfoByItemId(param1:int) : ShopGoodsInfo
      {
         return _assaultwarShopTemplateDic[param1];
      }
      
      public function getAssaultwarShopTempInfoList() : Dictionary
      {
         return _assaultwarShopTemplateDic;
      }
      
      public function get childArenaRewardTempCate() : ChildArenaRewardTempCate
      {
         return _childArenaRewardTempCate;
      }
      
      public function get alchemicalMineTempCate() : AlchemicalMineTempCate
      {
         return _alchemicalMineTempCate;
      }
      
      public function get alchemicalFormulaTempCate() : AlchemicalFormulaTempCate
      {
         return _alchemicalFormulaTempCate;
      }
      
      public function get armoryTempCate() : ArmoryTempCate
      {
         return _armoryTempCate;
      }
      
      public function get skyBoxRoadRankRewardTempCate() : SkyBoxRoadRankRewardTempCate
      {
         return _skyBoxRoadRankRewardTempCate;
      }
      
      public function get skyBoxRoadTimeRewardTempCate() : SkyBoxRoadTimeRewardTempCate
      {
         return _skyBoxRoadTimeRewardTempCate;
      }
      
      public function get dragonTalkerFightMountTempcate() : DragonTalkerFightMountTempcate
      {
         return _dragonTalkerFightMountTempcate;
      }
      
      public function get planeCrisisTempCate() : PlaneCrisisTempCate
      {
         return _planeCrisisTempCate;
      }
      
      public function get planeCrisisEventTempCate() : PlaneCrisisEventTempCate
      {
         return _planeCrisisEventTempCate;
      }
      
      public function get planeCrisisGoodTempCate() : PlaneCrisisGoodTempCate
      {
         return _planeCrisisGoodTempCate;
      }
      
      public function get timeVortexDropTemplateCate() : TimeVortexDropTemplateCate
      {
         return _timeVortexDropTemplateCate;
      }
      
      public function get timeVortexDic() : Dictionary
      {
         return _timeVortexDic;
      }
      
      public function get unrealShootingRewardTempCate() : UnrealShootingRewardTempCate
      {
         return _unrealShootingRewardTempCate;
      }
      
      public function get starGazingDropTempCate() : StarGazingDropTempCate
      {
         return _starGazingDropTempCate;
      }
      
      public function get magicSpringTempCate() : MagicSpringFormulaTempCate
      {
         return _magicSpringTempCate;
      }
      
      public function get eclipticPalaceTempCate() : EclipticPalaceTempCate
      {
         return _eclipticPalaceTempCate;
      }
      
      public function get eclipticPalaceRewardCate() : EclipticPalaceRewardCate
      {
         return _eclipticPalaceRewardTempCate;
      }
      
      public function get upgradePresentBoxDropTempCate() : UpgradePresentBoxDropTempCate
      {
         return _upgradePresentBoxDropTempCate;
      }
      
      public function get demonLandDropTemplateCate() : DemonLandDropTemplateCate
      {
         return _demonLandDropTemplateCate;
      }
      
      public function get demonLandBoxDropTemplateCate() : DemonLandBoxDropTemplateCate
      {
         return _demonLandBoxDropTemplateCate;
      }
      
      public function get demonLandTemplateCate() : DemonLandTemplateCate
      {
         return _demonLandTemplateCate;
      }
      
      public function getSpaceTimeBoxConfigValue(param1:int) : String
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         if(param1 == 1)
         {
            _loc2_ = "SpaceTimeNomal";
         }
         else if(param1 == 2)
         {
            _loc2_ = "SpaceTimeNightmare";
         }
         var _loc3_:ConfigInfosTempInfo = getConfigInfoByConfigName(_loc2_);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.ConfigValue;
         }
         return _loc4_;
      }
      
      public function getSpaceTimeBoxCountConfigValue(param1:int) : String
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         if(param1 == 1)
         {
            _loc2_ = "SpaceTimeNormalRewards";
         }
         else if(param1 == 2)
         {
            _loc2_ = "SpaceTimeNightmareRewards";
         }
         var _loc3_:ConfigInfosTempInfo = getConfigInfoByConfigName(_loc2_);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.ConfigValue;
         }
         return _loc4_;
      }
      
      public function get goddessTempCate() : GoddessTemplateCate
      {
         return _goddessTempCate;
      }
      
      public function get goddessLevelTempCate() : GoddessLevelTempCate
      {
         return _goddessLevelTempCate;
      }
      
      public function get goddessAdvanceTempCate() : GoddessAdvanceTempCate
      {
         return _goddessAdvanceTempCate;
      }
      
      public function get goddessDedicationTempCate() : GoddessDediactionTempCate
      {
         return _goddessDedicationTempCate;
      }
      
      public function get goddessFormationTempCate() : GoddessFormationTempCate
      {
         return _goddessFormationTempCate;
      }
      
      public function get goddessFormationSkillTempCate() : GoddessFormationSkillTempCate
      {
         return _goddessFormationSkillTempCate;
      }
      
      public function get goddessEquipTempCate() : GoddessEquipTempCate
      {
         return _goddessEquipTempCate;
      }
      
      public function get guildFBTempCate() : GuildFBTemplateCate
      {
         return _guildFbTempcate;
      }
      
      public function get guildFBDropTempCate() : GuildFBDropTempCate
      {
         return _guildFbDropTempCate;
      }
      
      public function get guildFbPveRankDropTempte() : GuildFBPveRankDropTempCate
      {
         return _guildFbPveRankDropTempte;
      }
      
      public function get consortiaQuestTempCate() : ConsortiaQuestTempCate
      {
         return _consortiaQuestTempCate;
      }
      
      public function get consortiaQuestConditionTempCate() : ConsortiaQuestConditionTempCate
      {
         return _consortiaQuestConditionTempCate;
      }
      
      public function get consortiaBusinessTempCate() : ConsortiaBusinessTempCate
      {
         return _consortiaBusinessTempCate;
      }
      
      public function get gameHallTemplateCate() : GameHallTemplateCate
      {
         return _gameHallTemplateCate;
      }
      
      public function get resolveitemsortTemplateCate() : ResolveitemsortTemplateCate
      {
         return _resolveitemsortTemplateCate;
      }
      
      public function get gameHallEastTemplateCate() : GameHallEastTemplateCate
      {
         return _gameHallEastTemplateCate;
      }
      
      public function get gamehallEastShopTempCate() : GamehallEastShopTempCate
      {
         return _gamehallEastShopTempCate;
      }
      
      public function get crossGuildRewardTempCate() : CrossGuildRewardTempCate
      {
         return _crossGuildRewardTempCate;
      }
      
      public function get crossGuildSingleRewardTempCate() : CrossGuildSingleRewardTempCate
      {
         return _crossGuildSingleRewardTempCate;
      }
      
      public function get crossGuildContributionRewardTempCate() : CrossGuildContributionRewardTempCate
      {
         return _crossGuildContributionRewardTempCate;
      }
      
      public function getCrossGuildShopTempInfoList() : Dictionary
      {
         return _crossGuildShopTemplateDic;
      }
      
      public function get apexRankRewardDropTempCate() : ApexRewardDropTempCate
      {
         return _apexRankRewardDropTempCate;
      }
      
      public function get crossGuildWarQuestTempCate() : CrossGuildWarQuestTempCate
      {
         return _crossGuildWarQuestTempCate;
      }
      
      public function get monsterTempCate() : MonsterTemplateCate
      {
         return _monsterTempCate;
      }
      
      public function get monsterExploreTemplateCate() : MonsterExploreTemplateCate
      {
         return _monsterExploreTemplateCate;
      }
      
      public function get monsterRecipeTemplateCate() : MonsterRecipeTemplateCate
      {
         return _monsterRecipeTempCate;
      }
      
      public function get monsterCookDropTempCate() : MonsterCookDropTempCate
      {
         return _monsterCookDropTempCate;
      }
      
      public function get monsterExploreDropTempCate() : MonsterExploreDropTempCate
      {
         return _monsterExploreDropCate;
      }
      
      public function get dreamArenaRewardTempCate() : DreamArenaRewardTempCate
      {
         return _dreamArenaRewardTempCate;
      }
      
      public function get dreamArenaTempCate() : DreamArenaTempCate
      {
         return _dreamArenaTempCate;
      }
      
      public function get airGardenBedTempCate() : AirGardenBedTempCate
      {
         return _airGardenBedTempCate;
      }
      
      public function get avengerSkillTempCate() : AvengerSkillTempCate
      {
         return _avengerSkillTempCate;
      }
      
      public function get avengerBodyTempCate() : AvengerBodyTempCate
      {
         return _avengerBodyTempCate;
      }
      
      public function get revengeRoadTempCate() : RevengeRoadTemplateCate
      {
         return _revengeRoadTempCate;
      }
      
      public function get revengeRoadAreaBoxCate() : RevengeRoadAreaBoxTempCate
      {
         return _revengeRoadAreaBoxCate;
      }
      
      public function get revengeRoadDropCate() : RevengeRoadDropTempCate
      {
         return _revengeRoadDropCate;
      }
      
      public function get proficiencyTempCate() : ProficiencyTempCate
      {
         return _proficiencyTempCate;
      }
      
      public function get kingbackTempCate() : KingbackTemplateCate
      {
         return _kingbackTempCate;
      }
      
      public function get guildWantedDropTempCate() : GuildWantedDropTempCate
      {
         return _guildWantedDropTempCate;
      }
      
      public function getSevenYearShopTemplateInfoList() : Dictionary
      {
         return _sevenYearShopTemplateDic;
      }
      
      public function get yearActiveShopList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = [];
         for each(_loc2_ in _yearactiveShop1Dic)
         {
            _loc1_.push(_loc2_);
            _yearactiveShopDic[_loc2_.Id] = _loc2_;
         }
         for each(_loc2_ in _yearactiveShop2Dic)
         {
            _loc1_.push(_loc2_);
            _yearactiveShopDic[_loc2_.Id] = _loc2_;
         }
         return _loc1_;
      }
      
      public function getYearactiveShopById(param1:int) : ShopGoodsInfo
      {
         return _yearactiveShopDic[param1];
      }
      
      public function get starareaRoadsTempCate() : StarareaRoadsTempCate
      {
         return _starareaRoadsTempCate;
      }
      
      public function get starAreaDropCate() : StarAreaDropCate
      {
         return _starAreaDropCate;
      }
      
      public function get sevenYearAchievementTempCate() : SevenYearAchievementTempCate
      {
         return _sevenYearAchievementTempCate;
      }
      
      public function get sevenYearQuestionTempCate() : SevenYearQuestionTempCate
      {
         return _sevenYearQuestionTempCate;
      }
      
      public function get sevenYearRewardDropCate() : SevenYearRewardDropCate
      {
         return _sevenYearRewardDropCate;
      }
      
      public function get sevenYearTreasureBoxDropCate() : SevenYearTreasureBoxDropCate
      {
         return _sevenYearTreasureBoxDropCate;
      }
      
      public function get gloryRewardDropCate() : GloryRewardDropCate
      {
         return _gloryRewardDropCate;
      }
      
      public function get abysmDropTempCate() : AbysmDropTempCate
      {
         return _abysmDropCate;
      }
      
      public function get abysmHellDropTempCate() : AbysmHellDropTempCate
      {
         return _abysmHellDropCate;
      }
      
      public function get avengerCommonTempCate() : AvengerCommonTempCate
      {
         return _avengerCommonTempCate;
      }
      
      public function get resolveTemplateCate() : ResolveTemplateCate
      {
         return _resolveTempCate;
      }
      
      public function get raceAgainstTimeDropTempCate() : RaceAgainstTimeDropTempCate
      {
         return _raceAgainstTimeDropTempCate;
      }
      
      public function get childAssistUpgradeTemplateCate() : ChildAssistUpgradeTemplateCate
      {
         return _childAssistUpgradeTemplateCate;
      }
      
      public function get childCampTempCate() : ChildCampTempCate
      {
         return _childCampTempCate;
      }
      
      public function get sevenYearFreeRewardDropCate() : SevenYearFreeRewardDropCate
      {
         return _sevenYearFreeRewardDropCate;
      }
      
      public function getFlameTempleDic() : Dictionary
      {
         return _flameTempleShopDic;
      }
      
      public function getDuskAreaShopDic() : Dictionary
      {
         return _duskAreaShopDic;
      }
      
      public function get spiritExpeditionTempCate() : SpiritExpeditionTempCate
      {
         return _spiritExpeditionTempCate;
      }
      
      public function get spiritExpeditionFightDropTempCate() : SpiritExpeditionFightDropTempCate
      {
         return _spiritExpeditionFightDropTempCate;
      }
      
      public function get spiritExpeditionStarDropTempCate() : SpiritExpeditionStarDropTempCate
      {
         return _spiritExpeditionStarDropTempCate;
      }
      
      public function getDemonShopTemplateDicList() : Dictionary
      {
         return _demonRoadShopDic;
      }
      
      public function get selfChessTempCate() : SelfChessTempCate
      {
         return _selfChessTempCate;
      }
      
      public function get selfChessBuffTempCate() : SelfChessBuffTampCate
      {
         return _selfChessBuffTempCate;
      }
      
      public function get shadowLandTempCate() : ShadowLandTempCate
      {
         return _shadowLandTempCate;
      }
      
      public function get shadowLandFightDropTempCate() : ShadowLandFightDropTempCate
      {
         return _shadowLandFightDropTempCate;
      }
      
      public function get shadowLandBoxDropTempCate() : ShadowLandBoxDropTempCate
      {
         return _shadowLandBoxDropTempCate;
      }
      
      public function get darkMazeEventTempCate() : DarkMazeEventTempCate
      {
         return _darkMazeEventTempCate;
      }
      
      public function get darkMazeChildTempCate() : DarkMazeChildTempCate
      {
         return _darkMazeChildTempCate;
      }
      
      public function getDarkMazeShopTemplateDicList() : Dictionary
      {
         return _darkmazeShopDic;
      }
      
      public function get stelaTempCate() : StelaTemplateCate
      {
         return _stelaTempCate;
      }
      
      public function get stelaStepTempCate() : StelaStepTemplateCate
      {
         return _stelaStepTempCate;
      }
      
      public function get theseusEquipQualityTmpl() : TheseusEquipQualityTmpl
      {
         return _theseusEquipQualityTmpl;
      }
      
      public function get theseusEquipStrengthenTmpl() : TheseusEquipStrengthenTmpl
      {
         return _theseusEquipStrengthenTmpl;
      }
      
      public function get stelaPropertyTempCate() : StelaPropertyTemplateCate
      {
         return _stelaPropertyTempCate;
      }
      
      public function get stelaResistTempCate() : StelaResistTemplateCate
      {
         return _stelaResistTempCate;
      }
      
      public function get singleCampaignDataTempCate() : SingleCampaignDataTempCate
      {
         return _singleCampaignTempCate;
      }
      
      public function get remainsExploreTempCate() : RemainsExploreTempCate
      {
         return _remainsExploreTempCate;
      }
      
      public function get remainsExploreChapterTempCate() : RemainsExploreChapterTempCate
      {
         return _remainsExploreChapterTempCate;
      }
      
      public function get remainsExploreEventTempCate() : RemainsExploreEventTempCate
      {
         return _remainsExploreEventTempCate;
      }
      
      public function get remainsExploreDropTempCate() : RemainsExploreDropTempCate
      {
         return _remainsExploreDropTempCate;
      }
      
      public function get remainsExploreActivityTempCate() : RemainsExploreActivityTempCate
      {
         return _remainsExploreActivityTempCate;
      }
      
      public function get remainsExploreActivityDropTempCate() : RemainsExploreActivityDropTempCate
      {
         return _remainsExploreActivityDropTempCate;
      }
      
      public function get skyStepDropTempCate() : SkyStepDropTempCate
      {
         return _skyStepDropTempCate;
      }
      
      public function getConsortiaNewBossShopTemplateDicList() : Dictionary
      {
         return _consortiaNewBossShopDic;
      }
      
      public function get consortiaNewBossTempCate() : ConsortiaNewBossTemplateCate
      {
         return _consortiaNewBossTempCate;
      }
      
      public function get consortiaNewBossRankRewardTempCate() : ConsortiaNewBossRankRewardTempCate
      {
         return _consortiaNewBossRankRewardTempCate;
      }
      
      public function get consortiaNewBossDamageRewardTempCate() : ConsortiaNewBossDamageRewardTempCate
      {
         return _consortiaNewBossDamageRewardTempCate;
      }
      
      public function get achievementTaskTemplateCate() : AchievementTaskTemplateCate
      {
         return _achievementTaskTemplateCate;
      }
      
      public function get achievementTaskBuyDropTemplateCate() : AchievementTaskBuyDropTemplateCate
      {
         return _achievementTaskBuyDropTemplateCate;
      }
      
      public function get newFirstPlayCate() : NewFirstPlayCate
      {
         return _newFirstPlayCate;
      }
      
      public function get newFirstPlayDropCate() : NewFirstPayDropCate
      {
         return _newFirstPlayDropCate;
      }
      
      public function get questionDropTempCate() : QuestionDropTempCate
      {
         return _questionDropTempCate;
      }
      
      public function get questionTempCate() : QuestionTempCate
      {
         return _questionTempCate;
      }
      
      public function get poseidonShopCate() : PoseidonShopCate
      {
         return _poseidonShopCate;
      }
      
      public function get royaltyBossTempCate() : RoyaltyBossTempCate
      {
         return _royaltyBossTempCate;
      }
      
      public function get royaltyTempCate() : RoyaltyTempCate
      {
         return _royaltyTempCate;
      }
      
      public function get forbiddenBossTempCate() : ForbiddenBossTempCate
      {
         return _forbiddenBossTempCate;
      }
      
      public function get forbiddenBossBelongDropCate() : ForbiddenBossBelongDropCate
      {
         return _forbiddenBossBelongDropCate;
      }
      
      public function get forbiddenBossJoinDropCate() : ForbiddenBossJoinDropCate
      {
         return _forbiddenBossJoinDropCate;
      }
      
      public function get theseusRageSuitTempCate() : TheseusRageSuiteTempCate
      {
         return _theseusRageSuitTempCate;
      }
      
      public function get collectionSuitTempCate() : CollectionSuitTempCate
      {
         return _collectionSuitTempCate;
      }
      
      public function get collectionTempCate() : CollectionTempCate
      {
         return _collectionTempCate;
      }
      
      public function get theseusRageTempCate() : TheseusRageTempCate
      {
         return _theseusRageTempCate;
      }
      
      public function get theseusEquipSuitCate() : TheseusEquipSuiteTempCate
      {
         return _theseusEquipSuitCate;
      }
      
      public function get secretMapCate() : SecretMapLevelCate
      {
         return _secretMapCate;
      }
      
      public function get secretsonLvCate() : SecretSonLevelCate
      {
         return _secretsonLvCate;
      }
      
      public function get secretEventCate() : SecretEventCate
      {
         return _secretEventCate;
      }
      
      public function get secretSonDataCate() : SecretMapDataCate
      {
         return _secretSonDataCate;
      }
      
      public function get theseusTreasureHokeCate() : TheseusTreasureHokeCate
      {
         return _theseusTreasureHokeCate;
      }
      
      public function get theseusTreasureCoreCate() : TheseusTreasureCoreCate
      {
         return _theseusTreasureCoreCate;
      }
      
      public function get theseusTreasureGrowupCate() : TheseusTreasureGrowupCate
      {
         return _theseusTreasureGrowupCate;
      }
      
      public function get theseusDungeonCate() : TheseusDungeonCate
      {
         return _theseusDungeonCate;
      }
      
      public function get theseusDungeonEventCate() : TheseusDungeonEventCate
      {
         return _theseusDungeonEventCate;
      }
      
      public function get theseusDungeonTaskCate() : TheseusDungeonTaskCate
      {
         return _theseusDungeonTaskCate;
      }
      
      public function get carnivalPointExchangeCate() : CarnivalPointExchangeTemplateCate
      {
         return _carnivalPointExchangeCate;
      }
      
      public function get carnivalPlayGroundTemplateCate() : CarnivalPlayGroundTemplateCate
      {
         return _carnivalPlayGroundTemplateCate;
      }
      
      public function get carnivalLuckDrawTemplateCate() : CarnivalLuckDrawTemplateCate
      {
         return _carnivalLuckDrawTemplateCate;
      }
      
      public function get carnivalDailyChallengeTemplateCate() : CarnivalDailyChallengeTemplateCate
      {
         return _carnivalDailyChallengeTemplateCate;
      }
      
      public function get newActiveLeedCate() : NewActiveLeedCate
      {
         return _newActiveLeedCate;
      }
      
      public function get newActiveLeedDailyCate() : NewActiveLeedDailyCate
      {
         return _newActiveLeedDailyCate;
      }
      
      public function get newActiveLeedWeekCate() : NewActiveLeedWeekCate
      {
         return _newActiveLeedWeekCate;
      }
      
      public function get warSoulTowerLevelTempCate() : WarSoulTowerLevelTempCate
      {
         return _warSoulTowerLevelTempCate;
      }
      
      public function get warSoulTowerStageTempCate() : WarSoulTowerStageTempCate
      {
         return _warSoulTowerStageTempCate;
      }
      
      public function get warsoulCate() : WarSoulTempCate
      {
         return _warsoulCate;
      }
      
      public function get warsoulStarCate() : WarSoulStarTempCate
      {
         return _warsoulStarCate;
      }
      
      public function get warsoulStrengthenCate() : WarSoulStrengthenTempCate
      {
         return _warsoulStrengthenCate;
      }
      
      public function get warsoulReformCate() : WarSoulReformTempCate
      {
         return _warsoulReformCate;
      }
      
      public function get finalRoadGroupTempCate() : FinalRoadGroupTempCate
      {
         return _finalRoadGroupTempCate;
      }
      
      public function get finalRoadEventTempCate() : FinalRoadEventTempCate
      {
         return _finalRoadEventTempCate;
      }
      
      public function get finalRoadChapterTempCate() : FinalRoadChapterTempCate
      {
         return _finalRoadChapterTempCate;
      }
      
      public function get theseusPvpTempCate() : TheseusPvpTempCate
      {
         return _theseusPvpTempCate;
      }
      
      public function get theseusPvpIntegralCate() : TheseusPvpIntegralTempCate
      {
         return _theseusPvpIntegralCate;
      }
      
      public function get theseusPvpTaskCate() : TheseusPvpTaskTempCate
      {
         return _theseusPvpTaskCate;
      }
      
      public function get theseusMultiPvpTempCate() : TheseusMultiPvpTempCate
      {
         return _theseusMultiPvpTempCate;
      }
      
      public function get theseusMultiPvpIntegralCate() : TheseusMultiPvpIntegralTempCate
      {
         return _theseusMultiPvpIntegralCate;
      }
      
      public function get theseusMultiPvpTaskCate() : TheseusMultiPvpTaskTempCate
      {
         return _theseusMultiPvpTaskCate;
      }
      
      public function get theseusPvpRewardCate() : SpeicalRewardTempCate
      {
         return _theseusPvpRewardCate;
      }
      
      public function get theseuspvpShopDic() : Dictionary
      {
         return _theseuspvpShopDic;
      }
      
      public function get oldPlayerReturnTaskTempCate() : OldPlayerReturnTaskTempCate
      {
         return _oldPlayerReturnTaskTempCate;
      }
      
      public function get oldPlayerReturnRewardTempCate() : OldPlayerReturnRewardTempCate
      {
         return _oldPlayerReturnRewardTempCate;
      }
      
      public function get oldPlayerReturnShopTempCate() : OldPlayerReturnShopTempCate
      {
         return _oldPlayerReturnShopTempCate;
      }
      
      public function get oldPlayerReturnPrivilegeTempCate() : OldPlayerReturnPrivilegeTempCate
      {
         return _oldPlayerReturnPrivilegeTempCate;
      }
      
      public function get runeGemInfoCate() : RuneGemTempInfoCate
      {
         return _runeGemInfoCate;
      }
      
      public function get runeHoleInfoCate() : RuneHoleTempInfoCate
      {
         return _runeHoleInfoCate;
      }
      
      public function get runeFsgainInfoCate() : RuneFsgainTempInfoCate
      {
         return _runeFsgainInfoCate;
      }
      
      public function get secretwarShopTempCate() : SecretwarShopTempCate
      {
         return _secretwarShopTempCate;
      }
      
      public function get yearActiveDropCate() : YearActiveDropCate
      {
         return _yearActiveDropCate;
      }
      
      public function get minosLevelCate() : MinosLevelCate
      {
         return _minosLevelCate;
      }
      
      public function get minosNodeCate() : MinosNodeCate
      {
         return _minosNodeCate;
      }
      
      public function get minosRewardCate() : MinosRewardCate
      {
         return _minosRewardCate;
      }
      
      public function get consortiaCommerceShopTempCate() : ConsortiaCommerceShopTempCate
      {
         return _consortiaCommerceShopTempCate;
      }
      
      public function get minosShopDic() : Dictionary
      {
         return _minosShopDic;
      }
      
      public function get chesspvpShopDic() : Dictionary
      {
         return _chesspvpShopDic;
      }
      
      public function get christmasLotteryTempCate() : ChristmasLotteryTempCate
      {
         return _christmasLotteryTempCate;
      }
      
      public function get christmasActivitiesTempCate() : ChristmasActivitiesTempCate
      {
         return _christmasActivitiesTempCate;
      }
      
      public function get christmasAnswersTempCate() : ChristmasAnswersTempCate
      {
         return _christmasAnswersTempCate;
      }
      
      public function get christmasAchievementsTempCate() : ChristmasAchievementsTempCate
      {
         return _christmasAchievementsTempCate;
      }
      
      public function get chesspvpFightDropCate() : ChessPvpFightDropCate
      {
         return _chesspvpFightDropCate;
      }
      
      public function get chesspvpRankDropCate() : ChessPvpRankDropCate
      {
         return _chesspvpRankDropCate;
      }
      
      public function get childNswarCate() : ChildNswarTempCate
      {
         return _childNswarCate;
      }
      
      public function get childNswarTaskCate() : ChildNswarTaskTempCate
      {
         return _childNswarTaskCate;
      }
      
      public function get childNswarShopDic() : Dictionary
      {
         return _childNswarShopDic;
      }
      
      public function get thessTowerCate() : ThessTowerTempCate
      {
         return _thessTowerCate;
      }
      
      public function get thessBoxCate() : ThessBoxTempCate
      {
         return _thessBoxCate;
      }
      
      public function get thessBoxMapCate() : ThessBoxMapCate
      {
         return _thessBoxMapCate;
      }
      
      public function get theseusSlateCate() : TheseusSlateCate
      {
         return _theseusSlateCate;
      }
      
      public function get theseusSlateTaskCate() : TheseusSlateTaskCate
      {
         return _theseusSlateTaskCate;
      }
      
      public function get theseusSlateUpgradeCate() : TheseusSlateUpgradeCate
      {
         return _theseusSlateUpgradeCate;
      }
   }
}

