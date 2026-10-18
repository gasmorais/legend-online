package battle.skillsys.mode.framedata
{
   public class SkillFrameData
   {
      
      public var Frame:int;
      
      public var Frame2:int;
      
      public var ActionType:int;
      
      public var Sex:int;
      
      public var attackLabel:String;
      
      public var effectData:EffectFrameData;
      
      public var moveForwardData:MoveFrameData;
      
      public var moveBackData:MoveFrameData;
      
      public var shootData:ShootFrameData;
      
      public var zoomData:ZoomFrameData;
      
      public var bgColorData:ColorTransformFrameData;
      
      public var bgShockData:ShockFrameData;
      
      public var displacementForward:DisplacementFrameData;
      
      public var displacementBack:DisplacementFrameData;
      
      public var hideData:HideFrameData;
      
      public function SkillFrameData()
      {
         super();
      }
      
      public function getRes() : Array
      {
         var _loc4_:IFrameData = null;
         var _loc5_:int = 0;
         var _loc1_:Array = [effectData,moveForwardData,moveBackData,shootData,zoomData,bgColorData,bgShockData,displacementForward,displacementBack,hideData];
         var _loc3_:int = int(_loc1_.length);
         var _loc2_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc1_[_loc5_] as IFrameData;
            if(_loc4_)
            {
               _loc2_ = _loc2_.concat(_loc4_.getRes());
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function clone() : SkillFrameData
      {
         var _loc1_:SkillFrameData = new SkillFrameData();
         _loc1_.ActionType = this.ActionType;
         _loc1_.Frame = this.Frame;
         _loc1_.Frame2 = this.Frame2;
         _loc1_.shootData = this.shootData;
         _loc1_.Sex = this.Sex;
         return _loc1_;
      }
   }
}

