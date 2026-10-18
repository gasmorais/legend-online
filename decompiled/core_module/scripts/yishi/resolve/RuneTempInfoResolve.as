package yishi.resolve
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.utils.ClassFactory;
   
   public class RuneTempInfoResolve extends TemplateBaseResolve
   {
      
      public function RuneTempInfoResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:RuneTemplateInfo = ClassFactory.createInstanceIII(RuneTemplateInfo,_list[_index]);
         _dic[_loc1_.TemplateId] = _loc1_;
         super.resolveImp();
      }
   }
}

