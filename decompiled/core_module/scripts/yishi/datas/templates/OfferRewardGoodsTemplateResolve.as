package yishi.datas.templates
{
   import yishi.resolve.TemplateBaseResolve;
   import yishi.utils.ClassFactory;
   
   public class OfferRewardGoodsTemplateResolve extends TemplateBaseResolve
   {
      
      public function OfferRewardGoodsTemplateResolve(param1:XMLList, param2:Function)
      {
         _index = 1;
         super(param1,param2);
         _dic = [];
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:OfferRewardGoodsTemplate = ClassFactory.createInstanceIII(OfferRewardGoodsTemplate,_list[_index]);
         _dic.push(_loc1_);
         super.resolveImp();
      }
   }
}

