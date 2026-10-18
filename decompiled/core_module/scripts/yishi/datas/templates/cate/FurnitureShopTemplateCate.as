package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.FurnitureShopTemplateInfo;
   
   public class FurnitureShopTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function FurnitureShopTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : FurnitureShopTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,FurnitureShopTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[_loc1_.@Id])
               {
                  _dic[_loc1_.@Id] = createNode(_loc1_,FurnitureShopTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

