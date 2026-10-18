package mvc.module.selectcampaign
{
   import events.SelectCampaignEvent;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.CampaignTemplateManager;
   import yishi.manager.TempleteManager;
   
   public class SelectCampaignModel extends EventDispatcher
   {
      
      private var _selectedLand:CampaignLandInfo;
      
      private var _selectedChapter:CampaignChapterInfo;
      
      private var _selectedArea:CampaignAreaInfo;
      
      private var _selectedCampaign:CampaignTemplate;
      
      private var tempPoint:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("single_hero_buy_cost");
      
      public var needPoint:int = tempPoint ? int(tempPoint.ConfigValue) : 10;
      
      private var nameposX:int;
      
      private var nameposY:int;
      
      public var recentChapter:CampaignChapterInfo;
      
      public var taskCampaignTem:CampaignTemplate;
      
      public var maxChapter:CampaignChapterInfo;
      
      public function SelectCampaignModel()
      {
         super();
      }
      
      public function set selectedLand(param1:CampaignLandInfo) : void
      {
         if(_selectedLand == param1)
         {
            return;
         }
         _selectedLand = param1;
         dispatchEvent(new SelectCampaignEvent("SELECTED_LAND_CHANGE"));
      }
      
      public function set selectedChapter(param1:CampaignChapterInfo) : void
      {
         _selectedChapter = param1;
         if(_selectedChapter)
         {
            dispatchEvent(new SelectCampaignEvent("SELECTED_CHAPTER_CHANGE"));
         }
      }
      
      private function get nameposPoint() : Point
      {
         return new Point(nameposX,nameposY);
      }
      
      public function set point(param1:Point) : void
      {
         nameposX = param1.x;
         nameposY = param1.y;
      }
      
      public function set selectedArea(param1:CampaignAreaInfo) : void
      {
         _selectedArea = param1;
         dispatchEvent(new SelectCampaignEvent("SELECTED_AREA_CHANGE",nameposPoint));
      }
      
      public function set selectCampaign(param1:CampaignTemplate) : void
      {
         _selectedCampaign = param1;
         if(_selectedCampaign)
         {
            dispatchEvent(new SelectCampaignEvent("SELECTED_CAMPAIGN_CHANGE"));
         }
      }
      
      public function getRecentCanSelectChapter() : void
      {
         var _loc2_:CampaignChapterInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = selectedLand.chapterDic.getList();
         _loc1_.sort(sortFun);
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = _loc3_ - 1;
         while(_loc4_ >= 0)
         {
            _loc2_ = _loc1_[_loc4_];
            if(_loc2_.getMaxOpenArea())
            {
               maxChapter = _loc2_;
            }
            _loc4_--;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _loc1_[_loc5_];
            if(taskCampaignTem && taskCampaignTem.DungeonId == _loc2_.chapterId && taskCampaignTem.DungeonId <= maxChapter.chapterId)
            {
               recentChapter = _loc2_;
               return;
            }
            if(!taskCampaignTem && _loc2_.getMaxOpenArea())
            {
               recentChapter = _loc2_;
               return;
            }
            _loc5_++;
         }
         recentChapter = _loc1_[_loc1_.length - 1] as CampaignChapterInfo;
      }
      
      private function sortFun(param1:CampaignChapterInfo, param2:CampaignChapterInfo) : int
      {
         if(param1.chapterId > param2.chapterId)
         {
            return -1;
         }
         if(param1.chapterId < param2.chapterId)
         {
            return 1;
         }
         return 0;
      }
      
      public function get selectedLand() : CampaignLandInfo
      {
         return CampaignTemplateManager.instance.landDic[1];
      }
      
      public function get selectedChapter() : CampaignChapterInfo
      {
         return _selectedChapter;
      }
      
      public function get selectedArea() : CampaignAreaInfo
      {
         return _selectedArea;
      }
      
      public function get selectCampaign() : CampaignTemplate
      {
         return _selectedCampaign;
      }
      
      public function get normalMap() : CampaignTemplate
      {
         if(!_selectedArea)
         {
            return null;
         }
         return _selectedArea.getMapByDifficult(1);
      }
      
      public function get heroMap() : CampaignTemplate
      {
         if(!_selectedArea)
         {
            return null;
         }
         return _selectedArea.getMapByDifficult(2);
      }
      
      public function isNormalOpen() : Boolean
      {
         if(normalMap && normalMap.state != 0)
         {
            return true;
         }
         return false;
      }
      
      public function isHeroOpen() : Boolean
      {
         if(heroMap && heroMap.state != 0)
         {
            return true;
         }
         return false;
      }
   }
}

