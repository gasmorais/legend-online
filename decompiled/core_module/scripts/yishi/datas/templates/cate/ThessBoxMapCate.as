package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ThessBoxMapInfo;
   import yishi.utils.SimpleDictionary;
   
   public class ThessBoxMapCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _allSkillDic:SimpleDictionary;
      
      public function ThessBoxMapCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         var _loc3_:ThessBoxMapInfo = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@MapId + "_" + _loc1_.@Chapters;
               _loc3_ = createNode(_loc1_,ThessBoxMapInfo,null) as ThessBoxMapInfo;
               _dic[_loc2_] = _loc3_;
            }
            _list = null;
         }
      }
      
      public function getTempByChapterIdAndMapId(param1:int, param2:int) : ThessBoxMapInfo
      {
         var _loc3_:String = param1 + "_" + param2;
         return _dic[_loc3_];
      }
      
      public function findInfoByChapterID(param1:int) : ThessBoxMapInfo
      {
         var _loc2_:Array = [];
         for each(var _loc3_:ThessBoxMapInfo in _dic)
         {
            if(_loc3_.Chapters == param1 && _loc3_.Award)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("MapId",16);
         return _loc2_[0];
      }
   }
}

