package mvc.module.children
{
   import flash.utils.Dictionary;
   import mvc.module.avenger.AvengerChildNsInfo;
   
   public class NursingSpiritInfo
   {
      
      public var resiGrade:int;
      
      public var resiGp:int;
      
      public var reduceResiGrade:int;
      
      public var reduceResiGp:int;
      
      public var jobTypeA:int;
      
      public var skillA:String;
      
      public var skillBookA:String;
      
      public var jobTypeB:int;
      
      public var skillB:String;
      
      public var skillBookB:String;
      
      public var talentPoint:int;
      
      public var talentGrade:int;
      
      public var talentGp:int;
      
      private var _talentSkill:String;
      
      public var lvlIndexDic:Dictionary;
      
      public var lifeWheelInfo:NsLifeWheelInfo;
      
      public var spiritArtifactInfo:NsSpiritArtifactInfo;
      
      public var awakeGrade:int;
      
      public var awakeGp:int;
      
      public var trainInfo:AvengerChildNsInfo;
      
      public function NursingSpiritInfo()
      {
         super();
         lifeWheelInfo = new NsLifeWheelInfo();
         spiritArtifactInfo = new NsSpiritArtifactInfo();
         trainInfo = new AvengerChildNsInfo();
      }
      
      public function get talentSkill() : String
      {
         return _talentSkill;
      }
      
      public function set talentSkill(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         _talentSkill = param1;
         lvlIndexDic = new Dictionary();
         var _loc4_:Array = _talentSkill.split("|");
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_].split(",");
            lvlIndexDic[_loc2_[0]] = _loc2_[1];
            _loc3_++;
         }
      }
   }
}

