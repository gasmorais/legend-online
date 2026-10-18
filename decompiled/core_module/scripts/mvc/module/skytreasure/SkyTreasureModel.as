package mvc.module.skytreasure
{
   import mvc.module.skytreasure.info.SkyTreasurePlayerVO;
   import mvc.module.skytreasure.info.SkyTreasureRewardInfoVO;
   
   public class SkyTreasureModel
   {
      
      private static var _instance:SkyTreasureModel;
      
      public var joinInfoVO:SkyTreasurePlayerVO = new SkyTreasurePlayerVO();
      
      private var _ranRewardsList:Vector.<SkyTreasureRewardInfoVO> = new Vector.<SkyTreasureRewardInfoVO>();
      
      private var _chargeRewardList:Vector.<SkyTreasureRewardInfoVO> = new Vector.<SkyTreasureRewardInfoVO>();
      
      private var _rankList:Array = [];
      
      private var _chargeRewardsListTemplateIdArray:Array = [];
      
      private var _rankRewardsListTemplateIdArray:Array = [];
      
      private var _chargeRewardsListCountArray:Array = [];
      
      private var _rankRewardsListCountArray:Array = [];
      
      private var _bagRewardsList:Array = [];
      
      public function SkyTreasureModel()
      {
         super();
      }
      
      public function get instance() : SkyTreasureModel
      {
         if(_instance == null)
         {
            _instance = new SkyTreasureModel();
         }
         return _instance;
      }
      
      public function get chargeRewardList() : Vector.<SkyTreasureRewardInfoVO>
      {
         return _chargeRewardList;
      }
      
      public function set chargeRewardList(param1:Vector.<SkyTreasureRewardInfoVO>) : void
      {
         if(_chargeRewardList == param1)
         {
            return;
         }
         _chargeRewardList = param1;
      }
      
      public function get chargeRewardsListTemplateIdArray() : Array
      {
         return _chargeRewardsListTemplateIdArray;
      }
      
      public function set chargeRewardsListTemplateIdArray(param1:Array) : void
      {
         if(_chargeRewardsListTemplateIdArray == param1)
         {
            return;
         }
         _chargeRewardsListTemplateIdArray = param1;
      }
      
      public function get rankRewardsListTemplateIdArray() : Array
      {
         return _rankRewardsListTemplateIdArray;
      }
      
      public function set rankRewardsListTemplateIdArray(param1:Array) : void
      {
         if(_rankRewardsListTemplateIdArray == param1)
         {
            return;
         }
         _rankRewardsListTemplateIdArray = param1;
      }
      
      public function get rankList() : Array
      {
         return _rankList;
      }
      
      public function set rankList(param1:Array) : void
      {
         if(_rankList == param1)
         {
            return;
         }
         _rankList = param1;
      }
      
      public function get chargeRewardsListCountArray() : Array
      {
         return _chargeRewardsListCountArray;
      }
      
      public function set chargeRewardsListCountArray(param1:Array) : void
      {
         if(_chargeRewardsListCountArray == param1)
         {
            return;
         }
         _chargeRewardsListCountArray = param1;
      }
      
      public function get rankRewardsListCountArray() : Array
      {
         return _rankRewardsListCountArray;
      }
      
      public function set rankRewardsListCountArray(param1:Array) : void
      {
         if(_rankRewardsListCountArray == param1)
         {
            return;
         }
         _rankRewardsListCountArray = param1;
      }
      
      public function get bagRewardsList() : Array
      {
         return _bagRewardsList;
      }
      
      public function set bagRewardsList(param1:Array) : void
      {
         if(_bagRewardsList == param1)
         {
            return;
         }
         _bagRewardsList = param1;
      }
      
      public function get ranRewardsList() : Vector.<SkyTreasureRewardInfoVO>
      {
         return _ranRewardsList;
      }
      
      public function set ranRewardsList(param1:Vector.<SkyTreasureRewardInfoVO>) : void
      {
         if(_ranRewardsList == param1)
         {
            return;
         }
         _ranRewardsList = param1;
      }
   }
}

