package battle.skillsys.mode
{
   import battle.skillsys.mode.framedata.SkillFrameData;
   
   public class ActionTemplateData
   {
      
      public var ActionId:int;
      
      public var ActionName:String;
      
      private var _presentType:int = -1;
      
      public var frames:Vector.<SkillFrameData>;
      
      public var dannyCountForTest:int;
      
      public var shootTime:int;
      
      public function ActionTemplateData()
      {
         super();
         frames = new Vector.<SkillFrameData>();
      }
      
      public function get presentType() : int
      {
         if(_presentType == -1)
         {
            for each(var _loc1_:SkillFrameData in frames)
            {
               if(_loc1_.ActionType == 11 || _loc1_.ActionType == 12)
               {
                  _presentType = 2;
                  break;
               }
               _presentType = 1;
            }
         }
         return _presentType;
      }
      
      public function getMoveForwardData(param1:int) : SkillFrameData
      {
         for each(var _loc2_:SkillFrameData in frames)
         {
            if(_loc2_.moveForwardData != null && _loc2_.Sex == param1)
            {
               return _loc2_;
            }
         }
         if(param1 != 2)
         {
            return getMoveForwardData(2);
         }
         return null;
      }
      
      public function getMoveBackData(param1:int) : SkillFrameData
      {
         for each(var _loc2_:SkillFrameData in frames)
         {
            if(_loc2_.moveBackData != null && _loc2_.Sex == param1)
            {
               return _loc2_;
            }
         }
         if(param1 != 2)
         {
            return getMoveBackData(2);
         }
         return null;
      }
      
      public function refreshMembers() : void
      {
         var _loc4_:SkillFrameData = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < frames.length)
         {
            _loc4_ = frames[_loc3_];
            if(_loc4_.ActionType == 3)
            {
               if(_loc4_.Sex == 2)
               {
                  _loc4_.effectData.count = _loc2_;
                  _loc2_++;
                  _loc1_++;
               }
               else if(_loc4_.Sex == 0)
               {
                  _loc4_.effectData.count = _loc2_;
                  _loc2_++;
               }
               else if(_loc4_.Sex == 1)
               {
                  _loc4_.effectData.count = _loc1_;
                  _loc1_++;
               }
            }
            else if(_loc4_.ActionType == 11 || _loc4_.ActionType == 12)
            {
               shootTime = shootTime + 1;
               if(_loc4_.Sex == 0)
               {
                  shootTime = shootTime - 1;
               }
            }
            _loc3_++;
         }
         dannyCountForTest = _loc2_;
      }
      
      public function getRes(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:SkillFrameData in frames)
         {
            if(_loc3_.Sex == 2 || _loc3_.Sex == param1 || param1 == 3)
            {
               _loc2_ = _loc2_.concat(_loc3_.getRes());
            }
         }
         return _loc2_;
      }
      
      public function getCompleteFrameIndex() : int
      {
         for each(var _loc1_:SkillFrameData in frames)
         {
            if(_loc1_.ActionType == 99)
            {
               return _loc1_.Frame;
            }
         }
         return 0;
      }
   }
}

