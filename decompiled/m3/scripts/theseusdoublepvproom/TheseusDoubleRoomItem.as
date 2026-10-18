package theseusdoublepvproom
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.TheseusRoomListControler;
   import mvc.module.room.RoomInfo;
   import yishi.datas.consant.RoomState;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.TheseusMultiPvpTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusDoubleRoomItem extends Component
   {
      
      private static var _clickTime:int;
      
      private var _bg:Bitmap;
      
      private var _selectedBack:ScaleFrameImage;
      
      private var _lockImg:ScaleBitmapImage;
      
      private var _iconBack:ScaleFrameImage;
      
      protected var _roomBg:Bitmap;
      
      protected var _NumTxt:FilterFrameText;
      
      protected var _participantsTxt:FilterFrameText;
      
      protected var _nametitleTxt:FilterFrameText;
      
      protected var _pointtitleTxt:FilterFrameText;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _pointTxt:FilterFrameText;
      
      private var _filter:IFilterFormat;
      
      private var _roomInfo:RoomInfo;
      
      private var _alert:TheseusRoomPasswordFrame;
      
      public function TheseusDoubleRoomItem()
      {
         super();
         buttonMode = true;
         initView();
         initEvent();
         defaultView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.roomSelect");
         _selectedBack = ComponentFactory.Instance.creatComponentByStylename("pveroom.RoomItemSelectedBack");
         _selectedBack.setFrame(2);
         _lockImg = ComponentFactory.Instance.creatComponentByStylename("core.RoomLockImg");
         _iconBack = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RoomItemIconBack");
         addChild(_selectedBack);
         _roomBg = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.roomBg");
         _NumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.NumTxt");
         _participantsTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.participantsTxt");
         _nametitleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.nametitleTxt");
         _pointtitleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.pointtitleTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.nameTxt");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.pointTxt");
         addChild(_roomBg);
         addChild(_NumTxt);
         addChild(_participantsTxt);
         addChild(_nametitleTxt);
         addChild(_pointtitleTxt);
         addChild(_nameTxt);
         addChild(_pointTxt);
         addChild(_bg);
         _bg.visible = false;
         _filter = new UIFilter();
         _nametitleTxt.text = LanguageMgr.GetTranslation("theseusroomlist.RoomListFrame.desc4");
         _pointtitleTxt.text = LanguageMgr.GetTranslation("theseusroomlist.RoomListFrame.desc8");
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
         NotificationManager.instance.addEventListener("TheseusDoubleRoomSelect",updateSelect);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         NotificationManager.instance.removeEventListener("TheseusDoubleRoomSelect",updateSelect);
      }
      
      private function updateSelect(param1:NotificationEvent) : void
      {
         if(_bg)
         {
            if(_roomInfo && _roomInfo.id == control.searchId)
            {
               _bg.visible = true;
            }
            else
            {
               _bg.visible = false;
            }
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_roomInfo)
         {
            return;
         }
         if(_roomInfo.roomState != 1)
         {
            MessageTipManager.instance().show(RoomState.getStateNameTips(_roomInfo.roomState));
         }
         else
         {
            control.searchId = _roomInfo.id;
            NotificationManager.instance.sendNotification("TheseusDoubleRoomSelect");
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
         _nametitleTxt.visible = false;
         _nameTxt.text = "";
         _NumTxt.text = "";
         _participantsTxt.text = "";
         _pointtitleTxt.visible = false;
         _pointTxt.text = "";
         _lockImg.visible = false;
         _iconBack.visible = false;
      }
      
      private function refreshView() : void
      {
         var _loc1_:TheseusMultiPvpTempInfo = null;
         defaultView();
         _iconBack.visible = false;
         if(_roomInfo)
         {
            _nametitleTxt.visible = true;
            _pointtitleTxt.visible = true;
            _lockImg.visible = _roomInfo.isLock;
            _NumTxt.text = "No." + _roomInfo.id;
            _nameTxt.text = _roomInfo.masterName.toString();
            _participantsTxt.text = LanguageMgr.GetTranslation("theseusroomlist.RoomListFrame.desc3") + _roomInfo.curCount + " / " + _roomInfo.capacity;
            _nametitleTxt.visible = _pointtitleTxt.visible = true;
            _loc1_ = TempleteManager.instance.theseusMultiPvpTempCate.getTempById(_roomInfo.masterScore);
            if(_loc1_)
            {
               _pointTxt.text = _loc1_.Name;
            }
         }
         else
         {
            _NumTxt.text = _participantsTxt.text = "";
            _nametitleTxt.visible = _pointtitleTxt.visible = false;
         }
      }
      
      private function get control() : TheseusRoomListControler
      {
         return FrameControllerManager.instance.theseusRoomListControler;
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
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_selectedBack)
         {
            _selectedBack.dispose();
         }
         _selectedBack = null;
         if(_iconBack)
         {
            ObjectUtils.disposeObject(_iconBack);
         }
         _iconBack = null;
         ObjectUtils.disposeObject(_roomBg);
         _roomBg = null;
         ObjectUtils.disposeObject(_NumTxt);
         _NumTxt = null;
         ObjectUtils.disposeObject(_participantsTxt);
         _participantsTxt = null;
         ObjectUtils.disposeObject(_nametitleTxt);
         _nametitleTxt = null;
         ObjectUtils.disposeObject(_pointtitleTxt);
         _pointtitleTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         _filter = null;
         _roomInfo = null;
         removeEvent();
         super.dispose();
      }
   }
}

