package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import yishi.datas.templates.SevenYearAchievementTempInfo;
   import yishi.utils.SimpleDictionary;
   
   public class SevenYearAchievementTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _typeDic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SevenYearAchievementTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _typeDic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc4_:SevenYearAchievementTempInfo = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               model.achievementMaxCount++;
               _loc3_ = _loc1_.@Type;
               if(!_typeDic[_loc3_])
               {
                  _loc2_ = parseInt(_loc3_);
                  _typeDic[_loc3_] = _loc2_;
               }
               if(!_dic[_loc3_])
               {
                  _dic[_loc3_] = new SimpleDictionary();
               }
               _loc4_ = createNode(_loc1_,SevenYearAchievementTempInfo,_tempXml) as SevenYearAchievementTempInfo;
               model.achievementMaxScore += _loc4_.Score;
               _dic[_loc3_].add(_loc4_.Grade,_loc4_);
            }
         }
         _list = null;
      }
      
      public function getTypeTemplates() : Dictionary
      {
         return _typeDic;
      }
      
      public function getTemplates() : Dictionary
      {
         return _dic;
      }
      
      public function getTempInfoArrByType(param1:int) : SimpleDictionary
      {
         var _loc2_:String = param1.toString();
         return _dic[_loc2_];
      }
      
      public function getTempInfoArrByTypeGrade(param1:int, param2:int) : SevenYearAchievementTempInfo
      {
         var _loc3_:SimpleDictionary = getTempInfoArrByType(param1);
         return _loc3_[param2];
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
   }
}

