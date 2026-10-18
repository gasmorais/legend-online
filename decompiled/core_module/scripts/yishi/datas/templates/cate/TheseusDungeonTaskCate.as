package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusDungeonTaskInfo;
   
   public class TheseusDungeonTaskCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusDungeonTaskCate(param1:XMLList)
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
               _loc2_ = _loc1_.@TemplateId + "";
               _dic[_loc2_] = createNode(_loc1_,TheseusDungeonTaskInfo,_tempXml) as TheseusDungeonTaskInfo;
            }
         }
         _list = null;
      }
      
      public function getListById(param1:int) : TheseusDungeonTaskInfo
      {
         for each(var _loc2_:TheseusDungeonTaskInfo in _dic)
         {
            if(_loc2_.TemplateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

