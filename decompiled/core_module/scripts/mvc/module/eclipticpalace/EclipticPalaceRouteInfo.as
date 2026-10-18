package mvc.module.eclipticpalace
{
   public class EclipticPalaceRouteInfo
   {
      
      public var guardJobType1:int;
      
      public var guardJobType2:int;
      
      public var skillId:int;
      
      public var bossList:Array;
      
      public function EclipticPalaceRouteInfo()
      {
         super();
         bossList = [];
      }
      
      public function getBossInfoByIndex(param1:int) : EclipticPalaceBossInfo
      {
         return bossList[param1];
      }
      
      public function get hasPass() : Boolean
      {
         for each(var _loc1_:EclipticPalaceBossInfo in bossList)
         {
            if(!_loc1_.defeated)
            {
               return false;
            }
         }
         return true;
      }
   }
}

