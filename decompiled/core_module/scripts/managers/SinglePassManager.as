package managers
{
   import com.road.yishi.proto.tollgate.RankInfoMsg;
   import com.road.yishi.proto.tollgate.SinglePassMsg;
   import com.road.yishi.proto.vip.VipRouletteMsg;
   import manager.LanguageMgr;
   import mvc.module.singlepass.SinglePassBugleInfo;
   import mvc.module.singlepass.SinglePassCardInfo;
   import mvc.module.singlepass.SinglePassModel;
   import tasktracetip.data.TipMessageData;
   import yishi.actions.base.AlertTipAction;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GodArriveData;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SinglePassManager
   {
      
      private static var _instance:SinglePassManager;
      
      private var isFirstGetSinglePassInfo:Boolean = true;
      
      private var _bugleLeftCount:int;
      
      private var _model:SinglePassModel;
      
      public function SinglePassManager()
      {
         super();
         _model = new SinglePassModel();
      }
      
      public static function get instance() : SinglePassManager
      {
         if(!_instance)
         {
            _instance = new SinglePassManager();
         }
         return _instance;
      }
      
      public function get model() : SinglePassModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.listener(4551,__updateAreaHandler);
         SocketManager.instance.listener(4552,__resSinglePassInfoHandler);
         SocketManager.instance.listener(4553,__bugleReqHandler);
         SocketManager.instance.listener(4554,__bugleRewardsHandler);
      }
      
      private function __updateAreaHandler(param1:SLGSocketEvent) : void
      {
      }
      
      private function __resSinglePassInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:SinglePassCardInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SinglePassMsg = new SinglePassMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SinglePassMsg;
         _model.area = _loc2_.area;
         _model.maxIndex = _loc2_.maxIndex;
         _model.areaReward = _loc2_.areaReward;
         _model.count = _loc2_.count;
         _model.itemCount = _loc2_.itemCount;
         for each(var _loc4_:RankInfoMsg in _loc2_.rankInfo)
         {
            _loc3_ = _model.getCardInfoByIndex(_loc4_.index);
            _loc3_.judge = _loc4_.rank;
         }
         _model.initFloors();
         _model.commit();
         if(isFirstGetSinglePassInfo)
         {
            isFirstGetSinglePassInfo = false;
            _bugleLeftCount = int(_model.maxIndex / 5) * _model.bugleCount - _model.itemCount;
            if(_bugleLeftCount > 0)
            {
               DelayActionsUtils.instance.addAction(new AlertTipAction("",showHasBugleTips));
            }
         }
      }
      
      private function showHasBugleTips(param1:String = "") : void
      {
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.type = 43;
         _loc2_.content = LanguageMgr.GetTranslation("taskTrace.SinglepassHasBugleYipsView.singlePassHas");
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = 3150001;
         _loc3_.count = _bugleLeftCount;
         _loc2_.goods = _loc3_;
         TaskTraceTipManager.instance.showView(_loc2_);
      }
      
      private function __bugleReqHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VipRouletteMsg = new VipRouletteMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VipRouletteMsg;
         var _loc4_:SinglePassBugleInfo = new SinglePassBugleInfo();
         _loc4_.itemList = _loc2_.leftItem;
         _model.updateBugleInfo(_loc4_);
      }
      
      private function __bugleRewardsHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VipRouletteMsg = new VipRouletteMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VipRouletteMsg;
         var _loc4_:SinglePassBugleInfo = new SinglePassBugleInfo();
         _loc4_.needPoint = _loc2_.needVipItem;
         _loc4_.openCount = _loc2_.leftCount;
         _loc4_.openIndex = _loc2_.openIndex;
         _loc4_.itemList = _loc2_.leftItem;
         _model.updateBugleRewards(_loc4_);
      }
      
      public function sendRequestSinglePassAttack(param1:int) : void
      {
         var _loc6_:String = null;
         var _loc2_:int = GoodsManager.instance.getGoodsNumByTempId(3140001);
         if(_model.count >= _model.maxCount && _loc2_ <= 0)
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.SinglePassManager.TipsTxt01");
            MessageTipManager.instance().show(_loc6_);
            return;
         }
         if(param1 > _model.maxIndex + 1)
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.SinglePassManager.TipsTxt02");
            MessageTipManager.instance().show(_loc6_);
            return;
         }
         if(_model.isMaxJudge(param1))
         {
            _loc6_ = LanguageMgr.GetTranslation("managers.SinglePassManager.TipsTxt03");
            MessageTipManager.instance().show(_loc6_);
            return;
         }
         var _loc4_:SinglePassCardInfo = _model.getCardInfoByIndex(param1);
         var _loc3_:GodArriveData = TempleteManager.instance.godArriveTemplateCate.getGodArriveData(40001,_loc4_.tollgate);
         var _loc5_:Array = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.PetTypeList").split("|");
         _loc6_ = LanguageMgr.GetTranslation("singlepass.SinglePassView.SinglePassAttack");
         if(_loc4_.judge > 0)
         {
            _loc6_ = LanguageMgr.GetTranslation("singlepass.SinglePassView.SinglePassAttackAgain");
         }
         else
         {
            _loc6_ += LanguageMgr.GetTranslation("singlepass.SinglePassView.Suggest",_loc5_[_loc3_.Param5 - 1]);
         }
         SimpleAlertHelper.instance.data = [beginBattle,param1];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc6_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"));
      }
      
      private function beginBattle(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            _model.selectIndex = param3;
            _model.lastIndex = param3;
            SinglePassSocketOutManager.sendRequestSinglePassAttack(param3);
         }
      }
      
      public function sendRequestGetAreaReward() : void
      {
         var _loc1_:String = null;
         if(_model.selectArea == _model.area && _model.maxIndex == _model.area * 10)
         {
            SinglePassSocketOutManager.sendRequestGetAreaReward();
         }
         else
         {
            _loc1_ = LanguageMgr.GetTranslation("managers.SinglePassManager.TipsTxt04");
            MessageTipManager.instance().show(_loc1_);
         }
      }
      
      public function needTurnNext() : Boolean
      {
         var _loc2_:int = _model.selectArea * 10;
         var _loc1_:int = _loc2_ - 10 + 1;
         if(getCardIndex() != 0 && _model.lastIndex == _model.maxIndex && _model.maxIndex != _loc2_ && _model.selectArea == _model.area)
         {
            return true;
         }
         return false;
      }
      
      public function getCardIndex() : int
      {
         var _loc2_:int = _model.selectArea * 10;
         var _loc1_:int = _loc2_ - 10 + 1;
         if(_model.selectArea == _model.area && _model.selectIndex >= _loc1_ && _model.selectIndex <= _loc2_)
         {
            if(_model.selectIndex == _loc2_)
            {
               return 10 - 1;
            }
            return _model.selectIndex - _loc1_ + 1;
         }
         return 0;
      }
   }
}

