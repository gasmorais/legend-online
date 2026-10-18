package mvc.module.consortia
{
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import managers.ConsortiaSocketOutManager;
   import managers.MinosManager;
   import managers.MopupManager;
   import mvc.controler.ConsortiaControler;
   import mvc.module.chesspvp.ChessPvpGroupInfo;
   import mvc.module.crossguild.CrossGuildModel;
   import mvc.module.fundVein.RewardItemInfo;
   import mvc.module.minos.MinosModel;
   import yishi.SwitchPageHelp;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConsortiaQuestTempInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.ConsortiaNewBossManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GuildWantedManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaViewHelper
   {
      
      private static var _instance:ConsortiaViewHelper;
      
      public static const SECRET:int = 1;
      
      public static const CAMPAIGN:int = 2;
      
      public static const EMEDREAM:int = 3;
      
      public static const TREASURE:int = 4;
      
      public static const CROSS_GUILD:int = 5;
      
      public static const GUILD_WANTED:int = 6;
      
      public static const NEW_BOSS:int = 0;
      
      public static const MINOS:int = -1;
      
      public static const CHESS_PVP:int = -2;
      
      public var activeList:Array;
      
      public function ConsortiaViewHelper()
      {
         super();
      }
      
      public static function get instance() : ConsortiaViewHelper
      {
         if(!_instance)
         {
            _instance = new ConsortiaViewHelper();
         }
         return _instance;
      }
      
      public function initActivityData() : void
      {
         activeList = [];
         if(VersionSwitch.CHESS_PVP)
         {
            initChesspvp();
         }
         initSecretInfo();
         initCampaignInfo();
         initEmeDreamInit();
         initTreasureInfo();
         if(VersionSwitch.CROSS_GUILD)
         {
            initCrossGuildInfo();
         }
         if(VersionSwitch.GUILD_WANTED)
         {
            initGuildWantedInfo();
         }
         if(VersionSwitch.CONSORTIA_NEW_BOSS)
         {
            initConsortiaNewBossInfo();
         }
         if(VersionSwitch.MINOS)
         {
            initMinosInfo();
         }
         activeList.sortOn("id",16);
      }
      
      public function getActivityInfoById(param1:int) : ConsortiaActivityInfo
      {
         for each(var _loc2_:ConsortiaActivityInfo in activeList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function initChesspvp() : void
      {
         var _loc1_:ConsortiaActivityInfo = new ConsortiaActivityInfo();
         _loc1_.id = -2;
         _loc1_.operatingFun = null;
         _loc1_.gotoFunction = gotoChessPvp;
         var _loc2_:ChessPvpGroupInfo = ChessPvpManager.Instance.model.selfGroupInfo;
         if(_loc2_.isSignUp)
         {
            _loc1_.promptTxt = _loc2_.beginTime;
         }
         else
         {
            _loc1_.promptTxt = LanguageMgr.GetTranslation("chesspvp.in.noJoin");
         }
         activeList.push(_loc1_);
      }
      
      private function gotoChessPvp() : void
      {
         if(!SwitchPageHelp.checkScene())
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("chesspvp");
         FrameControllerManager.instance.chessPvpCtl.setLockPreFrame("consortia","15",5,"consortiachess.ChesspvpInFrame");
      }
      
      private function initSecretInfo() : void
      {
         var _loc1_:ConsortiaActivityInfo = new ConsortiaActivityInfo();
         _loc1_.id = 1;
         _loc1_.operatingFun = null;
         _loc1_.gotoFunction = gotoSecret;
         if(model.secretInfo.secretState != 0)
         {
            _loc1_.promptTxt = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.treeisOpen");
         }
         else
         {
            _loc1_.promptTxt = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.treeIsClose");
         }
         activeList.push(_loc1_);
      }
      
      private function gotoSecret() : void
      {
         if(MopupManager.instance.model.isMopup)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01"));
            return;
         }
         if(!SwitchPageHelp.checkScene())
         {
            return;
         }
         ConsortiaSocketOutManager.sendEnterSecretLand();
      }
      
      private function initCrossGuildInfo() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:ConsortiaActivityInfo = new ConsortiaActivityInfo();
         _loc1_.id = 5;
         _loc1_.gotoFunction = openCrossGuildHandler;
         _loc1_.operatingFun = null;
         _loc1_.isEnabled = true;
         if(crossGuildModel.state == 1 && crossGuildModel.signStartTime)
         {
            _loc2_ = crossGuildModel.signStartTime.month + 1;
            _loc3_ = crossGuildModel.signStartTime.date;
            _loc1_.promptTxt = LanguageMgr.GetTranslation("ConsortiaActivityListView.crossGuildAcitveItem.text1",_loc2_,_loc3_);
         }
         else if(crossGuildModel.state == 2)
         {
            _loc1_.promptTxt = LanguageMgr.GetTranslation("ConsortiaActivityListView.crossGuildAcitveItem.text2");
         }
         else if(crossGuildModel.signType)
         {
            if(crossGuildModel.state == 3 || crossGuildModel.state == 4)
            {
               _loc1_.promptTxt = LanguageMgr.GetTranslation("toptoolbar.topBtn.crossGuild.stateText4");
            }
            else if(crossGuildModel.state == 5 || crossGuildModel.state == 6)
            {
               _loc1_.promptTxt = LanguageMgr.GetTranslation("toptoolbar.topBtn.crossGuild.stateText6");
            }
         }
         else
         {
            _loc1_.promptTxt = LanguageMgr.GetTranslation("ConsortiaActivityListView.crossGuildAcitveItem.text20");
         }
         activeList.push(_loc1_);
      }
      
      public function openCrossGuildHandler() : void
      {
         if(playerInfo.consortiaID == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.command01"));
            return;
         }
         if(crossGuildModel.signType)
         {
            if(crossGuildModel.state == 1)
            {
               FrameControllerManager.instance.openControllerByInfo("crossguild",1);
            }
            else if(crossGuildModel.state == 2)
            {
               FrameControllerManager.instance.openControllerByInfo("crossguild",2);
            }
            else if(crossGuildModel.state == 3 || crossGuildModel.state == 4 || crossGuildModel.state == 5)
            {
               FrameControllerManager.instance.openControllerByInfo("crossguild",2);
            }
            else if(crossGuildModel.state == 6)
            {
               if(crossGuildModel.signType == 0 || crossGuildModel.isBye || !crossGuildModel.isValid)
               {
                  FrameControllerManager.instance.openControllerByInfo("crossguild",2);
               }
               else
               {
                  CrossGuildManager.instance.sendCrossGuildWar(6);
               }
            }
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("crossguild",1);
         }
      }
      
      private function initEmeDreamInit() : void
      {
         var _loc1_:ConsortiaActivityInfo = new ConsortiaActivityInfo();
         _loc1_.id = 3;
         if(model.consortiaInfo.levels >= 5)
         {
            _loc1_.isEnabled = true;
            _loc1_.promptTxt = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamPromptTxt" + model.emeDreamInfo.state);
            if(consortiaControl.getRightsByIndex(1))
            {
               _loc1_.operatingLabel = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamBtnLabel01");
               _loc1_.operatingFun = operatEmeDreamHandler;
            }
            else
            {
               _loc1_.operatingLabel = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamBtnLabel02");
               _loc1_.operatingFun = openEmeDreamReward;
            }
            _loc1_.gotoFunction = gotoEmeDreamCampaign;
         }
         else
         {
            _loc1_.promptTxt = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamPromptTxt",5);
         }
         activeList.push(_loc1_);
      }
      
      private function openEmeDreamReward() : void
      {
         MsgMan.notifyObserver("OPEN_EMEDREAM_REWARD_FRAME");
      }
      
      private function operatEmeDreamHandler() : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortia",12);
      }
      
      private function gotoEmeDreamCampaign() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(model.emeDreamInfo.state != 1 && model.emeDreamInfo.state != 2)
         {
            _loc1_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamPromptTxt" + model.emeDreamInfo.state);
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!SwitchPageHelp.checkScene())
         {
            return;
         }
         if(playerInfo.consortiaBossCount >= 1)
         {
            SimpleAlertHelper.instance.data = [__gotoEmeDreamCampaignHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("mainBar.MainToolBar.prompt");
            _loc4_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamPromptTxt4");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,true,true);
         }
         else
         {
            ConsortiaSocketOutManager.enterConsortiaBoss();
         }
      }
      
      private function __gotoEmeDreamCampaignHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ConsortiaSocketOutManager.enterConsortiaBoss();
         }
      }
      
      private function initTreasureInfo() : void
      {
         var _loc1_:ConsortiaActivityInfo = new ConsortiaActivityInfo();
         _loc1_.id = 4;
         _loc1_.promptTxt = LanguageMgr.GetTranslation("Consortia.treasure.digLeftCount",model.treasureGroupInfo.leftCount);
         if(model.treasureGroupInfo.leftCount > 0 || model.treasureGroupInfo.helpLeftCount > 0)
         {
            _loc1_.isNeedJoinMc = true;
         }
         else
         {
            _loc1_.isNeedJoinMc = false;
         }
         _loc1_.operatingFun = null;
         _loc1_.gotoFunction = openTreasureFrame;
         _loc1_.redTipNum = model.treasureCount;
         activeList.push(_loc1_);
      }
      
      private function openTreasureFrame() : void
      {
         FrameControllerManager.instance.consortiaController.showTreasureFrame(7);
      }
      
      private function initMinosInfo() : void
      {
         var _loc3_:ConsortiaActivityInfo = new ConsortiaActivityInfo();
         _loc3_.id = -1;
         var _loc5_:MinosModel = MinosManager.ins.model;
         var _loc1_:int = _loc5_.cofigBaseChallenge + _loc5_.configBuyMax;
         var _loc6_:int = _loc5_.playInfo.challengeCount;
         var _loc2_:int = _loc5_.getReaNum;
         var _loc4_:int = _loc1_ - _loc6_;
         if(_loc4_ <= 0 && _loc2_ == 0)
         {
            if(_loc4_ <= 0)
            {
               _loc4_ = 0;
            }
            _loc3_.isNeedJoinMc = false;
         }
         else
         {
            _loc3_.isNeedJoinMc = true;
         }
         _loc3_.promptTxt = LanguageMgr.GetTranslation("PetChallengeSortView.leftCountText.text",_loc4_,_loc1_);
         _loc3_.redTipNum = _loc2_;
         _loc3_.operatingFun = null;
         _loc3_.gotoFunction = gotoMinos;
         activeList.push(_loc3_);
      }
      
      private function gotoMinos() : void
      {
         SwitchPageHelp.openMinosFrame();
      }
      
      private function initCampaignInfo() : void
      {
         var _loc4_:ConsortiaActivityInfo = new ConsortiaActivityInfo();
         _loc4_.id = 2;
         var _loc1_:int = FrameControllerManager.instance.guildFbController.model.configMaxFightNum;
         var _loc5_:int = FrameControllerManager.instance.guildFbController.model.currFightNum;
         var _loc2_:int = FrameControllerManager.instance.guildFbController.model.getReaNum();
         var _loc3_:int = _loc1_ - _loc5_;
         if(_loc3_ <= 0 && _loc2_ == 0)
         {
            if(_loc3_ <= 0)
            {
               _loc3_ = 0;
            }
            _loc4_.isNeedJoinMc = false;
         }
         else
         {
            _loc4_.isNeedJoinMc = true;
         }
         _loc4_.promptTxt = LanguageMgr.GetTranslation("PetChallengeSortView.leftCountText.text",_loc3_,_loc1_);
         _loc4_.redTipNum = _loc2_;
         _loc4_.operatingFun = null;
         _loc4_.gotoFunction = gotoCampaign;
         activeList.push(_loc4_);
      }
      
      private function gotoCampaign() : void
      {
         SwitchPageHelp.openGuildFbFrame();
      }
      
      private function initGuildWantedInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ConsortiaActivityInfo = new ConsortiaActivityInfo();
         _loc3_.id = 6;
         if(model.consortiaInfo.levels >= 10)
         {
            _loc1_ = 10;
            _loc2_ = GuildWantedManager.instance.model.leftCount;
            if(_loc2_ <= 0)
            {
               _loc2_ = 0;
               _loc3_.isNeedJoinMc = false;
            }
            else
            {
               _loc3_.isNeedJoinMc = true;
            }
            _loc3_.promptTxt = LanguageMgr.GetTranslation("PetChallengeSortView.leftCountText.text",_loc2_,_loc1_);
            _loc3_.gotoFunction = gotoGuildWanted;
         }
         else
         {
            _loc3_.promptTxt = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamPromptTxt",10);
         }
         activeList.push(_loc3_);
      }
      
      private function initConsortiaNewBossInfo() : void
      {
         var _loc1_:ConsortiaActivityInfo = new ConsortiaActivityInfo();
         _loc1_.id = 0;
         _loc1_.gotoFunction = openConsortiaNewBossHandler;
         _loc1_.operatingFun = null;
         _loc1_.isEnabled = true;
         var _loc3_:int = consortiaNewBossModel.maxCallCount - consortiaNewBossModel.hasCallCount;
         var _loc2_:int = consortiaNewBossModel.maxCallCount;
         if(consortiaNewBossModel.bossId > 0)
         {
            if(consortiaNewBossModel.isOver())
            {
               _loc1_.promptTxt = LanguageMgr.GetTranslation("ConsortiaViewHelper.crossGuildInfo.openConsortiaNewBossTips");
               _loc1_.operatingLabel = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamBtnLabel01");
            }
            else
            {
               _loc1_.promptTxt = LanguageMgr.GetTranslation("consortia.view.ConsortiaActivityItem.leftCountText");
            }
            _loc1_.operatingFun = operatConsortiaNewBossHandler;
         }
         else
         {
            _loc1_.promptTxt = LanguageMgr.GetTranslation("ConsortiaViewHelper.crossGuildInfo.openConsortiaNewBossTips");
            _loc1_.operatingLabel = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamBtnLabel01");
            _loc1_.operatingFun = operatConsortiaNewBossHandler;
         }
         activeList.push(_loc1_);
      }
      
      private function operatConsortiaNewBossHandler() : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortianewboss",2);
      }
      
      private function get consortiaNewBossModel() : ConsortiaNewBossModel
      {
         return ConsortiaNewBossManager.instance.model;
      }
      
      private function openConsortiaNewBossHandler() : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortianewboss",1);
      }
      
      private function gotoGuildWanted() : void
      {
         SwitchPageHelp.openGuildWantedFrame();
      }
      
      public function cleanActivityData() : void
      {
         activeList = null;
      }
      
      public function getRewardTipString(param1:ConsortiaQuestTempInfo) : String
      {
         var _loc3_:String = getRewardStr(param1.RewardItems);
         var _loc6_:String = _loc3_;
         var _loc5_:String = "";
         var _loc2_:String = "";
         var _loc4_:String = "";
         if(param1.ConsortiaActivePoint > 0)
         {
            _loc5_ = LanguageMgr.GetTranslation("ConsortiaTaskItem.rewardText.addActivePoint",param1.ConsortiaActivePoint);
            _loc6_ += "," + _loc5_;
         }
         if(param1.ConsortiaAsset > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("Consortia.ConsortiaActiveRewardItem.assetReward",param1.ConsortiaAsset);
            _loc6_ += "," + _loc2_;
         }
         if(param1.PersonReputation > 0)
         {
            _loc4_ = LanguageMgr.GetTranslation("Consortia.ConsortiaActiveRewardItem.reputationReward",param1.PersonReputation);
            _loc6_ += "," + _loc4_;
         }
         if(_loc3_ == "")
         {
            _loc6_ = _loc6_.substring(1,_loc6_.length);
         }
         return _loc6_;
      }
      
      private function getRewardStr(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc3_:RewardItemInfo = null;
         if(StringHelper.isNullOrEmpty(param1))
         {
            return "";
         }
         var _loc5_:Array = [];
         var _loc2_:Array = param1.split("|");
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc6_].split(",");
            _loc3_ = new RewardItemInfo();
            _loc3_.tempId = _loc4_[0];
            _loc3_.count = _loc4_[1];
            _loc5_.push(_loc3_);
            _loc6_++;
         }
         return GoodsHelp.getRewardDesc(_loc5_);
      }
      
      private function get consortiaControl() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get crossGuildModel() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

