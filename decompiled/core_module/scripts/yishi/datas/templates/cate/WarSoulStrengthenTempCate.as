package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.WarSoulStrengthenTempInfo;
   
   public class WarSoulStrengthenTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function WarSoulStrengthenTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,WarSoulStrengthenTempInfo,_tempXml) as WarSoulStrengthenTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTemp(param1:int, param2:int) : WarSoulStrengthenTempInfo
      {
         for each(var _loc3_:WarSoulStrengthenTempInfo in _dic)
         {
            if(_loc3_.WarSoulId == param1 && _loc3_.Grades == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

