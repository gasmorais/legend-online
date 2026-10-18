package yishi.datas.templates
{
   import flash.utils.Dictionary;
   import yishi.resolve.TemplateBaseResolve;
   import yishi.utils.ClassFactory;
   
   public class OfferRewardTemplateResolve extends TemplateBaseResolve
   {
      
      public function OfferRewardTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:OfferRewardTemplate = ClassFactory.createInstanceIII(OfferRewardTemplate,_list[_index]);
         _dic[_loc1_.TemplateId] = _loc1_;
         super.resolveImp();
      }
   }
}

