package battle.data
{
   public class GameLoadNeedData
   {
      
      private var _urlPath:String;
      
      private var _defineClass:String;
      
      private var _type:int = 0;
      
      public var isSelf:Boolean;
      
      public function GameLoadNeedData(param1:String, param2:String = null, param3:int = 0)
      {
         super();
         _urlPath = param1;
         _defineClass = param2;
         _type = param3;
      }
      
      public function get urlPath() : String
      {
         return _urlPath;
      }
      
      public function get defineClass() : String
      {
         return _defineClass;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}

