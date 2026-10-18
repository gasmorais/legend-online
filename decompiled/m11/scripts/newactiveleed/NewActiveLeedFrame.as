package newactiveleed
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.NewActiveLeedManager;
   import mvc.module.newactiveleed.NewActiveLeedModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   
   public class NewActiveLeedFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _noviceBtn:SelectedIconButton;
      
      private var _oneTurnBtn:SelectedIconButton;
      
      private var _twoTurnBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _rightBack:MutipleImage;
      
      private var _view:NewActiveLeedView;
      
      private var _doubleBtn:IconButton;
      
      private var _doubleOpenBtn:IconButton;
      
      private var _remainTxt:FilterFrameText;
      
      private var _countDownTime:Timer;
      
      private var _totalSecond:int;
      
      private var _doubleActiveCost:int;
      
      public function NewActiveLeedFrame()
      {
         super();
         initView();
         addEvent();
         initBtnState();
         refreshView();
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,773,533);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedFrame.border");
         _noviceBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedFrame.noviceBtn");
         _oneTurnBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedFrame.oneTurnBtn");
         _twoTurnBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedFrame.twoTurnBtn");
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedFrame.rightBack");
         _doubleBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedFrame.doubleBtn");
         _doubleOpenBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedFrame.doubleOpenBtn");
         _remainTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedFrame.remainTxt");
         addToContent(_border);
         addToContent(_noviceBtn);
         addToContent(_oneTurnBtn);
         addToContent(_twoTurnBtn);
         addToContent(_rightBack);
         addToContent(_doubleOpenBtn);
         addToContent(_remainTxt);
         addToContent(_doubleBtn);
         _doubleOpenBtn.buttonMode = _doubleOpenBtn.mouseChildren = _doubleOpenBtn.mouseEnabled = false;
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_noviceBtn);
         _btnGroup.addSelectItem(_oneTurnBtn);
         _btnGroup.addSelectItem(_twoTurnBtn);
         _view = new NewActiveLeedView();
         _view.x = 176;
         _view.y = 8;
         addToContent(_view);
         _doubleActiveCost = ConfigInfoManager.instance.getLeedBuyBuffPoint();
      }
      
      private function initBtnState() : void
      {
         var _loc1_:int = _btnGroup.itemLength - 1;
         if(!thane.isHoly)
         {
            if(!thane.isAvenger)
            {
               if(!thane.isChangeJob)
               {
                  _twoTurnBtn.enable = false;
                  _loc1_ = 1;
                  if(thane.vocationGrades == 0)
                  {
                     _oneTurnBtn.enable = false;
                     _loc1_ = 0;
                  }
               }
            }
         }
         _btnGroup.selectIndex = _loc1_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnGroup.addEventListener("change",__btnChangeHandler);
         MsgMan.addObserver("NEW_ACTIVELEED_UPDATE",this,__updateNewActiveLeedHandler);
         _doubleBtn.addEventListener("click",__doubleBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btnGroup.removeEventListener("change",__btnChangeHandler);
         MsgMan.removeObserver("NEW_ACTIVELEED_UPDATE",this,__updateNewActiveLeedHandler);
         _doubleBtn.removeEventListener("click",__doubleBtnClickHandler);
         clearTime();
      }
      
      private function __doubleBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("dayguide.newleed.doubleActiveText",_doubleActiveCost);
         SimpleAlertHelper.instance.data = [_buyDoubleActiveHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,true,2);
      }
      
      private function _buyDoubleActiveHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(playerModel.playerInfo.point >= _doubleActiveCost)
            {
               NewActiveLeedManager.instance.sendBuyBuff();
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      private function clearTime() : void
      {
         if(_countDownTime)
         {
            _countDownTime.stop();
            _countDownTime.removeEventListener("timer",__onTimer);
            _countDownTime = null;
         }
      }
      
      private function __updateNewActiveLeedHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(_totalSecond > 0)
         {
            _loc2_ = DateFormatter.getDefaultFullDateString(_totalSecond);
            _remainTxt.htmlText = LanguageMgr.GetTranslation("NewActiveLeedFrame.remainTxt.text",_loc2_);
            _totalSecond = _totalSecond - 1;
         }
      }
      
      private function __btnChangeHandler(param1:Event) : void
      {
         model.masterType = _btnGroup.selectIndex + 1;
         _view.refreshView();
      }
      
      public function refreshView() : void
      {
         clearTime();
         var _loc1_:Date = DateFormatter.parse(model.buffTime,"YYYY-MM-DD hh:mm:ss");
         if(!_loc1_)
         {
            return;
         }
         if(_loc1_.time > playerModel.nowDate)
         {
            _doubleOpenBtn.visible = true;
            _doubleBtn.visible = false;
            _remainTxt.visible = true;
            _totalSecond = (_loc1_.time - playerModel.nowDate) / 1000;
            _countDownTime = new Timer(1000,_totalSecond);
            _countDownTime.addEventListener("timer",__onTimer);
            _countDownTime.start();
         }
         else
         {
            _doubleOpenBtn.visible = false;
            _doubleBtn.visible = true;
            _remainTxt.visible = false;
         }
         __btnChangeHandler(null);
      }
      
      private function get model() : NewActiveLeedModel
      {
         return NewActiveLeedManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
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
         titleText = LanguageMgr.GetTranslation("dayGuide.view.DayGuideFrame.title");
      }
      
      override public function dispose() : void
      {
         clearTime();
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_noviceBtn);
         _noviceBtn = null;
         ObjectUtils.disposeObject(_oneTurnBtn);
         _oneTurnBtn = null;
         ObjectUtils.disposeObject(_twoTurnBtn);
         _twoTurnBtn = null;
         ObjectUtils.disposeObject(_rightBack);
         _rightBack = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_doubleBtn);
         _doubleBtn = null;
         ObjectUtils.disposeObject(_doubleOpenBtn);
         _doubleOpenBtn = null;
         ObjectUtils.disposeObject(_remainTxt);
         _remainTxt = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         super.dispose();
      }
   }
}

