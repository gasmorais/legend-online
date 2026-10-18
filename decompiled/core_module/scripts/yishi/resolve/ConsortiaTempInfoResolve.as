package yishi.resolve
{
   import flash.utils.Dictionary;
   import mvc.module.consortia.ConsortiaTemplete;
   import yishi.utils.ClassFactory;
   
   public class ConsortiaTempInfoResolve extends TemplateBaseResolve
   {
      
      public function ConsortiaTempInfoResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:ConsortiaTemplete = ClassFactory.createInstanceIII(ConsortiaTemplete,_list[_index]);
         _dic[_loc1_.TemplateId] = _loc1_;
         _dic[_loc1_.Types + "_" + _loc1_.Levels] = _loc1_;
         super.resolveImp();
      }
   }
}

