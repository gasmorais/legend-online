package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusDungeonInfo;
   
   public class TheseusDungeonCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusDungeonCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,TheseusDungeonInfo,_tempXml) as TheseusDungeonInfo;
            }
         }
         _list = null;
      }
      
      public function getAlltemps() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:TheseusDungeonInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("TemplateId",16);
         return _loc1_;
      }
      
      public function getListById(param1:int) : TheseusDungeonInfo
      {
         for each(var _loc2_:TheseusDungeonInfo in _dic)
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

