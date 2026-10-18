package registwelfare
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.registwelfare.ItemBoxInfo;
   import mvc.module.registwelfare.SimpleTaskRecordInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RegistWelfareManager;
   import yishi.utils.NumberViewUtils;
   
   public class RegistWelfareFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObject;
      
      private var _buyBg:Bitmap;
      
      private var _buyBtn1:IconButton;
      
      private var _buyBtn2:IconButton;
      
      private var _buyBtn3:IconButton;
      
      private var _numberAsset:BitmapData;
      
      private var _buyNote1:FilterFrameText;
      
      private var _buyNote2:FilterFrameText;
      
      private var _buyNote3:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _hBox:HBox;
      
      private var _countdownNote:Bitmap;
      
      private var _dayBmp:Bitmap;
      
      private var _hourBmp:Bitmap;
      
      private var _minBmp:Bitmap;
      
      private var _secBmp:Bitmap;
      
      private var _countdownDay:FilterFrameText;
      
      private var _countdownHour:FilterFrameText;
      
      private var _countdownMin:FilterFrameText;
      
      private var _countdownSec:FilterFrameText;
      
      private var _container1:Component;
      
      private var _container2:Component;
      
      private var _container3:Component;
      
      public function RegistWelfareFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,708,607);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("view.RegistWelfareFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("registwelfare.Back1");
         _buyBg = ComponentFactory.Instance.creatBitmap("asset.registwelfare.buyBg");
         _buyBtn1 = ComponentFactory.Instance.creatComponentByStylename("registwelfare.buyBtn");
         _buyBtn2 = ComponentFactory.Instance.creatComponentByStylename("registwelfare.buyBtn");
         _buyBtn3 = ComponentFactory.Instance.creatComponentByStylename("registwelfare.buyBtn");
         _buyNote1 = ComponentFactory.Instance.creatComponentByStylename("registwelfare.buyNote1");
         _buyNote2 = ComponentFactory.Instance.creatComponentByStylename("registwelfare.buyNote2");
         _buyNote3 = ComponentFactory.Instance.creatComponentByStylename("registwelfare.buyNote3");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("registwelfare.welfareHbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("registwelfare.ScrollPanel");
         _countdownNote = ComponentFactory.Instance.creatBitmap("asset.registwelfare.countdownNote");
         _dayBmp = ComponentFactory.Instance.creatBitmap("asset.registwelfare.countdownDay");
         _hourBmp = ComponentFactory.Instance.creatBitmap("asset.registwelfare.countdownHour");
         _minBmp = ComponentFactory.Instance.creatBitmap("asset.registwelfare.countdownMin");
         _secBmp = ComponentFactory.Instance.creatBitmap("asset.registwelfare.countdownSec");
         _countdownDay = ComponentFactory.Instance.creatComponentByStylename("registwelfare.countdownTxt");
         _countdownHour = ComponentFactory.Instance.creatComponentByStylename("registwelfare.countdownTxt");
         _countdownMin = ComponentFactory.Instance.creatComponentByStylename("registwelfare.countdownTxt");
         _countdownSec = ComponentFactory.Instance.creatComponentByStylename("registwelfare.countdownTxt");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.registwelfare.buyIndexNum");
         _container1 = new Component();
         _container1.x = 16;
         _container1.y = 15;
         _container2 = new Component();
         _container2.x = 16;
         _container2.y = 15;
         _container3 = new Component();
         _container3.x = 16;
         _container3.y = 15;
         _buyNote1.text = LanguageMgr.GetTranslation("registwelfare.RegistWelfareFrame.buyNote1");
         _buyNote2.text = LanguageMgr.GetTranslation("registwelfare.RegistWelfareFrame.buyNote2");
         _buyNote3.text = LanguageMgr.GetTranslation("registwelfare.RegistWelfareFrame.buyNote3");
         addToContent(_bg);
         addToContent(_buyBg);
         addToContent(_buyBtn1);
         _buyBtn1.x = 98;
         addToContent(_buyBtn2);
         _buyBtn2.x = 263;
         addToContent(_buyBtn3);
         _buyBtn3.x = 429;
         addToContent(_buyNote1);
         addToContent(_buyNote2);
         addToContent(_buyNote3);
         addToContent(_scrollPanel);
         _scrollPanel.setView(_hBox);
         _scrollPanel.hScrollProxy = 0;
         addToContent(_countdownNote);
         addToContent(_dayBmp);
         addToContent(_hourBmp);
         addToContent(_minBmp);
         addToContent(_secBmp);
         addToContent(_countdownDay);
         _countdownDay.x = 240;
         addToContent(_countdownHour);
         _countdownHour.x = 308;
         addToContent(_countdownMin);
         _countdownMin.x = 385;
         addToContent(_countdownSec);
         _countdownSec.x = 481;
         _buyBtn1.addChild(_container1);
         _buyBtn2.addChild(_container2);
         _buyBtn3.addChild(_container3);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__systimeUpdateHandler);
         _buyBtn1.addEventListener("click",__mountClickHandler);
         _buyBtn2.addEventListener("click",__stoneClickHandler);
         _buyBtn3.addEventListener("click",__fashionClickHandler);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__extraFieldHandler);
         NotificationManager.instance.addEventListener("REGIST_TASK_RECORD",__registTaskHandler);
         __extraFieldHandler(null);
         __systimeUpdateHandler(null);
         __registTaskHandler(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__systimeUpdateHandler);
         _buyBtn1.removeEventListener("click",__mountClickHandler);
         _buyBtn2.removeEventListener("click",__stoneClickHandler);
         _buyBtn3.removeEventListener("click",__fashionClickHandler);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__extraFieldHandler);
         NotificationManager.instance.removeEventListener("REGIST_TASK_RECORD",__registTaskHandler);
      }
      
      private function __extraFieldHandler(param1:Event) : void
      {
         var _loc2_:int = RegistWelfareManager.instance.mount + 1;
         NumberViewUtils.refreshValue(_loc2_,_container1,_numberAsset,14,18,10,14,"0123456789");
         if(_loc2_ == 0)
         {
            _buyBtn1.visible = false;
         }
         _loc2_ = RegistWelfareManager.instance.stone + 1;
         NumberViewUtils.refreshValue(_loc2_,_container2,_numberAsset,14,18,10,14,"0123456789");
         if(_loc2_ == 0)
         {
            _buyBtn2.visible = false;
         }
         _loc2_ = RegistWelfareManager.instance.fashion + 1;
         NumberViewUtils.refreshValue(_loc2_,_container3,_numberAsset,14,18,10,14,"0123456789");
         if(_loc2_ == 0)
         {
            _buyBtn3.visible = false;
         }
      }
      
      private function __registTaskHandler(param1:Event) : void
      {
         var _loc5_:RegistWelfareItem = null;
         _hBox.disposeAllChildren();
         var _loc2_:Array = [];
         var _loc6_:Dictionary = RegistWelfareManager.instance.recordListDic;
         for each(var _loc3_:SimpleTaskRecordInfo in _loc6_)
         {
            _loc2_.push(_loc3_);
         }
         _loc2_.sortOn("taskState",1 | 0x10);
         _hBox.beginChanges();
         for each(var _loc4_:SimpleTaskRecordInfo in _loc2_)
         {
            if(_loc4_.taskState != -1)
            {
               _loc5_ = new RegistWelfareItem();
               _loc5_.data = _loc4_;
               _hBox.addChild(_loc5_);
            }
         }
         _hBox.commitChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function __mountClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ItemBoxInfo = getItemBoxByType(3);
         FrameControllerManager.instance.openControllerByInfo("registwelfare",1,_loc2_);
      }
      
      private function __stoneClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ItemBoxInfo = getItemBoxByType(1);
         FrameControllerManager.instance.openControllerByInfo("registwelfare",1,_loc2_);
      }
      
      private function __fashionClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ItemBoxInfo = getItemBoxByType(2);
         FrameControllerManager.instance.openControllerByInfo("registwelfare",1,_loc2_);
      }
      
      private function getItemBoxByType(param1:int) : ItemBoxInfo
      {
         return RegistWelfareManager.instance.getItemBoxByType(param1);
      }
      
      private function __systimeUpdateHandler(param1:PlayerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         if(RegistWelfareManager.instance.endDate)
         {
            _loc2_ = (RegistWelfareManager.instance.endDate.time - playerModel.sysCurtime.time) / 1000;
            if(_loc2_ < 0)
            {
               return;
            }
            _loc5_ = Math.floor(_loc2_ / 86400);
            _loc4_ = (_loc2_ - _loc5_ * 24 * 3600) / 3600;
            _loc3_ = (_loc2_ - _loc5_ * 24 * 3600 - _loc4_ * 3600) / 60;
            _loc6_ = _loc2_ - _loc5_ * 24 * 3600 - _loc4_ * 3600 - _loc3_ * 60;
            _countdownDay.text = _loc5_ + "";
            _countdownHour.text = _loc4_ + "";
            _countdownMin.text = _loc3_ + "";
            _countdownSec.text = _loc6_ + "";
         }
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
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_buyBg);
         _buyBg = null;
         ObjectUtils.disposeObject(_buyBtn1);
         _buyBtn1 = null;
         ObjectUtils.disposeObject(_buyBtn2);
         _buyBtn2 = null;
         ObjectUtils.disposeObject(_buyBtn3);
         _buyBtn3 = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_buyNote1);
         _buyNote1 = null;
         ObjectUtils.disposeObject(_buyNote2);
         _buyNote2 = null;
         ObjectUtils.disposeObject(_buyNote3);
         _buyNote3 = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_countdownNote);
         _countdownNote = null;
         ObjectUtils.disposeObject(_dayBmp);
         _dayBmp = null;
         ObjectUtils.disposeObject(_hourBmp);
         _hourBmp = null;
         ObjectUtils.disposeObject(_minBmp);
         _minBmp = null;
         ObjectUtils.disposeObject(_secBmp);
         _secBmp = null;
         ObjectUtils.disposeObject(_countdownDay);
         _countdownDay = null;
         ObjectUtils.disposeObject(_countdownHour);
         _countdownHour = null;
         ObjectUtils.disposeObject(_countdownMin);
         _countdownMin = null;
         ObjectUtils.disposeObject(_countdownSec);
         _countdownSec = null;
         ObjectUtils.disposeObject(_container1);
         _container1 = null;
         ObjectUtils.disposeObject(_container2);
         _container2 = null;
         ObjectUtils.disposeObject(_container3);
         _container3 = null;
         super.dispose();
      }
   }
}

