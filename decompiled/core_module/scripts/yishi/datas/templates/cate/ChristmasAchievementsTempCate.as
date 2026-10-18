package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ChristmasAchievementsTempInfo;
   
   public class ChristmasAchievementsTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ChristmasAchievementsTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Id;
               _dic[_loc2_] = createNode(_loc1_,ChristmasAchievementsTempInfo,_tempXml) as ChristmasAchievementsTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplateByID(param1:int) : ChristmasAchievementsTempInfo
      {
         return _dic[param1];
      }
      
      public function getTaskList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ChristmasAchievementsTempInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("Id",16);
         return _loc1_;
      }
   }
}

