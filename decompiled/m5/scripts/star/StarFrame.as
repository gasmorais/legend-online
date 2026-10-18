package star
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import star.view.DisplayStarView;
   import star.view.MakeStarView;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.StarManager;
   import yishi.view.component.MovieButton;
   
   public class StarFrame extends Frame
   {
      
      private var _9cornerBg:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _starBar:Bitmap;
      
      public var _horoscopeBtn:SimpleBitmapButton;
      
      private var _horoscopeBtnEffect:MovieClip;
      
      private var _helpBtn:BaseButton;
      
      private var _makeStarView:MakeStarView;
      
      private var _displayStarView:DisplayStarView;
      
      private var _isCloseBySatrBag:Boolean;
      
      private var _horoscopeFrame:HoroscopeFrame;
      
      public function StarFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("star.StarFrame.titleText");
         _9cornerBg = ComponentFactory.Instance.creatComponentByStylename("star.9CornerBg");
         _bg = ComponentFactory.Instance.creatBitmap("asset.star.BG");
         _starBar = ComponentFactory.Instance.creatBitmap("asset.star.StarBar");
         _horoscopeBtn = ComponentFactory.Instance.creatComponentByStylename("star.HoroscopeBtn");
         _horoscopeBtnEffect = ComponentFactory.Instance.creatCustomObject("star.HoroscopeBtnEffect");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("star.HelpBtn");
         _makeStarView = ComponentFactory.Instance.creatCustomObject("star.MakeStarView");
         _displayStarView = ComponentFactory.Instance.creatCustomObject("star.DisplayStarView");
         _helpBtn.tipData = LanguageMgr.GetTranslation("star.view.StarFrame.helpBtnTipData");
         _horoscopeFrame = ComponentFactory.Instance.creatComponentByStylename("star.HoroscopeFrame");
         _horoscopeFrame.starFrame = this;
         addToContent(_9cornerBg);
         addToContent(_bg);
         addToContent(_displayStarView);
         _displayStarView.addChildAt(_starBar,1);
         _displayStarView.addChildAt(_horoscopeBtn,2);
         _displayStarView.addChildAt(_horoscopeBtnEffect,3);
         addToContent(_makeStarView);
         addToContent(_helpBtn);
         addChild(_horoscopeFrame);
         _horoscopeFrame.visible = true;
      }
      
      public function getCrystalByIndex(param1:int) : MovieButton
      {
         return _makeStarView.getCrystalByIndex(param1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _horoscopeBtn.addEventListener("click",__horoscopeClick);
         _helpBtn.addEventListener("click",__helpClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_horoscopeBtn)
         {
            _horoscopeBtn.removeEventListener("click",__horoscopeClick);
         }
         _helpBtn.removeEventListener("click",__helpClick);
      }
      
      public function show(param1:* = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("star",2,param1);
         }
      }
      
      private function __horoscopeClick(param1:MouseEvent) : void
      {
         hideHoroscopeFrame();
      }
      
      public function hideHoroscopeFrame() : void
      {
         _isCloseBySatrBag = true;
         _horoscopeFrame.visible = !_horoscopeFrame.visible;
         if(_horoscopeFrame.visible)
         {
            this.x = (StageReferance.stageWidth - 1092) / 2;
         }
         else
         {
            this.x = (StageReferance.stageWidth - 683) / 2;
         }
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.starController.openStarHelpFrame();
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
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      override public function dispose() : void
      {
         var _loc1_:DisplayObject = null;
         if(isAddToPool)
         {
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
            KeyBoardRegister.instance.keyEnable = true;
            _loc1_ = StageReferance.stage.focus as DisplayObject;
            if(_loc1_ && contains(_loc1_))
            {
               StageReferance.stage.focus = null;
            }
            ComponentFactory.Instance.preStylename = "";
            NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
            return;
         }
         removeEvent();
         ObjectUtils.disposeObject(_9cornerBg);
         _9cornerBg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_starBar);
         _starBar = null;
         ObjectUtils.disposeObject(_horoscopeBtn);
         _horoscopeBtn = null;
         ObjectUtils.disposeViolentMc(_horoscopeBtnEffect);
         _horoscopeBtnEffect = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_makeStarView);
         _makeStarView = null;
         ObjectUtils.disposeObject(_displayStarView);
         _displayStarView = null;
         ObjectUtils.disposeAllChildren(this);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
         _horoscopeFrame.dispose();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         if(!_isCloseBySatrBag)
         {
            StarManager.instance.starModel.quickPickupClick();
         }
      }
   }
}

