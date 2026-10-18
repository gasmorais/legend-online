package mvc.module.card
{
   import manager.LanguageMgr;
   import yishi.datas.templates.MagicCardTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class MagicCardModel
   {
      
      private var _isSelfCheck:Boolean = true;
      
      private var _cardSuitInfoList:SimpleDictionary;
      
      private var _cardCampaignBuffList:Array;
      
      private var _cardFightInfoList:Vector.<MagicCardFightInfo>;
      
      private var _allCardInfoList:Array;
      
      private var _allActivatedCard:Array;
      
      private var _activatedType:Array = [];
      
      private var _activatedPosByType:Object;
      
      private var _activedPer:Number;
      
      private var _activedCount:int;
      
      private var _averageProfile:Number;
      
      private var _averageGrades:Number;
      
      public var hasCanActiveCard:Boolean = false;
      
      public function MagicCardModel()
      {
         super();
         _cardSuitInfoList = new SimpleDictionary();
         _cardCampaignBuffList = [];
         _cardFightInfoList = new Vector.<MagicCardFightInfo>();
         _allCardInfoList = [];
      }
      
      public function getInfoByTypeAndPos(param1:int, param2:int) : MagicCardInfo
      {
         var _loc5_:MagicCardInfo = null;
         var _loc4_:int = 0;
         var _loc3_:MagicCardInfo = null;
         _loc4_ = 0;
         while(_loc4_ < allActivatedCard.length)
         {
            _loc3_ = allActivatedCard[_loc4_];
            if(_loc3_.types == param1 && _loc3_.pos == param2)
            {
               _loc5_ = allActivatedCard[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function get averageGrades() : Number
      {
         var _loc3_:int = 0;
         var _loc1_:MagicCardInfo = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < allActivatedCard.length)
         {
            _loc1_ = allActivatedCard[_loc3_];
            _loc2_ += TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(_loc1_.types,_loc1_.pos,_loc1_.grades).Grades;
            _loc3_++;
         }
         if(activedCount == 0)
         {
            _averageGrades = 0;
         }
         else
         {
            _averageGrades = _loc2_ / activedCount;
         }
         return _averageGrades;
      }
      
      public function get averageProfile() : Number
      {
         var _loc3_:int = 0;
         var _loc2_:MagicCardInfo = null;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < allActivatedCard.length)
         {
            _loc2_ = allActivatedCard[_loc3_];
            _loc1_ += TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(_loc2_.types,_loc2_.pos,_loc2_.grades).Profile;
            _loc3_++;
         }
         if(activedCount == 0)
         {
            _averageProfile = 0;
         }
         else
         {
            _averageProfile = _loc1_ / activedCount;
         }
         return _averageProfile;
      }
      
      public function get activedPer() : Number
      {
         _activedPer = activedCount / TempleteManager.instance.magicCardTemplateCate.cardCount * 100;
         return _activedPer;
      }
      
      public function get activedCount() : int
      {
         _activedCount = _allActivatedCard.length;
         return _activedCount;
      }
      
      public function get activatedPosByType() : Object
      {
         return _activatedPosByType;
      }
      
      public function set activatedPosByType(param1:Object) : void
      {
         _activatedPosByType = param1;
      }
      
      public function get allActivatedCard() : Array
      {
         return _allActivatedCard;
      }
      
      public function set allActivatedCard(param1:Array) : void
      {
         _allActivatedCard = param1;
      }
      
      public function get hasCanExplainCard() : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:MagicCardTemplateInfo = null;
         var _loc2_:MagicCardInfo = null;
         var _loc1_:Number = NaN;
         var _loc6_:* = null;
         var _loc3_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < allActivatedCard.length)
         {
            _loc2_ = allActivatedCard[_loc4_];
            _loc5_ = TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(_loc2_.types,_loc2_.pos,_loc2_.grades);
            _loc1_ = GoodsManager.instance.getGoodsNumByTempId(_loc5_.ActiveNeedTempId) + GoodsManager.instance.getConsoritaBagGoodsNumByTempId(_loc5_.ActiveNeedTempId);
            if(_loc1_ > 0)
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            return _loc3_;
         }
         for each(_loc6_ in TempleteManager.instance.magicCardTemplateCate.getTemplates())
         {
            _loc1_ = GoodsManager.instance.getGoodsNumByTempId(_loc6_.ActiveNeedTempId) + GoodsManager.instance.getConsoritaBagGoodsNumByTempId(_loc6_.ActiveNeedTempId);
            if(_loc1_ >= 2)
            {
               _loc3_ = true;
               break;
            }
         }
         for each(_loc6_ in TempleteManager.instance.magicCardTemplateCate.getTemplates())
         {
            if(!cardIsActive(_loc6_.TemplateId,_loc6_.Grades) && !hasCanActiveCard)
            {
               if(GoodsManager.instance.getGoodsNumByTempId(_loc6_.ActiveNeedTempId) > 0 || GoodsManager.instance.getConsoritaBagGoodsNumByTempId(_loc6_.ActiveNeedTempId) > 0)
               {
                  hasCanActiveCard = true;
                  break;
               }
            }
         }
         return _loc3_;
      }
      
      public function cardIsActive(param1:int, param2:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:MagicCardInfo = null;
         var _loc3_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < allActivatedCard.length)
         {
            _loc4_ = allActivatedCard[_loc5_];
            if(_loc4_.templateId == param1 && _loc4_.grades == param2)
            {
               _loc3_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function get activatedType() : Array
      {
         return _activatedType;
      }
      
      public function updateSuitCard(param1:MagicCardSuitInfo) : void
      {
         if(param1)
         {
            _cardSuitInfoList.add(param1.suiteId,param1);
         }
      }
      
      public function addActivatedCard(param1:MagicCardInfo) : void
      {
         if(_allActivatedCard == null)
         {
            _allActivatedCard = [];
         }
         _allActivatedCard.push(param1);
         if(_activatedType.indexOf(param1.types) == -1)
         {
            _activatedType.push(param1.types);
            _activatedPosByType[param1.types] = [];
         }
         if(_activatedPosByType[param1.types] == null)
         {
            _activatedPosByType[param1.types] = [];
         }
         _activatedPosByType[param1.types].push(param1.pos);
      }
      
      public function updateCampaignBuff(param1:Array) : void
      {
         _cardCampaignBuffList.length = 0;
         if(param1)
         {
            _cardCampaignBuffList = param1;
         }
      }
      
      public function get cardCampBuffList() : Array
      {
         return _cardCampaignBuffList;
      }
      
      public function get cardFightInfoList() : Vector.<MagicCardFightInfo>
      {
         return _cardFightInfoList;
      }
      
      public function set cardFightInfoList(param1:Vector.<MagicCardFightInfo>) : void
      {
         _cardFightInfoList = param1;
      }
      
      public function cardType(param1:int) : String
      {
         return "";
      }
      
      public function getFightText(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1 - 800)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("card.CardFrame.MultiCampaign");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("card.CardFrame.trialTower");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("card.CardFrame.TowerCampaign");
               break;
            case 6:
               _loc2_ = LanguageMgr.GetTranslation("card.CardFrame.matchPVP");
               break;
            case 7:
               _loc2_ = LanguageMgr.GetTranslation("card.CardFrame.warfieldBattle");
         }
         return _loc2_ + (LanguageMgr.GetTranslation("sort.view.MemberTitleView.ap") + " +");
      }
      
      public function buffContent(param1:MagicCardBuffInfo, param2:int = 0) : String
      {
         return "";
      }
      
      public function get isSelfCheck() : Boolean
      {
         return _isSelfCheck;
      }
      
      public function set isSelfCheck(param1:Boolean) : void
      {
         _isSelfCheck = param1;
      }
      
      public function get cardSuitInfoList() : SimpleDictionary
      {
         return _cardSuitInfoList;
      }
      
      public function getMagicCardSuitInfoBySuitId(param1:int) : MagicCardSuitInfo
      {
         for each(var _loc2_:MagicCardSuitInfo in cardSuitInfoList)
         {
            if(_loc2_.suiteId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get getOrderIdList() : Array
      {
         return [];
      }
      
      public function get getSelectedItem() : int
      {
         var _loc2_:* = null;
         var _loc1_:Boolean = false;
         for each(var _loc3_:MagicCardInfo in allActivatedCard)
         {
            if(_loc3_.isActive)
            {
               _loc1_ = true;
               break;
            }
         }
         if(_loc1_)
         {
            return _loc3_.types;
         }
         return -1;
      }
      
      public function get getAllCardCount() : int
      {
         return _allCardInfoList.length;
      }
      
      public function getAllCardList() : void
      {
         var _loc2_:int = 0;
         _allCardInfoList.length = 0;
         for each(var _loc3_:MagicCardSuitInfo in cardSuitInfoList)
         {
            for each(var _loc1_:MagicCardInfo in _loc3_.cardInfos)
            {
               _loc1_.pos = _loc2_;
               _loc2_++;
               _allCardInfoList.push(_loc1_);
            }
         }
      }
      
      public function getCardInfoByPos(param1:int) : MagicCardInfo
      {
         return _allCardInfoList[param1];
      }
   }
}

