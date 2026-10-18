package yishi.datas.templates
{
   public class PlaneCrisisEventTempInfo
   {
      
      public var EventId:int;
      
      public var EventType:int;
      
      public var Property1:String;
      
      public var Property2:String;
      
      public var Property3:String;
      
      public var Property4:String;
      
      public var Property5:String;
      
      public var Description:String;
      
      public var Icon:String;
      
      private var _bossTransNum:int = -1;
      
      private var _bossAttackNum:int = -1;
      
      public function PlaneCrisisEventTempInfo()
      {
         super();
      }
      
      public function get bossTransNum() : int
      {
         var _loc1_:Array = null;
         if(_bossTransNum == -1 && Property3 != null && Property3 != "")
         {
            _loc1_ = Property3.split("|");
            if(_loc1_ != null && _loc1_.length > 0)
            {
               _bossTransNum = int(_loc1_[0]);
            }
         }
         return _bossTransNum;
      }
      
      public function get bossAttackNum() : int
      {
         var _loc1_:Array = null;
         if(_bossAttackNum == -1 && Property3 != null && Property3 != "")
         {
            _loc1_ = Property3.split("|");
            if(_loc1_ != null && _loc1_.length > 0)
            {
               _bossAttackNum = int(_loc1_[1]);
            }
         }
         return _bossAttackNum;
      }
   }
}

