package yishi.resolve
{
   import flash.net.registerClassAlias;
   import flash.utils.Dictionary;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.ClassFactory;
   
   public class SkillTempInfoResolve extends TemplateBaseResolve
   {
      
      public function SkillTempInfoResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:SkillTempInfo = ClassFactory.createInstanceIII(SkillTempInfo,_list[_index]);
         _dic[_loc1_.TemplateId] = _loc1_;
         super.resolveImp();
      }
      
      override protected function preCache() : void
      {
         if(_cacheName == null)
         {
            _cacheName = "SkillTempInfoResolve";
            registerClassAlias("SkillTempInfo",SkillTempInfo);
         }
      }
   }
}

