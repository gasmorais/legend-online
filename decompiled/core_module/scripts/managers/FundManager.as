package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.active.DepositActiveMsg;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import mvc.module.fund.ActiveParmaInfo;
   import mvc.module.fund.FundInfo;
   import mvc.module.fund.GLogInfo;
   import mvc.module.fund.GetItemInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.FundEvent;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FundManager extends EventDispatcher
   {
      
      private static var _instance:FundManager;
      
      private var _model:FundInfo;
      
      private var _newbieModel:FundInfo;
      
      public var isUseOpen:Boolean = false;
      
      public var isNewbie:Boolean = false;
      
      public var getFlag:Boolean = false;
      
      public var getIndex:int = 0;
      
      public function FundManager()
      {
         super();
      }
      
      public static function get instance() : FundManager
      {
         if(!_instance)
         {
            _instance = new FundManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
         _model = new FundInfo();
         _newbieModel = new FundInfo();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4612,__getFundInfo);
      }
      
      public function fundOperate(param1:int = 0, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8703);
         var _loc3_:DepositActiveMsg = new DepositActiveMsg();
         _loc3_.opType = param1;
         _loc3_.opParam = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function fundNewOperate(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(8703);
         var _loc4_:DepositActiveMsg = new DepositActiveMsg();
         _loc4_.opType = param1;
         _loc4_.opParam = param2;
         if(param3 != 0)
         {
            _loc4_.sort = param3;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      private function __getFundInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DepositActiveMsg = new DepositActiveMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DepositActiveMsg;
         model.activeId = int(_loc2_.activeId);
         model.title = _loc2_.title;
         model.contents = _loc2_.contents;
         model.activeType = _loc2_.activeType;
         model.description = _loc2_.description;
         model.chargePoint = _loc2_.chargePoint;
         if(_loc2_.actionTimeContent)
         {
            model.actionTimeContent = Int64Utils.int64ToNumber(_loc2_.actionTimeContent) / 1000;
         }
         model.consortia = _loc2_.consortia;
         model.grades = _loc2_.grades;
         if(_loc2_.setStartDate)
         {
            model.setStartDate = Int64Utils.int64ToNumber(_loc2_.setStartDate) / 1000;
         }
         if(_loc2_.setEndDate)
         {
            model.setEndDate = Int64Utils.int64ToNumber(_loc2_.setEndDate) / 1000;
         }
         if(_loc2_.getStartDate)
         {
            model.getStartDate = Int64Utils.int64ToNumber(_loc2_.getStartDate) / 1000;
         }
         if(_loc2_.getEndDate)
         {
            model.getEndDate = Int64Utils.int64ToNumber(_loc2_.getEndDate) / 1000;
         }
         model.depositLevel = _loc2_.depositLevel;
         if(_loc2_.depositTime)
         {
            model.depositTime = Int64Utils.int64ToNumber(_loc2_.depositTime) / 1000;
         }
         model.newActiveArr = _loc2_.activeParams;
         model.getNewLogArr = _loc2_.logs;
         if(_loc2_.harvestedInfos)
         {
            model.hasGetInfo = _loc2_.harvestedInfos;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("FUND_REFRESH"));
         if(!isUseOpen)
         {
            dispatchEvent(new FundEvent("SHOWTOPBTN"));
         }
         dispatchEvent(new FundEvent("OPEN"));
         switch(model.activeType - 1)
         {
            case 0:
               if(_loc2_.depositLevel >= 1)
               {
                  dispatchEvent(new FundEvent("SHOWGET"));
               }
               if(isUseOpen)
               {
                  FrameControllerManager.instance.openControllerByInfo("fund",2);
                  isUseOpen = false;
               }
               break;
            case 1:
               if(_loc2_.depositLevel < 1)
               {
                  return;
               }
               if(isUseOpen)
               {
                  FrameControllerManager.instance.openControllerByInfo("fund",2);
                  isUseOpen = false;
               }
               break;
            case 2:
               if(isUseOpen)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04"));
                  dispatchEvent(new FundEvent("SHOWTOPBTN"));
                  isUseOpen = false;
               }
         }
         InfoTipsManager.instance.dealData(22);
      }
      
      public function getCanGetGift() : Boolean
      {
         var _loc1_:ActiveParmaInfo = null;
         var _loc8_:Array = null;
         var _loc3_:Array = null;
         var _loc7_:GetItemInfo = null;
         var _loc4_:int = 0;
         var _loc2_:GLogInfo = null;
         var _loc5_:int = 0;
         var _loc6_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(model.activeType == 1 && model.depositLevel == 0)
         {
            return true;
         }
         if(model.activeType == 2 && model.depositLevel > 0)
         {
            _loc1_ = model.getNewActiveByLevel(model.depositLevel);
            _loc8_ = model.getNewLogArr;
            _loc3_ = _loc1_.newGetInfos;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc7_ = _loc3_[_loc4_] as GetItemInfo;
               if(_loc6_ >= model.getStartDate + _loc7_.interval * 60)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.length)
                  {
                     _loc2_ = _loc8_[_loc5_] as GLogInfo;
                     if(_loc2_.type == _loc7_.times)
                     {
                        return false;
                     }
                     _loc5_++;
                  }
                  return true;
               }
               _loc4_++;
            }
            return false;
         }
         return false;
      }
      
      public function getShowBtn() : Boolean
      {
         if(ArmyManager.instance.thane.grades < 11)
         {
            return false;
         }
         if(model.activeType == 1)
         {
            return true;
         }
         if(model.activeType == 2 && model.depositLevel > 0)
         {
            return true;
         }
         return false;
      }
      
      public function fundNewbieOperate(param1:int = 0, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8751);
         var _loc3_:DepositActiveMsg = new DepositActiveMsg();
         _loc3_.opType = param1;
         _loc3_.opParam = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      private function __getFundNewbieInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DepositActiveMsg = new DepositActiveMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DepositActiveMsg;
         newbieModel.activeId = int(_loc2_.activeId);
         newbieModel.title = _loc2_.title;
         newbieModel.contents = _loc2_.contents;
         newbieModel.activeType = _loc2_.activeType;
         newbieModel.description = _loc2_.description;
         if(_loc2_.activeType != 1 && _loc2_.activeType != 2)
         {
            FrameControllerManager.instance.fundController.closeFrame();
         }
         if(_loc2_.actionTimeContent)
         {
            newbieModel.actionTimeContent = Int64Utils.int64ToNumber(_loc2_.actionTimeContent) / 1000;
         }
         newbieModel.consortia = _loc2_.consortia;
         newbieModel.grades = _loc2_.grades;
         if(_loc2_.setStartDate)
         {
            newbieModel.setStartDate = Int64Utils.int64ToNumber(_loc2_.setStartDate) / 1000;
         }
         if(_loc2_.setEndDate)
         {
            newbieModel.setEndDate = Int64Utils.int64ToNumber(_loc2_.setEndDate) / 1000;
         }
         if(_loc2_.getStartDate)
         {
            newbieModel.getStartDate = Int64Utils.int64ToNumber(_loc2_.getStartDate) / 1000;
         }
         if(_loc2_.getEndDate)
         {
            newbieModel.getEndDate = Int64Utils.int64ToNumber(_loc2_.getEndDate) / 1000;
         }
         newbieModel.depositLevel = _loc2_.depositLevel;
         if(_loc2_.depositTime)
         {
            newbieModel.depositTime = Int64Utils.int64ToNumber(_loc2_.depositTime) / 1000;
         }
         newbieModel.activeArr = _loc2_.activeParams;
         newbieModel.getLogArr = _loc2_.logs;
         if(_loc2_.harvestedInfos)
         {
            newbieModel.hasGetInfo = _loc2_.harvestedInfos;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("FUND_REFRESH"));
         if(!isUseOpen)
         {
            dispatchEvent(new FundEvent("SHOWTOPBTN"));
         }
         dispatchEvent(new FundEvent("OPEN"));
         switch(newbieModel.activeType - 1)
         {
            case 0:
               if(_loc2_.depositLevel >= 1)
               {
                  dispatchEvent(new FundEvent("SHOWGET"));
               }
               if(isUseOpen)
               {
                  FrameControllerManager.instance.openControllerByInfo("fund",1);
                  isUseOpen = false;
               }
               break;
            case 1:
               if(_loc2_.depositLevel < 1)
               {
                  return;
               }
               if(isUseOpen)
               {
                  FrameControllerManager.instance.openControllerByInfo("fund",1);
                  isUseOpen = false;
               }
               break;
            case 2:
               if(isUseOpen)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04"));
                  dispatchEvent(new FundEvent("SHOWTOPBTN"));
                  isUseOpen = false;
               }
         }
         InfoTipsManager.instance.dealData(22);
      }
      
      public function getNewbieCanGetGift() : Boolean
      {
         var _loc1_:ActiveParmaInfo = null;
         var _loc7_:Array = null;
         var _loc3_:Array = null;
         var _loc6_:GetItemInfo = null;
         var _loc4_:int = 0;
         var _loc2_:GLogInfo = null;
         var _loc5_:int = 0;
         if(newbieModel.activeType == 1 && newbieModel.depositLevel == 0)
         {
            return true;
         }
         if(newbieModel.activeType == 2 && newbieModel.depositLevel > 0)
         {
            _loc1_ = newbieModel.getActiveByLevel(newbieModel.depositLevel);
            _loc7_ = newbieModel.getLogArr;
            _loc3_ = _loc1_.getInfos;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc6_ = _loc3_[_loc4_] as GetItemInfo;
               if(ArmyManager.instance.thane.grades >= _loc6_.interval)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc7_.length)
                  {
                     _loc2_ = _loc7_[_loc5_] as GLogInfo;
                     if(_loc2_.type == _loc6_.times)
                     {
                        return false;
                     }
                     _loc5_++;
                  }
                  return true;
               }
               _loc4_++;
            }
            return false;
         }
         return false;
      }
      
      public function getNewbieShowBtn() : Boolean
      {
         if(ArmyManager.instance.thane.grades < 6)
         {
            return false;
         }
         if(newbieModel.activeType == 1)
         {
            return true;
         }
         if(newbieModel.activeType == 2 && newbieModel.depositLevel > 0)
         {
            return true;
         }
         return false;
      }
      
      public function get model() : FundInfo
      {
         return _model;
      }
      
      public function get newbieModel() : FundInfo
      {
         return _newbieModel;
      }
   }
}

