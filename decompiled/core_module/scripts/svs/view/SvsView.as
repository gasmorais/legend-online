package svs.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.SvsModel;
   import mvc.controler.SvsController;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SvsView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _openTips:MovieClip;
      
      private var _vsIcon:Bitmap;
      
      private var _joinBtn:IconButton;
      
      private var _shopBtn:BaseButton;
      
      private var _listBtn:FilterFrameText;
      
      private var _rankBtn:IconButton;
      
      private var _helpBtn:IconButton;
      
      private var _timeNumBmd:BitmapData;
      
      private var _timeNumBmdGold:BitmapData;
      
      private var _timeNumBmdCurrent:BitmapData;
      
      private var _yearSprite:Sprite;
      
      private var _mouthSprite:Sprite;
      
      private var _daySprite:Sprite;
      
      private var _startHourSprite:Sprite;
      
      private var _startMinuteSprite:Sprite;
      
      private var _selfServerName:GradientText;
      
      private var _matchServerName:GradientText;
      
      private var _svsInfoTips:GradientText;
      
      private var _turnBtn1:SelectedButton;
      
      private var _turnBtn2:SelectedButton;
      
      private var _turnBtn3:SelectedButton;
      
      private var _turnBtn4:SelectedButton;
      
      private var _turnBtnGold1:SelectedButton;
      
      private var _turnBtnGold2:SelectedButton;
      
      private var _turnBtnGold3:SelectedButton;
      
      private var _turnBtnGold4:SelectedButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _controller:SvsController;
      
      private var _model:SvsModel;
      
      private var _selectedTurn:int;
      
      private var _openDate1:Date;
      
      private var _openDate2:Date;
      
      private var _openDate3:Date;
      
      private var _openDate4:Date;
      
      private var _openDate:Date;
      
      public function SvsView()
      {
         super();
         _controller = FrameControllerManager.instance.svsController;
         _model = _controller.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.Bg");
         _openTips = ComponentFactory.Instance.creatCustomObject("svsmap.svsViewOpenTips");
         _vsIcon = ComponentFactory.Instance.creatBitmap("asset.svsmap.svsFrameVSIcon");
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.JoinBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.ShopBtn");
         _listBtn = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.ListBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.RankBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.HelpBtn");
         _timeNumBmd = ComponentFactory.Instance.creatBitmapData("asset.svsmap.timeNumBmd");
         _timeNumBmdGold = ComponentFactory.Instance.creatBitmapData("asset.svsmap.timeNumBmdGold");
         _yearSprite = ComponentFactory.Instance.creatCustomObject("svs.SvsView.YearSprite");
         _mouthSprite = ComponentFactory.Instance.creatCustomObject("svs.SvsView.MouthSprite");
         _daySprite = ComponentFactory.Instance.creatCustomObject("svs.SvsView.DaySprite");
         _startHourSprite = ComponentFactory.Instance.creatCustomObject("svs.SvsView.StartHourSprite");
         _startMinuteSprite = ComponentFactory.Instance.creatCustomObject("svs.SvsView.StartMinuteSprite");
         _selfServerName = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.SelfServerName");
         _matchServerName = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.MatchServerName");
         _svsInfoTips = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.SvsInfoTips");
         _turnBtn1 = ComponentFactory.Instance.creatComponentByStylename("svsmap.TurnBtn1");
         _turnBtn2 = ComponentFactory.Instance.creatComponentByStylename("svsmap.TurnBtn2");
         _turnBtn3 = ComponentFactory.Instance.creatComponentByStylename("svsmap.TurnBtn3");
         _turnBtn4 = ComponentFactory.Instance.creatComponentByStylename("svsmap.TurnBtn4");
         _turnBtnGold1 = ComponentFactory.Instance.creatComponentByStylename("svsmap.TurnBtnGold1");
         _turnBtnGold2 = ComponentFactory.Instance.creatComponentByStylename("svsmap.TurnBtnGold2");
         _turnBtnGold3 = ComponentFactory.Instance.creatComponentByStylename("svsmap.TurnBtnGold3");
         _turnBtnGold4 = ComponentFactory.Instance.creatComponentByStylename("svsmap.TurnBtnGold4");
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_turnBtn1);
         _buttonGroup.addSelectItem(_turnBtn2);
         _buttonGroup.addSelectItem(_turnBtn3);
         _buttonGroup.addSelectItem(_turnBtn4);
         _buttonGroup.addSelectItem(_turnBtnGold1);
         _buttonGroup.addSelectItem(_turnBtnGold2);
         _buttonGroup.addSelectItem(_turnBtnGold3);
         _buttonGroup.addSelectItem(_turnBtnGold4);
         _openTips.stop();
         _listBtn.mouseEnabled = true;
         _listBtn.htmlText = LanguageMgr.GetTranslation("svs.view.SvsFrame.listBtnTxt");
         _selfServerName.text = "";
         _matchServerName.text = "";
         _vsIcon.visible = false;
         _selfServerName.mouseEnabled = _selfServerName.mouseChildren = false;
         _matchServerName.mouseEnabled = _matchServerName.mouseChildren = false;
         _svsInfoTips.mouseEnabled = _svsInfoTips.mouseChildren = false;
         _bg.addChild(_openTips);
         _bg.addChild(_vsIcon);
         _bg.addChild(_yearSprite);
         _bg.addChild(_mouthSprite);
         _bg.addChild(_daySprite);
         _bg.addChild(_startHourSprite);
         _bg.addChild(_startMinuteSprite);
         addChild(_bg);
         addChild(_joinBtn);
         addChild(_shopBtn);
         addChild(_listBtn);
         addChild(_rankBtn);
         addChild(_helpBtn);
         addChild(_selfServerName);
         addChild(_matchServerName);
         addChild(_svsInfoTips);
         addChild(_turnBtn1);
         addChild(_turnBtn2);
         addChild(_turnBtn3);
         addChild(_turnBtn4);
         addChild(_turnBtnGold1);
         addChild(_turnBtnGold2);
         addChild(_turnBtnGold3);
         addChild(_turnBtnGold4);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_openTips);
         _openTips = null;
         ObjectUtils.disposeObject(_vsIcon);
         _vsIcon = null;
         ObjectUtils.disposeObject(_joinBtn);
         _joinBtn = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_listBtn);
         _listBtn = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_timeNumBmd);
         _timeNumBmd = null;
         ObjectUtils.disposeObject(_timeNumBmdGold);
         _timeNumBmdGold = null;
         ObjectUtils.disposeObject(_timeNumBmdCurrent);
         _timeNumBmdCurrent = null;
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
         ObjectUtils.disposeObject(_selfServerName);
         _selfServerName = null;
         ObjectUtils.disposeObject(_matchServerName);
         _matchServerName = null;
         ObjectUtils.disposeObject(_svsInfoTips);
         _svsInfoTips = null;
         ObjectUtils.disposeObject(_turnBtn1);
         _turnBtn1 = null;
         ObjectUtils.disposeObject(_turnBtn2);
         _turnBtn2 = null;
         ObjectUtils.disposeObject(_turnBtn3);
         _turnBtn3 = null;
         ObjectUtils.disposeObject(_turnBtn4);
         _turnBtn4 = null;
         ObjectUtils.disposeObject(_turnBtnGold1);
         _turnBtnGold1 = null;
         ObjectUtils.disposeObject(_turnBtnGold2);
         _turnBtnGold2 = null;
         ObjectUtils.disposeObject(_turnBtnGold3);
         _turnBtnGold3 = null;
         ObjectUtils.disposeObject(_turnBtnGold4);
         _turnBtnGold4 = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         ObjectUtils.disposeAllChildren(this);
         _controller = null;
         _model = null;
         _openDate1 = null;
         _openDate2 = null;
         _openDate3 = null;
         _openDate4 = null;
         _openDate = null;
      }
      
      private function addEvent() : void
      {
         _joinBtn.addEventListener("click",__joinBtnClickHandler);
         _shopBtn.addEventListener("click",__shopBtnClickHandler);
         _listBtn.addEventListener("click",__listBtnClickHandler);
         _rankBtn.addEventListener("click",__rankBtnClickHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _buttonGroup.addEventListener("change",__onTapBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _joinBtn.removeEventListener("click",__joinBtnClickHandler);
         _shopBtn.removeEventListener("click",__shopBtnClickHandler);
         _listBtn.removeEventListener("click",__listBtnClickHandler);
         _rankBtn.removeEventListener("click",__rankBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         _buttonGroup.removeEventListener("change",__onTapBtnHandler);
      }
      
      private function __onTapBtnHandler(param1:Event) : void
      {
         switch(_buttonGroup.getSelectedItem())
         {
            case _turnBtn1:
            case _turnBtnGold1:
               _selectedTurn = 1;
               break;
            case _turnBtn2:
            case _turnBtnGold2:
               _selectedTurn = 2;
               break;
            case _turnBtn3:
            case _turnBtnGold3:
               _selectedTurn = 3;
               break;
            case _turnBtn4:
            case _turnBtnGold4:
               _selectedTurn = 4;
         }
         refreshOpenTime();
      }
      
      private function __joinBtnClickHandler(param1:MouseEvent) : void
      {
         _controller.sendSvsEnter();
      }
      
      private function __shopBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",19);
      }
      
      private function __listBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("svsmap",1);
      }
      
      private function __rankBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("svsmap",3);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("svs.HelperFrame");
         _loc2_.show();
      }
      
      public function refreshView() : void
      {
         _openDate1 = new Date(_model.openDate.getTime() + 0);
         _openDate2 = new Date(_model.openDate.getTime() + 900000);
         _openDate3 = new Date(_model.openDate.getTime() + 1800000);
         _openDate4 = new Date(_model.openDate.getTime() + 2700000);
         _selfServerName.text = _model.selfServerName;
         _matchServerName.text = _model.matchServerName;
         _vsIcon.visible = true;
         _svsInfoTips.text = "";
         if(_model.groupId == 0)
         {
            _selfServerName.text = "";
            _matchServerName.text = "";
            _vsIcon.visible = false;
            _svsInfoTips.text = LanguageMgr.GetTranslation("svs.view.SvsFrame.svsInfoTipsTxt01");
         }
         else if(_model.groupId == 1000000)
         {
            _selfServerName.text = "";
            _matchServerName.text = "";
            _vsIcon.visible = false;
            _svsInfoTips.text = LanguageMgr.GetTranslation("svs.view.SvsFrame.svsInfoTipsTxt02");
         }
         else if(_model.groupId == 2000000)
         {
            _selfServerName.text = "";
            _matchServerName.text = "";
            _vsIcon.visible = false;
            _svsInfoTips.text = LanguageMgr.GetTranslation("svs.view.SvsFrame.svsInfoTipsTxt03");
         }
         if(_model.currentTurn <= 0 || _model.currentTurn > 4)
         {
            _model.currentTurn = 1;
         }
         refreshButtonGroup();
         refreshOpenTime();
      }
      
      private function refreshButtonGroup() : void
      {
         _turnBtn1.visible = true;
         _turnBtn2.visible = true;
         _turnBtn3.visible = true;
         _turnBtn4.visible = true;
         _turnBtnGold1.visible = false;
         _turnBtnGold2.visible = false;
         _turnBtnGold3.visible = false;
         _turnBtnGold4.visible = false;
         this["_turnBtn" + _model.currentTurn].visible = false;
         this["_turnBtnGold" + _model.currentTurn].visible = true;
         _buttonGroup.selectIndex = _buttonGroup.getSelectIndexByItem(this["_turnBtnGold" + _model.currentTurn]);
      }
      
      private function refreshOpenTime() : void
      {
         if(_selectedTurn == _model.currentTurn)
         {
            _timeNumBmdCurrent = _timeNumBmdGold;
            _openTips.gotoAndStop(2);
         }
         else
         {
            _timeNumBmdCurrent = _timeNumBmd;
            _openTips.gotoAndStop(1);
         }
         _openDate = this["_openDate" + _selectedTurn];
         NumberViewUtils.refreshValue(_openDate.fullYear,_yearSprite,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(_openDate.month + 1,_mouthSprite,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(_openDate.date,_daySprite,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(_openDate.hours,_startHourSprite,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
         NumberViewUtils.refreshValue(_openDate.minutes,_startMinuteSprite,_timeNumBmdCurrent,23,31,12,23,"0123456789",true);
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

