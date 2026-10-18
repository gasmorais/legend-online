package mvc.module.star
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class StarTroughInfo extends EventDispatcher
   {
      
      private var _userId:int;
      
      private var _type:int;
      
      private var _pos:int;
      
      private var _grade:int;
      
      private var _gp:int;
      
      private var _isFirstOpen:Boolean;
      
      public function StarTroughInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function set isFirstOpen(param1:Boolean) : void
      {
         this._isFirstOpen = param1;
      }
      
      public function get isFirstOpen() : Boolean
      {
         return _isFirstOpen;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(param1:int) : void
      {
         _userId = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function set pos(param1:int) : void
      {
         _pos = param1;
      }
      
      public function get grade() : int
      {
         return _grade;
      }
      
      public function set grade(param1:int) : void
      {
         _grade = param1;
      }
      
      public function get gp() : int
      {
         return _gp;
      }
      
      public function set gp(param1:int) : void
      {
         _gp = param1;
      }
   }
}

