package steel.view
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
   import map.campaign.data.SteelModel;
   import mvc.controler.SteelController;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SteelView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _openTips:MovieClip;
      
      private var _joinBtn:IconButton;
      
      private var _myTeamBtn:FilterFrameText;
      
      private var _joinTeamBtn:FilterFrameText;
      
      private var _changeBtn:IconButton;
      
      private var _rankBtn:IconButton;
      
      private var _helpBtn:IconButton;
      
      private var _timeNumBmd:BitmapData;
      
      private var _yearSprite:Sprite;
      
      private var _mouthSprite:Sprite;
      
      private var _daySprite:Sprite;
      
      private var _startHourSprite:Sprite;
      
      private var _startMinuteSprite:Sprite;
      
      private var _controller:SteelController;
      
      private var _model:SteelModel;
      
      private var _openDate:Date;
      
      public function SteelView()
      {
         super();
         _controller = FrameControllerManager.instance.steelController;
         _model = _controller.model;
         initView();
         addEvent();
         _controller.sendSteelInfoReq();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelView.Bg");
         _openTips = ComponentFactory.Instance.creatCustomObject("steelmap.steelViewOpenTips");
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelView.JoinBtn");
         _myTeamBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelView.ListBtn");
         _joinTeamBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelView.ListBtn");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelView.ChangeBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelView.RankBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelView.HelpBtn");
         _timeNumBmd = ComponentFactory.Instance.creatBitmapData("asset.svsmap.timeNumBmd");
         _yearSprite = ComponentFactory.Instance.creatCustomObject("steel.SteelView.YearSprite");
         _mouthSprite = ComponentFactory.Instance.creatCustomObject("steel.SteelView.MouthSprite");
         _daySprite = ComponentFactory.Instance.creatCustomObject("steel.SteelView.DaySprite");
         _startHourSprite = ComponentFactory.Instance.creatCustomObject("steel.SteelView.StartHourSprite");
         _startMinuteSprite = ComponentFactory.Instance.creatCustomObject("steel.SteelView.StartMinuteSprite");
         _openTips.stop();
         _myTeamBtn.visible = false;
         _myTeamBtn.mouseEnabled = true;
         _myTeamBtn.htmlText = LanguageMgr.GetTranslation("steel.view.SteelFrame.myTeamBtnTxt");
         _joinTeamBtn.visible = false;
         _joinTeamBtn.mouseEnabled = true;
         _joinTeamBtn.htmlText = LanguageMgr.GetTranslation("steel.view.SteelFrame.joinTeamBtnTxt");
         _bg.addChild(_openTips);
         _bg.addChild(_yearSprite);
         _bg.addChild(_mouthSprite);
         _bg.addChild(_daySprite);
         _bg.addChild(_startHourSprite);
         _bg.addChild(_startMinuteSprite);
         addChild(_bg);
         addChild(_joinBtn);
         addChild(_myTeamBtn);
         addChild(_joinTeamBtn);
         addChild(_changeBtn);
         addChild(_rankBtn);
         addChild(_helpBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_openTips);
         _openTips = null;
         ObjectUtils.disposeObject(_joinBtn);
         _joinBtn = null;
         ObjectUtils.disposeObject(_myTeamBtn);
         _myTeamBtn = null;
         ObjectUtils.disposeObject(_joinTeamBtn);
         _joinTeamBtn = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_timeNumBmd);
         _timeNumBmd = null;
         ObjectUtils.disposeAllChildren(_yearSprite);
         _yearSprite = null;
         ObjectUtils.disposeAllChildren(_mouthSprite);
         _mouthSprite = null;
         ObjectUtils.disposeAllChildren(_daySprite);
         _daySprite = null;
         ObjectUtils.disposeAllChildren(_startHourSprite);
         _startHourSprite = null;
         ObjectUtils.disposeAllChildren(_startMinuteSprite);
         _startMinuteSprite = null;
         ObjectUtils.disposeAllChildren(this);
         _controller = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         _joinBtn.addEventListener("click",__joinBtnClickHandler);
         _myTeamBtn.addEventListener("click",__myTeamBtnnClickHandler);
         _joinTeamBtn.addEventListener("click",__joinTeamBtnClickHandler);
         _changeBtn.addEventListener("click",__changeBtnClickHandler);
         _rankBtn.addEventListener("click",__rankBtnClickHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _joinBtn.removeEventListener("click",__joinBtnClickHandler);
         _myTeamBtn.removeEventListener("click",__myTeamBtnnClickHandler);
         _joinTeamBtn.removeEventListener("click",__joinTeamBtnClickHandler);
         _changeBtn.removeEventListener("click",__changeBtnClickHandler);
         _rankBtn.removeEventListener("click",__rankBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
      }
      
      private function __joinBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.steelController.sendSteelEnter();
      }
      
      private function __myTeamBtnnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("steelmap",1);
      }
      
      private function __joinTeamBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("steelmap",2);
      }
      
      private function __changeBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vehicledaimon",null,true);
      }
      
      private function __rankBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("steelmap",5);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("steel.HelperFrame");
         _loc2_.show();
      }
      
      public function refreshView() : void
      {
         if(StringHelper.isNullOrEmpty(_model.selfTeamUid))
         {
            _myTeamBtn.visible = false;
            _joinTeamBtn.visible = true;
         }
         else
         {
            _myTeamBtn.visible = true;
            _joinTeamBtn.visible = false;
         }
         refreshOpenTime();
      }
      
      private function refreshOpenTime() : void
      {
         _openDate = _model.openDate;
         NumberViewUtils.refreshValue(_openDate.fullYear,_yearSprite,_timeNumBmd,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(_openDate.month + 1,_mouthSprite,_timeNumBmd,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(_openDate.date,_daySprite,_timeNumBmd,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(_openDate.hours,_startHourSprite,_timeNumBmd,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(_openDate.minutes,_startMinuteSprite,_timeNumBmd,23,31,12,23,"0123456789",true);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

