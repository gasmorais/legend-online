package mvc.module.sort
{
   import events.SortEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class SortModel extends EventDispatcher
   {
      
      public static const PAGE_NUM:int = 8;
      
      public static const REGRESS_PAGE_NUM:int = 10;
      
      public static const SELF_LEVEL:int = 1;
      
      public static const SELF_POW:int = 2;
      
      public static const MULTIPLE_POW:int = 3;
      
      public static const CONSORTIA_POW:int = 4;
      
      public static const SELF_HONOUR:int = 5;
      
      public static const SELF_CHARMS:int = 6;
      
      public static const SELF_SOULSCORE:int = 7;
      
      public static const PET_POWER:int = 9;
      
      public static const REGRESS:int = 12;
      
      public static const CHILD_POWER:int = 13;
      
      public static const THESEUS:int = 14;
      
      public static const NUMBER_ONE_BTN:int = 10;
      
      public static const DAY_ADD:int = 1;
      
      public static const WEEK_ADD:int = 2;
      
      public static const ACCUMULAT_ADD:int = 3;
      
      private var _currentSelected:int = 0;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      private var _addType:int;
      
      private var _currentShowList:Array;
      
      public var createDate:Date;
      
      public var isFirstOpen:Boolean = true;
      
      public var loaded:Dictionary = new Dictionary(true);
      
      public var dayAddList:Array;
      
      public var weekAddList:Array;
      
      public var accumulationAddList:Array;
      
      public var playerFightList:Array;
      
      public var theseusList:Array;
      
      public var multipleCapacityList:Array;
      
      public var consortiaFightList:Array;
      
      public var playerHonourList:Array;
      
      public var charmsDayAddList:Array;
      
      public var charmsWeekAddList:Array;
      
      public var charmsTotalAddList:Array;
      
      public var soulScoreTotalAddList:Array;
      
      public var petPowerList:Array;
      
      public var childPowerList:Array;
      
      public var regressPlayerList:Array;
      
      public var dayAddList2:Array;
      
      public var weekAddList2:Array;
      
      public var accumulationAddList2:Array;
      
      public var playerFightList2:Array;
      
      public var multipleCapacityList2:Array;
      
      public var consortiaFightList2:Array;
      
      public var playerHonourList2:Array;
      
      public var charmsDayAddList2:Array;
      
      public var charmsWeekAddList2:Array;
      
      public var charmsTotalAddList2:Array;
      
      public var soulScoreTotalAddList2:Array;
      
      public var petPowerList2:Array;
      
      public var childPowerList2:Array;
      
      public var theseusList2:Array;
      
      public var warlordsDic:SimpleDictionary;
      
      public var multilordsDic:SimpleDictionary;
      
      public var changList:Dictionary;
      
      private var _isCross:Boolean = false;
      
      private var _widthConfig:Dictionary = new Dictionary(true);
      
      private var _languageConfig:Dictionary = new Dictionary(true);
      
      public var petRanking:SortData;
      
      public var petRankingCross:SortData;
      
      public var childRanking:SortData;
      
      public var childRankingCross:SortData;
      
      public var theseusRanking:SortData;
      
      public var theseusRankingCross:SortData;
      
      private var _currentSelectedJob:int;
      
      public function SortModel(param1:IEventDispatcher = null)
      {
         super(param1);
         _currentShowList = [];
         dayAddList = [];
         weekAddList = [];
         accumulationAddList = [];
         playerFightList = [];
         theseusList = [];
         multipleCapacityList = [];
         consortiaFightList = [];
         playerHonourList = [];
         charmsDayAddList = [];
         charmsWeekAddList = [];
         charmsTotalAddList = [];
         soulScoreTotalAddList = [];
         petPowerList = [];
         childPowerList = [];
         regressPlayerList = [];
         dayAddList2 = [];
         weekAddList2 = [];
         accumulationAddList2 = [];
         playerFightList2 = [];
         theseusList2 = [];
         multipleCapacityList2 = [];
         consortiaFightList2 = [];
         playerHonourList2 = [];
         charmsDayAddList2 = [];
         charmsWeekAddList2 = [];
         charmsTotalAddList2 = [];
         soulScoreTotalAddList2 = [];
         petPowerList2 = [];
         childPowerList2 = [];
         warlordsDic = new SimpleDictionary();
         multilordsDic = new SimpleDictionary();
         changList = new Dictionary();
         initLanguageConfig();
         initWidthConfig();
      }
      
      public function get currentSelectedJob() : int
      {
         return _currentSelectedJob;
      }
      
      public function set currentSelectedJob(param1:int) : void
      {
         _currentSelectedJob = param1;
      }
      
      public function get currentSelected() : int
      {
         return _currentSelected;
      }
      
      public function set currentSelected(param1:int) : void
      {
         if(_currentSelected == param1)
         {
            return;
         }
         _currentSelected = param1;
         changList["SELECTE_CHANGE"] = true;
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         param1 = int(param1 <= 0 ? 1 : param1);
         if(_currentPage == param1)
         {
            return;
         }
         _currentPage = param1;
         changList["PAGE_UPDATE"] = true;
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set totalPage(param1:int) : void
      {
         param1 = param1 <= _currentPage ? _currentPage : param1;
         if(_totalPage == param1)
         {
            return;
         }
         _totalPage = param1;
         changList["PAGE_UPDATE"] = true;
      }
      
      public function get currentShowList() : Array
      {
         return _currentShowList;
      }
      
      private function get pageNum() : int
      {
         if(currentSelected == 12)
         {
            return 10;
         }
         return 8;
      }
      
      public function set currentShowList(param1:Array) : void
      {
         _currentShowList = param1;
         totalPage = Math.ceil(_currentShowList.length / pageNum);
         changList["SELECTE_LIST_CHANG"] = true;
      }
      
      public function commitChange() : void
      {
         if(changList["SELECTE_LIST_CHANG"])
         {
            dispatchEvent(new SortEvent("SELECTE_LIST_CHANG"));
         }
         if(changList["PAGE_UPDATE"])
         {
            dispatchEvent(new SortEvent("PAGE_UPDATE"));
         }
         if(changList["SELECTE_CHANGE"])
         {
            dispatchEvent(new SortEvent("SELECTE_CHANGE"));
         }
         resetChangList();
      }
      
      private function resetChangList() : void
      {
         for(var _loc1_:String in changList)
         {
            changList[_loc1_] = false;
         }
      }
      
      public function get addType() : int
      {
         return _addType;
      }
      
      public function set addType(param1:int) : void
      {
         _addType = param1;
      }
      
      public function getHonourName(param1:int) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc5_:Array = TempleteManager.instance.getTemplatesByType(14);
         _loc5_.sortOn("Data",0x10 | 2);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc2_ = _loc5_[_loc4_] as UpgradeTemplateInfo;
            if(param1 >= _loc2_.Data)
            {
               _loc3_ = _loc2_.TemplateName;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function get isCross() : Boolean
      {
         return _isCross;
      }
      
      public function set isCross(param1:Boolean) : void
      {
         _isCross = param1;
         changList["SELECTE_CHANGE"] = true;
      }
      
      public function get widthConfig() : Dictionary
      {
         return _widthConfig;
      }
      
      public function get languageConfig() : Dictionary
      {
         return _languageConfig;
      }
      
      private function initWidthConfig() : void
      {
         _widthConfig[1] = "75,152,66,110,135";
         _widthConfig[2] = "75,158,120,188";
         _widthConfig[3] = "75,158,120,188";
         _widthConfig[4] = "75,150,126,185";
         _widthConfig[5] = "75,152,66,110,135";
         _widthConfig[6] = "75,158,120,188";
         _widthConfig[7] = "75,158,120,188";
         _widthConfig[9] = "60,110,55,110,80,125";
         _widthConfig[13] = "67,122,122,89,139";
         _widthConfig[12] = "75,158,120,188";
         _widthConfig[14] = "75,158,120,188";
         _widthConfig["C1"] = "58,114,73,73,91,130";
         _widthConfig["C2"] = "58,134,84,111,150";
         _widthConfig["C3"] = "58,134,84,111,150";
         _widthConfig["C4"] = "58,130,74,150,120";
         _widthConfig["C5"] = "58,114,73,73,91,130";
         _widthConfig["C6"] = "58,134,84,111,150";
         _widthConfig["C7"] = "58,134,84,111,150";
         _widthConfig["C9"] = "60,100,45,100,70,80,90";
         _widthConfig["C13"] = "65,109,109,76,87,99";
         _widthConfig["C14"] = "58,134,84,111,150";
      }
      
      private function initLanguageConfig() : void
      {
         _languageConfig[1] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.level"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.empirical")];
         _languageConfig[2] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap")];
         _languageConfig[3] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.multipleAp")];
         _languageConfig[4] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ConsortiaName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.level"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap")];
         _languageConfig[5] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.honourName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.honour")];
         _languageConfig[6] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.charms")];
         _languageConfig[7] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.soulScore")];
         _languageConfig[9] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.petname"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.property"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.master"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.petgrade"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap")];
         _languageConfig[13] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.parent"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap")];
         _languageConfig[12] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.regressTime")];
         _languageConfig[2] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap")];
         _languageConfig[14] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.theseusFightPow")];
         _languageConfig["C1"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.level"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.empirical")];
         _languageConfig["C2"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap")];
         _languageConfig["C3"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.multipleAp")];
         _languageConfig["C4"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ConsortiaName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.level"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap")];
         _languageConfig["C5"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.honourName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.honour")];
         _languageConfig["C6"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.charms")];
         _languageConfig["C7"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.soulScore")];
         _languageConfig["C9"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.petname"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.property"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.master"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.petgrade"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap")];
         _languageConfig["C13"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.parent"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap")];
         _languageConfig["C14"] = [LanguageMgr.GetTranslation("sort.view.MemberTitleView.ranking"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.name"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.Job"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName"),LanguageMgr.GetTranslation("sort.view.MemberTitleView.theseusFightPow")];
      }
      
      public function cleanData() : void
      {
         cleanSortList();
         cleanSortList2();
         petRanking = null;
         petRankingCross = null;
      }
      
      private function cleanSortList() : void
      {
         var _loc1_:SortData = null;
         while(dayAddList.length > 0)
         {
            _loc1_ = dayAddList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(weekAddList.length > 0)
         {
            _loc1_ = weekAddList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(accumulationAddList.length > 0)
         {
            _loc1_ = accumulationAddList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(playerFightList.length > 0)
         {
            _loc1_ = playerFightList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(theseusList.length > 0)
         {
            _loc1_ = theseusList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(multipleCapacityList.length > 0)
         {
            _loc1_ = multipleCapacityList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(consortiaFightList.length > 0)
         {
            _loc1_ = consortiaFightList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(playerHonourList.length > 0)
         {
            _loc1_ = playerHonourList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(charmsDayAddList.length > 0)
         {
            _loc1_ = charmsDayAddList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(charmsWeekAddList.length > 0)
         {
            _loc1_ = charmsWeekAddList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(charmsTotalAddList.length > 0)
         {
            _loc1_ = charmsTotalAddList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(soulScoreTotalAddList.length > 0)
         {
            _loc1_ = soulScoreTotalAddList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(petPowerList.length > 0)
         {
            _loc1_ = petPowerList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(childPowerList.length > 0)
         {
            _loc1_ = childPowerList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(regressPlayerList.length > 0)
         {
            _loc1_ = regressPlayerList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
      }
      
      private function cleanSortList2() : void
      {
         var _loc1_:SortData = null;
         while(dayAddList2.length > 0)
         {
            _loc1_ = dayAddList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(weekAddList2.length > 0)
         {
            _loc1_ = weekAddList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(accumulationAddList2.length > 0)
         {
            _loc1_ = accumulationAddList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(playerFightList2.length > 0)
         {
            _loc1_ = playerFightList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(theseusList2.length > 0)
         {
            _loc1_ = theseusList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(multipleCapacityList2.length > 0)
         {
            _loc1_ = multipleCapacityList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(consortiaFightList2.length > 0)
         {
            _loc1_ = consortiaFightList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(playerHonourList2.length > 0)
         {
            _loc1_ = playerHonourList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(charmsDayAddList2.length > 0)
         {
            _loc1_ = charmsDayAddList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(charmsWeekAddList2.length > 0)
         {
            _loc1_ = charmsWeekAddList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(charmsTotalAddList2.length > 0)
         {
            _loc1_ = charmsTotalAddList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(soulScoreTotalAddList2.length > 0)
         {
            _loc1_ = soulScoreTotalAddList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(petPowerList2.length > 0)
         {
            _loc1_ = petPowerList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         while(childPowerList2.length > 0)
         {
            _loc1_ = childPowerList2.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
      }
   }
}

