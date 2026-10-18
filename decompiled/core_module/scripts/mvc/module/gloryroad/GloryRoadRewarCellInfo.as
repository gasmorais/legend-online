package mvc.module.gloryroad
{
   import managers.GloryroadManager;
   
   public class GloryRoadRewarCellInfo
   {
      
      public var items:Array = [];
      
      public var grade:int;
      
      public var haveOpenAmount:int;
      
      public function GloryRoadRewarCellInfo()
      {
         super();
      }
      
      public function getLeftOpenAmount() : int
      {
         return 10 - haveOpenAmount;
      }
      
      public function get isCanOpen() : Boolean
      {
         return haveOpenAmount < 10;
      }
      
      public function get onePay() : int
      {
         if(!isCanOpen)
         {
            return 0;
         }
         return GloryroadManager.instance.model.getConfig().openBoxPoint;
      }
      
      public function get allPay() : int
      {
         var _loc1_:int = GloryroadManager.instance.model.getConfig().openBoxPoint;
         return getLeftOpenAmount() * _loc1_;
      }
   }
}

