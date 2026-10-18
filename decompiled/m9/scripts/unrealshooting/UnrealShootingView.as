package unrealshooting
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingModel;
   import mvc.controler.UnrealShootingController;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class UnrealShootingView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _openTips:MovieClip;
      
      private var _prepareTips:MovieClip;
      
      private var _joinBtn:IconButton;
      
      private var _rankBtn:IconButton;
      
      private var _helpBtn:IconButton;
      
      private var _timeNumBmd:BitmapData;
      
      private var _timeNumBmdGold:BitmapData;
      
      private var _timeNumBmdCurrent:BitmapData;
      
      private var _startHour1:Sprite;
      
      private var _startMin1:Sprite;
      
      private var _endHour1:Sprite;
      
      private var _endMin1:Sprite;
      
      private var _startHour2:Sprite;
      
      private var _startMin2:Sprite;
      
      private var _endHour2:Sprite;
      
      private var _endMin2:Sprite;
      
      private var _prepareStartHour1:Sprite;
      
      private var _prepareStartMin1:Sprite;
      
      private var _prepareEndHour1:Sprite;
      
      private var _prepareEndMin1:Sprite;
      
      private var _prepareStartHour2:Sprite;
      
      private var _prepareStartMin2:Sprite;
      
      private var _prepareEndHour2:Sprite;
      
      private var _prepareEndMin2:Sprite;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _controller:UnrealShootingController;
      
      private var _model:UnrealShootingModel;
      
      private var _openDate:Date;
      
      public function UnrealShootingView()
      {
         super();
         _controller = FrameControllerManager.instance.unrealShootingController;
         _model = _controller.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingView.Bg");
         _openTips = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.OpenTips");
         _prepareTips = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.PrepareTips");
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingView.JoinBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingView.RankBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingView.HelpBtn");
         _timeNumBmd = ComponentFactory.Instance.creatBitmapData("asset.svsmap.timeNumBmd");
         _timeNumBmdGold = ComponentFactory.Instance.creatBitmapData("asset.svsmap.timeNumBmdGold");
         _startHour1 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.startHour1");
         _startMin1 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.startMin1");
         _endHour1 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.endHour1");
         _endMin1 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.endMin1");
         _startHour2 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.startHour2");
         _startMin2 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.startMin2");
         _endHour2 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.endHour2");
         _endMin2 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.endMin2");
         _prepareStartHour1 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.prepareStartHour1");
         _prepareStartMin1 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.prepareStartMin1");
         _prepareEndHour1 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.prepareEndHour1");
         _prepareEndMin1 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.prepareEndMin1");
         _prepareStartHour2 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.prepareStartHour2");
         _prepareStartMin2 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.prepareStartMin2");
         _prepareEndHour2 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.prepareEndHour2");
         _prepareEndMin2 = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingView.prepareEndMin2");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingView.TipsTxt");
         _openTips.stop();
         _prepareTips.stop();
         _tipsTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingView.tip3");
         _bg.addChild(_openTips);
         _bg.addChild(_startHour1);
         _bg.addChild(_startMin1);
         _bg.addChild(_endHour1);
         _bg.addChild(_endMin1);
         _bg.addChild(_startHour2);
         _bg.addChild(_startMin2);
         _bg.addChild(_endHour2);
         _bg.addChild(_endMin2);
         _bg.addChild(_prepareTips);
         _bg.addChild(_prepareStartHour1);
         _bg.addChild(_prepareStartMin1);
         _bg.addChild(_prepareEndHour1);
         _bg.addChild(_prepareEndMin1);
         _bg.addChild(_prepareStartHour2);
         _bg.addChild(_prepareStartMin2);
         _bg.addChild(_prepareEndHour2);
         _bg.addChild(_prepareEndMin2);
         addChild(_bg);
         addChild(_joinBtn);
         addChild(_rankBtn);
         addChild(_helpBtn);
         addChild(_tipsTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_openTips);
         _openTips = null;
         ObjectUtils.disposeAllChildren(_prepareTips);
         _prepareTips = null;
         ObjectUtils.disposeObject(_joinBtn);
         _joinBtn = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_timeNumBmd);
         _timeNumBmd = null;
         ObjectUtils.disposeAllChildren(_startHour1);
         _startHour1 = null;
         ObjectUtils.disposeAllChildren(_startMin1);
         _startMin1 = null;
         ObjectUtils.disposeAllChildren(_endHour1);
         _endHour1 = null;
         ObjectUtils.disposeAllChildren(_endMin1);
         _endMin1 = null;
         ObjectUtils.disposeAllChildren(_startHour2);
         _startHour2 = null;
         ObjectUtils.disposeAllChildren(_startMin2);
         _startMin2 = null;
         ObjectUtils.disposeAllChildren(_endHour2);
         _endHour2 = null;
         ObjectUtils.disposeAllChildren(_endMin2);
         _endMin2 = null;
         ObjectUtils.disposeAllChildren(_prepareStartHour1);
         _prepareStartHour1 = null;
         ObjectUtils.disposeAllChildren(_prepareStartMin1);
         _prepareStartMin1 = null;
         ObjectUtils.disposeAllChildren(_endHour1);
         _prepareEndHour1 = null;
         ObjectUtils.disposeAllChildren(_prepareEndMin1);
         _prepareEndMin1 = null;
         ObjectUtils.disposeAllChildren(_prepareStartHour2);
         _prepareStartHour2 = null;
         ObjectUtils.disposeAllChildren(_prepareStartMin2);
         _prepareStartMin2 = null;
         ObjectUtils.disposeAllChildren(_prepareEndHour2);
         _prepareEndHour2 = null;
         ObjectUtils.disposeAllChildren(_prepareEndMin2);
         _prepareEndMin2 = null;
         ObjectUtils.disposeObject(_timeNumBmdGold);
         _timeNumBmdGold = null;
         ObjectUtils.disposeAllChildren(_bg);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _controller = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         _joinBtn.addEventListener("click",__joinBtnClickHandler);
         _rankBtn.addEventListener("click",__rankBtnClickHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _joinBtn.removeEventListener("click",__joinBtnClickHandler);
         _rankBtn.removeEventListener("click",__rankBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
      }
      
      private function __joinBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!_model.shineUnrealShootingBtn)
         {
            _loc2_ = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingView.tip1");
         }
         if(!StringHelper.isNullOrEmpty(_loc2_))
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _controller.sendUnrealShootingEnter();
      }
      
      private function __rankBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("unrealshooting",1);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.HelperFrame");
         _loc2_.show();
      }
      
      public function refreshView() : void
      {
         refreshOpenTime();
      }
      
      private function refreshOpenTime() : void
      {
         if(_model.showUnrealShootingBtn)
         {
            _timeNumBmdCurrent = _timeNumBmdGold;
            _openTips.gotoAndStop(2);
            _prepareTips.gotoAndStop(2);
         }
         else
         {
            _timeNumBmdCurrent = _timeNumBmd;
            _openTips.gotoAndStop(1);
            _prepareTips.gotoAndStop(1);
         }
         NumberViewUtils.refreshValue(int(_model.unrealShootingTimeArray[0]),_startHour1,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingTimeArray[1]),_startMin1,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingTimeArray[2]),_endHour1,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingTimeArray[3]),_endMin1,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingTimeArray[4]),_startHour2,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingTimeArray[5]),_startMin2,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingTimeArray[6]),_endHour2,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingTimeArray[7]),_endMin2,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingPrepareTimeArray[0]),_prepareStartHour1,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingPrepareTimeArray[1]),_prepareStartMin1,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingPrepareTimeArray[2]),_prepareEndHour1,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingPrepareTimeArray[3]),_prepareEndMin1,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingPrepareTimeArray[4]),_prepareStartHour2,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingPrepareTimeArray[5]),_prepareStartMin2,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingPrepareTimeArray[6]),_prepareEndHour2,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(int(_model.unrealShootingPrepareTimeArray[7]),_prepareEndMin2,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

