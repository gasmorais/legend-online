package mvc.module.secretary
{
   import manager.LanguageMgr;
   import managers.OfferRewardManager;
   import managers.PerkinLabManager;
   import managers.SecretaryManager;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.buildings.OfferRewardModel;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.perkinlab.PerkinLabModel;
   import mvc.module.secretary.acts.ILitteAction;
   import mvc.module.secretary.acts.LittleActionFactory;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class SecretaryItemData
   {
      
      public static const TYPE_OFFICAL:int = 1;
      
      public static const TYPE_UNDERGROUNDMAZR:int = 2;
      
      public static const TYPE_ABYSSMAZE:int = 3;
      
      public static const TYPE_PURGATORYMAZR:int = 4;
      
      public static const TYPE_GEM:int = 5;
      
      public static const TYPE_LEVY:int = 6;
      
      public static const TYPE_PlatinumLaboratory:int = 7;
      
      public static const TYPE_farm:int = 8;
      
      public static const TYPE_altar:int = 9;
      
      public static const QUICK_BLESS_VIP_GRADE:int = 4;
      
      public var type:int;
      
      public var masterType:int;
      
      private var _isOpen:Boolean = true;
      
      private var _mazeCostGold:int;
      
      private var _mazeCounts:int;
      
      private var _title:String;
      
      private var _des:String;
      
      private var _state:Boolean = true;
      
      public var moneyState:Boolean = true;
      
      private var _moneyNum:int = 0;
      
      private var _goldNum:int = 0;
      
      public var moneyType:int = 0;
      
      public function SecretaryItemData(param1:int)
      {
         super();
         type = param1;
         initData(type);
         state = true;
      }
      
      public function get goldNum() : int
      {
         return _goldNum;
      }
      
      public function set goldNum(param1:int) : void
      {
         _goldNum = param1;
      }
      
      public function get isOpen() : Boolean
      {
         var _loc2_:BuildInfo = null;
         var _loc1_:int = 0;
         switch(type - 1)
         {
            case 0:
               return thane.grades >= 17 && rewardModel.remainRewardCount > 0;
            case 1:
               return playerModel.towerInfo1.maxIndex >= 10 && (playerModel.towerInfo1.enterCount < playerModel.towerInfo1.maxEnterCount && playerModel.towerInfo1.towerIndex == 0 || playerModel.towerInfo1.towerIndex != 0 && playerModel.towerInfo1.towerIndex < playerModel.towerInfo1.maxIndex);
            case 2:
               return playerModel.towerInfo2.maxIndex >= 10 && (playerModel.towerInfo2.enterCount < playerModel.towerInfo2.maxEnterCount && playerModel.towerInfo2.towerIndex == 0 || playerModel.towerInfo2.towerIndex != 0 && playerModel.towerInfo2.towerIndex < playerModel.towerInfo2.maxIndex);
            case 3:
               return playerModel.towerInfo3.maxIndex >= 10 && (playerModel.towerInfo3.enterCount < playerModel.towerInfo3.maxEnterCount && playerModel.towerInfo3.towerIndex == 0 || playerModel.towerInfo3.towerIndex != 0 && playerModel.towerInfo3.towerIndex < playerModel.towerInfo3.maxIndex);
            case 4:
               goldNum = model.GemGold;
               return thane.grades >= 15 && model.GemGold > 0;
            case 5:
               _loc2_ = BuildingManager.instance.getBuildingInfoBySonType(901);
               return thane.grades >= 11 && _loc2_.property2 - _loc2_.property1 > 0;
            case 6:
               _loc1_ = ConfigInfoManager.instance.getPerkibnRobMaxCount();
               return thane.vocationGrades > 0 && PerkinLabManager.instance.checkHasPick && _loc1_ - modelPerkin.robCount > 0;
            case 7:
               return thane.grades >= 12;
            case 8:
               return playerInfo.consortiaID != 0 && consortiaInfo.altarLevel > 0 && totalTime - model1.alTarBlessLeftTime > 0;
            default:
               return false;
         }
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
      
      public function get state() : Boolean
      {
         return _state;
      }
      
      public function set state(param1:Boolean) : void
      {
         _state = param1;
         if(type == 2)
         {
            model.dixState = param1;
         }
         MsgMan.notifyObserver("SecretaryCompentItem",type);
      }
      
      private function get modelPerkin() : PerkinLabModel
      {
         return PerkinLabManager.instance.model;
      }
      
      private function get totalTime() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,model1.consortiaInfo.altarLevel).Property2;
      }
      
      public function get moneyNum() : int
      {
         return _moneyNum;
      }
      
      public function set moneyNum(param1:int) : void
      {
         _moneyNum = param1;
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      public function initData(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:BuildInfo = null;
         var _loc2_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               model.getofferInfo();
               des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame1") + model.offerNum;
               moneyNum = int(TempleteManager.instance.getConfigInfoByConfigName("Reward_OneKey").ConfigValue);
               moneyType = 1;
               break;
            case 1:
               _mazeCostGold = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Gold").ConfigValue);
               if(playerModel.towerInfo1.towerIndex)
               {
                  _mazeCounts = playerModel.towerInfo1.maxIndex - playerModel.towerInfo1.towerIndex + 1;
               }
               else
               {
                  _mazeCounts = playerModel.towerInfo1.maxIndex;
               }
               goldNum = _mazeCostGold * _mazeCounts;
               moneyType = 2;
               if(playerModel.towerInfo1.towerIndex != 0 && playerModel.towerInfo1.towerIndex < playerModel.towerInfo1.maxIndex)
               {
                  moneyType = 0;
                  moneyNum = 0;
                  des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips11");
               }
               else
               {
                  _loc4_ = GoodsManager.instance.getGoodsNumBySonType(297);
                  if(_loc4_ > 0)
                  {
                     des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame8",1);
                     moneyType = 0;
                     moneyNum = 0;
                  }
                  else
                  {
                     des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame2",1);
                     moneyNum = model.getmazeMoney(param1,1);
                  }
               }
               break;
            case 2:
               _mazeCostGold = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Gold").ConfigValue);
               if(playerModel.towerInfo2.towerIndex)
               {
                  _mazeCounts = playerModel.towerInfo2.maxIndex - playerModel.towerInfo2.towerIndex + 1;
               }
               else
               {
                  _mazeCounts = playerModel.towerInfo2.maxIndex;
               }
               goldNum = _mazeCostGold * _mazeCounts;
               moneyType = 2;
               if(playerModel.towerInfo2.towerIndex != 0 && playerModel.towerInfo2.towerIndex < playerModel.towerInfo2.maxIndex)
               {
                  moneyType = 0;
                  moneyNum = 0;
                  des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips11");
               }
               else
               {
                  _loc4_ = GoodsManager.instance.getGoodsNumBySonType(297);
                  if(!model.dixState)
                  {
                     if(_loc4_ >= 3)
                     {
                        des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame8",3);
                        moneyType = 0;
                        moneyNum = 0;
                     }
                     else
                     {
                        des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame2",3 - _loc4_);
                        moneyNum = model.getmazeMoney(param1,3 - _loc4_);
                     }
                  }
                  else if(_loc4_ >= 4)
                  {
                     des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame8",3);
                     moneyType = 0;
                     moneyNum = 0;
                  }
                  else
                  {
                     _loc3_ = 4 - _loc4_ > 3 ? 3 : 4 - _loc4_;
                     des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame2",_loc3_);
                     moneyNum = model.getmazeMoney(param1,_loc3_);
                  }
               }
               break;
            case 3:
               _mazeCostGold = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Gold").ConfigValue);
               if(playerModel.towerInfo3.towerIndex)
               {
                  _mazeCounts = playerModel.towerInfo3.maxIndex - playerModel.towerInfo3.towerIndex + 1;
               }
               else
               {
                  _mazeCounts = playerModel.towerInfo3.maxIndex;
               }
               goldNum = _mazeCostGold * _mazeCounts;
               moneyType = 2;
               if(playerModel.towerInfo3.towerIndex != 0 && playerModel.towerInfo3.towerIndex < playerModel.towerInfo3.maxIndex)
               {
                  moneyType = 0;
                  moneyNum = 0;
                  des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips11");
               }
               else
               {
                  _loc4_ = GoodsManager.instance.getGoodsNumByTempId(208037);
                  if(_loc4_ >= 3)
                  {
                     des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame9",3);
                     moneyType = 0;
                     moneyNum = 0;
                  }
                  else
                  {
                     des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame4",3 - _loc4_);
                     moneyNum = model.getmazeMoney(param1,3 - _loc4_);
                  }
               }
               break;
            case 4:
               des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame5");
               goldNum = model.GemGold;
               moneyType = 0;
               break;
            case 5:
               model.getCityInfo();
               _loc5_ = BuildingManager.instance.getBuildingInfoBySonType(901);
               des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame6") + model.levyNum;
               break;
            case 6:
               _loc2_ = ConfigInfoManager.instance.getPerkibnRobMaxCount();
               model.getCityInfo();
               des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame7");
               break;
            case 7:
               des = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrame7");
         }
      }
      
      private function get model1() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      protected function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return ConsortiaManager.instance.model.consortiaInfo;
      }
      
      private function get model() : SecretaryData
      {
         return SecretaryManager.instance.model;
      }
      
      public function get des() : String
      {
         return _des;
      }
      
      public function set des(param1:String) : void
      {
         _des = param1;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function getAction() : ILitteAction
      {
         return LittleActionFactory.creatAction(this);
      }
   }
}

