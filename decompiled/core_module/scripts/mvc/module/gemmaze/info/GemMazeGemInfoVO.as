package mvc.module.gemmaze.info
{
   public class GemMazeGemInfoVO
   {
      
      private var _index:int;
      
      private var _type:int;
      
      public var isRemove:Boolean = false;
      
      public var isAdd:Boolean = false;
      
      public var isMove:Boolean = false;
      
      public var nextIndex:int;
      
      public function GemMazeGemInfoVO()
      {
         super();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
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

