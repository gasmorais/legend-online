package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ChildAssistUpgradeTempInfo;
   
   public class ChildAssistUpgradeTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ChildAssistUpgradeTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[String(_loc1_.@Level)])
               {
                  _dic[String(_loc1_.@Level)] = createNode(_loc1_,ChildAssistUpgradeTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateByAwakeLevel(param1:int) : ChildAssistUpgradeTempInfo
      {
         var _loc3_:* = null;
         if(!_dic[param1] && _list)
         {
            _loc3_ = _list.(@Level == param1);
            var _loc9_:int = 0;
            var _loc8_:* = _loc3_;
            for each(var _loc2_:XML in _loc8_)
            {
               _dic[String(_loc2_.@Level)] = createNode(_loc2_,ChildAssistUpgradeTempInfo,_tempXml);
            }
         }
         return _dic[param1];
      }
   }
}

