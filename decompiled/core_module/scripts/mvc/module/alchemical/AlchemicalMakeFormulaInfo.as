package mvc.module.alchemical
{
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.AlchemicalFormulaTempInfo;
   import yishi.manager.AlchemicalManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class AlchemicalMakeFormulaInfo
   {
      
      public var shareUid:int = -1;
      
      public var formulaId:int;
      
      public var startTime:int;
      
      public var childFormulaList:Array;
      
      public function AlchemicalMakeFormulaInfo()
      {
         super();
         if(childFormulaList == null)
         {
            childFormulaList = [];
         }
      }
      
      public function getChildFormulaInfoByIndex(param1:int) : AlchemicalChildFormulaInfo
      {
         for each(var _loc2_:AlchemicalChildFormulaInfo in childFormulaList)
         {
            if(_loc2_.childIndex == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get tempInfo() : AlchemicalFormulaTempInfo
      {
         return TempleteManager.instance.alchemicalFormulaTempCate.getTempInfoById(formulaId);
      }
      
      public function get isCooperation() : Boolean
      {
         return shareUid != -1;
      }
      
      public function get isMutiFormula() : Boolean
      {
         return tempInfo && tempInfo.Type == 1;
      }
      
      public function get stepCount() : int
      {
         if(!tempInfo)
         {
            return 0;
         }
         return tempInfo.NeedItem.split("|").length;
      }
      
      public function getNeedItemArrByIndex(param1:int = -1) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = [];
         if(!tempInfo)
         {
            return _loc5_;
         }
         if(isMutiFormula && param1 != -1)
         {
            _loc3_ = tempInfo.NeedItem.split("|")[param1];
         }
         else
         {
            _loc3_ = tempInfo.NeedItem;
         }
         _loc2_ = _loc3_.split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_.push(_loc2_[_loc4_].split(":"));
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function get rewardItemArr() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         if(!tempInfo)
         {
            return _loc3_;
         }
         var _loc1_:Array = tempInfo.Reward.split(",");
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].split(":")[0] != 700000)
            {
               _loc3_.push(_loc1_[_loc2_].split(":"));
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function get allName() : String
      {
         var _loc2_:String = "";
         for each(var _loc1_:AlchemicalChildFormulaInfo in childFormulaList)
         {
            _loc2_ += _loc1_.nickName + " ";
         }
         return _loc2_;
      }
      
      public function get formulaLeftTime() : String
      {
         var _loc1_:int = ConfigInfoManager.instance.getAlchemicalFormulaMaxTime();
         var _loc2_:int = startTime + _loc1_ * 3600 - playerModel.sysCurTimeBySecond;
         if(_loc2_ > 0)
         {
            return DateFormatter.getConsortiaCountDate(_loc2_);
         }
         return LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
      }
      
      public function get isSelfJoin() : Boolean
      {
         for each(var _loc1_:AlchemicalChildFormulaInfo in childFormulaList)
         {
            if(_loc1_.userId == playerModel.playerInfo.userId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get casalystCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:AlchemicalChildFormulaInfo in childFormulaList)
         {
            if(_loc1_.isAddCatalyst)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function get isOpen() : Boolean
      {
         if(!tempInfo)
         {
            return false;
         }
         return alchemicalModel.curScore >= tempInfo.NeedScore;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get alchemicalModel() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
   }
}

