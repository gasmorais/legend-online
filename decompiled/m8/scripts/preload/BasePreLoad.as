package preload
{
   public class BasePreLoad
   {
      
      protected var _isOver:Boolean;
      
      public function BasePreLoad()
      {
         super();
      }
      
      public function get preNode() : int
      {
         return -1;
      }
      
      public function get nextNode() : int
      {
         return -1;
      }
      
      public function load() : void
      {
      }
      
      public function get isOver() : Boolean
      {
         return _isOver;
      }
   }
}

