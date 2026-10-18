package pvproomlist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import mvc.controler.PVPRoomListControler;
   import mvc.module.room.RoomInfo;
   import yishi.datas.consant.RoomState;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.FrameControllerManager;
   import yishi.view.RoomPasswordFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PVPRoomItem extends Component
   {
      
      private var _lockImg:ScaleBitmapImage;
      
      private var _back:ScaleFrameImage;
      
      private var _overMc:MovieClip;
      
      private var _roomTitle:FilterFrameText;
      
      private var _roomLevel:FilterFrameText;
      
      private var _roomName:Bitmap;
      
      private var _roomCapicity:FilterFrameText;
      
      private var _filter:IFilterFormat;
      
      private var _roomInfo:RoomInfo;
      
      private var _alert:RoomPasswordFrame;
      
      public function PVPRoomItem()
      {
         super();
         buttonMode = false;
         initView();
         initEvent();
         defaultView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("core.RoomItemBack2");
         _back.setFrame(1);
         _lockImg = ComponentFactory.Instance.creatComponentByStylename("core.RoomLockImg");
         _roomTitle = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.RoomItemTitle");
         _roomLevel = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.RoomItemLevel");
         _roomName = ComponentFactory.Instance.creatBitmap("asset.pvproomlist.RoomName");
         _roomCapicity = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.RoomCapicity");
         _overMc = ComponentFactory.Instance.creat("core.RoomItemOverMc");
         _overMc.x = 20;
         _overMc.y = 12;
         addChild(_back);
         addChild(_overMc);
         addChild(_lockImg);
         addChild(_roomTitle);
         addChild(_roomLevel);
         addChild(_roomName);
         addChild(_roomCapicity);
         _filter = new UIFilter();
         _overMc.stop();
         _overMc.visible = false;
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
         if(_overMc)
         {
            _overMc.gotoAndPlay(1);
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_overMc)
         {
            _overMc.gotoAndStop(1);
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
         else if(_roomInfo.id)
         {
            control.sendSearchRoomInfo(1,_roomInfo.id);
         }
      }
      
      private function inviteBackCall(param1:int, param2:String) : void
      {
         control.sendEnterRoom(1,_roomInfo.id,param2,false);
      }
      
      private function __updateRoomHandler(param1:RoomEvent) : void
      {
         refreshView();
      }
      
      private function defaultView() : void
      {
         _back.setFrame(1);
         _roomTitle.text = "";
         _roomCapicity.text = "";
         _roomLevel.text = "";
         _roomName.visible = false;
         _lockImg.visible = false;
         _overMc.visible = false;
         buttonMode = false;
      }
      
      private function refreshView() : void
      {
         defaultView();
         if(_roomInfo)
         {
            buttonMode = true;
            _overMc.visible = true;
            _roomTitle.text = "No." + _roomInfo.id;
            _roomCapicity.text = _roomInfo.curCount + " / " + _roomInfo.capacity;
            _roomName.visible = true;
            _lockImg.visible = _roomInfo.isLock;
            _back.setFrame(2);
         }
      }
      
      private function get control() : PVPRoomListControler
      {
         return FrameControllerManager.instance.pvpRoomlistControler;
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
         removeEvent();
         super.dispose();
         _lockImg = null;
         _back = null;
         _overMc = null;
         _roomTitle = null;
         _roomLevel = null;
         _roomName = null;
         _roomCapicity = null;
         _filter = null;
      }
   }
}

