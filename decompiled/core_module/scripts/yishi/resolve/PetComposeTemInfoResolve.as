package yishi.resolve
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.PetComposeGoodsTemplete;
   import yishi.utils.ClassFactory;
   
   public class PetComposeTemInfoResolve extends TemplateBaseResolve
   {
      
      public function PetComposeTemInfoResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         if(totalLength == 0)
         {
            super.resolveImp();
            return;
         }
         var _loc1_:PetComposeGoodsTemplete = ClassFactory.createInstanceIII(PetComposeGoodsTemplete,_list[_index]);
         _dic[_loc1_.TemplateId] = _loc1_;
         super.resolveImp();
      }
   }
}

