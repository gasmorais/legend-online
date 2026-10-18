package mvc.module.mvpshop
{
   public class MvpShopModel
   {
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var itemList:Array;
      
      public var goodsList:Array;
      
      public var score:int;
      
      public var isOpen:Boolean;
      
      public var nextTime:Number;
      
      public var openChange:Boolean = false;
      
      public function MvpShopModel()
      {
         super();
         itemList = [];
         goodsList = [];
      }
   }
}

