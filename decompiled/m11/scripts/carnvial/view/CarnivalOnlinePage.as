package carnvial.view
{
   import carnvial.item.CarnivalOnLineBox;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.datas.templates.CarnivalPointExchangeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.TempleteManager;
   
   public class CarnivalOnlinePage extends BaseCarnivalPage
   {
      
      private var _allCountBg:Image;
      
      private var _allCountTxt:FilterFrameText;
      
      private var _onLineTimeTxt:FilterFrameText;
      
      private var _restTxtBg:Bitmap;
      
      private var _resttxt:FilterFrameText;
      
      private var _panel:SimpleTileList;
      
      private var _timer:Timer;
      
      private var _tempList:Array;
      
      private var _dic:Dictionary = new Dictionary();
      
      private const TYPE_ONLINE:int = 3;
      
      public function CarnivalOnlinePage()
      {
         super();
         initData();
         initEvent();
         refreshView();
      }
      
      override protected function initView() : void
      {
         _allCountBg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.rechargeCountTxtBg");
         _allCountTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.rechargeCountTxt");
         _onLineTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.onLineAllTimeTxt");
         _restTxtBg = ComponentFactory.Instance.creatBitmap("asset.carniver.timeSetBg");
         _resttxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.retTimeTxt");
         _panel = ComponentFactory.Instance.creatCustomObject("ui.carnival.onLinePanelList",[3]);
         _resttxt.htmlText = LanguageMgr.GetTranslation("carnival.today.reset");
         _allCountTxt.text = LanguageMgr.GetTranslation("carnival.onLineTitle");
         addChild(_allCountBg);
         addChild(_allCountTxt);
         addChild(_onLineTimeTxt);
         addChild(_restTxtBg);
         addChild(_resttxt);
         addChild(_panel);
         _timer = new Timer(60000);
         _timer.start();
      }
      
      private function initData() : void
      {
         var _loc3_:CarnivalPointExchangeTemplateInfo = null;
         var _loc1_:CarnivalOnLineBox = null;
         var _loc4_:int = 0;
         _tempList = TempleteManager.instance.carnivalPointExchangeCate.getTempListByType(3);
         var _loc2_:int = int(_tempList ? _tempList.length : 0);
         _panel.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _tempList[_loc4_];
            _loc1_ = new CarnivalOnLineBox();
            _loc1_.tempInfo = _loc3_;
            _dic[_loc3_.Id] = _loc1_;
            _panel.addChild(_loc1_);
            _loc4_++;
         }
         _panel.commitChanges();
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _timer.addEventListener("timer",timeHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _timer.stop();
         _timer.removeEventListener("timer",timeHandler);
      }
      
      private function timeHandler(param1:TimerEvent) : void
      {
         refreshView();
      }
      
      private function refreshView(param1:int = -1) : void
      {
         var _loc3_:CarnivalPointExchangeTemplateInfo = null;
         var _loc4_:int = 0;
         if(param1 == 1)
         {
            model.openFrameTime = getTimer();
         }
         var _loc5_:int = (getTimer() - model.openFrameTime) / 1000 / 60;
         _loc5_ = _loc5_ + model.dayOnline;
         var _loc2_:int = int(_tempList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _tempList[_loc4_];
            _dic[_loc3_.Id].refreshView(_loc5_);
            _loc4_++;
         }
         _onLineTimeTxt.text = LanguageMgr.GetTranslation("carnival.onLineTime",_loc5_);
      }
      
      override protected function updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         refreshView(_loc2_);
      }
      
      override protected function clearView() : void
      {
         for each(var _loc1_:DisplayObject in _dic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _dic = null;
         ObjectUtils.disposeObject(_allCountBg);
         _allCountBg = null;
         ObjectUtils.disposeObject(_allCountTxt);
         _allCountTxt = null;
         ObjectUtils.disposeObject(_restTxtBg);
         _restTxtBg = null;
         ObjectUtils.disposeObject(_resttxt);
         _resttxt = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_onLineTimeTxt);
         _onLineTimeTxt = null;
         _timer = null;
      }
   }
}

