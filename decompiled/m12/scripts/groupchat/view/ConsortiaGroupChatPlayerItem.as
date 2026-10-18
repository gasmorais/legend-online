package groupchat.view
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import events.GroupChatEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.IMManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.HeadIconCell;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaGroupChatPlayerItem extends Sprite implements ISelectable, IListCell, Disposeable
   {
      
      private var _selected:Boolean;
      
      private var _data:ThaneInfo;
      
      private var _back:ScaleBitmapImage;
      
      private var _iconMaster:ScaleFrameImage;
      
      private var _icon:HeadIconCell;
      
      private var _nameText:FilterFrameText;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _vipText:GradientText;
      
      public function ConsortiaGroupChatPlayerItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.PlayerItemBack");
         _iconMaster = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.MenberListItemMaster");
         _icon = ComponentFactory.Instance.creatCustomObject("consortiagroupchat.MenberListItemHeadCell");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.MenberListItemName");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon");
         _vipText = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.MenberListItemNameGradientText");
         _nameText.isAutoFitLength = true;
         addChild(_back);
         _back.visible = false;
         addChild(_iconMaster);
         _iconMaster.setFrame(1);
         addChild(_icon);
         addChild(_nameText);
         addChild(_vipText);
         addChild(_vipIcon);
         _vipIcon.x = _nameText.x - _vipIcon.width;
         _vipIcon.y = 8;
      }
      
      private function initEvent() : void
      {
         DoubleClickManager.Instance.enableDoubleClick(this);
         addEventListener("click",__onMouseClick);
         addEventListener("interactive_double_click",__onDoubleClick);
         addEventListener("rollOver",__onMouseRollover);
         addEventListener("rollOut",__onMouseRollout);
      }
      
      private function removeEvent() : void
      {
         DoubleClickManager.Instance.disableDoubleClick(this);
         removeEventListener("click",__onMouseClick);
         removeEventListener("interactive_double_click",__onDoubleClick);
         removeEventListener("rollOver",__onMouseRollover);
         removeEventListener("rollOut",__onMouseRollout);
      }
      
      private function __onMouseClick(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         FrameControllerManager.instance.consortiaGroupChatControler.model.dispatchEvent(new GroupChatEvent("consortiagroupchatitemselected",_data,this));
      }
      
      private function __onDoubleClick(param1:InteractiveEvent) : void
      {
         var _loc2_:String = "";
         if(!_data)
         {
            return;
         }
         if(_data.userId == ArmyManager.instance.thane.userId)
         {
            _loc2_ = LanguageMgr.GetTranslation("friends.im.IMManager.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         IMManager.instance.createIMFrame(_data);
      }
      
      protected function __onMouseRollover(param1:MouseEvent) : void
      {
         _back.visible = true;
      }
      
      protected function __onMouseRollout(param1:MouseEvent) : void
      {
         _back.visible = false;
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
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         selected = param2;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         if(_data)
         {
            _icon.filters = null;
            _nameText.filters = null;
            _iconMaster.visible = false;
            _vipIcon.filters = null;
            _vipIcon.visible = false;
            _vipText.filters = null;
            _vipText.visible = false;
            if(_back.parent)
            {
               _back.parent.removeChild(_back);
            }
            if(_iconMaster.parent)
            {
               _iconMaster.parent.removeChild(_iconMaster);
            }
            if(_icon.parent)
            {
               _icon.parent.removeChild(_icon);
            }
            if(_nameText.parent)
            {
               _nameText.parent.removeChild(_nameText);
            }
            if(_vipIcon.parent)
            {
               _vipIcon.parent.removeChild(_vipIcon);
            }
            if(_vipText.parent)
            {
               _vipText.parent.removeChild(_vipText);
            }
         }
         _data = param1 as ThaneInfo;
         if(!_data)
         {
            return;
         }
         if(_data.dutyId == 1)
         {
            _iconMaster.x = 1;
            _iconMaster.setFrame(2);
            _iconMaster.visible = true;
         }
         else if(_data.dutyId == 2)
         {
            _iconMaster.x = 3;
            _iconMaster.setFrame(1);
            _iconMaster.visible = true;
         }
         if(_icon.headId != _data.headId)
         {
            _icon.headId = _data.headId;
         }
         _nameText.text = _data.nickName || "";
         if(_data.IsVipAndNoExpirt)
         {
            if(_data.vipType == 1)
            {
               _vipIcon.setFrame(1);
            }
            else
            {
               _vipIcon.setFrame(2);
            }
            _vipIcon.visible = true;
            _vipText.visible = true;
            _nameText.visible = false;
            _vipText.text = _nameText.text;
         }
         else
         {
            _nameText.visible = true;
         }
         if(!_data.isOnline)
         {
            _icon.filters = [UIFilter.getGrayFilter()];
            _nameText.filters = [UIFilter.getGrayFilter()];
            _vipIcon.filters = [UIFilter.getGrayFilter()];
            _vipText.filters = [UIFilter.getGrayFilter()];
         }
         addChild(_back);
         addChild(_iconMaster);
         addChild(_icon);
         addChild(_nameText);
         addChild(_vipIcon);
         addChild(_vipText);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_iconMaster)
         {
            _iconMaster.dispose();
         }
         _iconMaster = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_nameText)
         {
            _nameText.dispose();
         }
         _nameText = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         if(_data)
         {
            _data = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

