package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusDungeonEventInfo;
   
   public class TheseusDungeonEventCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusDungeonEventCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,TheseusDungeonEventInfo,_tempXml) as TheseusDungeonEventInfo;
            }
         }
         _list = null;
      }
      
      public function getListById(param1:int) : TheseusDungeonEventInfo
      {
         for each(var _loc2_:TheseusDungeonEventInfo in _dic)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

