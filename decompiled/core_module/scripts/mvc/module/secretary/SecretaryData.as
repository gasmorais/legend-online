package mvc.module.secretary
{
   import flash.events.EventDispatcher;
   import managers.OfferRewardManager;
   import managers.PerkinLabManager;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.buildings.OfferRewardModel;
   import mvc.module.perkinlab.PerkinLabModel;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.AssistantTempInfo;
   import yishi.manager.BuildingManager;
   import yishi.manager.TempleteManager;
   
   public class SecretaryData extends EventDispatcher
   {
      
      public var type:int;
      
      public var openAward:Boolean = true;
      
      public var dixState:Boolean = true;
      
      public var tabArr:Array = [];
      
      public var allItemDatas:Array = [];
      
      public var offerNum:String;
      
      public var offerMoney:int;
      
      public var offerUsebind:Boolean = true;
      
      public var levyNum:String;
      
      public var laboratoryNum:String;
      
      public var farmNum:String;
      
      public var levyGold:String;
      
      public var GemGold:int;
      
      public function SecretaryData()
      {
         super();
      }
      
      public function getTabArr() : void
      {
         var _loc2_:Boolean = false;
         var _loc5_:SecretaryItemData = null;
         if(allItemDatas.length > 0)
         {
            return;
         }
         var _loc3_:Array = TempleteManager.instance.assistantTemplates.getallInfos();
         tabArr = [];
         for each(var _loc1_:AssistantTempInfo in _loc3_)
         {
            _loc2_ = false;
            for each(var _loc4_:AssistantTempInfo in tabArr)
            {
               if(_loc4_.MaterType == _loc1_.MaterType)
               {
                  _loc2_ = true;
                  break;
               }
            }
            if(!_loc2_)
            {
               tabArr.push(_loc1_);
            }
         }
         tabArr.sortOn("MaterType");
         for each(_loc1_ in _loc3_)
         {
            _loc5_ = new SecretaryItemData(_loc1_.SonType);
            _loc5_.masterType = _loc1_.MaterType;
            _loc5_.title = _loc1_.RoleName;
            _loc5_.type = _loc1_.SonType;
            allItemDatas.push(_loc5_);
         }
         allItemDatas.sortOn("type");
      }
      
      public function setItemState() : void
      {
         for each(var _loc1_:SecretaryItemData in allItemDatas)
         {
            _loc1_.state = true;
         }
      }
      
      public function toTabGetDataArr(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:SecretaryItemData in allItemDatas)
         {
            if(param1 == _loc3_.masterType)
            {
               _loc3_.initData(_loc3_.type);
               if(_loc3_.isOpen)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getofferInfo() : void
      {
         offerMoney = int(TempleteManager.instance.getConfigInfoByConfigName("Reward_OneKey").ConfigValue);
         offerNum = String(rewardModel.remainRewardCount) + " / " + String(rewardModel.maxRewardCount);
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      public function getCityInfo() : void
      {
         var _loc4_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(901);
         levyNum = _loc4_.property2 - _loc4_.property1 + " / " + _loc4_.property2;
         var _loc1_:int = _loc4_.templeteInfo.Property1 * 6;
         var _loc3_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(101);
         if(_loc3_)
         {
            _loc1_ += _loc3_.templeteInfo.Property1 * 3;
         }
         levyGold = _loc1_ * (_loc4_.property2 - _loc4_.property1) + "";
         var _loc2_:int = ConfigInfoManager.instance.getPerkibnRobMaxCount();
         laboratoryNum = _loc2_ - model.robCount + " / " + _loc2_;
      }
      
      private function get model() : PerkinLabModel
      {
         return PerkinLabManager.instance.model;
      }
      
      public function getmazeMoney(param1:int, param2:int = 1) : int
      {
         var _loc3_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(208008);
         if(param1 == 2)
         {
            return _loc3_.price;
         }
         if(param1 == 3)
         {
            return _loc3_.price * param2;
         }
         _loc3_ = TempleteManager.instance.getShopTempInfoByItemId(208037);
         if(param1 == 4)
         {
            return _loc3_.price * param2;
         }
         return 0;
      }
   }
}

