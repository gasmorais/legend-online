package map.internals.data
{
   import chat.datas.ChatData;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import map.internals.constant.MapGrid;
   import map.internals.event.OuterCityEvent;
   
   public class MapPhysics extends EventDispatcher
   {
      
      protected var _info:PhysicInfo;
      
      public var visitState:int;
      
      private var _chatData:ChatData;
      
      public var nodeView:Sprite;
      
      private var _convertX:int;
      
      private var _convertY:int;
      
      private var _x:int;
      
      private var _y:int;
      
      public function MapPhysics()
      {
         super();
      }
      
      public function get chatData() : ChatData
      {
         return _chatData;
      }
      
      public function set chatData(param1:ChatData) : void
      {
         _chatData = param1;
         this.dispatchEvent(new PhysicsEvent("CHAT_DATA",_chatData));
      }
      
      public function get info() : PhysicInfo
      {
         return _info;
      }
      
      public function set info(param1:PhysicInfo) : void
      {
         _info = param1;
         _x = _info.posX * 20;
         _convertX = MapGrid.getConvertWidth(_info.posX);
         _y = _info.posY * 20;
         _convertY = MapGrid.getConvertHeight(_info.posY);
      }
      
      public function get posX() : int
      {
         return _info.posX;
      }
      
      public function get posY() : int
      {
         return _info.posY;
      }
      
      public function get convertX() : int
      {
         return _convertX;
      }
      
      public function move(param1:int, param2:int) : void
      {
         _info.posX = param1;
         _info.posY = param2;
         _x = _info.posX * 20;
         _convertX = MapGrid.getConvertWidth(_info.posX);
         _y = _info.posY * 20;
         _convertY = MapGrid.getConvertHeight(_info.posY);
         this.dispatchEvent(new PhysicsEvent("MOVE_POS",_chatData));
      }
      
      public function get convertY() : int
      {
         return _convertY;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function set nodeViewVisible(param1:Boolean) : void
      {
         nodeView.visible = param1;
         nodeView.mouseEnabled = param1;
      }
      
      public function get nodeViewVisible() : Boolean
      {
         return nodeView.visible;
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new OuterCityEvent("UPDATA_MAP_PHYSICS",this));
      }
   }
}

