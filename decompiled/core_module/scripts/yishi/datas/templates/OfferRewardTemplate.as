package yishi.datas.templates
{
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class OfferRewardTemplate
   {
      
      public var TemplateId:int;
      
      public var Type:int;
      
      public var Title:String;
      
      public var Detail:String;
      
      public var NeedFightId:int;
      
      public var NeedMinLevel:int;
      
      public var NeedMaxLevel:int;
      
      public var IsLeague:Boolean;
      
      public var RewardPlayGP:int;
      
      public var RewardGold:int;
      
      public var RewardStrategy:int;
      
      public var RewardHappy:int;
      
      public var StartDate:String;
      
      public var EndDate:String;
      
      public var Rands:int;
      
      public var ShowType:int;
      
      private var _rewardItemList:Array;
      
      private var _conditionList:Array;
      
      public var profile:int;
      
      public function OfferRewardTemplate()
      {
         super();
      }
      
      public function get rewardItemList() : Array
      {
         return _rewardItemList;
      }
      
      public function get conditionList() : Array
      {
         return _conditionList;
      }
      
      public function addData() : void
      {
         addRewardGoodsList();
         addRewardConditionList();
      }
      
      public function get isReachDate() : Boolean
      {
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc2_:Date = DateFormatter.parse(StartDate,"YYYY-MM-DD hh:mm:ss");
         return _loc1_.time > _loc2_.time;
      }
      
      public function get isOutDate() : Boolean
      {
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc1_:Date = DateFormatter.parse(EndDate,"YYYY-MM-DD hh:mm:ss");
         return _loc2_.time > _loc1_.time;
      }
      
      private function addRewardGoodsList() : void
      {
         if(!_rewardItemList)
         {
            _rewardItemList = [];
         }
         var _loc1_:Array = TempleteManager.instance.offerRewardGoodsTemplateList;
         for each(var _loc2_:OfferRewardGoodsTemplate in _loc1_)
         {
            if(_loc2_.TemplateId == TemplateId)
            {
               _rewardItemList.push(_loc2_);
            }
         }
      }
      
      private function addRewardConditionList() : void
      {
         if(!_conditionList)
         {
            _conditionList = [];
         }
         var _loc2_:Array = TempleteManager.instance.offerRewardConditionTemplateList;
         for each(var _loc1_:OfferRewardConditionTemplate in _loc2_)
         {
            if(_loc1_.TemplateId == TemplateId)
            {
               _conditionList.push(_loc1_);
            }
         }
      }
   }
}

