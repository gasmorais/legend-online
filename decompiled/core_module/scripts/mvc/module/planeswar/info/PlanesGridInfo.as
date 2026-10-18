package mvc.module.planeswar.info
{
   public class PlanesGridInfo
   {
      
      private var _x:int;
      
      private var _y:int;
      
      private var _eventId:int;
      
      private var _opened:Boolean;
      
      private var _occupied:Boolean;
      
      private var _index:int;
      
      public var frontBase:Boolean;
      
      public var occupyName:String;
      
      public function PlanesGridInfo()
      {
         super();
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function set x(param1:int) : void
      {
         _x = param1;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function set y(param1:int) : void
      {
         _y = param1;
      }
      
      public function get eventId() : int
      {
         return _eventId;
      }
      
      public function set eventId(param1:int) : void
      {
         _eventId = param1;
         if(_eventId == 3)
         {
            frontBase = true;
         }
      }
      
      public function get opened() : Boolean
      {
         return _opened;
      }
      
      public function set opened(param1:Boolean) : void
      {
         _opened = param1;
      }
      
      public function get occupied() : Boolean
      {
         return _occupied;
      }
      
      public function set occupied(param1:Boolean) : void
      {
         _occupied = param1;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
   }
}

