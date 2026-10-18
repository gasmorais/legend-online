package yishi.resolve
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.utils.ClassFactory;
   
   public class UpgradeTemplateResolve extends TemplateBaseResolve
   {
      
      public function UpgradeTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:UpgradeTemplateInfo = ClassFactory.createInstanceIII(UpgradeTemplateInfo,_list[_index]);
         _dic[_loc1_.Id] = _loc1_;
         super.resolveImp();
      }
   }
}

