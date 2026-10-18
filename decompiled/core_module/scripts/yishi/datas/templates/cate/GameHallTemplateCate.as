package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GameHallTemplateInfo;
   
   public class GameHallTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GameHallTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : GameHallTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@GameId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,GameHallTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@GameId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,GameHallTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

