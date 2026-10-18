package yishi.manager
{
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.external.ExternalInterface;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   import mvc.module.friends.BaseIMInfo;
   
   public class SharedManager extends EventDispatcher
   {
      
      public static const LOCAL_FILE:String = "7road/files";
      
      public static const IS_STRENGTHEN:String = "IS_STRENGTHEN";
      
      public static const STRENGTHEN_CHECK_DATE:String = "STRENGTHEN_CHECK_DATE";
      
      private static var _instance:SharedManager;
      
      public static const PVP_ALERT_SIGN:String = "PVP_ALERT_SIGN";
      
      public static const PVP_CHECK_DATE:String = "PVP_CHECK_DATE";
      
      private static var _skillSoundTransform:SoundTransform = new SoundTransform();
      
      private var _userId:int;
      
      public var payChooseType:int;
      
      public var thewCheck:Boolean;
      
      public var thewCheckDate:Date = new Date();
      
      public var attackCastleCheck:Boolean;
      
      public var attackCastleCheckDate:Date = new Date();
      
      public var qteUpgrade:Boolean;
      
      public var qteUpgradeCheckDate:Date = new Date();
      
      public var multiFailded:Boolean;
      
      public var multiFaildedCheckDate:Date = new Date();
      
      public var secretGetBuffTip:Boolean;
      
      public var secretGetBuffTipCheckDate:Date = new Date();
      
      public var demonGetBuffTip:Boolean;
      
      public var demonGetBuffTipCheckDate:Date = new Date();
      
      public var vipBoxRefreshTip:Boolean;
      
      public var vipBoxRefreshTipCheckDate:Date = new Date();
      
      public var storeCompose:Boolean;
      
      public var storeComposeCheckDate:Date = new Date();
      
      public var resolveStrengthen:Boolean;
      
      public var resolveStrengthenCheckDate:Date = new Date();
      
      public var storeSwitch:Boolean;
      
      public var storeSwitchCheckDate:Date = new Date();
      
      public var quickInvite:Boolean;
      
      public var quickInviteCheckDate:Date = new Date();
      
      public var storeRefreshBuy:Boolean;
      
      public var storeRefreshBuyCheckDate:Date = new Date();
      
      public var storeRefreshBinding:Boolean;
      
      public var storeRefreshBindingCheckDate:Date = new Date();
      
      public var expendCrystal:Boolean;
      
      public var expendCrystalCheckDate:Date = new Date();
      
      public var mysteryShopRefresh:Boolean;
      
      public var mysteryShopRefreshCheckDate:Date = new Date();
      
      public var mysteryShopRefreshUseBind:Boolean;
      
      public var mysteryShopRefreshUseBindDate:Date = new Date();
      
      public var llkBuyBombAlert:Boolean;
      
      public var llkBuyBombUseBind:Boolean = true;
      
      public var llkBuyResetAlert:Boolean;
      
      public var llkBuyResetUseBind:Boolean = true;
      
      public var offerRewardRefresh:Boolean;
      
      public var offerRewardRefreshCheckDate:Date = new Date();
      
      public var advDomesticateUseBind:Boolean;
      
      public var advDomesticateUseBindDate:Date;
      
      public var advDomesticateUseBind2:Boolean;
      
      public var starQuickSellType:int = 1;
      
      public var expBackIsSelected:Boolean;
      
      public var demonReviveTipCheckDate:Date;
      
      public var hideOthers:Boolean = false;
      
      public var allowMusic:Boolean = true;
      
      public var musicVolumn:int = 40;
      
      public var allowSound:Boolean = true;
      
      public var soundVolumn:int = 40;
      
      public var allowSceneEffect:Boolean = true;
      
      public var allowAttactedEffect:Boolean = true;
      
      public var buildingName:Boolean = true;
      
      public var shadowEffect:Boolean = true;
      
      public var specialBtnHadShine:Boolean;
      
      public var talentBtnNeedShine:Boolean;
      
      public var difficultMazeBtnShine:Boolean;
      
      public var consortiaGroupChatShineSwitch:Boolean = true;
      
      public var isTrailFirst:Boolean;
      
      public var isCampaignBuffFirst:Boolean;
      
      public var lastBagSortType:Number;
      
      public var openBottle:Boolean;
      
      public var openBottleCheckDate:Date = new Date();
      
      public var receiveMapFlag:Boolean = false;
      
      public var refreshRewardNotAlert:Boolean = false;
      
      public var refreshRewardUseBind:Boolean = false;
      
      public var quicklyRefreshRewardNotAlert:Boolean = false;
      
      public var quicklyRefreshRewardUseBind:Boolean = false;
      
      public var currentTreasureMapId:int;
      
      public var isUsedTreaSureMap:Boolean = false;
      
      public var singlePassBugleOpenCardUseBind:Boolean;
      
      public var singlePassBugleOpenCardUseBindDate:Date;
      
      public var addSlotUseBind:Boolean;
      
      public var addSlotUseBindDate:Date;
      
      public var petEquipStrengAutoBuy:Boolean;
      
      public var petEquipStrengAutoBuyCheckDate:Date = new Date();
      
      public var petEquipRefineryAutoBuy:Boolean;
      
      public var petEquipRefineryAutoBuyCheckDate:Date = new Date();
      
      public var petEquipUpgradeAutoBuy:Boolean;
      
      public var petEquipUpgradeAutoBuyCheckDate:Date = new Date();
      
      public var hideOthersInBattle:Boolean = false;
      
      public var secretwarShopRefresh:Boolean;
      
      public var secretwarShopRefreshCheckDate:Date = new Date();
      
      public var secretwarShopRefreshUseBind:Boolean;
      
      public var recentList:Array;
      
      private var _autoReplyList:Dictionary;
      
      private var _imHistoryDic:Dictionary;
      
      private var _activeDic:Dictionary;
      
      public var todayFullScreenBtnShine:Number = 0;
      
      public var pownConveruseBind:Boolean;
      
      public var offerRewardRefreshUseBind:Boolean;
      
      public var worldBossRiverUseBind:Boolean;
      
      public var worldBossBuyBuffUseBind:Boolean;
      
      public var guildWantedRefreshUseBind:Boolean;
      
      public var autoStarCostGold:int = 1;
      
      public var autoStarSell:int = 1;
      
      public var autoStarCompose:int = 1;
      
      public var sacrificeRefreshNeedAlertCheckDate:Date;
      
      public var sacrificeGetRewardAlertCheckDate:Date;
      
      public var worldBossPointTodayNeedAlertCheckDate:Date;
      
      public var worldBossGifttokenTodayNeedAlertCheckDate:Date;
      
      public var worldBossRiverTodayNeedAlertCheckDate:Date;
      
      public var worldBossRiverTodayNeedAlertCheckDate_enterBattle:Date = null;
      
      public var refuseInvitation:Boolean = false;
      
      public var advDomesticateAlertDate:Date;
      
      public var advDomesticateAlertDate2:Date;
      
      public var petAdvanceAlertDate:Date;
      
      public var handInMineralDate:Date;
      
      public var completeRingTaskDate:Date;
      
      public var completeRingTaskFlag:Boolean;
      
      public var completeRingTaskUseBind:Boolean = true;
      
      public var domesticateAlertDate:Date;
      
      public var domesticateAlertDate2:Date;
      
      public var pownConverAlertDate:Date;
      
      public var fashionComposeBindsAlertDate:Date;
      
      public var fashionComposeBindsSoulAlertDate:Date;
      
      public var fashionSwitchBindsAlertDate:Date;
      
      public var openKingContractAlertDate:Date;
      
      public var petNormalAdvanceUseBind:Boolean;
      
      public var upRingNormalUseBind:Boolean;
      
      public var upRingSeniorUseBind:Boolean;
      
      public var petNormalAdvancedAlertDate:Date;
      
      public var upRingSeniorAlertDate:Date;
      
      public var diamondTrainUseBind:Boolean;
      
      public var diamondTrainAlertDate:Date;
      
      public var upRingNormalAlertDate:Date;
      
      public var petSeniorAdvancedUseBind:Boolean;
      
      public var petSeniorAdvancedAlertDate:Date;
      
      public var petadvanceWillbeBindCheck1:int;
      
      public var petadvanceWillbeBindCheckDate1:Date;
      
      public var petadvanceWillbeBindCheck2:int;
      
      public var petadvanceWillbeBindCheckDate2:Date;
      
      public var petadvanceWillbeBindCheck3:int;
      
      public var petadvanceWillbeBindCheckDate3:Date;
      
      public var petadvanceWillbeBindCheck4:int;
      
      public var petadvanceWillbeBindCheckDate4:Date;
      
      public var petadvanceWillbeBindCheck5:Boolean;
      
      public var petadvanceWillbeBindCheckDate5:Date;
      
      public var petadvanceWillbeBindCheck6:Boolean;
      
      public var petadvanceWillbeBindCheckDate6:Date;
      
      public var buyPetChallengeCountDate:Date;
      
      public var buyPetChallengeCountDate2:Date;
      
      public var quickMouseWorkDate:Date;
      
      public var quickActiveMouseWorkDate:Date;
      
      public var advanceTrainMountAlertDate:Date;
      
      private var _funnyOldDic:Dictionary;
      
      public var petswallowNotShow:Boolean;
      
      public var petswallowNotShowResult:Boolean;
      
      public var sharePetComposeBtn:Boolean = true;
      
      private var _fashionIdentityProgress:int = 0;
      
      public var mountStarNotAlert:Boolean = false;
      
      public var mountStarNotAlertAdv:Boolean = false;
      
      private var _flashPromotionBtn:Boolean = true;
      
      public var buyGemMazeTimesAlertDate:Date;
      
      public var buyGemMazeTimesUseBind:Boolean;
      
      public var dungeonBuyShoesAlertDate:Date;
      
      public var dungeonBuyShoesUseBind:Boolean;
      
      public var dungeonBuyLifeAlertDate:Date;
      
      public var dungeonBuyLifeUseBind:Boolean;
      
      public var dungeonRemoveCannotMoveAlertDate:Date;
      
      public var dungeonRemoveCannotMoveUseBind:Boolean;
      
      public var dungeonUseLifeAlertDate:Date;
      
      public var dungeonSkipAlertDate:Date;
      
      public var dungeonBuyRoadAlertDate:Date;
      
      public var dungeonBuyRoadUseBind:Boolean;
      
      public var dungeonBlackBuyAlertDate:Date;
      
      public var dungeonFindAlertDate:Date;
      
      public var dungeonExploreHelpFrameDate:Date;
      
      public var refreshGoldRoadGoods:Date;
      
      public var gameHallEastShop:Date;
      
      public var diceGoldRoad:Date;
      
      public var diceGoldRoad2:Date;
      
      public var refreshTargetAlertDate:Date;
      
      public var monopolyDiceMagicBuyAlertDate:Date;
      
      public var monopolyDiceMagicBuyUseBind:Boolean;
      
      public var monopolyWarFlagBuyAlertDate:Date;
      
      public var monopolyWarFlagBuyUseBind:Boolean;
      
      public var outercityshopFreshAlertDate:Date;
      
      public var outercityshopFreshUseBind:Boolean;
      
      public var upgradeTalentUseBind:Boolean;
      
      public var buySingleHeroCountAlertDate:Date;
      
      public var buySingleHeroCountUseBind:Boolean;
      
      public var showResolveAlertForMountCard:Boolean;
      
      public var showResolveAlertForFashion:Boolean;
      
      public var planesAddEnergyAlertDate:Date;
      
      public var planesAddEnergyUseBind:Boolean;
      
      public var planesFindAlertDate:Date;
      
      public var planesBuyLifeAlertDate:Date;
      
      public var planesBuyLifeUseBind:Boolean;
      
      public var armyViewReviveAlertDate:Date;
      
      public var armyViewReviveUseBind:Boolean;
      
      public var planesWarBlackBuyAlertDate:Date;
      
      public var petBossTeamDate:Date;
      
      public var battleMountAlertDate:Date;
      
      public var battleMountAdvAlertDate:Date;
      
      public var hadOpenedBattleMount:Boolean;
      
      public var svsBeginWar:Date;
      
      public var needAlertRefreshReward:Boolean;
      
      public var needAlertRefreshIcon:Boolean;
      
      public var needAlertRefreshChild:Boolean;
      
      public var needAlertRefreshChildBindPoint:Boolean;
      
      public var armoryEquipGrade:Boolean;
      
      public var armoryEquipGradeCheckDate:Date = new Date();
      
      public var ancientArmoryDelete:Boolean;
      
      public var ancientArmoryDeleteCheckDate:Date = new Date();
      
      public var guildWantedRefreshStar:Boolean;
      
      public var guildWantedRefreshStarCheckDate:Date = new Date();
      
      public var setDefaultFashionFlag:Boolean = true;
      
      public function SharedManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : SharedManager
      {
         if(!_instance)
         {
            _instance = new SharedManager();
         }
         return _instance;
      }
      
      public function saveSecretwarShopRefreshUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["secretwarShopRefreshUseBind" + _userId] = secretwarShopRefreshUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function getSkillSoundTransform() : SoundTransform
      {
         if(allowSound)
         {
            _skillSoundTransform = new SoundTransform(1);
            _skillSoundTransform.volume = soundVolumn / 100;
         }
         else
         {
            _skillSoundTransform = new SoundTransform(0);
            _skillSoundTransform.volume = 0;
         }
         return _skillSoundTransform;
      }
      
      public function get autoReplyList() : Dictionary
      {
         if(!_autoReplyList)
         {
            _autoReplyList = new Dictionary();
         }
         return _autoReplyList;
      }
      
      public function get imHistoryDic() : Dictionary
      {
         if(!_imHistoryDic)
         {
            _imHistoryDic = new Dictionary();
         }
         return _imHistoryDic;
      }
      
      public function get activeDic() : Dictionary
      {
         if(!_activeDic)
         {
            _activeDic = new Dictionary();
         }
         return _activeDic;
      }
      
      public function get funnyOldDic() : Dictionary
      {
         if(!_funnyOldDic)
         {
            _funnyOldDic = new Dictionary();
         }
         return _funnyOldDic;
      }
      
      public function setup(param1:int) : void
      {
         _userId = param1;
         loadLocal();
      }
      
      public function setProperty(param1:String, param2:*, param3:String, param4:*) : void
      {
         var _loc5_:SharedObject = null;
         try
         {
            _loc5_ = SharedObject.getLocal("7road/files","/");
            _loc5_.data[param1 + _userId] = param2;
            _loc5_.data[param3 + _userId] = param4;
            _loc5_.flush();
         }
         catch(error:*)
         {
         }
      }
      
      public function saveAutoStarSet() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["autoStarCostGold" + _userId] = autoStarCostGold;
            _loc1_.data["autoStarSell" + _userId] = autoStarSell;
            _loc1_.data["autoStarCompose" + _userId] = autoStarCompose;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function getProperty(param1:String) : *
      {
         var _loc2_:SharedObject = null;
         try
         {
            _loc2_ = SharedObject.getLocal("7road/files","/");
            return _loc2_.data[param1 + _userId];
         }
         catch(error:*)
         {
            var _loc5_:* = null;
         }
         return _loc5_;
      }
      
      public function checkIsExpired(param1:Date) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function loadLocal() : void
      {
         var _loc6_:SharedObject = null;
         var _loc9_:Dictionary = null;
         var _loc7_:Object = null;
         var _loc1_:* = undefined;
         var _loc2_:BaseIMInfo = null;
         var _loc3_:* = undefined;
         try
         {
            _loc6_ = SharedObject.getLocal("7road/files");
            if(_loc6_ && _loc6_.data)
            {
               if(_loc6_.data["allowMusic" + _userId] != undefined)
               {
                  allowMusic = _loc6_.data["allowMusic" + _userId];
               }
               if(_loc6_.data["allowSound" + _userId] != undefined)
               {
                  allowSound = _loc6_.data["allowSound" + _userId];
               }
               if(_loc6_.data["musicVolumn" + _userId] != undefined)
               {
                  musicVolumn = _loc6_.data["musicVolumn" + _userId];
               }
               if(_loc6_.data["soundVolumn" + _userId] != undefined)
               {
                  soundVolumn = _loc6_.data["soundVolumn" + _userId];
               }
               if(_loc6_.data["allowSceneEffect" + _userId] != undefined)
               {
                  allowSceneEffect = _loc6_.data["allowSceneEffect" + _userId];
               }
               if(_loc6_.data["allowAttactedEffect" + _userId] != undefined)
               {
                  allowAttactedEffect = _loc6_.data["allowAttactedEffect" + _userId];
               }
               if(_loc6_.data["buildingName" + _userId] != undefined)
               {
                  buildingName = _loc6_.data["buildingName" + _userId];
               }
               if(_loc6_.data["consortiaGroupChatShineSwitch" + _userId] != undefined)
               {
                  consortiaGroupChatShineSwitch = _loc6_.data["consortiaGroupChatShineSwitch" + _userId];
               }
               if(_loc6_.data["recent" + _userId] != undefined)
               {
                  recentList = _loc6_.data["recent" + _userId] as Array;
               }
               if(_loc6_.data["autoReplyList" + _userId] != undefined)
               {
                  _autoReplyList = _loc6_.data["autoReplyList" + _userId] as Dictionary;
               }
               if(_loc6_.data["activeDic" + _userId] != undefined)
               {
                  _activeDic = _loc6_.data["activeDic" + _userId] as Dictionary;
               }
               if(_loc6_.data["funnyOldDic" + _userId] != undefined)
               {
                  _funnyOldDic = _loc6_.data["funnyOldDic" + _userId] as Dictionary;
               }
               if(_loc6_.data["imHistoryDic" + _userId] != undefined)
               {
                  _loc9_ = _loc6_.data["imHistoryDic" + _userId] as Dictionary;
                  for(var _loc8_:String in _loc9_)
                  {
                     _loc7_ = _loc9_[_loc8_];
                     _loc1_ = new Vector.<BaseIMInfo>();
                     for each(var _loc4_:Object in _loc7_)
                     {
                        _loc2_ = new BaseIMInfo();
                        _loc2_.userId = _loc4_.userId;
                        _loc2_.nickName = _loc4_.nickName;
                        _loc2_.toId = _loc4_.toId;
                        _loc2_.msg = _loc4_.msg;
                        _loc2_.date = _loc4_.date;
                        _loc2_.sendResult = _loc4_.sendResult;
                        _loc1_.push(_loc2_);
                     }
                     imHistoryDic[_loc8_] = _loc1_;
                  }
               }
               if(_loc6_.data["payChooseType" + _userId] != undefined)
               {
                  payChooseType = _loc6_.data["payChooseType" + _userId];
               }
               if(_loc6_.data["thewCheck" + _userId] != undefined)
               {
                  thewCheck = _loc6_.data["thewCheck" + _userId];
               }
               if(_loc6_.data["qteUpgrade" + _userId] != undefined)
               {
                  qteUpgrade = _loc6_.data["qteUpgrade" + _userId];
               }
               if(_loc6_.data["secretGetBuffTip" + _userId] != undefined)
               {
                  secretGetBuffTip = _loc6_.data["secretGetBuffTip" + _userId];
               }
               if(_loc6_.data["demonGetBuffTip" + _userId] != undefined)
               {
                  demonGetBuffTip = _loc6_.data["demonGetBuffTip" + _userId];
               }
               if(_loc6_.data["vipBoxRefreshTip" + _userId] != undefined)
               {
                  vipBoxRefreshTip = _loc6_.data["vipBoxRefreshTip" + _userId];
               }
               if(_loc6_.data["storeCompose" + _userId] != undefined)
               {
                  storeCompose = _loc6_.data["storeCompose" + _userId];
               }
               if(_loc6_.data["resolveStrengthen" + _userId] != undefined)
               {
                  resolveStrengthen = _loc6_.data["resolveStrengthen" + _userId];
               }
               if(_loc6_.data["storeSwitch" + _userId] != undefined)
               {
                  storeSwitch = _loc6_.data["storeSwitch" + _userId];
               }
               if(_loc6_.data["quickInvite" + _userId] != undefined)
               {
                  quickInvite = _loc6_.data["quickInvite" + _userId];
               }
               if(_loc6_.data["storeRefreshBuy" + _userId] != undefined)
               {
                  storeRefreshBuy = _loc6_.data["storeRefreshBuy" + _userId];
               }
               if(_loc6_.data["storeRefreshBinding" + _userId] != undefined)
               {
                  storeRefreshBinding = _loc6_.data["storeRefreshBinding" + _userId];
               }
               if(_loc6_.data["mysteryShopRefresh" + _userId] != undefined)
               {
                  mysteryShopRefresh = _loc6_.data["mysteryShopRefresh" + _userId];
               }
               if(_loc6_.data["mysteryShopRefreshUseBind" + _userId] != undefined)
               {
                  mysteryShopRefreshUseBind = _loc6_.data["mysteryShopRefreshUseBind" + _userId];
               }
               if(_loc6_.data["offerRewardRefresh" + _userId] != undefined)
               {
                  offerRewardRefresh = _loc6_.data["offerRewardRefresh" + _userId];
               }
               if(_loc6_.data["starQuickSellType" + _userId] != undefined)
               {
                  starQuickSellType = _loc6_.data["starQuickSellType" + _userId];
               }
               if(_loc6_.data["multiFailded" + _userId] != undefined)
               {
                  multiFailded = _loc6_.data["multiFailded" + _userId];
               }
               if(_loc6_.data["thewCheckDate" + _userId] != undefined)
               {
                  thewCheckDate = _loc6_.data["thewCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["qteUpgradeCheckDate" + _userId] != undefined)
               {
                  qteUpgradeCheckDate = _loc6_.data["qteUpgradeCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["secretGetBuffTipCheckDate" + _userId] != undefined)
               {
                  secretGetBuffTipCheckDate = _loc6_.data["secretGetBuffTipCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["demonGetBuffTipCheckDate" + _userId] != undefined)
               {
                  demonGetBuffTipCheckDate = _loc6_.data["demonGetBuffTipCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["vipBoxRefreshTipCheckDate" + _userId] != undefined)
               {
                  vipBoxRefreshTipCheckDate = _loc6_.data["vipBoxRefreshTipCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["demonReviveTipCheckDate" + _userId] != undefined)
               {
                  demonReviveTipCheckDate = _loc6_.data["demonReviveTipCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["storeComposeCheckDate" + _userId] != undefined)
               {
                  storeComposeCheckDate = _loc6_.data["storeComposeCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["resolveStrengthenCheckDate" + _userId] != undefined)
               {
                  resolveStrengthenCheckDate = _loc6_.data["resolveStrengthenCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["storeSwitchCheckDate" + _userId] != undefined)
               {
                  storeSwitchCheckDate = _loc6_.data["storeSwitchCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["quickInviteCheckDate" + _userId] != undefined)
               {
                  quickInviteCheckDate = _loc6_.data["quickInviteCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["storeRefreshBuyCheckDate" + _userId] != undefined)
               {
                  storeRefreshBuyCheckDate = _loc6_.data["storeRefreshBuyCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["storeRefreshBindingCheckDate" + _userId] != undefined)
               {
                  storeRefreshBindingCheckDate = _loc6_.data["storeRefreshBindingCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["starQuickSellType" + _userId] != undefined)
               {
                  expBackIsSelected = _loc6_.data["expBackIsSelected" + _userId];
               }
               if(_loc6_.data["mysteryShopRefreshUseBindDate" + _userId] != undefined)
               {
                  mysteryShopRefreshUseBindDate = _loc6_.data["mysteryShopRefreshUseBindDate" + _userId];
               }
               if(_loc6_.data["multiFaildedCheckDate" + _userId] != undefined)
               {
                  multiFaildedCheckDate = _loc6_.data["multiFaildedCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["attackCastleCheck" + _userId] != undefined)
               {
                  attackCastleCheck = _loc6_.data["attackCastleCheck" + _userId];
               }
               if(_loc6_.data["thewCheckDate" + _userId] != undefined)
               {
                  attackCastleCheckDate = _loc6_.data["attackCastleCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["worldBossRiverTodayNeedAlertDate" + _userId] != undefined)
               {
                  worldBossRiverTodayNeedAlertCheckDate = _loc6_.data["worldBossRiverTodayNeedAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["worldBossPointTodayNeedAlertCheckDate" + _userId] != undefined)
               {
                  worldBossPointTodayNeedAlertCheckDate = _loc6_.data["worldBossPointTodayNeedAlertCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["worldBossGifttokenTodayNeedAlertCheckDate" + _userId] != undefined)
               {
                  worldBossGifttokenTodayNeedAlertCheckDate = _loc6_.data["worldBossGifttokenTodayNeedAlertCheckDate" + _userId] as Date;
               }
               if(_loc6_.data["refuseInvitation" + _userId] != undefined)
               {
                  refuseInvitation = Boolean(_loc6_.data["refuseInvitation" + _userId]);
               }
               if(_loc6_.data["advDomesticateUseBind"] + _userId != undefined)
               {
                  advDomesticateUseBind = _loc6_.data["advDomesticateUseBind" + _userId];
               }
               if(_loc6_.data["advDomesticateUseBind2" + _userId] != undefined)
               {
                  advDomesticateUseBind2 = _loc6_.data["advDomesticateUseBind2" + _userId];
               }
               if(_loc6_.data["advDomesticateUseBindDate"] + _userId != undefined)
               {
                  advDomesticateUseBindDate = _loc6_.data["advDomesticateUseBindDate" + _userId];
               }
               if(_loc6_.data["pownConverAlertDate" + _userId] != undefined)
               {
                  pownConverAlertDate = _loc6_.data["pownConverAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["completeRingTaskDate" + _userId] != undefined)
               {
                  completeRingTaskDate = _loc6_.data["completeRingTaskDate" + _userId] as Date;
               }
               if(_loc6_.data["completeRingTaskUseBind" + _userId] != undefined)
               {
                  completeRingTaskUseBind = _loc6_.data["completeRingTaskUseBind" + _userId] as Date;
               }
               if(_loc6_.data["petAdvanceAlertDate" + _userId] != undefined)
               {
                  petAdvanceAlertDate = _loc6_.data["petAdvanceAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["worldBossRiverTodayNeedAlertCheckDate_enterBattle" + _userId] != undefined)
               {
                  worldBossRiverTodayNeedAlertCheckDate_enterBattle = _loc6_.data["worldBossRiverTodayNeedAlertCheckDate_enterBattle" + _userId] as Date;
               }
               if(_loc6_.data["specialBtnHadShine" + _userId] != undefined)
               {
                  specialBtnHadShine = _loc6_.data["specialBtnHadShine" + _userId];
               }
               if(_loc6_.data["talentBtnNeedShine" + _userId] != undefined)
               {
                  talentBtnNeedShine = _loc6_.data["talentBtnNeedShine" + _userId];
               }
               if(_loc6_.data["isTrailFirst" + _userId] != undefined)
               {
                  isTrailFirst = _loc6_.data["isTrailFirst" + _userId];
               }
               if(_loc6_.data["lastBagSortType" + _userId] != undefined)
               {
                  lastBagSortType = _loc6_.data["lastBagSortType" + _userId];
               }
               if(_loc6_.data["difficultMazeBtnShine" + _userId] != undefined)
               {
                  difficultMazeBtnShine = _loc6_.data["difficultMazeBtnShine" + _userId];
               }
               if(_loc6_.data["fashionComposeBindsAlertDate" + _userId] != undefined)
               {
                  fashionComposeBindsAlertDate = _loc6_.data["fashionComposeBindsAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["fashionComposeBindsSoulAlertDate" + _userId] != undefined)
               {
                  fashionComposeBindsSoulAlertDate = _loc6_.data["fashionComposeBindsSoulAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["openKingContractAlertDate" + _userId] != undefined)
               {
                  openKingContractAlertDate = _loc6_.data["openKingContractAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["fashionSwitchBindsAlertDate" + _userId] != undefined)
               {
                  fashionSwitchBindsAlertDate = _loc6_.data["fashionSwitchBindsAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["petNormalAdvancedAlertDate" + _userId] != undefined)
               {
                  petNormalAdvancedAlertDate = _loc6_.data["petNormalAdvancedAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["petSeniorAdvancedAlertDate" + _userId] != undefined)
               {
                  petSeniorAdvancedAlertDate = _loc6_.data["petSeniorAdvancedAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["pownConveruseBind"] + _userId != undefined)
               {
                  pownConveruseBind = _loc6_.data["pownConveruseBind" + _userId];
               }
               if(_loc6_.data["offerRewardRefreshUseBind" + _userId] != undefined)
               {
                  offerRewardRefreshUseBind = _loc6_.data["offerRewardRefreshUseBind" + _userId];
               }
               if(_loc6_.data["guildWantedRefreshUseBind" + _userId] != undefined)
               {
                  guildWantedRefreshUseBind = _loc6_.data["guildWantedRefreshUseBind" + _userId];
               }
               if(_loc6_.data["worldBossRiverUseBind" + _userId] != undefined)
               {
                  worldBossRiverUseBind = _loc6_.data["worldBossRiverUseBind" + _userId];
               }
               if(_loc6_.data["worldBossBuyBuffUseBind" + _userId] != undefined)
               {
                  worldBossBuyBuffUseBind = _loc6_.data["worldBossBuyBuffUseBind" + _userId];
               }
               if(_loc6_.data["petNormalAdvanceUseBind" + _userId] != undefined)
               {
                  petNormalAdvanceUseBind = _loc6_.data["petNormalAdvanceUseBind" + _userId];
               }
               if(_loc6_.data["petSeniorAdvancedUseBind;" + _userId] != undefined)
               {
                  petSeniorAdvancedUseBind = _loc6_.data["petSeniorAdvancedUseBind;" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheck1" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheck1 = _loc6_.data["petadvanceWillbeBindCheck1" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheck2" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheck2 = _loc6_.data["petadvanceWillbeBindCheck2" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheck3" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheck3 = _loc6_.data["petadvanceWillbeBindCheck3" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheck4" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheck4 = _loc6_.data["petadvanceWillbeBindCheck4" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheck5" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheck5 = _loc6_.data["petadvanceWillbeBindCheck5" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheck6" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheck6 = _loc6_.data["petadvanceWillbeBindCheck6" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheckDate1" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheckDate1 = _loc6_.data["petadvanceWillbeBindCheckDate1" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheckDate2" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheckDate2 = _loc6_.data["petadvanceWillbeBindCheckDate2" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheckDate3" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheckDate3 = _loc6_.data["petadvanceWillbeBindCheckDate3" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheckDate4" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheckDate4 = _loc6_.data["petadvanceWillbeBindCheckDate4" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheckDate5" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheckDate5 = _loc6_.data["petadvanceWillbeBindCheckDate5" + _userId];
               }
               if(_loc6_.data["petadvanceWillbeBindCheckDate6" + _userId] != undefined)
               {
                  petadvanceWillbeBindCheckDate6 = _loc6_.data["petadvanceWillbeBindCheckDate6" + _userId];
               }
               if(_loc6_.data["buyPetChallengeCountDate" + _userId] != undefined)
               {
                  buyPetChallengeCountDate = _loc6_.data["buyPetChallengeCountDate" + _userId] as Date;
               }
               if(_loc6_.data["buyPetChallengeCountDate2" + _userId] != undefined)
               {
                  buyPetChallengeCountDate2 = _loc6_.data["buyPetChallengeCountDate2" + _userId] as Date;
               }
               if(_loc6_.data["expendCrystal" + _userId] != undefined)
               {
                  expendCrystal = _loc6_.data["expendCrystal" + _userId];
               }
               if(_loc6_.data["expendCrystalAlertDate" + _userId] != undefined)
               {
                  expendCrystalCheckDate = _loc6_.data["expendCrystalAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["todayFullScreenBtnShine" + _userId] != undefined)
               {
                  todayFullScreenBtnShine = _loc6_.data["todayFullScreenBtnShine" + _userId];
               }
               if(_loc6_.data["currentTreasureMapId" + _userId] != undefined)
               {
                  currentTreasureMapId = _loc6_.data["currentTreasureMapId" + _userId];
               }
               if(_loc6_.data["isUsedTreaSureMap" + _userId] != undefined)
               {
                  isUsedTreaSureMap = _loc6_.data["isUsedTreaSureMap" + _userId];
               }
               if(_loc6_.data["sharePetComposeBtn" + _userId] != undefined)
               {
                  sharePetComposeBtn = _loc6_.data["sharePetComposeBtn" + _userId] as Boolean;
               }
               if(_loc6_.data["singlePassBugleOpenCardUseBind" + _userId] != undefined)
               {
                  singlePassBugleOpenCardUseBind = _loc6_.data["singlePassBugleOpenCardUseBind" + _userId];
               }
               if(_loc6_.data["singlePassBugleOpenCardUseBindDate" + _userId] != undefined)
               {
                  singlePassBugleOpenCardUseBindDate = _loc6_.data["singlePassBugleOpenCardUseBindDate" + _userId];
               }
               if(_loc6_.data["fashionIdentityProgress" + _userId] != undefined)
               {
                  _fashionIdentityProgress = _loc6_.data["fashionIdentityProgress" + _userId];
               }
               if(_loc6_.data["flashPromotionBtn" + _userId] != undefined)
               {
                  _flashPromotionBtn = _loc6_.data["flashPromotionBtn" + _userId];
               }
               if(_loc6_.data["upRingNormalAlertDate" + _userId] != undefined)
               {
                  upRingNormalAlertDate = _loc6_.data["upRingNormalAlertDate" + _userId];
               }
               if(_loc6_.data["upRingNormalUseBind" + _userId] != undefined)
               {
                  upRingNormalUseBind = _loc6_.data["upRingNormalUseBind" + _userId];
               }
               if(_loc6_.data["upRingSeniorUseBind" + _userId] != undefined)
               {
                  upRingSeniorUseBind = _loc6_.data["upRingSeniorUseBind" + _userId];
               }
               if(_loc6_.data["upRingSeniorAlertDate" + _userId] != undefined)
               {
                  upRingSeniorAlertDate = _loc6_.data["upRingSeniorAlertDate" + _userId];
               }
               if(_loc6_.data["diamondTrainAlertDate" + _userId] != undefined)
               {
                  diamondTrainAlertDate = _loc6_.data["diamondTrainAlertDate" + _userId];
               }
               if(_loc6_.data["addSlotUseBind" + _userId] != undefined)
               {
                  addSlotUseBind = _loc6_.data["addSlotUseBind" + _userId];
               }
               if(_loc6_.data["addSlotUseBindDate" + _userId] != undefined)
               {
                  addSlotUseBindDate = _loc6_.data["addSlotUseBindDate" + _userId];
               }
               if(_loc6_.data["refreshGoldRoadGoods" + _userId] != undefined)
               {
                  refreshGoldRoadGoods = _loc6_.data["refreshGoldRoadGoods" + _userId];
               }
               if(_loc6_.data["diceGoldRoad" + _userId] != undefined)
               {
                  diceGoldRoad = _loc6_.data["diceGoldRoad" + _userId];
               }
               if(_loc6_.data["diceGoldRoad2" + _userId] != undefined)
               {
                  diceGoldRoad2 = _loc6_.data["diceGoldRoad2" + _userId];
               }
               if(_loc6_.data["buyGemMazeTimesAlertDate" + _userId] != undefined)
               {
                  buyGemMazeTimesAlertDate = _loc6_.data["buyGemMazeTimesAlertDate" + _userId];
               }
               if(_loc6_.data["buyGemMazeTimesUseBind" + _userId] != undefined)
               {
                  buyGemMazeTimesUseBind = _loc6_.data["buyGemMazeTimesUseBind" + _userId];
               }
               if(_loc6_.data["dungeonBuyShoesAlertDate" + _userId] != undefined)
               {
                  dungeonBuyShoesAlertDate = _loc6_.data["dungeonBuyShoesAlertDate" + _userId];
               }
               if(_loc6_.data["dungeonBuyShoesAlertDate" + _userId] != undefined)
               {
                  dungeonBuyShoesAlertDate = _loc6_.data["dungeonBuyShoesAlertDate" + _userId];
               }
               if(_loc6_.data["dungeonBuyShoesUseBind" + _userId] != undefined)
               {
                  dungeonBuyShoesUseBind = _loc6_.data["dungeonBuyShoesUseBind" + _userId];
               }
               if(_loc6_.data["dungeonBuyLifeAlertDate" + _userId] != undefined)
               {
                  dungeonBuyLifeAlertDate = _loc6_.data["dungeonBuyLifeAlertDate" + _userId];
               }
               if(_loc6_.data["dungeonRemoveCannotMoveAlertDate" + _userId] != undefined)
               {
                  dungeonRemoveCannotMoveAlertDate = _loc6_.data["dungeonRemoveCannotMoveAlertDate" + _userId];
               }
               if(_loc6_.data["dungeonRemoveCannotMoveUseBind" + _userId] != undefined)
               {
                  dungeonRemoveCannotMoveUseBind = _loc6_.data["dungeonRemoveCannotMoveUseBind" + _userId];
               }
               if(_loc6_.data["dungeonUseLifeAlertDate" + _userId] != undefined)
               {
                  dungeonUseLifeAlertDate = _loc6_.data["dungeonUseLifeAlertDate" + _userId];
               }
               if(_loc6_.data["dungeonSkipAlertDate" + _userId] != undefined)
               {
                  dungeonSkipAlertDate = _loc6_.data["dungeonSkipAlertDate" + _userId];
               }
               if(_loc6_.data["dungeonBuyRoadAlertDate" + _userId] != undefined)
               {
                  dungeonBuyRoadAlertDate = _loc6_.data["dungeonBuyRoadAlertDate" + _userId];
               }
               if(_loc6_.data["dungeonBuyRoadUseBind" + _userId] != undefined)
               {
                  dungeonBuyRoadUseBind = _loc6_.data["dungeonBuyRoadUseBind" + _userId];
               }
               if(_loc6_.data["dungeonBlackBuyAlertDate" + _userId] != undefined)
               {
                  dungeonBlackBuyAlertDate = _loc6_.data["dungeonBlackBuyAlertDate" + _userId];
               }
               if(_loc6_.data["dungeonFindAlertDate" + _userId] != undefined)
               {
                  dungeonFindAlertDate = _loc6_.data["dungeonFindAlertDate" + _userId];
               }
               if(_loc6_.data["dungeonExploreHelpFrameDate" + _userId] != undefined)
               {
                  dungeonExploreHelpFrameDate = _loc6_.data["dungeonExploreHelpFrameDate" + _userId];
               }
               if(_loc6_.data["monopolyDiceMagicBuyAlertDate" + _userId] != undefined)
               {
                  monopolyDiceMagicBuyAlertDate = _loc6_.data["monopolyDiceMagicBuyAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["monopolyDiceMagicBuyUseBind" + _userId] != undefined)
               {
                  monopolyDiceMagicBuyUseBind = _loc6_.data["monopolyDiceMagicBuyUseBind" + _userId];
               }
               if(_loc6_.data["monopolyWarFlagBuyAlertDate" + _userId] != undefined)
               {
                  monopolyWarFlagBuyAlertDate = _loc6_.data["monopolyWarFlagBuyAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["monopolyWarFlagBuyUseBind" + _userId] != undefined)
               {
                  monopolyWarFlagBuyUseBind = _loc6_.data["monopolyWarFlagBuyUseBind" + _userId];
               }
               if(_loc6_.data["refreshTargetAlertDate" + _userId] != undefined)
               {
                  refreshTargetAlertDate = _loc6_.data["refreshTargetAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["buySingleHeroCountAlertDate" + _userId] != undefined)
               {
                  buySingleHeroCountAlertDate = _loc6_.data["buySingleHeroCountAlertDate" + _userId];
               }
               if(_loc6_.data["buySingleHeroCountUseBind" + _userId] != undefined)
               {
                  buySingleHeroCountUseBind = _loc6_.data["buySingleHeroCountUseBind" + _userId];
               }
               if(_loc6_.data["planesAddEnergyAlertDate" + _userId] != undefined)
               {
                  planesAddEnergyAlertDate = _loc6_.data["planesAddEnergyAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["planesAddEnergyUseBind" + _userId] != undefined)
               {
                  planesAddEnergyUseBind = _loc6_.data["planesAddEnergyUseBind" + _userId] as Date;
               }
               if(_loc6_.data["planesFindAlertDate" + _userId] != undefined)
               {
                  planesFindAlertDate = _loc6_.data["planesFindAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["planesBuyLifeAlertDate" + _userId] != undefined)
               {
                  planesBuyLifeAlertDate = _loc6_.data["planesBuyLifeAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["planesBuyLifeUseBind" + _userId] != undefined)
               {
                  planesBuyLifeUseBind = _loc6_.data["planesBuyLifeUseBind" + _userId] as Date;
               }
               if(_loc6_.data["outercityshopFreshAlertDate" + _userId] != undefined)
               {
                  outercityshopFreshAlertDate = _loc6_.data["outercityshopFreshAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["outercityshopFreshUseBind" + _userId] != undefined)
               {
                  outercityshopFreshUseBind = _loc6_.data["outercityshopFreshUseBind" + _userId] as Boolean;
               }
               if(_loc6_.data["upgradeTalentUseBind" + _userId] != undefined)
               {
                  upgradeTalentUseBind = _loc6_.data["upgradeTalentUseBind" + _userId] as Boolean;
               }
               if(_loc6_.data["armyViewReviveAlertDate" + _userId] != undefined)
               {
                  armyViewReviveAlertDate = _loc6_.data["armyViewReviveAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["armyViewReviveUseBind" + _userId] != undefined)
               {
                  armyViewReviveUseBind = _loc6_.data["armyViewReviveUseBind" + _userId] as Date;
               }
               if(_loc6_.data["planesWarBlackBuyAlertDate" + _userId] != undefined)
               {
                  planesWarBlackBuyAlertDate = _loc6_.data["planesWarBlackBuyAlertDate" + _userId] as Date;
               }
               if(_loc6_.data["petBossTeamDate" + _userId] != undefined)
               {
                  petBossTeamDate = _loc6_.data["petBossTeamDate" + _userId] as Date;
               }
               if(_loc6_.data["autoStarCostGold" + _userId] != undefined)
               {
                  autoStarCostGold = _loc6_.data["autoStarCostGold" + _userId];
               }
               if(_loc6_.data["autoStarSell" + _userId] != undefined)
               {
                  autoStarSell = _loc6_.data["autoStarSell" + _userId];
               }
               if(_loc6_.data["autoStarCompose" + _userId] != undefined)
               {
                  autoStarCompose = _loc6_.data["autoStarCompose" + _userId];
               }
               if(_loc6_.data["sacrificeRefreshNeedAlertCheckDate" + _userId] != undefined)
               {
                  sacrificeRefreshNeedAlertCheckDate = _loc6_.data["sacrificeRefreshNeedAlertCheckDate" + _userId];
               }
               if(_loc6_.data["sacrificeGetRewardAlertCheckDate" + _userId] != undefined)
               {
                  sacrificeGetRewardAlertCheckDate = _loc6_.data["sacrificeGetRewardAlertCheckDate" + _userId];
               }
               if(_loc6_.data["hideOthersInBattle" + _userId] != undefined)
               {
                  hideOthersInBattle = _loc6_.data["hideOthersInBattle" + _userId];
               }
               if(_loc6_.data["hideOthers" + _userId] != undefined)
               {
                  hideOthers = _loc6_.data["hideOthers" + _userId];
               }
               _loc3_ = new <String>["battleMountAlertDate","battleMountAdvAlertDate","hadOpenedBattleMount"];
               for each(var _loc5_:String in _loc3_)
               {
                  if(_loc6_.data.hasOwnProperty(_loc5_ + _userId))
                  {
                     this[_loc5_] = _loc6_.data[_loc5_ + _userId];
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
         finally
         {
            try
            {
               BaseManager.isMusicOn = allowMusic;
               BaseManager.isSoundOn = allowSound;
               changed();
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function saveSacrificeRefreshNeedAlertCheckDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["sacrificeRefreshNeedAlertCheckDate" + _userId] = sacrificeRefreshNeedAlertCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savesacrificeGetRewardAlertCheckDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["sacrificeGetRewardAlertCheckDate" + _userId] = sacrificeGetRewardAlertCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveWorldBossPointTodayNeedAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["worldBossPointTodayNeedAlertCheckDate" + _userId] = worldBossPointTodayNeedAlertCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveWorldBossGifttokenTodayNeedAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["worldBossGifttokenTodayNeedAlertCheckDate" + _userId] = worldBossGifttokenTodayNeedAlertCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveWorldBossRiverTodayNeedAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["worldBossRiverTodayNeedAlertDate" + _userId] = worldBossRiverTodayNeedAlertCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveWorldBossRiverTodayNeedAlertCheckDate_enterBattle() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["worldBossRiverTodayNeedAlertCheckDate_enterBattle" + _userId] = worldBossRiverTodayNeedAlertCheckDate_enterBattle;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDemonReviveTipCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["demonReviveTipCheckDate" + _userId] = demonReviveTipCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAttackCastleCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["attackCastleCheck" + _userId] = attackCastleCheck;
            _loc1_.data["attackCastleCheckDate" + _userId] = attackCastleCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAutoReplyList() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            if(LoaderSavingManager.cacheAble)
            {
               _loc1_ = SharedObject.getLocal("7road/files");
               _loc1_.data["autoReplyList" + _userId] = _autoReplyList;
               _loc1_.flush();
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public function saveActiveDic() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            if(LoaderSavingManager.cacheAble)
            {
               _loc1_ = SharedObject.getLocal("7road/files");
               _loc1_.data["activeDic" + _userId] = _activeDic;
               _loc1_.flush();
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public function savefunnyOldDic() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            if(LoaderSavingManager.cacheAble)
            {
               _loc1_ = SharedObject.getLocal("7road/files");
               _loc1_.data["funnyOldDic" + _userId] = _funnyOldDic;
               _loc1_.flush();
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public function saveIMHistory() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            if(LoaderSavingManager.cacheAble)
            {
               _loc1_ = SharedObject.getLocal("7road/files");
               _loc1_.data["imHistoryDic" + _userId] = _imHistoryDic;
               _loc1_.flush();
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public function saveThewCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["thewCheck" + _userId] = thewCheck;
            _loc1_.data["thewCheckDate" + _userId] = thewCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveQteUpgradeCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["qteUpgrade" + _userId] = qteUpgrade;
            _loc1_.data["qteUpgradeCheckDate" + _userId] = qteUpgradeCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveSecretGetBuffTipCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["secretGetBuffTip" + _userId] = secretGetBuffTip;
            _loc1_.data["secretGetBuffTipCheckDate" + _userId] = secretGetBuffTipCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveVipBoxRefreshTipCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["vipBoxRefreshTip" + _userId] = vipBoxRefreshTip;
            _loc1_.data["vipBoxRefreshTipCheckDate" + _userId] = vipBoxRefreshTipCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDemonGetBuffTipCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["demonGetBuffTip" + _userId] = demonGetBuffTip;
            _loc1_.data["demonGetBuffTipCheckDate" + _userId] = demonGetBuffTipCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveComposeTipCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["storeCompose" + _userId] = storeCompose;
            _loc1_.data["storeComposeCheckDate" + _userId] = storeComposeCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveResolveStrengthenTipCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["resolveStrengthen" + _userId] = resolveStrengthen;
            _loc1_.data["resolveStrengthenCheckDate" + _userId] = resolveStrengthenCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveSwitchTipCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["storeSwitch" + _userId] = storeSwitch;
            _loc1_.data["storeSwitchCheckDate" + _userId] = storeSwitchCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savequickInviteTipCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["quickInvite" + _userId] = quickInvite;
            _loc1_.data["quickInviteCheckDate" + _userId] = quickInviteCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveStoreRefreshBuyCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["storeRefreshBuy" + _userId] = storeRefreshBuy;
            _loc1_.data["storeRefreshBuyCheckDate" + _userId] = storeRefreshBuyCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveStoreRefreshBindingCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["storeRefreshBinding" + _userId] = storeRefreshBinding;
            _loc1_.data["storeRefreshBindingCheckDate" + _userId] = storeRefreshBindingCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetEquipStrengAutoBuyCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petEquipStrengAutoBuy" + _userId] = petEquipStrengAutoBuy;
            _loc1_.data["petEquipStrengAutoBuyCheckDate" + _userId] = petEquipStrengAutoBuyCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetEquipRefineryAutoBuyCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petEquipRefineryAutoBuy" + _userId] = petEquipRefineryAutoBuy;
            _loc1_.data["petEquipRefineryAutoBuyCheckDate" + _userId] = petEquipRefineryAutoBuyCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetEquipUpgradeAutoBuyCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petEquipUpgradeAutoBuy" + _userId] = petEquipUpgradeAutoBuy;
            _loc1_.data["petEquipUpgradeAutoBuyCheckDate" + _userId] = petEquipUpgradeAutoBuyCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveExpendCrystalCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["expendCrystal" + _userId] = expendCrystal;
            _loc1_.data["expendCrystalAlertDate" + _userId] = expendCrystalCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveMysteryShopRefreshCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveMysteryShopRefreshUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["mysteryShopRefreshUseBind" + _userId] = mysteryShopRefreshUseBind;
            _loc1_.data["mysteryShopRefreshUseBindDate" + _userId] = mysteryShopRefreshUseBindDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveOfferRewardRefreshCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["offerRewardRefresh" + _userId] = offerRewardRefresh;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveMultiFailedCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["multiFailded" + _userId] = multiFailded;
            _loc1_.data["multiFaildedCheckDate" + _userId] = multiFaildedCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function save() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["payChooseType" + _userId] = payChooseType;
            _loc1_.data["allowMusic" + _userId] = allowMusic;
            _loc1_.data["allowSound" + _userId] = allowSound;
            _loc1_.data["musicVolumn" + _userId] = musicVolumn;
            _loc1_.data["soundVolumn" + _userId] = soundVolumn;
            _loc1_.data["allowAttactedEffect" + _userId] = allowAttactedEffect;
            _loc1_.data["buildingName" + _userId] = buildingName;
            _loc1_.data["allowSceneEffect" + _userId] = allowSceneEffect;
            _loc1_.data["refuseInvitation" + _userId] = refuseInvitation;
            _loc1_.data["consortiaGroupChatShineSwitch" + _userId] = consortiaGroupChatShineSwitch;
            _loc1_.data["starQuickSellType" + _userId] = starQuickSellType;
            _loc1_.data["expBackIsSelected" + _userId] = expBackIsSelected;
            _loc1_.flush();
            changed();
         }
         catch(e:Error)
         {
         }
      }
      
      public function updateRecent(param1:Array) : void
      {
         var _loc2_:SharedObject = null;
         try
         {
            _loc2_ = SharedObject.getLocal("7road/files");
            _loc2_.data["recent" + _userId] = param1;
            _loc2_.flush(20971520);
         }
         catch(e:Error)
         {
         }
      }
      
      public function changed() : void
      {
         SoundManager.instance.setConfig(allowSound,allowMusic,musicVolumn,soundVolumn);
         if(ExternalInterface.available)
         {
            if(!allowMusic && !allowSound)
            {
               ExternalInterface.call("SetSoundBtnOff");
            }
            else
            {
               ExternalInterface.call("SetSoundBtnOn");
            }
         }
         BuildingManager.instance.isShowBuildingName = buildingName;
         dispatchEvent(new Event("change"));
      }
      
      public function saveAdvDomesticateAlert() : void
      {
         try
         {
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAdvDomesticateUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["advDomesticateUseBind" + _userId] = advDomesticateUseBind;
            _loc1_.data["advDomesticateUseBindDate" + _userId] = advDomesticateUseBindDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAdvDomesticateUseBind2() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["advDomesticateUseBind2" + _userId] = advDomesticateUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAdvDomesticateAlert2() : void
      {
         try
         {
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetAdvanceAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petAdvanceAlertDate" + _userId] = petAdvanceAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveHandInMineralAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["handInMineralDate" + _userId] = handInMineralDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveCompleteRingTaskDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["completeRingTaskDate" + _userId] = completeRingTaskDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveCompleteRingTaskUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["completeRingTaskUseBind" + _userId] = completeRingTaskUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDomesticateAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["domesticateAlertDate" + _userId] = domesticateAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDomesticate2Alert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["domesticateAlertDate2" + _userId] = domesticateAlertDate2;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePownConverAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["pownConverAlertDate" + _userId] = pownConverAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveSpecialBtnHadShine() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["specialBtnHadShine" + _userId] = specialBtnHadShine;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveTalentBtnNeedShine() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["talentBtnNeedShine" + _userId] = talentBtnNeedShine;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveFistTrail() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["isTrailFirst" + _userId] = isTrailFirst;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveFistCampaignBuff() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["isCampaignBuffFirst" + _userId] = isCampaignBuffFirst;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveLastBagSortType() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["lastBagSortType" + _userId] = lastBagSortType;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDifficultMazeBtnShine() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["difficultMazeBtnShine" + _userId] = difficultMazeBtnShine;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savefashionComposeBindsAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["fashionComposeBindsAlertDate" + _userId] = fashionComposeBindsAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savefashionComposeBindsSoulAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["fashionComposeBindsSoulAlertDate" + _userId] = fashionComposeBindsSoulAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savefashionSwitchBindsAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["fashionSwitchBindsAlertDate" + _userId] = fashionSwitchBindsAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveOpenKingContractAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["openKingContractAlertDate" + _userId] = openKingContractAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetNormalAdvanceUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petNormalAdvanceUseBind" + _userId] = petNormalAdvanceUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveUpRingNormalUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["upRingNormalUseBind" + _userId] = upRingNormalUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveUpRingSeniorUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["upRingSeniorUseBind" + _userId] = upRingSeniorUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetNormalAdvancedAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petNormalAdvancedAlertDate" + _userId] = petNormalAdvancedAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveupRingSeniorAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["upRingSeniorAlertDate" + _userId] = upRingSeniorAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveUpdiamondTrainUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["diamondTrainUseBind" + _userId] = diamondTrainUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDiamondTrainAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["diamondTrainAlertDate" + _userId] = diamondTrainAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveupRingNormalAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["upRingNormalAlertDate" + _userId] = upRingNormalAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetSeniorAdvancedUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petSeniorAdvancedUseBind;" + _userId] = petSeniorAdvancedUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetSeniorAdvancedAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petSeniorAdvancedAlertDate" + _userId] = petSeniorAdvancedAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePownConveruseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["pownConveruseBind" + _userId] = pownConveruseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveOfferRewardRefreshUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["offerRewardRefreshUseBind" + _userId] = offerRewardRefreshUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveWorldBossRiverUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["worldBossRiverUseBind" + _userId] = worldBossRiverUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveWorldBossBuyBuffUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["worldBossBuyBuffUseBind" + _userId] = worldBossBuyBuffUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetadvanceWillbeBindCheck1() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petadvanceWillbeBindCheck1" + _userId] = petadvanceWillbeBindCheck1;
            _loc1_.data["petadvanceWillbeBindCheckDate1" + _userId] = petadvanceWillbeBindCheckDate1;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetadvanceWillbeBindCheck2() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petadvanceWillbeBindCheck2" + _userId] = petadvanceWillbeBindCheck2;
            _loc1_.data["petadvanceWillbeBindCheckDate2" + _userId] = petadvanceWillbeBindCheckDate2;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetadvanceWillbeBindCheck3() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petadvanceWillbeBindCheck3" + _userId] = petadvanceWillbeBindCheck3;
            _loc1_.data["petadvanceWillbeBindCheckDate3" + _userId] = petadvanceWillbeBindCheckDate3;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetadvanceWillbeBindCheck4() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petadvanceWillbeBindCheck4" + _userId] = petadvanceWillbeBindCheck4;
            _loc1_.data["petadvanceWillbeBindCheckDate4" + _userId] = petadvanceWillbeBindCheckDate4;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetadvanceWillbeBindCheck5() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petadvanceWillbeBindCheck5" + _userId] = petadvanceWillbeBindCheck5;
            _loc1_.data["petadvanceWillbeBindCheckDate5" + _userId] = petadvanceWillbeBindCheckDate5;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePetadvanceWillbeBindCheck6() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petadvanceWillbeBindCheck6" + _userId] = petadvanceWillbeBindCheck6;
            _loc1_.data["petadvanceWillbeBindCheckDate6" + _userId] = petadvanceWillbeBindCheckDate6;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyPetChallengeCountDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["buyPetChallengeCountDate" + _userId] = buyPetChallengeCountDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyPetChallengeCountDate2() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["buyPetChallengeCountDate2" + _userId] = buyPetChallengeCountDate2;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveQuickMouseWorkDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["quickMouseWorkDate" + _userId] = quickMouseWorkDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveQuickActiveMouseWorkDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["quickActiveMouseWorkDate" + _userId] = quickActiveMouseWorkDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveTodayFullScreenBtnShine() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["todayFullScreenBtnShine" + _userId] = todayFullScreenBtnShine;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveCurrentTreasureMapId() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["currentTreasureMapId" + _userId] = currentTreasureMapId;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveIsUsedTreasureMap() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["isUsedTreaSureMap" + _userId] = isUsedTreaSureMap;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveSinglePassBugleOpenCardUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["singlePassBugleOpenCardUseBind" + _userId] = singlePassBugleOpenCardUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveSinglePassBugleOpenCardUseBindDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["singlePassBugleOpenCardUseBindDate" + _userId] = singlePassBugleOpenCardUseBindDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAdvanceTrainMountAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["advanceTrainMountAlertDate" + _userId] = advanceTrainMountAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAddSlotUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["addSlotUseBind" + _userId] = addSlotUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAddSlotUseBindDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["addSlotUseBindDate" + _userId] = addSlotUseBindDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveSharePetComposeBtn() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["sharePetComposeBtn" + _userId] = false;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function get fashionIdentityProgress() : int
      {
         return _fashionIdentityProgress;
      }
      
      public function set fashionIdentityProgress(param1:int) : void
      {
         var _loc2_:SharedObject = null;
         _fashionIdentityProgress = param1;
         try
         {
            _loc2_ = SharedObject.getLocal("7road/files");
            _loc2_.data["fashionIdentityProgress" + _userId] = _fashionIdentityProgress;
            _loc2_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function get flashPromotionBtn() : Boolean
      {
         return _flashPromotionBtn;
      }
      
      public function set flashPromotionBtn(param1:Boolean) : void
      {
         var _loc2_:SharedObject = null;
         _flashPromotionBtn = param1;
         try
         {
            _loc2_ = SharedObject.getLocal("7road/files");
            _loc2_.data["flashPromotionBtn" + _userId] = _flashPromotionBtn;
            _loc2_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyGemMazeTimesAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["buyGemMazeTimesAlertDate" + _userId] = buyGemMazeTimesAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyGemMazeTimesUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["buyGemMazeTimesUseBind" + _userId] = buyGemMazeTimesUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyDungeonShoesAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["buyDungeonShoesAlertDate" + _userId] = dungeonBuyShoesAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyDungeonShoesUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonBuyShoesUseBind" + _userId] = dungeonBuyShoesUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyDungeonLifeAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonBuyLifeAlertDate" + _userId] = dungeonBuyLifeAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyDungeonLifeUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonBuyLifeUseBind" + _userId] = dungeonBuyLifeUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveRemoveCannotMoveAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonRemoveCannotMoveAlertDate" + _userId] = dungeonRemoveCannotMoveAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveRemoveCannotMoveUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonRemoveCannotMoveUseBind" + _userId] = dungeonRemoveCannotMoveUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDungeonUseLifeAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonUseLifeAlertDate" + _userId] = dungeonUseLifeAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDungeonSkipAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonSkipAlertDate" + _userId] = dungeonSkipAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDungeonBuyRoadAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonBuyRoadAlertDate" + _userId] = dungeonBuyRoadAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savedungeonBuyRoadUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonBuyRoadUseBind" + _userId] = dungeonBuyRoadUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDungeonBlackBuyAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonBlackBuyAlertDate" + _userId] = dungeonBlackBuyAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDungeonFindAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonFindAlertDate" + _userId] = dungeonFindAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveDungeonExploreHelpFrameDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["dungeonExploreHelpFrameDate" + _userId] = dungeonExploreHelpFrameDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saverefreshGoldRoadAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["refreshGoldRoadGoods" + _userId] = refreshGoldRoadGoods;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveGameHallEastShopAlertData() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["gameHallEastShop" + _userId] = gameHallEastShop;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savereDiceAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["diceGoldRoad" + _userId] = diceGoldRoad;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savereDiceAlertDate2() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["diceGoldRoad2" + _userId] = diceGoldRoad2;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveRefreshTargetAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["refreshTargetAlertDate" + _userId] = refreshTargetAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveMonopolyDiceMagicBuyAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["monopolyDiceMagicBuyAlertDate" + _userId] = monopolyDiceMagicBuyAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveMonopolyDiceMagicBuyUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["monopolyDiceMagicBuyUseBind" + _userId] = monopolyDiceMagicBuyUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveMonopolyWarFlagBuyAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["monopolyWarFlagBuyAlertDate" + _userId] = monopolyWarFlagBuyAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveMonopolyWarFlagBuyUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["monopolyWarFlagBuyUseBind" + _userId] = monopolyWarFlagBuyUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveOutercityshopFreshAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["outercityshopFreshAlertDate" + _userId] = outercityshopFreshAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveOutercityshopUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["outercityshopFreshUseBind" + _userId] = outercityshopFreshUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveUpgradeTalentUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["upgradeTalentUseBind" + _userId] = upgradeTalentUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuySingleHeroCountAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["buySingleHeroCountAlertDate" + _userId] = buySingleHeroCountAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuySingleHeroCountUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["buySingleHeroCountUseBind" + _userId] = buySingleHeroCountUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAddEnergyAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["planesAddEnergyAlertDate" + _userId] = planesAddEnergyAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveAddEnergyUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["planesAddEnergyUseBind" + _userId] = planesAddEnergyUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savePlanesFindAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["planesFindAlertDate" + _userId] = planesFindAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyLifeAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["planesBuyLifeAlertDate" + _userId] = planesBuyLifeAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBuyLifeUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["planesBuyLifeUseBind" + _userId] = planesBuyLifeUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveArmyViewReviveAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["armyViewReviveAlertDate" + _userId] = armyViewReviveAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveArmyViewReviveUseBind() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["armyViewReviveUseBind" + _userId] = armyViewReviveUseBind;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveplanesWarBlackBuyAlertDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["planesWarBlackBuyAlertDate" + _userId] = planesWarBlackBuyAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function savepetBossTeamDate() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["petBossTeamDate" + _userId] = petBossTeamDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBattleMountAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["battleMountAlertDate" + _userId] = battleMountAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveBattleMountAdvAlert() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["battleMountAdvAlertDate" + _userId] = battleMountAdvAlertDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveHadOpenedBattleMount() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["hadOpenedBattleMount" + _userId] = hadOpenedBattleMount;
            _loc1_.flush();
         }
         catch(error:Error)
         {
         }
      }
      
      public function saveSvsBeginWar() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["svsBeginWar" + _userId] = svsBeginWar;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveHideOthersInBattle() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["hideOthersInBattle" + _userId] = hideOthersInBattle;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveHideOthers() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["hideOthers" + _userId] = hideOthers;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function armoryEquipGradeCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["armoryEquipGrade" + _userId] = armoryEquipGrade;
            _loc1_.data["armoryEquipGradeCheckDate" + _userId] = armoryEquipGradeCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function ancientArmoryDeleteCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["ancientArmoryDelete" + _userId] = ancientArmoryDelete;
            _loc1_.data["ancientArmoryDeleteCheckDate" + _userId] = ancientArmoryDeleteCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function guildWantedRefreshStarCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["guildWantedRefreshStar" + _userId] = guildWantedRefreshStar;
            _loc1_.data["guildWantedRefreshStarCheckDate" + _userId] = guildWantedRefreshStarCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function saveSecretwarShopRefreshCheck() : void
      {
         var _loc1_:SharedObject = null;
         try
         {
            _loc1_ = SharedObject.getLocal("7road/files");
            _loc1_.data["secretwarShopRefresh" + _userId] = secretwarShopRefresh;
            _loc1_.data["secretwarShopRefreshCheckDate" + _userId] = secretwarShopRefreshCheckDate;
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
      }
   }
}

