package theseuspvp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.TheseusPvpManager;
   import mvc.module.theseuspvp.TheseusPvpUserInfo;
   import theseuspvp.item.TheseuspvpPrivateCItem;
   import theseuspvp.item.TheseuspvpPrivateItem;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SpeicalRewardTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.PageBar;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class TheseusGloryRewardFrame extends Frame
   {
      
      public var _bg:Bitmap;
      
      public var _privateValueBg:Bitmap;
      
      public var _privateGloryIcon:Image;
      
      public var _privateDesTxt:FilterFrameText;
      
      public var _prc:TheseuspvpPrivateCItem;
      
      public var _preResetTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _onekeyBtn:IconButton;
      
      private var _pageBar:PageBar;
      
      private var _itemList:Array = [];
      
      private var _hasRewardState:Array = [];
      
      private var _allTempList:Array = [];
      
      private var _hbox:HBox;
      
      private var _stripView:StripView;
      
      private const PAGE_NUM:int = 7;
      
      public function TheseusGloryRewardFrame()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.private.bg");
         _privateValueBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.privateValueBg");
         _privateGloryIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.privateGloryIcon");
         _privateDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.privateDesTxt");
         _prc = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.prc");
         _preResetTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.preResetTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvpPrivate.helpBtn");
         _hbox = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.privateHbox");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryReward.Pagebar");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryRewardValue");
         _privateDesTxt.text = LanguageMgr.GetTranslation("theseuspvp.gloryDes");
         _onekeyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.onekeyBtn");
         _stripView = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.glory.StripView");
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(7640002);
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = _loc1_.Description;
         addToContent(_bg);
         addToContent(_privateValueBg);
         addToContent(_privateGloryIcon);
         addToContent(_privateDesTxt);
         addToContent(_prc);
         addToContent(_preResetTxt);
         addToContent(_hbox);
         addToContent(_pageBar);
         addToContent(_helpBtn);
         addToContent(_numTxt);
         addToContent(_onekeyBtn);
         addToContent(_stripView);
         __updateGodwinerPoint();
      }
      
      public function initData() : void
      {
         var _loc1_:TheseuspvpPrivateItem = null;
         var _loc2_:int = 0;
         _allTempList = TempleteManager.instance.theseusPvpRewardCate.getListByType(1);
         updateParams();
         _hbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new TheseuspvpPrivateItem();
            _itemList[_loc2_] = _loc1_;
            _hbox.addChild(_loc1_);
            _loc2_++;
         }
         _hbox.commitChanges();
         _pageBar.setAutoPagingData(_allTempList,7);
         _pageBar.setCurPage(1);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",_helpCilckHandler);
         _pageBar.addEventListener("change",changeHandler);
         _onekeyBtn.addEventListener("click",oneKeyHandler);
         NotificationManager.instance.addEventListener("theseuspvpUserInfoEvent",updateUserInfoHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",_helpCilckHandler);
         _pageBar.removeEventListener("change",changeHandler);
         _onekeyBtn.removeEventListener("click",oneKeyHandler);
         NotificationManager.instance.removeEventListener("theseuspvpUserInfoEvent",updateUserInfoHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
      }
      
      private function updateUserInfoHandler(param1:NotificationEvent) : void
      {
         updateParams();
         updateItemStates();
      }
      
      private function updateParams() : void
      {
         var _loc2_:Array = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:TheseusPvpUserInfo = TheseusPvpManager.Instance.model.selfUserInfo;
         _prc.updateState(_loc1_.openPaySpecial);
         _hasRewardState.length = 0;
         var _loc8_:String = _loc1_.specialInfo;
         if(_loc8_.length > 1)
         {
            _loc2_ = _loc8_.split("|");
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc9_ = _loc2_[_loc4_];
               if(_loc9_.length > 1)
               {
                  _loc10_ = _loc9_.split(",");
                  _loc5_ = int(_loc10_[0]);
                  if(_hasRewardState.indexOf(_loc5_) == -1)
                  {
                     _hasRewardState.push(_loc5_);
                  }
               }
               _loc4_++;
            }
         }
         var _loc7_:Boolean = false;
         var _loc3_:int = int(PlayerCurrencyManager.instance.currencyInfo.thesepvpHoner.amount);
         for each(var _loc11_:SpeicalRewardTempInfo in _allTempList)
         {
            if(_loc11_.NeedNum <= _loc3_)
            {
               _loc6_ = _hasRewardState.indexOf(_loc11_.Gear);
               if(_loc6_ == -1)
               {
                  _loc7_ = true;
                  break;
               }
            }
         }
         _onekeyBtn.enable = _loc7_;
      }
      
      private function oneKeyHandler(param1:MouseEvent) : void
      {
         TheseusPvpManager.Instance.doSomething(11);
      }
      
      private function __updateGodwinerPoint(param1:NotificationEvent = null) : void
      {
         _numTxt.text = PlayerCurrencyManager.instance.currencyInfo.thesepvpHoner.amount.toString();
      }
      
      private function changeHandler(param1:Event) : void
      {
         var _loc3_:TheseuspvpPrivateItem = null;
         var _loc5_:int = 0;
         var _loc6_:Array = _pageBar.getCurPageDatas();
         var _loc4_:int = int(_loc6_.length);
         var _loc2_:int = int(_pageBar.getCurPage());
         _loc5_ = 0;
         while(_loc5_ < 7)
         {
            _loc3_ = _itemList[_loc5_];
            if(_loc5_ < _loc4_)
            {
               _loc3_.temp = _loc6_[_loc5_];
            }
            else
            {
               _loc3_.temp = null;
            }
            _loc5_++;
         }
         updateItemStates();
      }
      
      private function updateItemStates() : void
      {
         var _loc3_:int = int(PlayerCurrencyManager.instance.currencyInfo.thesepvpHoner.amount);
         var _loc1_:TheseusPvpUserInfo = TheseusPvpManager.Instance.model.selfUserInfo;
         for each(var _loc2_:TheseuspvpPrivateItem in _itemList)
         {
            _loc2_.updateBtnState(_hasRewardState,_loc3_,_loc1_.openPaySpecial);
         }
      }
      
      private function _helpCilckHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryReward.helpFrame");
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
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("theseuspvp.grolyTitle");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseuspvpPrivateItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_privateValueBg);
         _privateValueBg = null;
         ObjectUtils.disposeObject(_privateGloryIcon);
         _privateGloryIcon = null;
         ObjectUtils.disposeObject(_privateDesTxt);
         _privateDesTxt = null;
         ObjectUtils.disposeObject(_prc);
         _prc = null;
         ObjectUtils.disposeObject(_preResetTxt);
         _preResetTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_onekeyBtn);
         _onekeyBtn = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         super.dispose();
         _allTempList = null;
         _hasRewardState = null;
      }
   }
}

