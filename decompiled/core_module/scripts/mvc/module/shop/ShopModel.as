package mvc.module.shop
{
   import com.road.yishi.proto.shop.MainDiscountInfo;
   import events.ShopEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class ShopModel extends EventDispatcher
   {
      
      public static const PAGE_NUM:int = 9;
      
      public static const PAGE_NUM_6:int = 6;
      
      public static const SEEDS_PER_PAGE:int = 6;
      
      public static const NOLIMIT_PER_PAGE:int = 999;
      
      public static const STARS_PER_PAGE:int = 6;
      
      public static const MAX_VIP_LEVEL:int = 6;
      
      public static const TAB1:int = 1;
      
      public static const TAB2:int = 2;
      
      public static const TAB3:int = 3;
      
      public static const TAB4:int = 4;
      
      public static const TAB5:int = 5;
      
      public static const TAB6:int = 6;
      
      public static const TAB7:int = 7;
      
      private var _allGoodsList:Dictionary;
      
      private var _mainDiscountList:Array;
      
      private var _mainNewList:Array;
      
      private var _mainUrlList:Array;
      
      private var _hotGoodsList:Array;
      
      private var _recommendGoodsList:Array;
      
      private var _propGoodsList:Array;
      
      private var _elseGoodsList:Array;
      
      private var _gemstoneGoodsList:Array;
      
      private var _giftGoodsList:Array;
      
      private var _backPlayerList:Array;
      
      private var _fashionWeaponList:Array;
      
      private var _fashionClothList:Array;
      
      private var _fashionHairList:Array;
      
      private var _fashionWingList:Array;
      
      private var _fashionList:Array;
      
      private var _cardReelList:Array;
      
      private var _homeItemList:Array;
      
      private var _loopItemList:Array;
      
      private var _timeBuyList:Array;
      
      private var _petGoodsList:Array;
      
      private var _petExchangeList:Array;
      
      private var _crossGvgList:Array;
      
      private var _childGoodsList:Array;
      
      private var _promotionalGoodsList:Array;
      
      private var _artifactList:Array;
      
      private var _theseusBoxtList:Array;
      
      private var _petSkillBookDic:Dictionary;
      
      private var _curSelectedTab:String;
      
      private var _shopCartList:Vector.<ShopCartGoodsInfo>;
      
      private var _heroGoodsList:Array;
      
      private var _hideGoodsList:Array;
      
      private var _farmShopTempArr:Array;
      
      private var _tabList:SimpleDictionary;
      
      private var _currentGoodsList:Array;
      
      private var _showGoodsList:Array;
      
      private var _currentTab:int = 1;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      private var _randomCount:Number;
      
      public var giftInfo:ItemBuyInfo;
      
      public var limiteTimeDiscountIsOpen:Boolean;
      
      public var limiteTimeDiscountActiveId:String;
      
      public var limiteTimeDiscountBegin:String;
      
      public var limiteTimeDiscountEnd:String;
      
      private var _limiteTimeDiscountGoodsList:Array;
      
      public var limiteTimeDicountCurrentPage:int = 1;
      
      public var currentPageNum:int = 9;
      
      private var _groupBuyList:Array;
      
      private var _shopTempDic:SimpleDictionary;
      
      private var _splitFlag:int = -10000;
      
      public function ShopModel()
      {
         super();
         _mainDiscountList = [];
         _mainUrlList = [];
         _mainNewList = [];
         _hotGoodsList = [];
         _recommendGoodsList = [];
         _propGoodsList = [];
         _elseGoodsList = [];
         _gemstoneGoodsList = [];
         _giftGoodsList = [];
         _cardReelList = [];
         _homeItemList = [];
         _showGoodsList = [];
         _farmShopTempArr = [];
         _petGoodsList = [];
         _backPlayerList = [];
         _childGoodsList = [];
         _fashionWeaponList = [];
         _fashionClothList = [];
         _fashionHairList = [];
         _fashionWingList = [];
         _fashionList = [];
         _petExchangeList = [];
         _crossGvgList = [];
         _heroGoodsList = [];
         _hideGoodsList = [];
         _theseusBoxtList = [];
         _limiteTimeDiscountGoodsList = [];
         _shopCartList = new Vector.<ShopCartGoodsInfo>();
         _tabList = new SimpleDictionary();
         _shopTempDic = new SimpleDictionary();
         init();
      }
      
      private static function farmGoodsSortFuncDesc(param1:ShopGoodsInfo, param2:ShopGoodsInfo) : int
      {
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.ItemId);
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.ItemId);
         if(_loc4_.Property1 > _loc3_.Property1)
         {
            return -1;
         }
         if(_loc4_.Property1 < _loc3_.Property1)
         {
            return 1;
         }
         if(param1.NeedGrades > param2.NeedGrades)
         {
            return -1;
         }
         if(param1.NeedGrades < param2.NeedGrades)
         {
            return 1;
         }
         return 0;
      }
      
      private static function farmGoodsSortFuncAsc(param1:ShopGoodsInfo, param2:ShopGoodsInfo) : int
      {
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.ItemId);
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.ItemId);
         if(_loc4_.Property1 < _loc3_.Property1)
         {
            return -1;
         }
         if(_loc4_.Property1 > _loc3_.Property1)
         {
            return 1;
         }
         if(param1.NeedGrades > param2.NeedGrades)
         {
            return -1;
         }
         if(param1.NeedGrades < param2.NeedGrades)
         {
            return 1;
         }
         return 0;
      }
      
      private function init() : void
      {
         var _loc2_:GoodsTemplateInfo = null;
         _allGoodsList = TempleteManager.instance.getShopTempInfoList();
         var _loc3_:ShopGoodsInfo = null;
         var _loc1_:ShopGoodsInfo = null;
         for each(var _loc5_:ShopGoodsInfo in _allGoodsList)
         {
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
            if(_loc2_)
            {
               if(_loc5_.Area == 2)
               {
                  _propGoodsList.push(_loc5_);
               }
               else if(_loc5_.Area == 4)
               {
                  _elseGoodsList.push(_loc5_);
               }
               else if(_loc5_.Area == 16)
               {
                  _heroGoodsList.push(_loc5_);
               }
               else if(_loc5_.Area == 18)
               {
                  _petGoodsList.push(_loc5_);
               }
               else if(_loc5_.Area == 12)
               {
                  _childGoodsList.push(_loc5_);
               }
               else if(_loc5_.Area == 52)
               {
                  _hideGoodsList.push(_loc5_);
               }
            }
         }
         _propGoodsList.sortOn("Sort",16);
         _elseGoodsList.sortOn("Sort",16);
         _heroGoodsList.sortOn("Sort",16);
         _petGoodsList.sortOn("Sort",16);
         _childGoodsList.sortOn("Sort",16);
         _hideGoodsList.sortOn("Sort",16);
         for each(var _loc4_:ShopGoodsInfo in TempleteManager.instance.getFarmShopTemplateDic())
         {
            _farmShopTempArr.push(_loc4_);
         }
         _farmShopTempArr.sortOn("NeedGrades",16);
      }
      
      public function get curSelectedTab() : String
      {
         return _curSelectedTab;
      }
      
      public function set curSelectedTab(param1:String) : void
      {
         _curSelectedTab = param1;
         dispatchEvent(new ShopEvent("CURSELECTED_TAB_CHANGE",_curSelectedTab));
      }
      
      public function get childGoodsList() : Array
      {
         return _childGoodsList;
      }
      
      public function get fashionClothList() : Array
      {
         return _fashionClothList;
      }
      
      public function get fashionWeaponList() : Array
      {
         return _fashionWeaponList;
      }
      
      public function get fashionHairList() : Array
      {
         return _fashionHairList;
      }
      
      public function get fashionWingList() : Array
      {
         return _fashionWingList;
      }
      
      public function get fashionList() : Array
      {
         return _fashionList;
      }
      
      public function get farmShopTempArr() : Array
      {
         return _farmShopTempArr;
      }
      
      public function get mainDiscountList() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _mainDiscountList.length)
         {
            if(_mainDiscountList[_loc2_].remainTime > 0)
            {
               _loc1_.push(_mainDiscountList[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get artifactList() : Array
      {
         return _artifactList;
      }
      
      public function get groupBuyList() : Array
      {
         return _groupBuyList;
      }
      
      public function getTimeBuyList(param1:int = -1) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:MainShopInfo = null;
         var _loc4_:Boolean = false;
         var _loc6_:int = 0;
         var _loc2_:Array = [];
         if(_timeBuyList)
         {
            _loc5_ = int(_timeBuyList.length);
            _loc4_ = false;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_ = _timeBuyList[_loc6_];
               switch(param1 - -1)
               {
                  case 0:
                     _loc4_ = true;
                     break;
                  case 1:
                     _loc4_ = _loc3_.needVIPGrade == 0;
                     break;
                  case 2:
                     _loc4_ = _loc3_.needVIPGrade > 0;
               }
               if(_loc4_ && _loc3_.remainTime > 0 && _loc3_.type == 1)
               {
                  _loc2_.push(_loc3_);
               }
               _loc6_++;
            }
         }
         return _loc2_;
      }
      
      public function getTimeBuyList2() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:MainShopInfo = null;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         if(_timeBuyList)
         {
            _loc3_ = int(_timeBuyList.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = _timeBuyList[_loc4_];
               if(_loc2_.remainTime > 0 && _loc2_.type == 2 && _loc2_.needVIPGrade <= 0)
               {
                  _loc1_.push(_loc2_);
               }
               _loc4_++;
            }
         }
         return _loc1_;
      }
      
      public function getPromotionalGoodsList() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:MainShopInfo = null;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         if(_promotionalGoodsList)
         {
            _loc3_ = int(_promotionalGoodsList.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = _promotionalGoodsList[_loc4_];
               if(_loc2_.remainTime > 0)
               {
                  _loc1_.push(_loc2_);
               }
               _loc4_++;
            }
         }
         return _loc1_;
      }
      
      public function updateLoopList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:MainShopInfo = null;
         var _loc2_:int = int(_loopItemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loopItemList[_loc3_] as MainShopInfo;
            _loc3_++;
         }
      }
      
      public function set mainDiscountList(param1:Array) : void
      {
         var _loc2_:MainDiscountInfo = null;
         var _loc7_:MainShopInfo = null;
         var _loc5_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         _mainDiscountList = [];
         _loopItemList = [];
         _timeBuyList = [];
         _artifactList = [];
         _groupBuyList = [];
         _promotionalGoodsList = [];
         var _loc4_:int = int(param1.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = param1[_loc5_];
            _loc7_ = new MainShopInfo();
            _loc7_.id = _loc2_.id;
            _loc7_.site = _loc2_.site;
            _loc7_.isGift = _loc2_.isGift;
            _loc7_.type = _loc2_.type;
            _loc7_.limitCount = _loc2_.limitCount;
            _loc7_.needVIPGrade = _loc2_.vip;
            _loc7_.shopId = _loc2_.shopId;
            _loc7_.templateId = _loc2_.templateId;
            _loc7_.counts = _loc2_.counts;
            _loc7_.shopId1 = _loc2_.shopId1;
            _loc7_.templateId1 = _loc2_.templateId1;
            _loc7_.count1 = _loc2_.count1;
            _loc7_.shopId2 = _loc2_.shopId2;
            _loc7_.templateId2 = _loc2_.templateId2;
            _loc7_.count2 = _loc2_.count2;
            _loc7_.shopId3 = _loc2_.shopId3;
            _loc7_.templateId3 = _loc2_.templateId3;
            _loc7_.count3 = _loc2_.count3;
            _loc7_.shopId4 = _loc2_.shopId4;
            _loc7_.templateId4 = _loc2_.templateId4;
            _loc7_.count4 = _loc2_.count4;
            _loc7_.shopId5 = _loc2_.shopId5;
            _loc7_.templateId5 = _loc2_.templateId5;
            _loc7_.count5 = _loc2_.count5;
            _loc7_.shopId6 = _loc2_.shopId6;
            _loc7_.templateId6 = _loc2_.templateId6;
            _loc7_.count6 = _loc2_.count6;
            _loc7_.shopId7 = _loc2_.shopId7;
            _loc7_.templateId7 = _loc2_.templateId7;
            _loc7_.count7 = _loc2_.count7;
            _loc7_.shopId8 = _loc2_.shopId8;
            _loc7_.templateId8 = _loc2_.templateId8;
            _loc7_.count8 = _loc2_.count8;
            _loc7_.currentCount = _loc2_.currentCount;
            _loc7_.sortId = _loc2_.sortId;
            _loc7_.discount = _loc2_.discount / 100;
            _loc7_.oneDayCount = _loc2_.oneDayCount;
            _loc7_.maxCount = _loc2_.maxCount;
            _loc7_.maxCurrentDate = DateFormatter.parse(_loc2_.maxCurrentDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
            _loc7_.url = _loc2_.url;
            _loc7_.names = _loc2_.names;
            _loc7_.beginDate = DateFormatter.parse(_loc2_.beginDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
            _loc7_.endDate = DateFormatter.parse(_loc2_.endDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
            _loc7_.level1 = _loc2_.level1;
            _loc7_.price1 = _loc2_.price1;
            _loc7_.level2 = _loc2_.level2;
            _loc7_.price2 = _loc2_.price2;
            _loc7_.level3 = _loc2_.level3;
            _loc7_.price3 = _loc2_.price3;
            _loc7_.sendDate = DateFormatter.parse(_loc2_.sendDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
            if(_loc7_.isGift)
            {
               _loc7_.isDiscount = _loc2_.price;
               _loc7_.setContent();
               _loc7_.sortName = _loc7_.names;
            }
            else
            {
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc7_.templateId;
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_.templateId);
               _loc7_.sortName = _loc3_.TemplateName;
            }
            _loc7_.setPrice(_loc2_.price);
            if(_loc7_.type == 1)
            {
               _mainDiscountList.push(_loc7_);
               _timeBuyList.push(_loc7_);
            }
            else if(_loc7_.type == 2)
            {
               _loopItemList.push(_loc7_);
               _timeBuyList.push(_loc7_);
            }
            else if(_loc7_.type == 3)
            {
               _groupBuyList.push(_loc7_);
            }
            else if(_loc7_.type == 4)
            {
               _promotionalGoodsList.push(_loc7_);
            }
            else if(_loc7_.type == 5)
            {
               _promotionalGoodsList.push(_loc7_);
            }
            else if(_loc7_.type == 6)
            {
               _promotionalGoodsList.push(_loc7_);
            }
            else if(_loc7_.type == 7)
            {
               _loc7_.oneDayCount = _loc7_.maxCount;
               _artifactList.push(_loc7_);
            }
            _loc5_++;
         }
         _promotionalGoodsList.sortOn("type",16);
         _timeBuyList.sortOn(["type","sortId"],2 | 0x10);
      }
      
      public function get splitFlag() : int
      {
         return _splitFlag;
      }
      
      public function set splitFlag(param1:int) : void
      {
         if(_splitFlag == param1)
         {
            return;
         }
         _splitFlag = param1;
      }
      
      public function get mainUrlList() : Array
      {
         return _mainUrlList;
      }
      
      public function set mainUrlList(param1:Array) : void
      {
         _mainUrlList = param1;
         _mainUrlList.sortOn("site",16);
      }
      
      public function get mainNewList() : Array
      {
         return _mainNewList;
      }
      
      public function set mainNewList(param1:Array) : void
      {
         _mainNewList = param1;
         _mainNewList.sortOn("sortId",16);
      }
      
      public function get hotGoodsList() : Array
      {
         return _hotGoodsList;
      }
      
      public function set hotGoodsList(param1:Array) : void
      {
         _hotGoodsList = param1;
      }
      
      public function get gemstoneGoodsList() : Array
      {
         return _gemstoneGoodsList;
      }
      
      public function set gemstoneGoodsList(param1:Array) : void
      {
         _gemstoneGoodsList = param1;
      }
      
      public function get backPlayerList() : Array
      {
         return _backPlayerList;
      }
      
      public function set childGoodsList(param1:Array) : void
      {
         _childGoodsList = param1;
      }
      
      public function set backPlayerList(param1:Array) : void
      {
         _backPlayerList = param1;
      }
      
      public function get recommendGoodsList() : Array
      {
         return _recommendGoodsList;
      }
      
      public function set recommendGoodsList(param1:Array) : void
      {
         _recommendGoodsList = param1;
      }
      
      public function get propGoodsList() : Array
      {
         return _propGoodsList;
      }
      
      public function set propGoodsList(param1:Array) : void
      {
         _propGoodsList = param1;
      }
      
      public function get elseGoodsList() : Array
      {
         return _elseGoodsList;
      }
      
      public function set elseGoodsList(param1:Array) : void
      {
         _elseGoodsList = param1;
      }
      
      public function get giftGoodsList() : Array
      {
         return _giftGoodsList;
      }
      
      public function set giftGoodsList(param1:Array) : void
      {
         _giftGoodsList = param1;
      }
      
      public function get cardReelList() : Array
      {
         return _cardReelList;
      }
      
      public function set cardReelList(param1:Array) : void
      {
         _cardReelList = param1;
      }
      
      public function get homeItemList() : Array
      {
         return _homeItemList;
      }
      
      public function set homeItemList(param1:Array) : void
      {
         _homeItemList = param1;
      }
      
      public function get allGoodsList() : Dictionary
      {
         return _allGoodsList;
      }
      
      public function set allGoodsList(param1:Dictionary) : void
      {
         _allGoodsList = param1;
      }
      
      public function get showGoodsList() : Array
      {
         return _showGoodsList;
      }
      
      public function set showGoodsList(param1:Array) : void
      {
         _showGoodsList = param1;
         dispatchEvent(new ShopEvent("GOODS_LIST_UPDATE"));
      }
      
      public function resetData(param1:int = 9, param2:int = 1, param3:int = 1) : void
      {
         currentPageNum = param1;
         _currentTab = param2;
         _currentPage = param3;
      }
      
      public function set currentTab(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_currentTab == param1)
         {
            return;
         }
         _currentTab = param1;
         currentGoodsList = _tabList[_currentTab];
         if(currentGoodsList)
         {
            currentPage = 1;
            totalPage = Math.ceil(currentGoodsList.length / currentPageNum);
            _loc2_ = (currentPage - 1) * currentPageNum;
            _loc3_ = _loc2_ + currentPageNum;
            if(_loc3_ > currentGoodsList.length)
            {
               _loc3_ = int(currentGoodsList.length);
            }
            showGoodsList = currentGoodsList.slice(_loc2_,_loc3_);
         }
      }
      
      public function sortFarmGoods(param1:Boolean) : void
      {
         currentGoodsList = _tabList[_currentTab];
         if(currentGoodsList)
         {
            if(param1)
            {
               showGoodsList = currentGoodsList.sort(farmGoodsSortFuncDesc);
            }
            else
            {
               showGoodsList = currentGoodsList.sort(farmGoodsSortFuncAsc);
            }
         }
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         param1 = int(param1 <= 0 ? 1 : param1);
         _currentPage = param1;
         dispatchEvent(new ShopEvent("PAGE_UPDATE"));
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set totalPage(param1:int) : void
      {
         param1 = param1 <= _currentPage ? _currentPage : param1;
         _totalPage = param1;
         dispatchEvent(new ShopEvent("PAGE_UPDATE"));
      }
      
      public function get tabList() : SimpleDictionary
      {
         return _tabList;
      }
      
      public function get currentGoodsList() : Array
      {
         return _currentGoodsList;
      }
      
      public function set currentGoodsList(param1:Array) : void
      {
         _currentGoodsList = param1;
      }
      
      public function get randomCount() : Number
      {
         if(_randomCount == 0)
         {
            _randomCount = Math.random();
         }
         return _randomCount;
      }
      
      public function set randomCount(param1:Number) : void
      {
         _randomCount = param1;
      }
      
      public function getShopTempInfoById(param1:int) : ShopGoodsInfo
      {
         for each(var _loc2_:ShopGoodsInfo in _allGoodsList)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function switchToFashionTab() : void
      {
         dispatchEvent(new ShopEvent("SWITCH_FASHION_PANEL"));
      }
      
      public function getChildItemById(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:ShopGoodsInfo = null;
         var _loc3_:int = int(childGoodsList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = childGoodsList[_loc4_];
            if(param1 == _loc2_.ItemId)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function get heroGoodsList() : Array
      {
         return _heroGoodsList;
      }
      
      public function set heroGoodsList(param1:Array) : void
      {
         _heroGoodsList = param1;
      }
      
      public function get petGoodsList() : Array
      {
         return _petGoodsList;
      }
      
      public function set petGoodsList(param1:Array) : void
      {
         _petGoodsList = param1;
      }
      
      public function get limiteTimeDiscountGoodsList() : Array
      {
         return _limiteTimeDiscountGoodsList;
      }
      
      public function set limiteTimeDiscountGoodsList(param1:Array) : void
      {
         _limiteTimeDiscountGoodsList = param1;
      }
      
      public function get petExchangeList() : Array
      {
         return _petExchangeList;
      }
      
      public function get petSkillBookDic() : Dictionary
      {
         var _loc7_:Array = null;
         var _loc3_:SkillTempInfo = null;
         var _loc2_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc1_:Array = null;
         if(!_petSkillBookDic)
         {
            _petSkillBookDic = new Dictionary();
            _loc7_ = _hideGoodsList;
            _loc2_ = [101,102,103,104,105,106,117,118,119];
            for each(var _loc5_:int in _loc2_)
            {
               _loc8_ = [];
               _loc9_ = [];
               for each(var _loc6_:ShopGoodsInfo in _loc7_)
               {
                  _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_.ItemId);
                  if(_loc4_)
                  {
                     _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc4_.Property1);
                     if(_loc3_)
                     {
                        if(_loc3_.MasterType == _loc5_ || _loc3_.MasterType == 107)
                        {
                           if(_loc3_.UseWay == 1)
                           {
                              _loc8_.push(_loc4_);
                           }
                           else
                           {
                              _loc9_.push(_loc4_);
                           }
                        }
                     }
                  }
               }
               _loc8_.sort(sortPetSkill);
               _loc9_.sort(sortPetSkill);
               _loc1_ = _loc8_.concat(_loc9_);
               _petSkillBookDic[_loc5_] = _loc1_;
            }
         }
         return _petSkillBookDic;
      }
      
      private function sortPetSkill(param1:GoodsTemplateInfo, param2:GoodsTemplateInfo) : int
      {
         var _loc3_:int = 0;
         if(param1.Profile > param2.Profile)
         {
            _loc3_ = -1;
         }
         else
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      public function get shopCartList() : Vector.<ShopCartGoodsInfo>
      {
         return _shopCartList;
      }
      
      public function set shopCartList(param1:Vector.<ShopCartGoodsInfo>) : void
      {
         if(_shopCartList == param1)
         {
            return;
         }
         _shopCartList = param1;
      }
      
      public function deleteItem(param1:ShopCartGoodsInfo) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < shopCartList.length)
         {
            if(param1 == shopCartList[_loc2_])
            {
               shopCartList.splice(_loc2_,1);
               dispatchEvent(new ShopEvent("SHOPCART_DELETE_SUCCESS"));
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.shopCartItem.deleteSuccess"));
               return;
            }
            _loc2_++;
         }
      }
      
      public function updateItem(param1:ShopCartGoodsInfo, param2:Boolean, param3:int) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < shopCartList.length)
         {
            if(param1.goodsInfo == shopCartList[_loc4_].goodsInfo)
            {
               shopCartList[_loc4_].isBind = param2;
               shopCartList[_loc4_].number = param3;
               dispatchEvent(new ShopEvent("SHOPCART_UPDATE_SUCCESS",shopCartList[_loc4_]));
               return;
            }
            _loc4_++;
         }
      }
      
      public function allCostPoint() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < shopCartList.length)
         {
            if(!shopCartList[_loc2_].isBind)
            {
               _loc1_ += shopCartList[_loc2_].goodsInfo.price * shopCartList[_loc2_].number;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function allCostBindPoint() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < shopCartList.length)
         {
            if(shopCartList[_loc1_].isBind)
            {
               _loc2_ += shopCartList[_loc1_].goodsInfo.price * shopCartList[_loc1_].number;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get shopTempDic() : SimpleDictionary
      {
         return _shopTempDic;
      }
   }
}

