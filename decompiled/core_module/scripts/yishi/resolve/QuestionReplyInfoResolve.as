package yishi.resolve
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import mvc.module.customerService.ServiceReplyInfo;
   import yishi.utils.ClassFactory;
   
   public class QuestionReplyInfoResolve extends TemplateBaseResolve
   {
      
      public function QuestionReplyInfoResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
         _templateXml = describeType(ServiceReplyInfo);
      }
      
      override public function resolveImp() : void
      {
         var _loc2_:Object = _coder.decode(_list[_index],_obj);
         var _loc1_:ServiceReplyInfo = ClassFactory.createInstanceII(ServiceReplyInfo,_loc2_,_templateXml);
         _dic[_loc1_.questionId] = _loc1_;
         super.resolveImp();
      }
   }
}

