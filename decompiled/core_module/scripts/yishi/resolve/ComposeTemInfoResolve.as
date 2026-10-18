package yishi.resolve
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.utils.ClassFactory;
   
   public class ComposeTemInfoResolve extends TemplateBaseResolve
   {
      
      public function ComposeTemInfoResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:ComposeGoodsTemplete = ClassFactory.createInstanceIII(ComposeGoodsTemplete,_list[_index]);
         _dic[_loc1_.Id] = _loc1_;
         super.resolveImp();
      }
   }
}

