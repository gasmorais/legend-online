package foisonhorn
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.FoisonHornManager;
   import mvc.module.foisonhorn.FoisonHornModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   
   public class FoisonHornFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _timeBmp:Bitmap;
      
      private var _ruleBmp:Bitmap;
      
      private var _countBmp:Bitmap;
      
      private var _itemList:Vector.<FoisonHornItem>;
      
      private var _timeTxt:FilterFrameText;
      
      private var _totalCountTxt:FilterFrameText;
      
      private var _ruleTxt:FilterFrameText;
      
      private var _rewardStripView:StripView;
      
      private var _rewardIcon:Bitmap;
      
      private var _activeBtn:IconButton;
      
      private var _hasActiveBtn:IconButton;
      
      public function FoisonHornFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         FoisonHornManager.instance.sendRequest(1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("foisonHornFrame.border");
         _back = ComponentFactory.Instance.creatBitmap("asset.FoisonHornFrame.frameBack");
         _titleBmp = ComponentFactory.Instance.creatBitmap("asset.FoisonHornFrame.frameTitle");
         _timeBmp = ComponentFactory.Instance.creatBitmap("asset.FoisonHornFrame.timeBmp");
         _ruleBmp = ComponentFactory.Instance.creatBitmap("asset.FoisonHornFrame.ruleBmp");
         _countBmp = ComponentFactory.Instance.creatBitmap("asset.FoisonHornFrame.countBmp");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("foisonHornFrame.timeTxt");
         _totalCountTxt = ComponentFactory.Instance.creatComponentByStylename("foisonHornFrame.totalCountTxt");
         _ruleTxt = ComponentFactory.Instance.creatComponentByStylename("foisonHornFrame.ruleTxt");
         _rewardStripView = ComponentFactory.Instance.creatCustomObject("foisonHornFrame.rewardStripView");
         _rewardIcon = ComponentFactory.Instance.creatBitmap("asset.FoisonHornFrame.rewardIcon");
         _activeBtn = ComponentFactory.Instance.creatComponentByStylename("foisonHornFrame.activeBtn");
         _hasActiveBtn = ComponentFactory.Instance.creatComponentByStylename("foisonHornFrame.hasActiveBtn");
         addToContent(_border);
         addToContent(_back);
         addToContent(_titleBmp);
         addToContent(_timeBmp);
         addToContent(_ruleBmp);
         addToContent(_countBmp);
         addToContent(_timeTxt);
         addToContent(_totalCountTxt);
         addToContent(_ruleTxt);
         addToContent(_rewardStripView);
         addToContent(_activeBtn);
         addToContent(_hasActiveBtn);
         _rewardStripView.addChild(_rewardIcon);
         _rewardStripView.setHitArea(0,0,_rewardIcon.width,_rewardIcon.height);
         _hasActiveBtn.visible = false;
         _hasActiveBtn.enable = false;
         initItem();
         _ruleTxt.htmlText = LanguageMgr.GetTranslation("foisonHornFrame.ruleTxt.content");
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FoisonHornItem = null;
         _itemList = new Vector.<FoisonHornItem>();
         _loc2_ = 0;
         while(_loc2_ < model.goodsList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("foisonhorn.FoisonHornItem",[_loc2_]);
            _loc1_.x = 284 + 72 * _loc2_;
            _loc1_.y = 267;
            addToContent(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("FOISONHORN_INFO_CHANGE",this,__updateInfoChange);
         _activeBtn.addEventListener("click",__activeBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("FOISONHORN_INFO_CHANGE",this,__updateInfoChange);
         if(_activeBtn)
         {
            _activeBtn.removeEventListener("click",__activeBtnClickHandler);
         }
      }
      
      private function __activeBtnClickHandler(param1:MouseEvent) : void
      {
         FoisonHornManager.instance.sendRequest(2);
      }
      
      private function __updateInfoChange(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         _timeTxt.text = model.openTime + " - " + model.stopTime;
         _totalCountTxt.text = model.totalCount + "";
         _rewardStripView.tipData = model.rewardInfo;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         for each(var _loc2_:FoisonHornItem in _itemList)
         {
            _loc2_.refreshView();
            if(_loc2_.canActive)
            {
               _loc3_++;
            }
            if(_loc2_.isActivated)
            {
               _loc1_++;
            }
         }
         _activeBtn.enable = _loc3_ >= _itemList.length;
         _activeBtn.visible = _loc1_ <= 0;
         _hasActiveBtn.visible = _loc1_ >= _itemList.length;
      }
      
      private function get model() : FoisonHornModel
      {
         return FoisonHornManager.instance.model;
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleBmp);
         _titleBmp = null;
         ObjectUtils.disposeObject(_timeBmp);
         _timeBmp = null;
         ObjectUtils.disposeObject(_ruleBmp);
         _ruleBmp = null;
         ObjectUtils.disposeObject(_countBmp);
         _countBmp = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_totalCountTxt);
         _totalCountTxt = null;
         ObjectUtils.disposeObject(_rewardStripView);
         _rewardStripView = null;
         ObjectUtils.disposeObject(_rewardIcon);
         _rewardIcon = null;
         ObjectUtils.disposeObject(_ruleTxt);
         _ruleTxt = null;
         ObjectUtils.disposeObject(_activeBtn);
         _activeBtn = null;
         ObjectUtils.disposeObject(_hasActiveBtn);
         _hasActiveBtn = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

