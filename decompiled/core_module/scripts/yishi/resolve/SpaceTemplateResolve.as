package yishi.resolve
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SpaceMapNodeInfoTemplate;
   import yishi.utils.ClassFactory;
   
   public class SpaceTemplateResolve extends TemplateBaseResolve
   {
      
      public function SpaceTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:SpaceMapNodeInfoTemplate = ClassFactory.createInstanceIII(SpaceMapNodeInfoTemplate,_list[_index]);
         _dic[_loc1_.Id] = _loc1_;
         super.resolveImp();
      }
   }
}

