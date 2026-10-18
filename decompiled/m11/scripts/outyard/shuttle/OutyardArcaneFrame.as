package outyard.shuttle
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ArrayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.shuttle.ArcaneZoneMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardArcaneFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _goodList:Array;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxtBack:DisplayObject;
      
      private var _pageTxt:FilterFrameText;
      
      private var _scoreBmp:Bitmap;
      
      private var _forbiddenBmp:Bitmap;
      
      private var _buyLeftTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int;
      
      private var _countGood:int = 0;
      
      private var _discountList:Array = [];
      
      private var _perPage:int = 3;
      
      private var _noteTxt:FilterFrameText;
      
      public function OutyardArcaneFrame()
      {
         super();
         initView();
         addEvent();
         OutyardManager.instance.OperateArcane(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,753,602);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:OutyardArcaneItem = null;
         titleText = LanguageMgr.GetTranslation("outyard.OutyardArcaneFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.outyard.arcane.bg");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.NextPageBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.LastPageBtn");
         _pageTxtBack = ComponentFactory.Instance.creatBitmap("asset.outyard.arcane.pageNumBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.PageTextStyle1");
         _scoreBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.arcane.scoreBmp");
         _forbiddenBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.arcane.forbiddenBmp");
         _buyLeftTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.buyLeftTxt");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.addArcaneBtn");
         _noteTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.arcane.noteTxt");
         addToContent(_bg);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_pageTxtBack);
         addToContent(_pageTxt);
         addToContent(_scoreBmp);
         addToContent(_forbiddenBmp);
         addToContent(_buyLeftTxt);
         addToContent(_addBtn);
         addToContent(_noteTxt);
         _goodList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new OutyardArcaneItem();
            _loc1_.x = _loc2_ * 234 + 1;
            _loc1_.y = 20;
            addToContent(_loc1_);
            _goodList.push(_loc1_);
            _loc2_++;
         }
         _noteTxt.text = LanguageMgr.GetTranslation("outyard.OutyardArcaneFrame.noteTips");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _preBtn.addEventListener("click",_preHandler);
         _nextBtn.addEventListener("click",_nextHandler);
         _addBtn.addEventListener("click",_addHandler);
         NotificationManager.instance.addEventListener("UPDATE_ARCANE_VIEW",__updateArcaneHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _preBtn.removeEventListener("click",_preHandler);
         _nextBtn.removeEventListener("click",_nextHandler);
         _addBtn.removeEventListener("click",_addHandler);
         NotificationManager.instance.removeEventListener("UPDATE_ARCANE_VIEW",__updateArcaneHandler);
      }
      
      private function __updateArcaneHandler(param1:NotificationEvent) : void
      {
         var _loc2_:ArcaneZoneMsg = OutyardManager.instance.shuttleModel.arcaneMsg;
         if(_loc2_.op == 1 || _loc2_.op == 5)
         {
            _discountList = ArrayUtils.cloneArray(_loc2_.bossList);
            _currentPage = 1;
            updateView();
         }
         var _loc3_:int = int(ConfigInfoManager.instance.getArcaneZoneMax());
         _buyLeftTxt.text = _loc2_.arcaneZoneCount + "/" + _loc3_;
      }
      
      private function _addHandler(param1:MouseEvent) : void
      {
         var checkTxt:String;
         var content:String;
         var event:MouseEvent = param1;
         var payCallBack:* = function():void
         {
            if(buyCountMax[1] > PlayerManager.instance.currentPlayerModel.playerInfo.point)
            {
               RechargeAlertMannager.show();
               return;
            }
            OutyardManager.instance.OperateArcane(4);
         };
         var arcaneMsg:ArcaneZoneMsg = OutyardManager.instance.shuttleModel.arcaneMsg;
         var arcaneMax:int = int(ConfigInfoManager.instance.getArcaneZoneMax());
         var buyCountMax:Array = ConfigInfoManager.instance.getArcaneZoneBuyCount();
         if(arcaneMsg.arcaneZoneBuyCount >= int(buyCountMax[0]))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardArcaneFrame.buyCountText"));
            return;
         }
         if(arcaneMsg.arcaneZoneCount >= arcaneMax)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardArcaneFrame.countText"));
            return;
         }
         checkTxt = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         content = LanguageMgr.GetTranslation("outyard.OutyardArcaneFrame.addTxt",buyCountMax[1],1);
         SharedManagerHelper.ins.needAlert("outyard.OutyardShuttleView.ResetAlert",payCallBack,checkTxt,content);
      }
      
      private function _preHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage - 1;
         updateView();
         updatePageView();
      }
      
      private function _nextHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         updateView();
         updatePageView();
      }
      
      private function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _countGood = 0;
         if(_discountList.length % _perPage != 0 || _discountList.length == 0)
         {
            _totalPage = _discountList.length / _perPage + 1;
         }
         else
         {
            _totalPage = _discountList.length / _perPage;
         }
         _loc2_ = 0;
         while(_loc2_ < _perPage)
         {
            if(_currentPage - 1 < 0)
            {
               _loc1_ = _loc2_;
            }
            else
            {
               _loc1_ = _loc2_ + (_currentPage - 1) * _perPage;
            }
            if(_discountList.length > _loc1_)
            {
               _countGood = _countGood + 1;
               _goodList[_loc2_].data = _discountList[_loc1_];
            }
            else
            {
               _goodList[_loc2_].data = null;
            }
            _loc2_++;
         }
         updatePageView();
      }
      
      private function updatePageView() : void
      {
         _pageTxt.text = _currentPage + "/" + _totalPage;
         if(_currentPage == 1)
         {
            _preBtn.enable = false;
         }
         else
         {
            _preBtn.enable = true;
         }
         if(_currentPage == _totalPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageTxtBack);
         _pageTxtBack = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_scoreBmp);
         _scoreBmp = null;
         ObjectUtils.disposeObject(_forbiddenBmp);
         _forbiddenBmp = null;
         ObjectUtils.disposeObject(_buyLeftTxt);
         _buyLeftTxt = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_noteTxt);
         _noteTxt = null;
         if(_goodList)
         {
            while(_goodList.length)
            {
               ObjectUtils.disposeObject(_goodList.pop());
            }
         }
         _goodList = null;
         _discountList = null;
         super.dispose();
      }
   }
}

