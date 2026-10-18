package yishi.manager
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.WarframeQuiltyInfo;
   import yishi.datas.templates.cate.TemplateCate;
   
   public class TheseusEquipQualityTmpl extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusEquipQualityTmpl(param1:XMLList)
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
               _loc2_ = _loc1_.@Id + "";
               _dic[_loc2_] = createNode(_loc1_,WarframeQuiltyInfo,_tempXml) as WarframeQuiltyInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfoByIndex(param1:int, param2:int) : WarframeQuiltyInfo
      {
         for each(var _loc3_:WarframeQuiltyInfo in _dic)
         {
            if(_loc3_.TemplateId == param1 && _loc3_.Quality == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

