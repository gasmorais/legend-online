package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConsortiaCommerceShopTempInfo;
   
   public class ConsortiaCommerceShopTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var arr:Array;
      
      public function ConsortiaCommerceShopTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         arr = [];
      }
      
      public function getTemplateByID(param1:int) : ConsortiaCommerceShopTempInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@MapShopId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,ConsortiaCommerceShopTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTempArray() : Array
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@MapShopId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,ConsortiaCommerceShopTempInfo,_tempXml);
               }
               arr.push(_loc2_);
            }
         }
         return arr;
      }
   }
}

