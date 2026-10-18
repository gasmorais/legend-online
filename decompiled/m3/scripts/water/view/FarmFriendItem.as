package water.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FriendFarmStateInfo;
   import farm.event.FarmEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   
   public class FarmFriendItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _nameText:FilterFrameText;
      
      private var _farmStateImg:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _back:ScaleFrameImage;
      
      private var _selected:Boolean;
      
      private var _farmStateInfo:FriendFarmStateInfo;
      
      private var _data:ThaneInfo;
      
      private var _viewType:int;
      
      public function FarmFriendItem()
      {
         super();
         buttonMode = true;
         _icon = ComponentFactory.Instance.creatComponentByStylename("core.SexIcon");
         _icon.x = 5;
         _icon.y = 1;
         addChild(_icon);
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__onItemOver);
         addEventListener("rollOut",__onItemOut);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__onItemOver);
         removeEventListener("rollOut",__onItemOut);
      }
      
      private function __onItemOver(param1:MouseEvent) : void
      {
         if(_back && !_selected)
         {
            _back.setFrame(1);
         }
      }
      
      private function __onItemOut(param1:MouseEvent) : void
      {
         if(_back && !_selected)
         {
            _back.setFrame(2);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(param1)
         {
            _back.setFrame(1);
            _nameText.setFrame(2);
         }
         else
         {
            _back.setFrame(2);
            _nameText.setFrame(1);
         }
      }
      
      public function set back(param1:String) : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename(param1);
         _back.setFrame(2);
         if(_back)
         {
            addChildAt(_back,0);
         }
      }
      
      public function set nameTextStyle(param1:String) : void
      {
         _nameText = ComponentFactory.Instance.creatComponentByStylename(param1);
         _nameText.setFrame(1);
         if(_nameText)
         {
            addChild(_nameText);
         }
      }
      
      public function set stateIconStyle(param1:String) : void
      {
         _farmStateImg = ComponentFactory.Instance.creatComponentByStylename(param1);
         if(_farmStateImg)
         {
            addChild(_farmStateImg);
         }
      }
      
      public function refreshView() : void
      {
         if(_data)
         {
            visible = true;
            _nameText.text = _data.nickName;
            _data.sexs == 0 ? _icon.setFrame(2) : _icon.setFrame(1);
            _farmStateInfo ? _farmStateImg.setFrame(_farmStateInfo.curStateFrame) : _farmStateImg.setFrame(1);
            hideFarmStateImage();
         }
         else
         {
            visible = false;
         }
      }
      
      private function hideFarmStateImage() : void
      {
         _farmStateImg.visible = true;
         if(viewType == 1)
         {
            _farmStateImg.visible = false;
         }
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function set viewType(param1:int) : void
      {
         _viewType = param1;
      }
      
      private function __friendInfoUpdateHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function addFriendListener(param1:ThaneInfo) : void
      {
         if(param1)
         {
            param1.addEventListener("PLAYER_INFO_UPDATE",__friendInfoUpdateHandler);
         }
      }
      
      private function removeFriendListener(param1:ThaneInfo) : void
      {
         if(param1)
         {
            param1.removeEventListener("PLAYER_INFO_UPDATE",__friendInfoUpdateHandler);
         }
      }
      
      private function addFarmStateListener(param1:FriendFarmStateInfo) : void
      {
         if(param1)
         {
            param1.addEventListener("FRIEND_FARM_STATE_CHANGE",__friendFarmStateChangeHandler);
         }
      }
      
      private function removeFarmStateListener(param1:FriendFarmStateInfo) : void
      {
         if(param1)
         {
            param1.removeEventListener("FRIEND_FARM_STATE_CHANGE",__friendFarmStateChangeHandler);
         }
      }
      
      private function __friendFarmStateChangeHandler(param1:FarmEvent) : void
      {
         if(_farmStateInfo)
         {
            _farmStateImg.setFrame(_farmStateInfo.curStateFrame);
            hideFarmStateImage();
         }
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         removeFriendListener(_data);
         removeFarmStateListener(_farmStateInfo);
         _data = param1;
         _data ? (_farmStateInfo = model.getFarmStateInfo(_data.userId)) : (_farmStateInfo = null);
         addFriendListener(_data);
         addFarmStateListener(_farmStateInfo);
         refreshView();
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeFarmStateListener(_farmStateInfo);
         removeFriendListener(_data);
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _farmStateInfo = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

