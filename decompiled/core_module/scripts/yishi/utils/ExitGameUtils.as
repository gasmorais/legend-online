package yishi.utils
{
   import flash.external.ExternalInterface;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.OfferRewardManager;
   import managers.PetChallengeManager;
   import managers.RemotePetManager;
   import managers.TreasureHuntManager;
   import mvc.module.buildings.BuildInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.PlayerManager;
   
   public class ExitGameUtils
   {
      
      public function ExitGameUtils()
      {
         super();
      }
      
      public function setup() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("getUnfinishedInfo",getUnfinishedInfo);
         }
      }
      
      public function getUnfinishedInfo() : String
      {
         var _loc3_:Array = [];
         var _loc1_:String = "";
         var _loc2_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(901);
         var _loc4_:int = _loc2_ ? _loc2_.property2 - _loc2_.property1 : 0;
         var _loc5_:int = ArmyManager.instance.thane.grades;
         _loc4_ = PlayerManager.instance.currentPlayerModel.playerInfo.weary;
         if(_loc4_ > 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.utils.ExitGameUtils.weary01",_loc4_);
            _loc3_.push(_loc1_);
         }
         _loc4_ = _loc2_ ? _loc2_.property2 - _loc2_.property1 : 0;
         if(_loc4_ > 0 && _loc5_ >= 14)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.utils.ExitGameUtils.weary06",_loc4_);
            _loc3_.push(_loc1_);
         }
         _loc4_ = DayGuideManager.instance.remainRewardCount;
         _loc4_ = OfferRewardManager.instance.model.remainRewardCount;
         if(_loc4_ > 0 && _loc5_ >= 17)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.utils.ExitGameUtils.weary05",_loc4_);
            _loc3_.push(_loc1_);
         }
         _loc4_ = PlayerManager.instance.currentPlayerModel.towerInfo1.maxEnterCount - PlayerManager.instance.currentPlayerModel.towerInfo1.enterCount;
         if(_loc4_ > 0 && _loc5_ >= 23)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.utils.ExitGameUtils.weary03",_loc4_);
            _loc3_.push(_loc1_);
         }
         _loc4_ = PlayerManager.instance.currentPlayerModel.playerInfo.multiCopyCount;
         if(_loc4_ > 0 && _loc5_ >= 20)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.utils.ExitGameUtils.weary04",_loc4_);
            _loc3_.push(_loc1_);
         }
         _loc4_ = int(PetChallengeManager.instance.model ? PetChallengeManager.instance.model.buildingOrder.remainCount : 0);
         if(_loc4_ > 0 && _loc5_ >= 50)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.utils.ExitGameUtils.weary09",_loc4_);
            _loc3_.push(_loc1_);
         }
         _loc4_ = RemotePetManager.instance.model ? (RemotePetManager.instance.model.isFrist ? 1 : 0) : 0;
         if(_loc4_ > 0 && _loc5_ >= 50)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.utils.ExitGameUtils.weary10",_loc4_);
            _loc3_.push(_loc1_);
         }
         _loc4_ = PlayerManager.instance.currentPlayerModel.playerInfo.warFieldCount;
         _loc4_ = Math.max(_loc4_,0);
         if(_loc4_ > 0 && _loc5_ >= 30)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.utils.ExitGameUtils.weary11",_loc4_);
            _loc3_.push(_loc1_);
         }
         _loc4_ = int(TreasureHuntManager.instance.model ? TreasureHuntManager.instance.model.seekCount : 0);
         if(_loc4_ > 0 && _loc5_ >= 32)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.utils.ExitGameUtils.weary12",_loc4_);
            _loc3_.push(_loc1_);
         }
         var _loc6_:String = "";
         if(_loc3_.length > 0)
         {
            _loc6_ = _loc3_.join("\r\n");
         }
         return _loc6_;
      }
   }
}

