package ylex
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.YLExpedtionManger;
   import mvc.module.children.ChildData;
   import mvc.module.ylex.ChildCampInfo;
   import mvc.module.ylex.YLExpedtionModel;
   import yishi.SwitchPageHelp;
   import yishi.datas.VersionSwitch;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.SimpleHelpFrame;
   import ylex.view.YLExpeditionItem;
   import ylex.view.YLExpedtionMainView;
   
   public class YLExpeditionMainFrame extends Frame
   {
      
      public var _view1:YLExpedtionMainView;
      
      private var _helpBtn:BaseButton;
      
      private var _kbg:Scale9CornerImage;
      
      private var _timer:Timer;
      
      private var _data:ChildCampInfo;
      
      public function YLExpeditionMainFrame()
      {
         super();
         initView();
         initEvent();
         YLExpedtionManger.instance.sendOp(1);
      }
      
      public function get data() : ChildCampInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildCampInfo) : void
      {
         _data = param1;
      }
      
      private function initView() : void
      {
         _kbg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.YLExpeditionMainFrame.bg");
         _view1 = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.view1");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.HelpBtn");
         addToContent(_kbg);
         addToContent(_view1);
         addToContent(_helpBtn);
         _helpBtn.tipData = LanguageMgr.GetTranslation("ylexpedition.helpBtn.TipData");
         _view1._longBtn.visible = VersionSwitch.SPIRIT_EXPEDITION;
         _timer = new Timer(1000);
         _timer.start();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("YLExpedtionModel.EVENT_UPDATE_INFO",updateInfoHandler);
         _helpBtn.addEventListener("click",__helpClick);
         _view1._backBtn.addEventListener("click",backHandler);
         _view1._longBtn.addEventListener("click",longClickHandler);
         _timer.addEventListener("timer",_timerHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("YLExpedtionModel.EVENT_UPDATE_INFO",updateInfoHandler);
         _view1._backBtn.removeEventListener("click",backHandler);
         _view1._longBtn.removeEventListener("click",longClickHandler);
         _helpBtn.removeEventListener("click",__helpClick);
         _timer.stop();
         _timer.removeEventListener("timer",_timerHandler);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.helpFrame");
         _loc2_.show();
      }
      
      private function longClickHandler(param1:MouseEvent) : void
      {
         SwitchPageHelp.openSpiritExpeditionFrame();
      }
      
      private function _timerHandler(param1:TimerEvent) : void
      {
         var _loc3_:Vector.<YLExpeditionItem> = _view1.ydList;
         for each(var _loc2_:YLExpeditionItem in _loc3_)
         {
            _loc2_.stateCount -= 1;
         }
      }
      
      private function backHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childpve");
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc8_:YLExpedtionModel = null;
         var _loc7_:int = 0;
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc5_:int = 0;
         var _loc2_:Number = NaN;
         var _loc10_:Array = null;
         var _loc6_:int = 0;
         if(_view1)
         {
            _loc8_ = YLExpedtionManger.instance.model;
            _loc7_ = 1;
            while(_loc7_ <= 3)
            {
               _view1.ydList[_loc7_ - 1].data = _loc8_.camp_list[_loc7_];
               _loc7_++;
            }
            _loc4_ = 0;
            _loc3_ = 0;
            _loc5_ = _loc8_.energyRecoveryTimeCD * 1000;
            _loc2_ = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
            _loc10_ = ChildManager.instance.model.nsList;
            _loc6_ = 0;
            for each(var _loc9_:ChildData in _loc10_)
            {
               if(_loc8_.getCampInfoByChildId(_loc9_.childId) == null)
               {
                  _loc4_ = 0;
                  if(_loc8_.child_list[_loc9_.childId] != null)
                  {
                     _loc4_ = Number(_loc8_.child_list[_loc9_.childId]);
                  }
                  _loc3_ = _loc4_ + _loc5_;
                  if(_loc3_ < _loc2_)
                  {
                     _loc6_++;
                  }
               }
            }
            _view1._cleftNum.text = "" + _loc6_;
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_kbg);
         _kbg = null;
         ObjectUtils.disposeObject(_view1);
         _view1 = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         super.dispose();
         _data = null;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("YLExpeditionMainFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
   }
}

