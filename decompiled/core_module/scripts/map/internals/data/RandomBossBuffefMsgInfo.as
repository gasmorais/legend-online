package map.internals.data
{
   public class RandomBossBuffefMsgInfo
   {
      
      public var turn:int;
      
      private var _buffs:Array;
      
      public function RandomBossBuffefMsgInfo()
      {
         super();
         buffs = [];
      }
      
      public function get buffs() : Array
      {
         return _buffs;
      }
      
      public function set buffs(param1:Array) : void
      {
         _buffs = param1;
      }
   }
}

