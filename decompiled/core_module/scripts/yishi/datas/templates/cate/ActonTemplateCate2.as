package yishi.datas.templates.cate
{
   import battle.skillsys.mode.ActionTemplateData;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import battle.skillsys.transform.SkillFrameDataTransform;
   import flash.utils.Dictionary;
   
   public class ActonTemplateCate2 extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      public function ActonTemplateCate2(param1:XMLList)
      {
         super(param1);
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
      
      public function getTemplateById(param1:int) : ActionTemplateData
      {
         var _loc3_:ActionTemplateData = null;
         var _loc4_:* = null;
         if(_list)
         {
            _loc3_ = _dic[param1] as ActionTemplateData;
            if(!_loc3_)
            {
               _dic[param1] = _loc3_ = new ActionTemplateData();
               _loc3_.ActionId = param1;
            }
            _loc4_ = _list.(@ActionId == param1);
            for each(var _loc2_:XML in _loc4_)
            {
               if(_loc2_.@ActionType == 3)
               {
               }
               _loc3_.frames.push(createFrameData(_loc2_));
            }
            _loc3_.refreshMembers();
         }
         return _dic[param1] as ActionTemplateData;
      }
   }
}

