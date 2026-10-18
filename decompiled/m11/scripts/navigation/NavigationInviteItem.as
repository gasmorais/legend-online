package navigation
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationModel;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class NavigationInviteItem extends Component
   {
      
      private var _icon:ScaleFrameImage;
      
      private var _nameText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _inviteText:FilterFrameText;
      
      private var _inviteBtn:SelectedButton;
      
      private var _selected:Boolean = false;
      
      private var _data:ThaneInfo;
      
      public function NavigationInviteItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("core.SexIcon");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteItem.ItemNameText");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteItem.gradeText");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteItem.SelectButton");
         _inviteText = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteItem.inviteTxt");
         _inviteText.text = LanguageMgr.GetTranslation("farm.view.invidedTxt");
         addChild(_icon);
         _icon.x = 10;
         _icon.y = 3;
         addChild(_nameText);
         addChild(_gradeText);
         addChild(_inviteBtn);
         addChild(_inviteText);
         _inviteBtn.selected = selected;
      }
      
      private function addEvent() : void
      {
         _inviteBtn.addEventListener("click",onSelectBtnClick);
      }
      
      private function removeEvent() : void
      {
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",onSelectBtnClick);
         }
      }
      
      private function onSelectBtnClick(param1:MouseEvent) : void
      {
         _selected = _inviteBtn.selected;
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         if(_data == null)
         {
            return;
         }
         updateView();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _inviteBtn.selected = selected;
      }
      
      public function updateView() : void
      {
         _data.sexs == 0 ? _icon.setFrame(2) : _icon.setFrame(1);
         _nameText.text = _data.nickName;
         _gradeText.text = LanguageMgr.GetTranslation("public.level4_space2",_data.grades);
         _inviteText.visible = false;
         _inviteBtn.visible = true;
      }
      
      public function invide() : void
      {
         _inviteText.visible = true;
         _inviteBtn.visible = false;
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_inviteText);
         _inviteText = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

