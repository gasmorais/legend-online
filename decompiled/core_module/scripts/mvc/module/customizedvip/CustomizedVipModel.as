package mvc.module.customizedvip
{
   import flash.utils.Dictionary;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.utils.SimpleDictionary;
   
   public class CustomizedVipModel
   {
      
      public var isOpen:Boolean;
      
      public var isFlicker:Boolean;
      
      public var startDate:Date;
      
      public var endDate:Date;
      
      private var _vipFreeCount:int;
      
      public var buyCountDic:Dictionary;
      
      public var boxVersion:int;
      
      public var vipBoxRewardInfo:CustomizedVipBoxInfo;
      
      public var customizedBoxDic:SimpleDictionary;
      
      public var clientBoxDic:SimpleDictionary;
      
      public var frameSelectDic:SimpleDictionary;
      
      public function CustomizedVipModel()
      {
         super();
         customizedBoxDic = new SimpleDictionary();
         clientBoxDic = new SimpleDictionary();
         frameSelectDic = new SimpleDictionary();
      }
      
      public function get isTopBtnFlicker() : Boolean
      {
         if(isFlicker)
         {
            return true;
         }
         if(vipModel.vipInfo.IsVipAndNoExpirt && vipModel.vipInfo.VipType != 2 && vipFreeCount > 0)
         {
            return true;
         }
         return false;
      }
      
      public function resloveBuyCount(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         buyCountDic = new Dictionary();
         var _loc4_:Array = param1.split("|");
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_].split(",");
            buyCountDic[_loc2_[0]] = _loc2_[1];
            _loc3_++;
         }
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      public function get vipFreeCount() : int
      {
         return _vipFreeCount;
      }
      
      public function set vipFreeCount(param1:int) : void
      {
         _vipFreeCount = param1;
         resetFlicker();
      }
      
      public function resetFlicker() : void
      {
         if(vipModel.vipInfo.IsVipAndNoExpirt && vipModel.vipInfo.VipType != 2 && vipFreeCount > 0)
         {
            isFlicker = true;
         }
         else
         {
            isFlicker = false;
         }
      }
   }
}

