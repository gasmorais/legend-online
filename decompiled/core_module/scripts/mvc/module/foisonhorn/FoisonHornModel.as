package mvc.module.foisonhorn
{
   public class FoisonHornModel
   {
      
      public var isOpen:Boolean;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var rewardInfo:String;
      
      public var goodsList:Array;
      
      public var activatingList:Array;
      
      public var totalCount:int;
      
      public var openChange:Boolean = false;
      
      public function FoisonHornModel()
      {
         super();
         goodsList = [];
         activatingList = [];
      }
   }
}

