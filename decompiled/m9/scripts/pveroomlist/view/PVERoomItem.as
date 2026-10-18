package pveroomlist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.controler.PVERoomListControler;
   import mvc.module.room.RoomInfo;
   import yishi.datas.consant.RoomState;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.view.RoomPasswordFrame;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class PVERoomItem extends Component
   {
      
      private static var _clickTime:int;
      
      private var _bg:Bitmap;
      
      private var _selectedBack:ScaleFrameImage;
      
      private var _effectback:ScaleFrameImage;
      
      private var _back:ScaleFrameImage;
      
      private var _lockImg:ScaleBitmapImage;
      
      private var _noTxt:FilterFrameText;
      
      private var _roomTitle:FilterFrameText;
      
      private var _iconBack:ScaleFrameImage;
      
      private var _roomIcon:BaseIconView;
      
      private var _roomCapicity:FilterFrameText;
      
      private var needGrades:FilterFrameText;
      
      private var _areaNameTxt:GradientText;
      
      private var _difText:GradientText;
      
      private var _filter:IFilterFormat;
      
      private var _roomInfo:RoomInfo;
      
      private var _alert:RoomPasswordFrame;
      
      public function PVERoomItem()
      {
         super();
         buttonMode = true;
         initView();
         initEvent();
         defaultView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.pveroomlist.RoomItemBG");
         _selectedBack = ComponentFactory.Instance.creatComponentByStylename("pveroom.RoomItemSelectedBack");
         _selectedBack.setFrame(2);
         _effectback = ComponentFactory.Instance.creatComponentByStylename("pveroom.RoomItemEffectBack");
         _back = ComponentFactory.Instance.creatComponentByStylename("core.PveRoomItemBack");
         _lockImg = ComponentFactory.Instance.creatComponentByStylename("core.RoomLockImg");
         _noTxt = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RoomItemTitleNo");
         _roomTitle = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RoomItemTitle");
         _iconBack = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RoomItemIconBack");
         _roomCapicity = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RoomCapicity");
         needGrades = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.needGrades");
         _areaNameTxt = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.areaNameTxt");
         _difText = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.difText");
         _roomIcon = ComponentFactory.Instance.creatCustomObject("pveRoom.RoomIcon");
         addChild(_effectback);
         addChild(_back);
         addChild(_roomIcon);
         addChild(_areaNameTxt);
         addChild(needGrades);
         addChild(_iconBack);
         addChild(_selectedBack);
         addChild(_lockImg);
         addChild(_bg);
         addChild(_selectedBack);
         addChild(_noTxt);
         addChild(_roomTitle);
         addChild(_roomCapicity);
         addChild(_difText);
         _filter = new UIFilter();
         _lockImg.x = 22;
         _lockImg.y = 27;
         _iconBack.visible = false;
         _iconBack.setFrame(1);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         removeEventListener("click",__clickHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _selectedBack.setFrame(1);
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _selectedBack.setFrame(2);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:int = getTimer();
         if(_loc3_ - _clickTime < 3000)
         {
            return;
         }
         _clickTime = _loc3_;
         if(!_roomInfo)
         {
            return;
         }
         if(_roomInfo.roomState != 1)
         {
            MessageTipManager.instance().show(RoomState.getStateNameTips(_roomInfo.roomState));
         }
         else if(_roomInfo.mapTemplate)
         {
            if(thane.grades < _roomInfo.mapTemplate.MinLevel)
            {
               _loc2_ = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.command01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            control.sendSearchRoomInfo(0,_roomInfo.id);
         }
         else
         {
            control.sendSearchRoomInfo(0,_roomInfo.id);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __updateRoomHandler(param1:RoomEvent) : void
      {
         refreshView();
      }
      
      private function defaultView() : void
      {
         _back.setFrame(1);
         _noTxt.text = "";
         _roomTitle.text = "";
         _roomCapicity.text = "";
         needGrades.text = "";
         _areaNameTxt.text = "";
         _difText.text = "";
         _roomIcon.icon = null;
         _lockImg.visible = false;
         _iconBack.visible = false;
      }
      
      private function refreshView() : void
      {
         defaultView();
         _iconBack.visible = false;
         if(_roomInfo)
         {
            _lockImg.visible = _roomInfo.isLock;
            _noTxt.text = "No.";
            _roomTitle.text = _roomInfo.id.toString();
            _roomCapicity.text = _roomInfo.curCount + " / " + _roomInfo.capacity;
            if(_roomInfo.mapTemplate)
            {
               _roomIcon.icon = PathManager.mapInstanceRoomIcon(_roomInfo.mapTemplate.AreaId);
               _areaNameTxt.text = _roomInfo.mapTemplate.CampaignName;
               _areaNameTxt.y = 130;
               if(_roomInfo.roomState != 3)
               {
                  _back.setFrame(_roomInfo.mapTemplate.DifficultyGrade + 1);
                  _filter.setNormalFilter(this);
                  _iconBack.setFrame(1);
                  if(_roomInfo.mapTemplate.DifficultyGrade > 1)
                  {
                     _iconBack.visible = true;
                     _iconBack.setFrame(_roomInfo.mapTemplate.DifficultyGrade);
                  }
               }
               if(_roomInfo.mapTemplate.NeedFourTransfer)
               {
                  needGrades.text = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text6");
               }
               else if(_roomInfo.mapTemplate.NeedThirdTransfer)
               {
                  needGrades.text = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text5");
               }
               else if(_roomInfo.mapTemplate.NeedChangeJob)
               {
                  needGrades.text = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text4");
               }
               else if(_roomInfo.mapTemplate.NeedTransfer)
               {
                  needGrades.text = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text1");
               }
               else if(_roomInfo.mapTemplate.MinLevel == 80)
               {
                  needGrades.text = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text3",_roomInfo.mapTemplate.MinLevel);
               }
               else
               {
                  needGrades.text = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text2",_roomInfo.mapTemplate.MinLevel,_roomInfo.mapTemplate.MaxLevel);
               }
            }
            else
            {
               _roomIcon.icon = PathManager.mapInstanceRoomIcon(0);
               _areaNameTxt.text = LanguageMgr.GetTranslation("pveroomlist.areaNameTxt.noselect.text");
               needGrades.text = "";
            }
         }
      }
      
      private function get control() : PVERoomListControler
      {
         return FrameControllerManager.instance.pveRoomListControler;
      }
      
      public function set data(param1:RoomInfo) : void
      {
         if(_roomInfo)
         {
            _roomInfo.removeEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomHandler);
         }
         _roomInfo = param1;
         if(_roomInfo)
         {
            _roomInfo.addEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomHandler);
         }
         refreshView();
      }
      
      override public function dispose() : void
      {
         if(_roomIcon)
         {
            _roomIcon.dispose();
         }
         _roomIcon = null;
         if(_selectedBack)
         {
            _selectedBack.dispose();
         }
         _selectedBack = null;
         if(_effectback)
         {
            _effectback.dispose();
         }
         _effectback = null;
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_noTxt)
         {
            _noTxt.dispose();
         }
         _noTxt = null;
         if(_roomTitle)
         {
            _roomTitle.dispose();
         }
         _roomTitle = null;
         if(_iconBack)
         {
            ObjectUtils.disposeObject(_iconBack);
         }
         _iconBack = null;
         if(_roomCapicity)
         {
            _roomCapicity.dispose();
         }
         _roomCapicity = null;
         if(needGrades)
         {
            ObjectUtils.disposeObject(needGrades);
         }
         needGrades = null;
         if(_difText)
         {
            ObjectUtils.disposeObject(_difText);
         }
         _difText = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _filter = null;
         _roomInfo = null;
         removeEvent();
         super.dispose();
      }
   }
}

