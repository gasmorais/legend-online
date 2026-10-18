package yishi.resolve
{
   import battle.skillsys.mode.ActionTemplateData;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import battle.skillsys.transform.SkillFrameDataTransform;
   import flash.utils.Dictionary;
   
   public class ActionTemplateInfoResolveII extends TemplateBaseResolve
   {
      
      public function ActionTemplateInfoResolveII(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      private static function createFrameData(param1:XML) : SkillFrameData
      {
         var _loc2_:SkillFrameData = new SkillFrameData();
         _loc2_.ActionType = param1.@ActionType;
         _loc2_.Frame = param1.@Frame;
         _loc2_.Frame2 = param1.@Frame;
         _loc2_.Sex = param1.@Sex;
         SkillFrameDataTransform.transformStringToFrameData(_loc2_,param1.@Para);
         return _loc2_;
      }
      
      override public function resolveImp() : void
      {
         var _loc2_:ActionTemplateData = null;
         var _loc3_:int = 0;
         var _loc1_:XML = _list[_index];
         _loc3_ = int(_loc1_.@ActionId);
         _loc2_ = _dic[_loc3_];
         if(!_loc2_)
         {
            _loc2_ = _dic[_loc3_] = new ActionTemplateData();
            _loc2_.ActionId = _loc3_;
         }
         _loc2_.frames.push(createFrameData(_loc1_));
         super.resolveImp();
      }
   }
}

