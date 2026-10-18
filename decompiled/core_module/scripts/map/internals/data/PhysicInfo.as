package map.internals.data
{
   import flash.events.EventDispatcher;
   
   public class PhysicInfo extends EventDispatcher
   {
      
      public var id:int;
      
      public var mapId:int;
      
      public var grade:int;
      
      public var vipCastleView:int;
      
      public var vipType:int;
      
      public var posX:int;
      
      public var posY:int;
      
      public var types:int;
      
      public var names:String;
      
      public var descrption:String;
      
      private var _state:int;
      
      public var canOccupied:Boolean;
      
      public var occupyPlayerId:int;
      
      public var occupyPlayerName:String;
      
      public var occupyLeagueName:String;
      
      public var crystalsYield:int;
      
      public var goldYield:int;
      
      public var op:int;
      
      public var bossType:int;
      
      public var size:int;
      
      public function PhysicInfo()
      {
         super();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         this.dispatchEvent(new PhysicsEvent("UP_STATE",param1));
      }
   }
}

