package outercityshop
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.MysteryShopEvent;
   import events.OuterCityShopEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.OuterCityShopManager;
   import mvc.controler.OuterCityShopControler;
   import mvc.module.outercityshop.OuterCityShopModel;
   import outercityshop.view.OuterCityShopExchangeView;
   import outercityshop.view.OuterCityShopLeftView;
   import outercityshop.view.OuterCityShopRandomView;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class OuterCityShopFrame extends Frame implements IManualSize
   {
      
      private var _leftView:OuterCityShopLeftView;
      
      private var _randomView:OuterCityShopRandomView;
      
      private var _exchangeView:OuterCityShopExchangeView;
      
      private var _randomButton:SelectedIconButton;
      
      private var _exchangeButton:SelectedIconButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _freshTimeTxt:FilterFrameText;
      
      private var _downTime:TimeDownView;
      
      private var _leftBackBg:Scale9CornerImage;
      
      private var _rightBackBg:Scale9CornerImage;
      
      private var _upBack:Bitmap;
      
      private var _dailyCountTxt:FilterFrameText;
      
      private var _pointsShowBack:Bitmap;
      
      private var _pointsShow:Image;
      
      private var _pointsShowTxt:FilterFrameText;
      
      private var _stonesShowBack:Bitmap;
      
      private var _stonesShow:Bitmap;
      
      private var _stonesShowTxt:FilterFrameText;
      
      private var _stripView:StripView;
      
      private var _helpBtn:BaseButton;
      
      private var MAX_COUNT:int = 10;
      
      public function OuterCityShopFrame()
      {
         super();
         initView();
         initData();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,775,525);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("ShopFresh_DayCount");
         if(_loc1_)
         {
            MAX_COUNT = int(_loc1_.ConfigValue);
         }
         _leftBackBg = ComponentFactory.Instance.creatComponentByStylename("outercityshop.leftBackBg");
         _rightBackBg = ComponentFactory.Instance.creatComponentByStylename("outercityshop.rightBackBg");
         _upBack = ComponentFactory.Instance.creatBitmap("asset.outercityshop.upBack");
         _dailyCountTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.DailyCountTxt");
         _pointsShowBack = ComponentFactory.Instance.creatBitmap("asset.outercityshop.displayShowBack");
         _pointsShow = ComponentFactory.Instance.creatComponentByStylename("outercityshop.displayShowPoints");
         _pointsShowTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.displayShowTxt");
         _stonesShowBack = ComponentFactory.Instance.creatBitmap("asset.outercityshop.displayShowBack");
         _stonesShow = ComponentFactory.Instance.creatBitmap("asset.outercityshop.displayShow");
         _stonesShowTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.displayShowTxt");
         _leftView = ComponentFactory.Instance.creatCustomObject("outercityshop.leftView");
         _randomView = ComponentFactory.Instance.creatCustomObject("outercityshop.randomView");
         _exchangeView = ComponentFactory.Instance.creatCustomObject("outercityshop.exchangeView");
         _randomButton = ComponentFactory.Instance.creatComponentByStylename("outercityshop.randomButton");
         _exchangeButton = ComponentFactory.Instance.creatComponentByStylename("outercityshop.exchangeButton");
         _freshTimeTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.freshTimeTxt");
         _downTime = ComponentFactory.Instance.creatComponentByStylename("outercityshop.downUpdateTime");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("outercityshop.OuterCityShopFrame.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.mysteryTip.StripView");
         _stripView.setHitArea(0,0,60,27);
         _stripView.tipData = LanguageMgr.GetTranslation("tips.mysteryTip.StripView");
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_randomButton);
         _buttonGroup.addSelectItem(_exchangeButton);
         _freshTimeTxt.text = LanguageMgr.GetTranslation("outercityshop.OuterCityShopFrame.freshTimeText2");
         addToContent(_leftBackBg);
         addToContent(_rightBackBg);
         addToContent(_upBack);
         addToContent(_dailyCountTxt);
         addToContent(_pointsShowBack);
         _pointsShowBack.y -= 34;
         addToContent(_pointsShow);
         addToContent(_pointsShowTxt);
         _pointsShowTxt.y -= 34;
         addToContent(_stonesShowBack);
         addToContent(_stonesShow);
         addToContent(_stonesShowTxt);
         addToContent(_leftView);
         addToContent(_randomButton);
         addToContent(_exchangeButton);
         addToContent(_freshTimeTxt);
         addToContent(_downTime);
         addToContent(_stripView);
         refreshView();
      }
      
      private function initData() : void
      {
         OuterCityShopManager.instance.sendAction(1);
         outercityShopControler.initExchangeGoodsData();
         if(model.lastFreshTime > 0)
         {
            _downTime.visible = true;
            _freshTimeTxt.visible = true;
            _downTime.timeCount = model.lastFreshTime;
         }
         else
         {
            __timeCompleteHandler(null);
         }
         __refreshCountView(null);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         model.addEventListener("FRESH_VIEW",__freshViewHandler);
         _downTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         _buttonGroup.addEventListener("change",__tabButtonHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__updateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__updateHandler);
      }
      
      private function __updateHandler(param1:BagEvent) : void
      {
         refreshView();
      }
      
      private function __freshViewHandler(param1:OuterCityShopEvent) : void
      {
         if(model.lastFreshTime > 0)
         {
            if(_buttonGroup.getSelectedItem() == _randomButton)
            {
               _downTime.visible = true;
               _freshTimeTxt.visible = true;
            }
            else
            {
               _downTime.visible = false;
               _freshTimeTxt.visible = false;
            }
            _downTime.timeCount = model.lastFreshTime;
         }
         else
         {
            __timeCompleteHandler(null);
         }
         __refreshCountView(null);
      }
      
      private function __tabButtonHandler(param1:Event) : void
      {
         switch(_buttonGroup.getSelectedItem())
         {
            case _randomButton:
               if(_exchangeView && _exchangeView.parent)
               {
                  _exchangeView.parent.removeChild(_exchangeView);
               }
               _dailyCountTxt.visible = true;
               addToContent(_randomView);
               if(model.lastFreshTime > 0)
               {
                  _downTime.visible = true;
                  _freshTimeTxt.visible = true;
               }
               else
               {
                  _downTime.visible = false;
                  _freshTimeTxt.visible = false;
               }
               break;
            case _exchangeButton:
               if(_randomView && _randomView.parent)
               {
                  _randomView.parent.removeChild(_randomView);
               }
               _dailyCountTxt.visible = false;
               addToContent(_exchangeView);
               _downTime.visible = false;
               _freshTimeTxt.visible = false;
               model.resetData();
               model.updateShowGoodsList();
         }
      }
      
      private function __onHelpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("outercityshop.helpframe");
         _loc2_.show();
      }
      
      private function __goodsLinkHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.outerCityShopControler.openGoodsFrame();
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         _downTime.timeCount = model.lastFreshTime;
         _downTime.visible = false;
         _freshTimeTxt.visible = false;
         _randomView.setIsFreeFreshAble(true);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         model.removeEventListener("FRESH_VIEW",__freshViewHandler);
         _downTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         _buttonGroup.removeEventListener("change",__tabButtonHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__updateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__updateHandler);
      }
      
      private function __refreshCountView(param1:MysteryShopEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("auction.view.mysteryshop.RefreshCountView.tipText");
         var _loc3_:int = MAX_COUNT - model.fresh_count;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         _dailyCountTxt.text = _loc2_ + _loc3_ + " / " + MAX_COUNT;
         refreshView();
      }
      
      private function refreshView() : void
      {
         _pointsShowTxt.text = model.consumePoints.toString();
         _stonesShowTxt.text = GoodsManager.instance.getGoodsNumByTempId(2131057).toString();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
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
         _buttonGroup.selectIndex = 0;
         titleText = LanguageMgr.GetTranslation("outercityshop.OuterCityShopFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : OuterCityShopModel
      {
         return OuterCityShopManager.instance.model;
      }
      
      private function get outercityShopControler() : OuterCityShopControler
      {
         return FrameControllerManager.instance.outerCityShopControler;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_leftView)
         {
            ObjectUtils.disposeObject(_leftView);
         }
         _leftView = null;
         if(_randomView)
         {
            ObjectUtils.disposeObject(_randomView);
         }
         _randomView = null;
         if(_exchangeView)
         {
            ObjectUtils.disposeObject(_exchangeView);
         }
         _exchangeView = null;
         if(_randomButton)
         {
            ObjectUtils.disposeObject(_randomButton);
         }
         _randomButton = null;
         if(_exchangeButton)
         {
            ObjectUtils.disposeObject(_exchangeButton);
         }
         _exchangeButton = null;
         if(_buttonGroup)
         {
            ObjectUtils.disposeObject(_buttonGroup);
         }
         _buttonGroup = null;
         if(_freshTimeTxt)
         {
            ObjectUtils.disposeObject(_freshTimeTxt);
         }
         _freshTimeTxt = null;
         if(_downTime)
         {
            ObjectUtils.disposeObject(_downTime);
         }
         _downTime = null;
         if(_leftBackBg)
         {
            ObjectUtils.disposeObject(_leftBackBg);
         }
         _leftBackBg = null;
         if(_rightBackBg)
         {
            ObjectUtils.disposeObject(_rightBackBg);
         }
         _rightBackBg = null;
         if(_upBack)
         {
            ObjectUtils.disposeObject(_upBack);
         }
         _upBack = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(_stripView)
         {
            ObjectUtils.disposeObject(_stripView);
         }
         _stripView = null;
         if(_stonesShowTxt)
         {
            _stonesShowTxt.dispose();
         }
         _stonesShowTxt = null;
         ObjectUtils.disposeObject(_stonesShow);
         _stonesShow = null;
         ObjectUtils.disposeObject(_stonesShowBack);
         _stonesShowBack = null;
         ObjectUtils.disposeObject(_pointsShowTxt);
         _pointsShowTxt = null;
         ObjectUtils.disposeObject(_pointsShow);
         _pointsShow = null;
         ObjectUtils.disposeObject(_pointsShowBack);
         _pointsShowBack = null;
         ObjectUtils.disposeObject(_dailyCountTxt);
         _dailyCountTxt = null;
         ObjectUtils.disposeObject(_pointsShowTxt);
         _pointsShowTxt = null;
         ObjectUtils.disposeObject(_pointsShowTxt);
         _pointsShowTxt = null;
         ObjectUtils.disposeObject(_pointsShowTxt);
         _pointsShowTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

