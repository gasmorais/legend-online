package yishi.resolve
{
   import flash.utils.Dictionary;
   import mvc.module.emailII.EmailInfo;
   import yishi.utils.ClassFactory;
   
   public class EmailInfoResolve extends TemplateBaseResolve
   {
      
      public function EmailInfoResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:EmailInfo = ClassFactory.createInstanceIII(EmailInfo,_list[_index]);
         _dic[_loc1_.Id] = _loc1_;
         super.resolveImp();
      }
   }
}

