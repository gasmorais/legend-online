package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.NavigationShopTempInfo;
   
   public class NavigationShopTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function NavigationShopTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByShopId(param1:int) : NavigationShopTempInfo
      {
         var _loc2_:XML = null;
         if(_list && !_dic[param1])
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@ShopId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,NavigationShopTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

