package groupfb
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import mvc.module.groupfb.GroupfbRoomInfo;
   import mvc.module.groupfb.GroupfbSender;
   import yishi.filter.UIFilter;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class GroupfbRoomItem extends Component
   {
      
      private var _lockImg:ScaleBitmapImage;
      
      private var _back:ScaleFrameImage;
      
      private var _overMc:MovieClip;
      
      private var _roomTitle:FilterFrameText;
      
      private var _roomLevel:FilterFrameText;
      
      private var _roomName:Bitmap;
      
      private var _roomCapicity:FilterFrameText;
      
      private var _filter:UIFilter;
      
      private var _roomInfo:GroupfbRoomInfo;
      
      public function GroupfbRoomItem()
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
         _roomName = ComponentFactory.Instance.creatBitmap("asset.groupfb.GroupfbRoomItem.mapName");
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
      
      private function unitView() : void
      {
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_lockImg)
         {
            _lockImg.dispose();
         }
         _lockImg = null;
         if(_roomTitle)
         {
            _roomTitle.dispose();
         }
         _roomTitle = null;
         if(_roomLevel)
         {
            _roomLevel.dispose();
         }
         _roomLevel = null;
         if(_roomCapicity)
         {
            _roomCapicity.dispose();
         }
         _roomCapicity = null;
         ObjectUtils.disposeViolentMc(_overMc);
         _overMc = null;
         ObjectUtils.disposeObject(_roomName);
         _roomName = null;
         _filter = null;
         _roomInfo = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         addEventListener("click",__clickHandler);
         MsgMan.addObserver("PVPRoomListEvent.GROUP_ROOM_UPDATE",this,__updateRoomHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         removeEventListener("click",__clickHandler);
         MsgMan.removeObserver("PVPRoomListEvent.GROUP_ROOM_UPDATE",this,__updateRoomHandler);
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
         GroupfbSender.searchRoom(_roomInfo.id);
      }
      
      private function __updateRoomHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GroupfbRoomInfo = param2 as GroupfbRoomInfo;
         if(_loc3_ && _roomInfo && _loc3_.id == _roomInfo.id)
         {
            refreshView();
         }
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
         if(_roomInfo && _roomInfo.count > 0 && _roomInfo.total > 0)
         {
            buttonMode = true;
            _overMc.visible = true;
            _roomTitle.text = "No." + _roomInfo.id;
            _roomCapicity.text = _roomInfo.count + "/" + _roomInfo.total;
            _roomName.visible = true;
            _lockImg.visible = !StringHelper.isNullOrEmpty(_roomInfo.passWord);
            _back.setFrame(2);
         }
      }
      
      public function set data(param1:GroupfbRoomInfo) : void
      {
         _roomInfo = param1;
         refreshView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

