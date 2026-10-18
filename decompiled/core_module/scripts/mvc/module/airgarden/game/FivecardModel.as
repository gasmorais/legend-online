package mvc.module.airgarden.game
{
   import yishi.utils.HashMap;
   
   public class FivecardModel
   {
      
      public var curTurn:int;
      
      public var score:int;
      
      public var addScore:int;
      
      public var pokers:HashMap;
      
      public var holdList:Array;
      
      public function FivecardModel()
      {
         super();
      }
      
      public function updatePokers(param1:Array) : void
      {
         var _loc3_:FivecardData = null;
         var _loc2_:int = 0;
         pokers = new HashMap();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new FivecardData(param1[_loc2_]);
            pokers.put(_loc3_.index,_loc3_);
            _loc2_++;
         }
      }
   }
}

