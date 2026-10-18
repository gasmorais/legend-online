package skytreasure
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkyTreasureEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureActTemplateInfo;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.SkyTreasureManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SkyTreasureFrame1 extends Frame implements IManualSize
   {
      
      private var _index:int = 1;
      
      public var _tabSpanel:ScrollPanel;
      
      private var _helpBtn:BaseButton;
      
      public var _tabVbox:VBox;
      
      public var _redArr:Array = [];
      
      public var _btnList:SelectedButtonGroup;
      
      private var _view:SkyTreasureExchangeView;
      
      private var _viewLo:SkyTreasureLotteryView;
      
      private var _back:DisplayObject;
      
      public var _fgx1:Bitmap;
      
      public var _tabBg:Bitmap;
      
      public function SkyTreasureFrame1()
      {
         SkyTreasureManager.Instance.sendSkyTreasureRankInfoReq();
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("secretary.view.SecretaryCompentView.back");
         _back.width = 918;
         _back.height = 485;
         titleText = LanguageMgr.GetTranslation("skyTreasure.frame.title");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("SkyTreasuremainRankView.helpBtn");
         _fgx1 = ComponentFactory.Instance.creatBitmap("asset.skysecrearytary.leftbg");
         _tabBg = ComponentFactory.Instance.creatBitmap("asset.skysecrearytary.leftfengexianline");
         _tabSpanel = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureFrame.tabSpanel");
         addToContent(_back);
         addToContent(_tabBg);
         addToContent(_fgx1);
         _tabVbox = ComponentFactory.Instance.creatCustomObject("skyTreasure.otherVbox");
         _view = new SkyTreasureExchangeView();
         _viewLo = new SkyTreasureLotteryView();
         _viewLo.x = 110;
         _view.x = 160;
         _view.visible = false;
         _tabSpanel.setView(_tabVbox);
         initData();
         addToContent(_viewLo);
         addToContent(_view);
         addToContent(_tabSpanel);
         addToContent(_helpBtn);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,940,580);
      }
      
      private function initData() : void
      {
         var _loc5_:SelectedTextButton = null;
         var _loc4_:int = 0;
         var _loc1_:Bitmap = null;
         _btnList = new SelectedButtonGroup();
         var _loc2_:Array = model.getAllSkyTreasureFrameOpenActTempData();
         var _loc3_:int = int(_loc2_ ? _loc2_.length : 0);
         _tabVbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureTabItem.Btn");
            _loc5_.text = _loc2_[_loc4_].actDesc;
            _loc5_.y = _loc4_ * (_loc5_.height + 15);
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.sky.red");
            _loc1_.x = 110;
            _loc5_.addChild(_loc1_);
            _redArr.push(_loc1_);
            _tabVbox.addChild(_loc5_);
            _btnList.addSelectItem(_loc5_);
            _loc4_++;
         }
         _tabVbox.commitChanges();
         _tabSpanel.invalidateViewport();
         if(model.actIsLotteryType(_loc2_[0].actType))
         {
            _viewLo.updateRewards(_loc2_[0]);
            _viewLo.visible = true;
         }
         else
         {
            model.currShowActId = _loc2_[0].actId;
            _view.update(_loc2_[0]);
            _view.visible = true;
            _viewLo.visible = false;
         }
         SkyTreasureManager.Instance.sendSkyTreasureLotteryRecordReq(_loc2_[0].actId);
         _btnList.selectIndex = 0;
         updateRed();
      }
      
      public function updateRed(param1:SkyTreasureEvent = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = model.getAllSkyTreasureFrameOpenActTempData();
         _loc3_ = 0;
         while(_loc3_ < _btnList.itemLength)
         {
            _redArr[_loc3_].visible = model.getred(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      private function __onTabClick(param1:Event) : void
      {
         _index = param1.currentTarget.selectIndex;
         var _loc2_:SkyTreasureActTemplateInfo = model.getAllSkyTreasureFrameOpenActTempData()[_index];
         if(!_loc2_)
         {
            return;
         }
         model.currShowActId = _loc2_.actId;
         if(model.actIsLotteryType(_loc2_.actType))
         {
            _viewLo.visible = true;
            _viewLo.updateRewards(_loc2_);
            SkyTreasureManager.Instance.sendSkyTreasureLotteryRecordReq(_loc2_.actId);
            _view.visible = false;
         }
         else
         {
            _viewLo.visible = false;
            _view.update(_loc2_);
            _view.visible = true;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnList.addEventListener("change",__onTabClick);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_LOTTERYINFO_UPDATE",updateRed);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_EXCHANGEINFO_UPDATE",updateRed);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function __disposeAction(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __dispose(param1:String, param2:Object) : void
      {
         if(!this.visible)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         _btnList.removeEventListener("change",__onTabClick);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_LOTTERYINFO_UPDATE",updateRed);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_EXCHANGEINFO_UPDATE",updateRed);
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpClickHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("SkyTreasuremainRankView.helperFrame");
         _loc2_.show();
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
      
      private function get model() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_viewLo);
         _viewLo = null;
         ObjectUtils.disposeObject(_tabVbox);
         _tabVbox = null;
         ObjectUtils.disposeObject(_btnList);
         _btnList = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_fgx1);
         _fgx1 = null;
         ObjectUtils.disposeObject(_tabBg);
         _tabBg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

