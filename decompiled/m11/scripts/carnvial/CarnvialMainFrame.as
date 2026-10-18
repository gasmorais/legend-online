package carnvial
{
   import carnvial.item.CarnivalSelectItem;
   import carnvial.utils.CarnivalLockOper;
   import carnvial.view.CarnivalBaoPage;
   import carnvial.view.CarnivalDayTaskPage;
   import carnvial.view.CarnivalDiscountPage;
   import carnvial.view.CarnivalGamePage;
   import carnvial.view.CarnivalLuckPage;
   import carnvial.view.CarnivalOnlinePage;
   import carnvial.view.CarnivalRechargePage;
   import carnvial.view.CarnvialYearPage;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.carnival.CarnivalModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.CarnivalManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.TabPageUtil;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class CarnvialMainFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _bTitle:Bitmap;
      
      private var _cBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _cbtb:Bitmap;
      
      private var _leftDownBit:Bitmap;
      
      private var _rightDownBit:Bitmap;
      
      private var _mContainer:Sprite;
      
      private var _pageContainer:Sprite;
      
      private var _lockLayer:Sprite;
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _tabVBox:VBox;
      
      private var _yearBtn:CarnivalSelectItem;
      
      private var _rechargeBtn:CarnivalSelectItem;
      
      private var _luckTurnBtn:CarnivalSelectItem;
      
      private var _giftBtn:CarnivalSelectItem;
      
      private var _luckGetBtn:CarnivalSelectItem;
      
      private var _dayTaskBtn:CarnivalSelectItem;
      
      private var _gameBtn:CarnivalSelectItem;
      
      private var _onlineBtn:CarnivalSelectItem;
      
      private var _activeTimes:FilterFrameText;
      
      public function CarnvialMainFrame()
      {
         super();
         initView();
         initEvent();
         model.openFrameTime = getTimer();
         CarnivalManager.Instance.opRequest(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1055,682);
      }
      
      private function initView() : void
      {
         _mContainer = new Sprite();
         addToContent(_mContainer);
         _bg = new Bitmap();
         _bTitle = new Bitmap();
         _cBtn = new BaseButton();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.HelpBtn");
         _cbtb = new Bitmap();
         _cBtn.addChild(_cbtb);
         _leftDownBit = new Bitmap();
         _rightDownBit = new Bitmap();
         _pageContainer = new Sprite();
         _bTitle.x = 180;
         _bTitle.y = -11;
         _leftDownBit.x = 14;
         _leftDownBit.y = 550;
         _cBtn.x = 986;
         _cBtn.y = 70;
         _mContainer.addChild(_bg);
         _mContainer.addChild(_bTitle);
         _mContainer.addChild(_pageContainer);
         _mContainer.addChild(_cBtn);
         _mContainer.addChild(_helpBtn);
         _tabPageUtil = new TabPageUtil();
         _tabVBox = ComponentFactory.Instance.creatCustomObject("ui.carnival.mainVbox");
         _activeTimes = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.activeTimes");
         var _loc6_:String = "";
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("CarnivalStartDate");
         if(_loc2_)
         {
            _loc6_ = _loc2_.ConfigValue;
         }
         var _loc1_:String = "";
         var _loc7_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("CarnivalStopDate");
         if(_loc7_)
         {
            _loc1_ = _loc7_.ConfigValue;
         }
         _activeTimes.htmlText = LanguageMgr.GetTranslation("carnival.active.time",_loc6_,_loc1_);
         _lockLayer = new Sprite();
         _lockLayer.graphics.beginFill(0,0);
         _lockLayer.graphics.drawRect(0,0,1055,682);
         _lockLayer.graphics.endFill();
         addToContent(_lockLayer);
         _lockLayer.mouseEnabled = false;
         _lockLayer.visible = false;
         _mContainer.addChild(_tabVBox);
         _mContainer.addChild(_leftDownBit);
         _mContainer.addChild(_rightDownBit);
         _mContainer.addChild(_activeTimes);
         _yearBtn = new CarnivalSelectItem();
         _rechargeBtn = new CarnivalSelectItem();
         _luckTurnBtn = new CarnivalSelectItem();
         _giftBtn = new CarnivalSelectItem();
         _luckGetBtn = new CarnivalSelectItem();
         _dayTaskBtn = new CarnivalSelectItem();
         _gameBtn = new CarnivalSelectItem();
         _onlineBtn = new CarnivalSelectItem();
         var _loc4_:String = LanguageMgr.GetTranslation("carnival.tab.names");
         var _loc3_:Array = _loc4_.split("|");
         _yearBtn.titleTab = _loc3_[0];
         _rechargeBtn.titleTab = _loc3_[1];
         _luckTurnBtn.titleTab = _loc3_[2];
         _giftBtn.titleTab = _loc3_[3];
         _luckGetBtn.titleTab = _loc3_[4];
         _dayTaskBtn.titleTab = _loc3_[5];
         _gameBtn.titleTab = _loc3_[6];
         _onlineBtn.titleTab = _loc3_[7];
         _tabVBox.addChild(_yearBtn);
         _tabVBox.addChild(_rechargeBtn);
         _tabVBox.addChild(_luckTurnBtn);
         _tabVBox.addChild(_giftBtn);
         _tabVBox.addChild(_luckGetBtn);
         _tabVBox.addChild(_dayTaskBtn);
         _tabVBox.addChild(_gameBtn);
         _tabVBox.addChild(_onlineBtn);
         _tabPageUtil.addItemPage(_yearBtn,createYearPage);
         _tabPageUtil.addItemPage(_rechargeBtn,createRechargePage);
         _tabPageUtil.addItemPage(_luckTurnBtn,createLuckTurnPage);
         _tabPageUtil.addItemPage(_giftBtn,createGiftPage);
         _tabPageUtil.addItemPage(_luckGetBtn,createLuckGetPage);
         _tabPageUtil.addItemPage(_dayTaskBtn,createDayTaskPage);
         _tabPageUtil.addItemPage(_gameBtn,createHappyGamePage);
         _tabPageUtil.addItemPage(_onlineBtn,createOnlinePage);
         _tabPageUtil.selectIndex = 0;
         CarnivalLockOper.Ins.regist(doLockOper);
         var _loc5_:int = int(model.configActId);
         toLoadImg(_bg,"frame_bg",_loc5_);
         toLoadImg(_bTitle,"frame_title",_loc5_);
         toLoadImg(_leftDownBit,"frame_left",_loc5_);
         toLoadImg(_cbtb,"frame_close",_loc5_);
      }
      
      private function doLockOper(param1:Boolean) : void
      {
         _lockLayer.mouseEnabled = param1;
         _lockLayer.visible = param1;
      }
      
      private function createYearPage() : CarnvialYearPage
      {
         var _loc1_:CarnvialYearPage = ComponentFactory.Instance.creatCustomObject("ui.carnivar.CarnvialYearPage");
         _pageContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createRechargePage() : CarnivalRechargePage
      {
         var _loc1_:CarnivalRechargePage = ComponentFactory.Instance.creatCustomObject("ui.carnivar.CarnivalRechargePage");
         _pageContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createLuckTurnPage() : CarnivalLuckPage
      {
         var _loc1_:CarnivalLuckPage = ComponentFactory.Instance.creatCustomObject("ui.carnivar.CarnivalLuckPage");
         _pageContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createGiftPage() : CarnivalDiscountPage
      {
         var _loc1_:CarnivalDiscountPage = ComponentFactory.Instance.creatCustomObject("ui.carnivar.CarnivalDiscountPage");
         _pageContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createLuckGetPage() : CarnivalBaoPage
      {
         var _loc1_:CarnivalBaoPage = ComponentFactory.Instance.creatCustomObject("ui.carnivar.CarnivalBaoPage");
         _pageContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createDayTaskPage() : CarnivalDayTaskPage
      {
         var _loc1_:CarnivalDayTaskPage = ComponentFactory.Instance.creatCustomObject("ui.carnivar.CarnivalDayTaskPage");
         _pageContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createHappyGamePage() : CarnivalGamePage
      {
         var _loc1_:CarnivalGamePage = ComponentFactory.Instance.creatCustomObject("ui.carnivar.CarnivalGamePage");
         _pageContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createOnlinePage() : CarnivalOnlinePage
      {
         var _loc1_:CarnivalOnlinePage = ComponentFactory.Instance.creatCustomObject("ui.carnivar.CarnivalOnlinePage");
         _pageContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function toLoadImg(param1:Bitmap, param2:String, param3:int) : void
      {
         var bit:Bitmap = param1;
         var imgName:String = param2;
         var activeId:int = param3;
         var path:String = PathManager.getCarnivalRes(activeId,imgName);
         LoaderManagerII.instance.load(path,2,0,function(param1:LoaderInfo, param2:Object):void
         {
            if(!isDie && param1.args && param2 is Bitmap)
            {
               param1.args.bitmapData = param2.bitmapData;
            }
         },null,null,bit);
      }
      
      private function get model() : CarnivalModel
      {
         return CarnivalManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _cBtn.addEventListener("click",clickHandler);
         _helpBtn.addEventListener("click",clickHelpHandler);
         CarnivalManager.Instance.addEventListener("carn.EVENT_UPDATE",updateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _cBtn.removeEventListener("click",clickHandler);
         _helpBtn.removeEventListener("click",clickHelpHandler);
         CarnivalManager.Instance.removeEventListener("carn.EVENT_UPDATE",updateInfoHandler);
      }
      
      private function clickHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ui.carivalHelpFrame");
         _loc2_.show();
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ == 1)
         {
            model.openFrameTime = getTimer();
         }
      }
      
      private function clickHandler(param1:Event) : void
      {
         dispose();
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_tabVBox);
         _tabVBox = null;
         ObjectUtils.disposeObject(_yearBtn);
         _yearBtn = null;
         ObjectUtils.disposeObject(_rechargeBtn);
         _rechargeBtn = null;
         ObjectUtils.disposeObject(_luckTurnBtn);
         _luckTurnBtn = null;
         ObjectUtils.disposeObject(_giftBtn);
         _giftBtn = null;
         ObjectUtils.disposeObject(_luckGetBtn);
         _luckGetBtn = null;
         ObjectUtils.disposeObject(_dayTaskBtn);
         _dayTaskBtn = null;
         ObjectUtils.disposeObject(_gameBtn);
         _gameBtn = null;
         ObjectUtils.disposeObject(_onlineBtn);
         _onlineBtn = null;
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         CarnivalLockOper.Ins.unRegist();
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
   }
}

