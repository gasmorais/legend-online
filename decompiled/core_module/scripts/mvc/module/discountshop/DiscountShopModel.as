package mvc.module.discountshop
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class DiscountShopModel extends EventDispatcher
   {
      
      private var _id:String;
      
      private var _beginTime:String;
      
      private var _endTime:String;
      
      private var _logo:String;
      
      private var _myScore:int;
      
      private var _myDiscount:int;
      
      public var discountShopItemInfo:Vector.<DiscountShopItemInfo> = new Vector.<DiscountShopItemInfo>();
      
      public var discountShopScoreInfo:Vector.<DiscountShopScoreInfo> = new Vector.<DiscountShopScoreInfo>();
      
      public var showTopIcon:Boolean = false;
      
      public function DiscountShopModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function set id(param1:String) : void
      {
         _id = param1;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function set beginTime(param1:String) : void
      {
         _beginTime = param1;
      }
      
      public function get beginTime() : String
      {
         return _beginTime;
      }
      
      public function set endTime(param1:String) : void
      {
         _endTime = param1;
      }
      
      public function get endTime() : String
      {
         return _endTime;
      }
      
      public function set logo(param1:String) : void
      {
         _logo = param1;
      }
      
      public function get logo() : String
      {
         return _logo;
      }
      
      public function set myScore(param1:int) : void
      {
         _myScore = param1;
      }
      
      public function get myScore() : int
      {
         return _myScore;
      }
      
      public function set myDiscount(param1:int) : void
      {
         _myDiscount = param1;
      }
      
      public function get myDiscount() : int
      {
         return _myDiscount;
      }
   }
}

