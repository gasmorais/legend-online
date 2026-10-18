package revenge
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.revenge.RevengeModel;
   import revenge.item.RevengeAreaBox;
   import revenge.item.RevengeCicleItem;
   import revenge.item.RevengeRewardBar;
   import revenge.view.RevengeRoadView;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.RevengeRoadManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldMapHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class RevengeRoadFrame extends Frame
   {
      
      private var _view:RevengeRoadView;
      
      private var _circle:RevengeCicleItem;
      
      private var _bar:RevengeRewardBar;
      
      private var _rewardList:Array;
      
      public function RevengeRoadFrame()
      {
         super();
         initView();
         RevengeRoadManager.Ins.sendGetData();
         initEvent();
      }
      
      private function get model() : RevengeModel
      {
         return RevengeRoadManager.Ins.model;
      }
      
      private function initView() : void
      {
         _view = new RevengeRoadView();
         addToContent(_view);
         _circle = ComponentFactory.Instance.creatCustomObject("revenge.item.RevengeCicleItem");
         _bar = ComponentFactory.Instance.creatCustomObject("revenge.item.RevengeRewardBar");
         _view.addChild(_circle);
         _view.addChild(_bar);
         _circle.num = 0;
         _view._renewTip.tipData = LanguageMgr.GetTranslation("revengeroad.main.text8",model.renewNum);
         initRewardAreaBox();
         refreshAreaBoxState();
      }
      
      private function initRewardAreaBox() : void
      {
         var _loc2_:RevengeAreaBox = null;
         var _loc1_:int = 0;
         _rewardList = [];
         _bar._rewardHbox.beginChanges();
         _loc1_ = 5;
         while(_loc1_ > 0)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("revenge.item.RevengeAreaBox");
            _loc2_.idx = _loc1_;
            _bar._rewardHbox.addChild(_loc2_);
            _rewardList[_loc1_ - 1] = _loc2_;
            _loc1_--;
         }
         _bar._rewardHbox.commitChanges();
         _bar._bar2.height = 0;
      }
      
      private function refreshAreaBoxState() : void
      {
         var _loc3_:Boolean = false;
         var _loc1_:int = 0;
         var _loc2_:Array = model.boxState.split(",");
         _loc1_ = 0;
         while(_loc1_ < _rewardList.length)
         {
            _rewardList[_loc1_]._getFlag.visible = _loc2_[_loc1_] == "1";
            _loc3_ = model.nodeId >= _rewardList[_loc1_].idx * 10;
            _rewardList[_loc1_].enable = _loc3_;
            _loc1_++;
         }
         boxProgress = model.nodeId;
      }
      
      public function set boxProgress(param1:int) : void
      {
         var _loc2_:int = param1 - 10;
         if(_loc2_ <= 0)
         {
            return;
         }
         var _loc3_:int = _loc2_ / 40 * _bar._bar1.height;
         _bar._bar2.height = _loc3_;
         _bar._bar2.y = _bar._bar1.y + _bar._bar1.height - _loc3_;
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _view._map["map" + _loc1_].addEventListener("click",mapClickFun);
            _loc1_++;
         }
         for each(var _loc2_:RevengeAreaBox in _rewardList)
         {
            _loc2_.addEventListener("click",boxClickHandler);
         }
         addEventListener("response",__frameResponse);
         _circle._buyBtn.addEventListener("click",_btnAddCountClickHandler);
         NotificationManager.instance.addEventListener("REVENGE_ROAD_DATA",dataHandler);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _view._map["map" + _loc1_].removeEventListener("click",mapClickFun);
            _loc1_++;
         }
         for each(var _loc2_:RevengeAreaBox in _rewardList)
         {
            _loc2_.removeEventListener("click",boxClickHandler);
         }
         removeEventListener("response",__frameResponse);
         _circle._buyBtn.removeEventListener("click",_btnAddCountClickHandler);
         NotificationManager.instance.removeEventListener("REVENGE_ROAD_DATA",dataHandler);
      }
      
      private function boxClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:RevengeAreaBox = param1.currentTarget as RevengeAreaBox;
         RevengeRoadManager.Ins.sendGetAreaBox(_loc2_.idx);
      }
      
      private function dataHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         _circle.num = model.revengeHeart;
         _loc2_ = 2;
         while(_loc2_ <= 5)
         {
            _view["_mapLock" + _loc2_].visible = model.nodeId / 10 + 1 < _loc2_;
            _loc2_++;
         }
         refreshAreaBoxState();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               model.currFightNodeId = -1;
               dispose();
         }
      }
      
      private function _btnAddCountClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("revengeroad.main.text5",model.buyTimePrice,model.MAX_VALUE,model.buyTimeMax - model.buyCount);
         SimpleAlertHelper.instance.data = [realBuy];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,true,true);
      }
      
      private function realBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            RevengeRoadManager.Ins.sendBuyHeart();
         }
      }
      
      private function mapClickFun(param1:MouseEvent) : void
      {
         var _loc3_:String = param1.currentTarget.name;
         var _loc2_:int = int(WorldMapHelper.tagNameToMapId(_loc3_));
         var _loc4_:int = (_loc2_ - 1) * 10 + 1;
         if(_loc4_ - 1 > model.nodeId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("revengeroad.main.text3"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("revengeroad","node",_loc2_);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:RevengeAreaBox in _rewardList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _rewardList = null;
         ObjectUtils.disposeObject(_circle);
         _circle = null;
         ObjectUtils.disposeObject(_bar);
         _bar = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show() : void
      {
         var _loc1_:int = 0;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(model.currFightNodeId > 0)
         {
            _loc1_ = (model.currFightNodeId - 1) / 10 + 1;
            FrameControllerManager.instance.openControllerByInfo("revengeroad","node",_loc1_);
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

