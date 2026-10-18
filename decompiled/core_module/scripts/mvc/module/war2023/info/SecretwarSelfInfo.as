package mvc.module.war2023.info
{
   public class SecretwarSelfInfo
   {
      
      public var camp:int;
      
      public var score:int;
      
      public var honor:int;
      
      private var _waitMove:Boolean;
      
      public function SecretwarSelfInfo()
      {
         super();
      }
      
      public function get waitMove() : Boolean
      {
         return _waitMove;
      }
      
      public function set waitMove(param1:Boolean) : void
      {
         _waitMove = param1;
      }
   }
}

