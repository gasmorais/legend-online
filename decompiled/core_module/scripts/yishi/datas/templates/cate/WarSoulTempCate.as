package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.WarSoulTempInfo;
   
   public class WarSoulTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function WarSoulTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@WarSoulId + "";
               _dic[_loc2_] = createNode(_loc1_,WarSoulTempInfo,_tempXml) as WarSoulTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfoById(param1:int) : WarSoulTempInfo
      {
         for each(var _loc2_:WarSoulTempInfo in _dic)
         {
            if(_loc2_.WarSoulId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getListBySontype(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:WarSoulTempInfo in _dic)
         {
            if(_loc3_.SonType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("WarSoulId",16);
         return _loc2_;
      }
   }
}

