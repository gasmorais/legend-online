package yishi.resolve
{
   import flash.utils.Dictionary;
   import mvc.module.outercityshop.OuterCityShopGoodsInfo;
   import yishi.utils.ClassFactory;
   
   public class OuterCityShopTemplateResolve extends TemplateBaseResolve
   {
      
      private var _value1:Dictionary;
      
      private var _value2:Dictionary;
      
      private var _value3:Dictionary;
      
      public function OuterCityShopTemplateResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _value1 = new Dictionary();
         _value2 = new Dictionary();
         _value3 = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:OuterCityShopGoodsInfo = ClassFactory.createInstanceIII(OuterCityShopGoodsInfo,_list[_index]);
         if(_loc1_.Type == 1)
         {
            _value1[_loc1_.MapShopId] = _loc1_;
         }
         else if(_loc1_.Type == 2)
         {
            _value2[_loc1_.MapShopId] = _loc1_;
         }
         else if(_loc1_.Type == 3)
         {
            _value3[_loc1_.MapShopId] = _loc1_;
         }
         _index = _index + 1;
         if(_index == totalLength)
         {
            isComplete = true;
            _callback(_value1,_value2,_value3);
            _callback = null;
         }
      }
   }
}

