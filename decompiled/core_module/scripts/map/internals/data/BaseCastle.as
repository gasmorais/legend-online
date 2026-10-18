package map.internals.data
{
   import yishi.events.PlayerEvent;
   
   public class BaseCastle extends NodeMapPhysics
   {
      
      private var _defenceLeftTime:int;
      
      public function BaseCastle()
      {
         super();
      }
      
      public function set defenceLeftTime(param1:int) : void
      {
         if(_defenceLeftTime != param1)
         {
            _defenceLeftTime = param1;
            dispatchEvent(new PlayerEvent("CASTLE_DEFENCE_TIME",null));
         }
      }
      
      public function get defenceLeftTime() : int
      {
         return _defenceLeftTime;
      }
      
      public function get sonType() : int
      {
         var _loc1_:int = 0;
         if(info.occupyPlayerId == 0)
         {
            _loc1_ = 100;
         }
         else if(info.vipCastleView == 0)
         {
            _loc1_ = 201;
         }
         else
         {
            _loc1_ = 202;
         }
         return _loc1_;
      }
   }
}

