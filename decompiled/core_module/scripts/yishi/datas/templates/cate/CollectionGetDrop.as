package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class CollectionGetDrop extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function CollectionGetDrop(param1:XMLList)
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
               _loc2_ = _loc1_.@id + "";
               _dic[_loc2_] = createNode(_loc1_,CommonDropTempInfo,_tempXml) as CommonDropTempInfo;
            }
         }
         _list = null;
      }
      
      public function getDropGood(param1:int) : CommonDropTempInfo
      {
         for each(var _loc2_:CommonDropTempInfo in _dic)
         {
            if(_loc2_.dropId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

