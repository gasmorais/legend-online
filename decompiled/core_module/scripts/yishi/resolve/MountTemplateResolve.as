package yishi.resolve
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MountTemplate;
   import yishi.utils.ClassFactory;
   
   public class MountTemplateResolve extends TemplateBaseResolve
   {
      
      public function MountTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:MountTemplate = ClassFactory.createInstanceIII(MountTemplate,_list[_index]);
         _dic[_loc1_.TemplateId] = _loc1_;
         super.resolveImp();
      }
   }
}

