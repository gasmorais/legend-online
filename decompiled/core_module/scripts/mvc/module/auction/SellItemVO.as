package mvc.module.auction
{
   public class SellItemVO
   {
      
      public static const GOODS:int = 1;
      
      public static const PET:int = 2;
      
      public var itemId:int;
      
      public var itemPos:int;
      
      public var count:int;
      
      public var point:int;
      
      public var fixPoint:int;
      
      public var hour:int;
      
      public var templateId:int;
      
      public var itemType:int = 1;
      
      public var bagType:int = 1;
      
      public function SellItemVO()
      {
         super();
      }
   }
}

