package childpatrol
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolFriendStateInfo;
   import mvc.module.childpatrol.ChildPatrolModel;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class ChildPatrolFriendItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _nameText:FilterFrameText;
      
      private var _icon:ScaleFrameImage;
      
      private var _back:ScaleFrameImage;
      
      private var _stateImage:Bitmap;
      
      private var _selected:Boolean;
      
      private var _data:ThaneInfo;
      
      private var stateInfo:ChildPatrolFriendStateInfo;
      
      public function ChildPatrolFriendItem()
      {
         super();
         buttonMode = true;
         _icon = ComponentFactory.Instance.creatComponentByStylename("core.SexIcon");
         _stateImage = ComponentFactory.Instance.creatBitmap("asset.ChildPatrolFriendItem.stateImage");
         _icon.x = 5;
         _icon.y = 1;
         addChild(_icon);
         addChild(_stateImage);
         _stateImage.visible = false;
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
      
      public function refreshView() : void
      {
         if(!_data)
         {
            visible = false;
         }
         else
         {
            visible = true;
            _nameText.text = _data.nickName;
            _data.sexs == 0 ? _icon.setFrame(2) : _icon.setFrame(1);
            stateInfo = model.getChildPatrolFriendStateInfoByUserId(_data.userId);
            if(stateInfo)
            {
               _stateImage.visible = stateInfo.state == 2 ? true : false;
            }
         }
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
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
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _data = null;
         stateInfo = null;
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
         }
         _nameText = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
         }
         _nameText = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_stateImage)
         {
            ObjectUtils.disposeObject(_stateImage);
         }
         _stateImage = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

