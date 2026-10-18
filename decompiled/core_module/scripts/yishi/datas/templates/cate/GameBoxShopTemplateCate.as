package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GameBoxShopTempInfo;
   
   public class GameBoxShopTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GameBoxShopTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,GameBoxShopTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateById(param1:int) : GameBoxShopTempInfo
      {
         var _loc2_:XML = null;
         checkFirst();
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,GameBoxShopTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

