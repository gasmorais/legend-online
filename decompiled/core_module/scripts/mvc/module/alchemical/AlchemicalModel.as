package mvc.module.alchemical
{
   import chat.datas.ChatData;
   import com.pickgliss.utils.ObjectPool;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.AlchemicalFormulaTempInfo;
   import yishi.datas.templates.AlchemicalMineTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class AlchemicalModel
   {
      
      public static const CATALYST_ITEM_SONTYPE:int = 701;
      
      public static const PROP_ITEM_SONTYPE:int = 702;
      
      public static const CATALYST_ITEM_TEMPID:int = 701000;
      
      public static const ALCHEMICAL_SCORE_ITEM_TEMPID:int = 700000;
      
      public var hasSpeedCount:int;
      
      public var speedMaxCount:int;
      
      public var curScore:int;
      
      public var cycleScore:int;
      
      public var cycleMaxScore:int;
      
      public var cycleRewardCount:int;
      
      private var _scoreGrade:int = -1;
      
      private var hasAlertScoreChange:Boolean = false;
      
      public var mineList:Array;
      
      public var alchemicalItemList:Array;
      
      public var cooperationList:Array;
      
      public var alchemicamlItemTempList:Array;
      
      public var scoreUpgradeTempArr:Array;
      
      public var mineTempList:Array;
      
      public var formulaTempDic:Dictionary;
      
      private var _selectFormulaType:int;
      
      private var _selectFormulaInfo:AlchemicalMakeFormulaInfo;
      
      private var _modelType:int;
      
      public var catalystTemp:GoodsTemplateInfo;
      
      public function AlchemicalModel()
      {
         super();
         if(mineList == null)
         {
            mineList = [];
         }
         if(mineTempList == null)
         {
            mineTempList = [];
         }
         if(cooperationList == null)
         {
            cooperationList = [];
         }
         if(scoreUpgradeTempArr == null)
         {
            scoreUpgradeTempArr = [];
         }
         if(alchemicalItemList == null)
         {
            alchemicalItemList = [];
         }
         if(alchemicamlItemTempList == null)
         {
            alchemicamlItemTempList = [];
         }
         if(formulaTempDic == null)
         {
            formulaTempDic = new Dictionary(true);
         }
         speedMaxCount = ConfigInfoManager.instance.getAlchemicalSpeedMaxCount();
         cycleMaxScore = ConfigInfoManager.instance.getAlchemicalFullScoreReward()[0];
         cycleRewardCount = ConfigInfoManager.instance.getAlchemicalFullScoreReward()[1];
         scoreUpgradeTempArr = TempleteManager.instance.getTemplatesByType(139);
         scoreUpgradeTempArr.sortOn("Grades",16);
         var _loc4_:Dictionary = TempleteManager.instance.alchemicalMineTempCate.getTemplates();
         for each(var _loc2_:AlchemicalMineTempInfo in _loc4_)
         {
            if(_loc2_.Grade == 1)
            {
               mineTempList.push(_loc2_);
            }
         }
         mineTempList.sortOn("Pos",16);
         var _loc1_:Dictionary = TempleteManager.instance.alchemicalFormulaTempCate.getTemplates();
         for each(var _loc3_:AlchemicalFormulaTempInfo in _loc1_)
         {
            if(formulaTempDic[_loc3_.RewardType + "_" + _loc3_.Type] == null)
            {
               formulaTempDic[_loc3_.RewardType + "_" + _loc3_.Type] = [];
            }
            formulaTempDic[_loc3_.RewardType + "_" + _loc3_.Type].push(_loc3_);
         }
         alchemicamlItemTempList = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(701);
         alchemicamlItemTempList = alchemicamlItemTempList.concat(TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(702));
         alchemicamlItemTempList.sortOn("TemplateId",16);
      }
      
      public function getMineInfoByPos(param1:int) : AlchemicalMineInfo
      {
         for each(var _loc2_:AlchemicalMineInfo in mineList)
         {
            if(_loc2_.pos == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getAlchemicalInfoByShareUid(param1:int) : AlchemicalMakeFormulaInfo
      {
         for each(var _loc2_:AlchemicalMakeFormulaInfo in cooperationList)
         {
            if(_loc2_.shareUid == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getAlchemicalItemById(param1:int) : GoodsInfo
      {
         for each(var _loc2_:GoodsInfo in alchemicalItemList)
         {
            if(_loc2_.templateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getFormulaTempListByType(param1:int, param2:int) : Array
      {
         return formulaTempDic[param1 + "_" + param2].sort(sortFormulaTemp);
      }
      
      public function sortFormulaTemp(param1:AlchemicalFormulaTempInfo, param2:AlchemicalFormulaTempInfo) : int
      {
         var _loc3_:Boolean = curScore >= param1.NeedScore;
         var _loc4_:Boolean = curScore >= param2.NeedScore;
         if(_loc3_ && !_loc4_)
         {
            return -1;
         }
         if(!_loc3_ && _loc4_)
         {
            return 1;
         }
         return param1.Id < param2.Id ? -1 : 1;
      }
      
      public function getSelectFormulaInIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(cooperationList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(cooperationList[_loc3_].shareUid == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function get nextSocreUpgradeTemp() : UpgradeTemplateInfo
      {
         var _loc2_:int = 0;
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc1_:int = int(scoreUpgradeTempArr.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = scoreUpgradeTempArr[_loc2_];
            if(curScore < _loc3_.Data)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get selectFormulaType() : int
      {
         return _selectFormulaType;
      }
      
      public function set selectFormulaType(param1:int) : void
      {
         if(_selectFormulaType == param1)
         {
            return;
         }
         _selectFormulaType = param1;
         MsgMan.notifyObserver("SELECT_BTNTYPE_CHANGE");
      }
      
      public function get selectFormulaInfo() : AlchemicalMakeFormulaInfo
      {
         return _selectFormulaInfo;
      }
      
      public function set selectFormulaInfo(param1:AlchemicalMakeFormulaInfo) : void
      {
         if(_selectFormulaInfo == param1)
         {
            return;
         }
         _selectFormulaInfo = param1;
         MsgMan.notifyObserver("SELECT_FORMULA_CHANGE");
      }
      
      public function get scoreGrade() : int
      {
         return _scoreGrade;
      }
      
      public function set scoreGrade(param1:int) : void
      {
         var _loc2_:ChatData = null;
         var _loc4_:String = null;
         if(scoreGrade == param1)
         {
            return;
         }
         _scoreGrade = param1;
         var _loc3_:UpgradeTemplateInfo = scoreUpgradeTempArr[_scoreGrade - 1];
         if(hasAlertScoreChange && _loc3_)
         {
            _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
            _loc4_ = LanguageMgr.GetTranslation("alchemical.scoreUpgrade.alert",_loc3_.Data,_loc3_.TemplateName);
            if(_loc2_)
            {
               _loc2_.channel = 3;
               _loc2_.msg = _loc4_;
               _loc2_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc2_);
            }
         }
         hasAlertScoreChange = true;
      }
      
      public function get modelType() : int
      {
         return _modelType;
      }
      
      public function set modelType(param1:int) : void
      {
         if(_modelType == param1)
         {
            return;
         }
         _modelType = param1;
         MsgMan.notifyObserver("SELECT_MODELTYPE_CHANGE");
      }
   }
}

