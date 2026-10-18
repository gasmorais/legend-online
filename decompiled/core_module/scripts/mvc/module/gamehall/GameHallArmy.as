package mvc.module.gamehall
{
   import events.GameHallEvent;
   import mvc.module.armyII.SystemArmy;
   
   public class GameHallArmy extends SystemArmy
   {
      
      public var angle:Number = -1;
      
      private var _isPrepare:Boolean = false;
      
      private var _online:Boolean = true;
      
      public function GameHallArmy()
      {
         super();
      }
      
      public function get isPrepare() : Boolean
      {
         return _isPrepare;
      }
      
      public function set isPrepare(param1:Boolean) : void
      {
         if(_isPrepare == param1)
         {
            return;
         }
         _isPrepare = param1;
         this.dispatchEvent(new GameHallEvent("PREPARE_STATE",this));
      }
      
      public function get online() : Boolean
      {
         return _online;
      }
      
      public function set online(param1:Boolean) : void
      {
         if(_online == param1)
         {
            return;
         }
         _online = param1;
         this.dispatchEvent(new GameHallEvent("ONLINE_STATE",this));
      }
   }
}

