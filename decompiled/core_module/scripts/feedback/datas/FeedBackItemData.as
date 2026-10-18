package feedback.datas
{
   public class FeedBackItemData
   {
      
      public var id:String;
      
      public var order:int;
      
      public var point:int;
      
      public var price:int;
      
      public var goodsId1:int;
      
      public var count1:int;
      
      public var goodsId2:int;
      
      public var count2:int;
      
      public var goodsId3:int;
      
      public var count3:int;
      
      public var goodsId4:int;
      
      public var count4:int;
      
      public var goodsId5:int;
      
      public var count5:int;
      
      public var goodsId6:int;
      
      public var count6:int;
      
      public var goodsId7:int;
      
      public var count7:int;
      
      public var goodsId8:int;
      
      public var count8:int;
      
      public var state:Boolean;
      
      public function FeedBackItemData()
      {
         super();
      }
      
      public function getGoodsIdByIndex(param1:int) : int
      {
         switch(param1 - 1)
         {
            case 0:
               return goodsId1;
            case 1:
               return goodsId2;
            case 2:
               return goodsId3;
            case 3:
               return goodsId4;
            case 4:
               return goodsId5;
            case 5:
               return goodsId6;
            case 6:
               return goodsId7;
            case 7:
               return goodsId8;
            default:
               return 0;
         }
      }
      
      public function getGoodsCountByIndex(param1:int) : int
      {
         switch(param1 - 1)
         {
            case 0:
               return count1;
            case 1:
               return count2;
            case 2:
               return count3;
            case 3:
               return count4;
            case 4:
               return count5;
            case 5:
               return count6;
            case 6:
               return count7;
            case 7:
               return count8;
            default:
               return 0;
         }
      }
   }
}

