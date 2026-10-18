package yishi.manager
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.WarframeStrengthenInfo;
   import yishi.datas.templates.cate.TemplateCate;
   
   public class TheseusEquipStrengthenTmpl extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusEquipStrengthenTmpl(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,WarframeStrengthenInfo,_tempXml) as WarframeStrengthenInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfoByIndex(param1:int, param2:int) : WarframeStrengthenInfo
      {
         for each(var _loc3_:WarframeStrengthenInfo in _dic)
         {
            if(_loc3_.Type == param1 && _loc3_.Strengthen == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

