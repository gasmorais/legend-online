package teammanager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class TeamSortItem extends Component
   {
      
      private var _iconCell:TeamSortCell;
      
      private var fontBtn:SelectedIconButton;
      
      private var backBtn:SelectedIconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _pos:int;
      
      private var _data:ThaneInfo;
      
      public var index:int;
      
      public var serverName:String;
      
      public var dragEnable:Boolean;
      
      public function TeamSortItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _iconCell = ComponentFactory.Instance.creatCustomObject("teammanager.TeamSortCell");
         fontBtn = ComponentFactory.Instance.creatComponentByStylename("teammanager.TeamSortItem.fontBtn");
         backBtn = ComponentFactory.Instance.creatComponentByStylename("teammanager.TeamSortItem.backBtn");
         addChild(iconCell);
         addChild(fontBtn);
         addChild(backBtn);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(fontBtn);
         _group.addSelectItem(backBtn);
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         iconCell.hero = _data;
         iconCell.index = index;
         iconCell.dragEnable = dragEnable;
         iconCell.buttonMode = dragEnable;
         iconCell.backTxt.visible = false;
         if(!_data || !dragEnable)
         {
            fontBtn.mouseEnabled = backBtn.mouseEnabled = false;
         }
      }
      
      private function __fontClickHandler(param1:MouseEvent) : void
      {
         iconCell.pos -= 2;
         setBtnEventAndState();
         iconCell.dispatchEvent(new Event("EDIT_TEAM_FIGHT_POS"));
      }
      
      private function __backClickHandler(param1:MouseEvent) : void
      {
         iconCell.pos += 2;
         setBtnEventAndState();
         iconCell.dispatchEvent(new Event("EDIT_TEAM_FIGHT_POS"));
      }
      
      public function set pos(param1:int) : void
      {
         _pos = param1;
         iconCell.pos = _pos;
         setBtnEventAndState();
      }
      
      private function setBtnEventAndState() : void
      {
         removeEvent();
         iconCell.backTxt.visible = false;
         if(iconCell.pos == 0)
         {
            _group.selectIndex = -1;
            fontBtn.mouseEnabled = backBtn.mouseEnabled = false;
            return;
         }
         if(dragEnable)
         {
            fontBtn.mouseEnabled = backBtn.mouseEnabled = true;
         }
         if(iconCell.pos % 3 != 0)
         {
            _group.selectIndex = 0;
         }
         else
         {
            _group.selectIndex = 1;
         }
         if(!fontBtn.selected)
         {
            fontBtn.addEventListener("click",__fontClickHandler);
         }
         if(!backBtn.selected)
         {
            backBtn.addEventListener("click",__backClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(fontBtn)
         {
            fontBtn.removeEventListener("click",__fontClickHandler);
         }
         if(backBtn)
         {
            backBtn.removeEventListener("click",__backClickHandler);
         }
      }
      
      public function get iconCell() : TeamSortCell
      {
         return _iconCell;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_iconCell)
         {
            ObjectUtils.disposeObject(_iconCell);
         }
         _iconCell = null;
         if(fontBtn)
         {
            ObjectUtils.disposeObject(fontBtn);
         }
         fontBtn = null;
         if(backBtn)
         {
            ObjectUtils.disposeObject(backBtn);
         }
         backBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

