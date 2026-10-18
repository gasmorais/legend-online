package mvc.module.dayGuide
{
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.manager.TempleteManager;
   
   public class DailyList
   {
      
      private var _infoList:Array = [];
      
      private var _dic:Dictionary;
      
      public function DailyList()
      {
         super();
      }
      
      public function get infoList() : Array
      {
         getTemplateList();
         return _infoList;
      }
      
      private function getTemplateList() : void
      {
         var _loc2_:DailyItemInfo = null;
         _infoList = [];
         _dic = TempleteManager.instance.activeTemplateCate.getTemplates();
         for each(var _loc1_:DailyItemInfo in _dic)
         {
            _loc2_ = new DailyItemInfo();
            _loc2_ = _loc1_;
            if(_loc2_ != null)
            {
               if(_loc2_.Type <= 1)
               {
                  _loc2_.condition = LanguageMgr.GetTranslation("public.grade") + "≥" + LanguageMgr.GetTranslation("public.level2",_loc2_.Levels);
                  switch(_loc2_.ActiveType - 1)
                  {
                     case 0:
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward01");
                        _loc2_.starCount = 5;
                        break;
                     case 1:
                        _loc2_.condition = LanguageMgr.GetTranslation("public.grade") + "≥" + LanguageMgr.GetTranslation("dayGuide.data.DailyList.level01",_loc2_.Levels);
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward02");
                        _loc2_.starCount = 4;
                        break;
                     case 2:
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward04");
                        _loc2_.starCount = 4;
                        break;
                     case 3:
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward11");
                        _loc2_.starCount = 4;
                        break;
                     case 4:
                        _loc2_.condition = LanguageMgr.GetTranslation("public.grade") + "≥" + LanguageMgr.GetTranslation("dayGuide.data.DailyList.level01",_loc2_.Levels);
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward11");
                        _loc2_.starCount = 4;
                  }
                  switch(_loc2_.TemplateId)
                  {
                     case "3":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward01");
                        _loc2_.starCount = 5;
                        break;
                     case "6":
                        _loc2_.condition = LanguageMgr.GetTranslation("public.grade") + "≥" + LanguageMgr.GetTranslation("dayGuide.data.DailyList.level02",_loc2_.Levels);
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward06");
                        _loc2_.starCount = 5;
                        break;
                     case "7":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward07");
                        _loc2_.starCount = 3;
                        break;
                     case "8":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward08");
                        _loc2_.starCount = 3;
                        break;
                     case "9":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward09");
                        _loc2_.starCount = 4;
                        break;
                     case "11":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward10");
                        _loc2_.starCount = 5;
                        break;
                     case "13":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward12");
                        _loc2_.starCount = 5;
                        break;
                     case "14":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward13");
                        _loc2_.starCount = 5;
                        break;
                     case "15":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward14");
                        _loc2_.starCount = 5;
                        break;
                     case "16":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward16");
                        _loc2_.starCount = 5;
                        break;
                     case "17":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward17");
                        _loc2_.starCount = 5;
                        break;
                     case "18":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward18");
                        _loc2_.starCount = 5;
                        break;
                     case "20":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward20");
                        _loc2_.starCount = 5;
                        break;
                     case "1000":
                        _loc2_.reward = LanguageMgr.GetTranslation("dayGuide.data.DailyList.reward1000");
                        _loc2_.starCount = 5;
                        break;
                     case "25":
                        _loc2_.starCount = 5;
                  }
                  _infoList.push(_loc2_);
               }
            }
         }
         _infoList.sortOn("Sort",16);
      }
   }
}

