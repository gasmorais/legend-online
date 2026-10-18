package battle.data
{
   import com.road.yishi.proto.battle.WaitReviveMsg;
   
   public class ReliveInfo
   {
      
      public var battleId:String;
      
      public var livingId:int;
      
      public var hp:int;
      
      public var sp:int;
      
      public var hitPoint:int;
      
      public function ReliveInfo()
      {
         super();
      }
      
      public static function createFromMsg(param1:WaitReviveMsg) : ReliveInfo
      {
         var _loc2_:ReliveInfo = new ReliveInfo();
         _loc2_.battleId = param1.battleId;
         _loc2_.livingId = param1.livingId;
         _loc2_.hp = param1.hp;
         _loc2_.sp = param1.sp;
         return _loc2_;
      }
   }
}

