package yishi.datas.templates
{
   import yishi.resolve.TemplateBaseResolve;
   import yishi.utils.ClassFactory;
   
   public class OfferRewardConditionTemplateResolve extends TemplateBaseResolve
   {
      
      public function OfferRewardConditionTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = [];
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:OfferRewardConditionTemplate = ClassFactory.createInstanceIII(OfferRewardConditionTemplate,_list[_index]);
         _dic.push(_loc1_);
         super.resolveImp();
      }
   }
}

