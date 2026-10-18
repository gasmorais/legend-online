package mvc.module.wishpool
{
   import flash.utils.Dictionary;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class WishPoolModel
   {
      
      public var refreshPrice:int;
      
      public var wishOnePrice:int;
      
      public var countDown:int;
      
      public var wishResult:Boolean;
      
      public var leftScore:int;
      
      public var startDate:Date;
      
      public var endDate:Date;
      
      public var wishPoolIsOpen:Boolean;
      
      private var _totalWishDic:Dictionary;
      
      private var _totalWishArray:Array;
      
      private var _wishpoolArray:Array;
      
      private var _successWishArray:Array;
      
      private var _selectedWishArray:Array = [];
      
      private var _totalShopArray:Array = [];
      
      public function WishPoolModel()
      {
         super();
      }
      
      public function get totalWishArray() : Array
      {
         return _totalWishArray;
      }
      
      public function set totalWishArray(param1:Array) : void
      {
         _totalWishArray = param1;
      }
      
      public function get totalShopArray() : Array
      {
         return _totalShopArray;
      }
      
      public function set totalShopArray(param1:Array) : void
      {
         _totalShopArray = param1;
      }
      
      public function get selectedWishArray() : Array
      {
         return _selectedWishArray;
      }
      
      public function set selectedWishArray(param1:Array) : void
      {
         _selectedWishArray = param1;
      }
      
      public function get successWishArray() : Array
      {
         return _successWishArray;
      }
      
      public function set successWishArray(param1:Array) : void
      {
         _successWishArray = param1;
      }
      
      public function get wishpoolArray() : Array
      {
         return _wishpoolArray;
      }
      
      public function set wishpoolArray(param1:Array) : void
      {
         _wishpoolArray = param1;
      }
      
      public function get totalWishDic() : Dictionary
      {
         return _totalWishDic;
      }
      
      public function set totalWishDic(param1:Dictionary) : void
      {
         _totalWishDic = param1;
      }
      
      public function isInActiveTime() : Boolean
      {
         var _loc1_:Boolean = false;
         if(startDate && endDate)
         {
            if(startDate.time <= playerModel.sysCurtime.time && playerModel.sysCurtime.time <= endDate.time)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

