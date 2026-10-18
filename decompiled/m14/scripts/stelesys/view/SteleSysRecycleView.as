package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import stelesys.item.StelaBackBoxItem;
   import stelesys.item.StelesysRecyleBoxItem;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.StelaTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.PageBar;
   import yishi.view.base.TextAddBitmap;
   
   public class SteleSysRecycleView extends Component
   {
      
      private const ITEM_ID:int = 7110003;
      
      private var _bg:MutipleImage;
      
      private var _backBtn:IconButton;
      
      private var _menu:SteleSysChooseMenu;
      
      private var _bagView:StelesysBagView;
      
      private var _arrow:Image;
      
      private var _currInfoList:Array;
      
      private var _metrialItem:StelesysRecyleBoxItem;
      
      private var _metrialIcon:Image;
      
      private var _metrialTxt:FilterFrameText;
      
      private var _hasMetrialNum:int;
      
      private var _mc:MovieClip;
      
      private var _bitTxt:TextAddBitmap;
      
      private var _pageBar:PageBar;
      
      public function SteleSysRecycleView()
      {
         super();
         initView();
         initEvent();
         refreshView(true);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.backBg");
         _backBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.backDoBtn");
         _menu = ComponentFactory.Instance.creatCustomObject("stelesys.backMenu");
         _bagView = ComponentFactory.Instance.creatCustomObject("stelesys.back.bagView");
         _arrow = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.backArrow");
         _metrialItem = ComponentFactory.Instance.creatCustomObject("stelesys.cls.StelesysRecyleBoxItem");
         _bitTxt = ComponentFactory.Instance.creatCustomObject("ui.stela.backBitTxt");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.back.PageBar");
         _metrialTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.backMetrialTxt");
         _metrialIcon = ComponentFactory.Instance.creatComponentByStylename("ui.asset.stelesys.backIcon");
         _mc = ComponentFactory.Instance.creatCustomObject("ui.asset.stelesys.backMc");
         addChild(_bg);
         addChild(_bitTxt);
         addChild(_backBtn);
         addChild(_bagView);
         addChild(_arrow);
         addChild(_metrialItem);
         addChild(_pageBar);
         addChild(_metrialTxt);
         addChild(_metrialIcon);
         addChild(_mc);
         addChild(_menu);
         _bitTxt.initView("ui.stelesys.intensifySortTxt","asset.stelesys.selectCount");
         _bitTxt.adjustPositionY(7);
         _bitTxt.setText("0");
         _mc.gotoAndStop(32);
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(7110003);
         if(_loc3_)
         {
            _metrialIcon.tipData = _loc3_.Description;
         }
         var _loc1_:Array = TempleteManager.instance.stelaTempCate.getMetrailTemps();
         var _loc4_:StelaTemplateInfo = _loc1_[0];
         var _loc5_:StelesysInfo = new StelesysInfo();
         _loc4_ = _loc1_[0];
         _loc5_.templateId = _loc4_.TemplateId;
         _metrialItem.data = _loc5_;
         _backBtn.enable = false;
         var _loc2_:String = "1|1|1|1|1|1,1|1|1|1|1|1";
         model.refreshBackStr(_loc2_);
         _menu.menuType = 3;
         _menu.refreshSwitchMenuName(_loc2_);
      }
      
      private function refreshView(param1:Boolean = false) : void
      {
         _currInfoList = model.backStelaList;
         var _loc3_:StelaSwitchObj = _menu.switchObj;
         _currInfoList = model.doSwitch(_currInfoList,_loc3_.stars,_loc3_.colors);
         model.doSort(_currInfoList);
         var _loc2_:int = int(param1 ? 1 : _pageBar.getCurPage());
         _pageBar.setAutoPagingData(_currInfoList,40);
         _pageBar.setCurPage(_loc2_);
         _bitTxt.setText("" + _currInfoList.length);
         _metrialItem.num = 0;
         freshMetrialNum();
      }
      
      private function freshMetrialNum() : void
      {
         _hasMetrialNum = GoodsManager.instance.getGoodsNumByTempId(7110003);
         _metrialTxt.text = _hasMetrialNum + "/1";
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_backBtn);
         _backBtn = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_metrialItem);
         _metrialItem = null;
         ObjectUtils.disposeObject(_metrialIcon);
         _metrialIcon = null;
         ObjectUtils.disposeObject(_metrialTxt);
         _metrialTxt = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeObject(_bitTxt);
         _bitTxt = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         super.dispose();
         _currInfoList = null;
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("STELE_SYS_SWITCH",switchViewHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_UPDATA",updateHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_METRIAL",metralChooseHandler);
         _backBtn.addEventListener("click",backClickHandler);
         _pageBar.addEventListener("change",pageChangeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("STELE_SYS_SWITCH",switchViewHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_UPDATA",updateHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_METRIAL",metralChooseHandler);
         _backBtn.removeEventListener("click",backClickHandler);
         _pageBar.removeEventListener("change",pageChangeHandler);
      }
      
      private function pageChangeHandler(param1:Event) : void
      {
         _bagView.refreshView(_pageBar.getCurPageDatas());
      }
      
      private function metralChooseHandler(param1:NotificationEvent) : void
      {
         var _loc6_:StelaBackBoxItem = null;
         var _loc3_:int = 0;
         var _loc11_:StelesysInfo = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:StelesysInfo = param1.data as StelesysInfo;
         if(_loc2_ == null)
         {
            _backBtn.enable = false;
            _metrialItem.num = 0;
            return;
         }
         var _loc10_:SimpleTileList = _bagView.bagList;
         var _loc5_:int = int(_loc10_.numChildren);
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc6_ = _loc10_.getChildAt(_loc8_) as StelaBackBoxItem;
            if(_loc6_ && _loc6_.data != _loc2_)
            {
               _loc6_.hideChoose();
            }
            _loc8_++;
         }
         var _loc7_:int = int(_loc2_.totalExp);
         var _loc9_:Array = [_loc2_.id];
         if(_loc9_.length > 0)
         {
            _loc11_ = _metrialItem.data;
            _loc3_ = int(_loc11_.tempInfo.Exp);
            _loc4_ = _loc7_ / _loc3_;
            _metrialItem.num = _loc4_;
            _backBtn.enable = true;
         }
      }
      
      private function backClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:ConfigInfosTempInfo = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(_hasMetrialNum <= 0)
         {
            _loc5_ = TempleteManager.instance.getConfigInfoByConfigName("stela_roll_back_point");
            if(_loc5_)
            {
               _loc4_ = int(_loc5_.ConfigValue);
            }
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("stela.back.needButTip",_loc4_);
            SimpleAlertHelper.instance.data = [__alertResponse];
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,false,true);
         }
         else
         {
            sendBack();
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            sendBack();
         }
      }
      
      private function sendBack() : void
      {
         var _loc1_:Array = [];
         for each(var _loc2_:StelesysInfo in _currInfoList)
         {
            if(_loc2_.isChoose)
            {
               _loc1_.push(_loc2_.id);
            }
         }
         if(_loc1_.length > 0)
         {
            SteleSysManager.Ins.sendRecycle(_loc1_);
         }
         _backBtn.enable = false;
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         refreshView();
         if(_mc.currentFrame == 32)
         {
            _mc.gotoAndPlay(1);
         }
      }
      
      private function switchViewHandler(param1:NotificationEvent) : void
      {
         _menu.refreshSwitchMenuName(model.backStr);
         refreshView();
      }
   }
}

