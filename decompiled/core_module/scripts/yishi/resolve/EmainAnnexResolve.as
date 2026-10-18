package yishi.resolve
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.ClassFactory;
   
   public class EmainAnnexResolve extends TemplateBaseResolve
   {
      
      public function EmainAnnexResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
         _templateXml = describeType(GoodsInfo);
      }
      
      override public function resolveImp() : void
      {
         var _loc2_:Object = _coder.decode(_list[_index],_obj);
         var _loc1_:GoodsInfo = ClassFactory.createInstanceII(GoodsInfo,_loc2_,_templateXml);
         _dic[_loc1_.id] = _loc1_;
         super.resolveImp();
      }
   }
}

