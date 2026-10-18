package mvc.module.magicspring
{
   import managers.MagicSpringManager;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.MagicSpringFormulaTempInfo;
   import yishi.utils.MsgMan;
   
   public class MagicSpringModel
   {
      
      private var _selectFormula:MagicSpringFormulaTempInfo;
      
      public var potionCount1:int;
      
      public var potionCount2:int;
      
      public var potionCount3:int;
      
      public var openSlotCount:int = 1;
      
      public var slotList:Array;
      
      public var potionTempArr:Array;
      
      public var slotOpenCount:Array;
      
      public var slotNeedCost:Array;
      
      public function MagicSpringModel()
      {
         super();
         slotList = [];
         potionTempArr = ConfigInfoManager.instance.getMagicSpringItemTempId();
         slotOpenCount = ConfigInfoManager.instance.getMagicSpringSlotOpenCount();
         slotNeedCost = ConfigInfoManager.instance.getMagicSpringOpenSlotCost();
      }
      
      public function get selectFormula() : MagicSpringFormulaTempInfo
      {
         return _selectFormula;
      }
      
      public function set selectFormula(param1:MagicSpringFormulaTempInfo) : void
      {
         if(_selectFormula == param1)
         {
            return;
         }
         _selectFormula = param1;
         MsgMan.notifyObserver("SELECT_FORMULA_CHANGE");
      }
      
      public function getFormulaInfoByTempId(param1:int) : MagicSpringSlotInfo
      {
         for each(var _loc2_:MagicSpringSlotInfo in slotList)
         {
            if(_loc2_.tempId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function checkBufferTime() : void
      {
         var _loc1_:Boolean = false;
         for each(var _loc2_:MagicSpringSlotInfo in slotList)
         {
            if(_loc2_.validCountDown <= 0)
            {
               _loc1_ = true;
               break;
            }
            _loc2_.validCountDown--;
         }
         if(_loc1_)
         {
            MagicSpringManager.instance.sendMagicSpringRequest(4);
         }
      }
      
      public function getIndxByTempId(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:MagicSpringSlotInfo = null;
         _loc2_ = 0;
         while(_loc2_ < slotList.length)
         {
            _loc3_ = slotList[_loc2_];
            if(_loc3_.tempId == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return slotList.length;
      }
      
      public function checkIsExistBuffer(param1:int) : MagicSpringSlotInfo
      {
         var _loc2_:MagicSpringSlotInfo = getFormulaInfoByTempId(param1);
         if(_loc2_ && _loc2_.validCountDown > 0)
         {
            return _loc2_;
         }
         return null;
      }
   }
}

