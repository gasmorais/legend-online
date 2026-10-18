package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.KingbackTempInfo;
   
   public class KingbackTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function KingbackTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TempId + "";
               _dic[_loc2_] = createNode(_loc1_,KingbackTempInfo,_tempXml) as KingbackTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTempById(param1:int) : KingbackTempInfo
      {
         return _dic[param1];
      }
   }
}

