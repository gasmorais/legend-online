package map.space.data
{
   import mvc.module.armyII.SystemArmy;
   
   public class SpaceArmy extends SystemArmy
   {
      
      public var viewState:int = -1;
      
      public var angle:Number = -1;
      
      public var isRobot:Boolean = false;
      
      public var isAdded:Boolean = false;
      
      public function SpaceArmy()
      {
         super();
      }
   }
}

