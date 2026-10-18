package yishi.resolve
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import mvc.module.star.StarInfo;
   import yishi.utils.ClassFactory;
   
   public class EmainAnnexStarResolve extends TemplateBaseResolve
   {
      
      public function EmainAnnexStarResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
         _templateXml = describeType(StarInfo);
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:Object = _coder.decode(_list[_index],_obj);
         var _loc2_:StarInfo = ClassFactory.createInstanceII(StarInfo,_loc1_,_templateXml);
         _dic[_loc2_.id] = _loc2_;
         super.resolveImp();
      }
   }
}

