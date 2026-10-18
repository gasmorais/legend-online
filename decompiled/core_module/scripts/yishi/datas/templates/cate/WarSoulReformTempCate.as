package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.WarSoulReformTempInfo;
   
   public class WarSoulReformTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function WarSoulReformTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,WarSoulReformTempInfo,_tempXml) as WarSoulReformTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTemp(param1:int, param2:int) : WarSoulReformTempInfo
      {
         for each(var _loc3_:WarSoulReformTempInfo in _dic)
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

