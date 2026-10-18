package yishi.resolve
{
   import flash.utils.Dictionary;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.utils.ClassFactory;
   
   public class ShopGoodsInfoResolve extends TemplateBaseResolve
   {
      
      private var _value1:Dictionary;
      
      private var _value2:Dictionary;
      
      private var _value3:Dictionary;
      
      private var _value4:Dictionary;
      
      private var _value5:Dictionary;
      
      private var _value6:Dictionary;
      
      private var _value7:Dictionary;
      
      private var _value8:Dictionary;
      
      private var _value9:Dictionary;
      
      private var _value10:Dictionary;
      
      private var _value11:Dictionary;
      
      private var _value12:Dictionary;
      
      private var _value13:Dictionary;
      
      private var _value14:Dictionary;
      
      private var _value15:Dictionary;
      
      private var _value16:Dictionary;
      
      private var _value17:Dictionary;
      
      private var _value18:Dictionary;
      
      private var _value19:Dictionary;
      
      private var _value20:Dictionary;
      
      private var _value21:Dictionary;
      
      private var _value22:Dictionary;
      
      private var _value23:Dictionary;
      
      private var _value24:Dictionary;
      
      private var _value25:Dictionary;
      
      private var _value26:Dictionary;
      
      private var _value27:Dictionary;
      
      private var _value28:Dictionary;
      
      private var _value29:Dictionary;
      
      private var _value30:Dictionary;
      
      private var _value31:Dictionary;
      
      private var _value32:Dictionary;
      
      private var _value33:Dictionary;
      
      private var _value34:Dictionary;
      
      private var _value35:Dictionary;
      
      private var _value36:Dictionary;
      
      private var _value37:Dictionary;
      
      private var _value38:Dictionary;
      
      private var _value39:Dictionary;
      
      private var _value40:Dictionary;
      
      private var _value41:Dictionary;
      
      private var _value42:Dictionary;
      
      private var _value43:Dictionary;
      
      private var _value44:Dictionary;
      
      private var _value45:Dictionary;
      
      private var _value46:Dictionary;
      
      private var _value47:Dictionary;
      
      private var _value48:Dictionary;
      
      private var _value49:Dictionary;
      
      private var _value50:Dictionary;
      
      public function ShopGoodsInfoResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _value1 = new Dictionary();
         _value2 = new Dictionary();
         _value3 = new Dictionary();
         _value4 = new Dictionary();
         _value5 = new Dictionary();
         _value6 = new Dictionary();
         _value7 = new Dictionary();
         _value8 = new Dictionary();
         _value9 = new Dictionary();
         _value10 = new Dictionary();
         _value11 = new Dictionary();
         _value12 = new Dictionary();
         _value13 = new Dictionary();
         _value14 = new Dictionary();
         _value15 = new Dictionary();
         _value16 = new Dictionary();
         _value17 = new Dictionary();
         _value18 = new Dictionary();
         _value19 = new Dictionary();
         _value20 = new Dictionary();
         _value21 = new Dictionary();
         _value22 = new Dictionary();
         _value23 = new Dictionary();
         _value24 = new Dictionary();
         _value25 = new Dictionary();
         _value26 = new Dictionary();
         _value27 = new Dictionary();
         _value28 = new Dictionary();
         _value29 = new Dictionary();
         _value30 = new Dictionary();
         _value31 = new Dictionary();
         _value32 = new Dictionary();
         _value33 = new Dictionary();
         _value34 = new Dictionary();
         _value35 = new Dictionary();
         _value36 = new Dictionary();
         _value37 = new Dictionary();
         _value38 = new Dictionary();
         _value39 = new Dictionary();
         _value40 = new Dictionary();
         _value41 = new Dictionary();
         _value42 = new Dictionary();
         _value43 = new Dictionary();
         _value44 = new Dictionary();
         _value45 = new Dictionary();
         _value46 = new Dictionary();
         _value47 = new Dictionary();
         _value48 = new Dictionary();
         _value49 = new Dictionary();
         _value50 = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:ShopGoodsInfo = ClassFactory.createInstanceIII(ShopGoodsInfo,_list[_index]);
         if(_loc1_.ShopType == 1)
         {
            _value1[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 2)
         {
            _value2[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 3)
         {
            _value3[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 100)
         {
            _value4[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 4)
         {
            _value5[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 5)
         {
            _value6[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 6)
         {
            _value7[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 7)
         {
            _value9[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 10)
         {
            _value10[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 8)
         {
            _value11[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 11)
         {
            _value12[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 99)
         {
            _value8[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 13)
         {
            _value14[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 14)
         {
            _value15[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 15)
         {
            _value16[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 16)
         {
            _value17[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 17)
         {
            _value18[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 19)
         {
            _value19[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 20)
         {
            _value21[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1002)
         {
            _value22[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1004)
         {
            _value23[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1008)
         {
            _value24[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1009)
         {
            _value25[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1010)
         {
            _value26[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1011)
         {
            _value27[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1012)
         {
            _value28[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 35)
         {
            _value29[_loc1_.ItemId] = _loc1_;
         }
         else if(_loc1_.ShopType == 1013)
         {
            _value30[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1014)
         {
            _value31[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1015)
         {
            _value32[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1016)
         {
            _value33[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1017)
         {
            _value34[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1018)
         {
            _value35[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 36)
         {
            _value36[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1020)
         {
            _value37[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1021)
         {
            _value38[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1022)
         {
            _value39[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1023)
         {
            _value40[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1024)
         {
            _value41[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1027)
         {
            _value42[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 37)
         {
            _value43[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 38)
         {
            _value44[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1029)
         {
            _value45[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1030)
         {
            _value46[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1031)
         {
            _value47[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1033)
         {
            _value48[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1035)
         {
            _value49[_loc1_.Id] = _loc1_;
         }
         else if(_loc1_.ShopType == 1034)
         {
            _value50[_loc1_.Id] = _loc1_;
         }
         _loc1_.init();
         _index = _index + 1;
         if(_index == totalLength)
         {
            isComplete = true;
            _callback(_value1,_value2,_value3,_value4,_value5,_value6,_value7,_value8,_value9,_value10,_value11,_value12,_value13,_value14,_value15,_value16,_value17,_value18,_value19,_value20,_value21,_value22,_value23,_value24,_value25,_value26,_value27,_value28,_value29,_value30,_value31,_value32,_value33,_value34,_value35,_value36,_value37,_value38,_value39,_value40,_value41,_value42,_value43,_value44,_value45,_value46,_value47,_value48,_value49,_value50);
            _callback = null;
         }
      }
   }
}

