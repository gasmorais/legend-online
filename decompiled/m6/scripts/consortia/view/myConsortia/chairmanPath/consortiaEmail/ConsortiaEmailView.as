package consortia.view.myConsortia.chairmanPath.consortiaEmail
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.view.frame.giftdonatio.RecipientsAutoSearchBox;
   
   public class ConsortiaEmailView extends Sprite implements Disposeable
   {
      
      public static const SPLIT_STR:String = ",";
      
      private var _searchBoxHideTimeId:int;
      
      private var _memberBtn:TextButton;
      
      private var _nameInput:FilterFrameText;
      
      private var _memberListView:EmailConsortiaMemberView;
      
      private var _memberSearchBox:RecipientsAutoSearchBox;
      
      private var _memberItemList:Vector.<ConsortiaEmailMemberItem>;
      
      public function ConsortiaEmailView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _memberBtn = ComponentFactory.Instance.creatComponentByStylename("email.ConsortiaEmailView.memberBtn");
         _nameInput = ComponentFactory.Instance.creatComponentByStylename("email.ConsortiaEmailView.memberNameInput");
         _memberBtn.text = LanguageMgr.GetTranslation("emailII.view.ConsortiaEmailView.memberBtn.text");
         _memberSearchBox = new RecipientsAutoSearchBox();
         _memberListView = new EmailConsortiaMemberView();
         addChild(_memberSearchBox);
         addChild(_memberListView);
         addChild(_memberBtn);
         addChild(_nameInput);
         _memberSearchBox.visible = false;
         _memberListView.visible = false;
         _memberSearchBox.x = -2;
         _memberSearchBox.y = 33;
         _memberListView.x = 255;
      }
      
      private function initEvent() : void
      {
         _memberSearchBox.addEventListener("listItemMouseDown",__onSearchListItemClick);
         _nameInput.addEventListener("change",__textChangeHandler);
         _nameInput.addEventListener("click",__textClickHandler);
         _nameInput.addEventListener("focusOut",__textFocusOutHandler);
         _memberBtn.addEventListener("click",__memberBtnClickHandler);
         _memberListView.addEventListener("UPDATA_CONSORTIAEMAIL_MEMBERLIST",__updataHandler);
      }
      
      private function removeEvents() : void
      {
         _nameInput.removeEventListener("change",__textChangeHandler);
         _nameInput.removeEventListener("click",__textClickHandler);
         _nameInput.removeEventListener("focusOut",__textFocusOutHandler);
         _memberSearchBox.removeEventListener("listItemMouseDown",__onSearchListItemClick);
         _memberBtn.removeEventListener("click",__memberBtnClickHandler);
         _memberListView.removeEventListener("UPDATA_CONSORTIAEMAIL_MEMBERLIST",__updataHandler);
      }
      
      private function __updataHandler(param1:ConsortiaEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("022");
         if(param1.data)
         {
            _memberItemList = param1.data as Vector.<ConsortiaEmailMemberItem>;
            _nameInput.text = "";
            _loc2_ = 0;
            while(_loc2_ < _memberItemList.length)
            {
               if(_loc2_ != _memberItemList.length - 1)
               {
                  _nameInput.appendText(_memberItemList[_loc2_].data.nickName + ",");
               }
               else
               {
                  _nameInput.appendText(_memberItemList[_loc2_].data.nickName);
               }
               _loc2_++;
            }
         }
      }
      
      private function __memberBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _memberListView.visible = !_memberListView.visible;
         _memberListView.refreshList();
      }
      
      private function __textClickHandler(param1:MouseEvent) : void
      {
         __textChangeHandler(null);
      }
      
      private function __textFocusOutHandler(param1:FocusEvent) : void
      {
         clearTimeout(_searchBoxHideTimeId);
         _searchBoxHideTimeId = setTimeout(hideSearchBox,50);
      }
      
      private function hideSearchBox() : void
      {
         clearTimeout(_searchBoxHideTimeId);
         if(_memberSearchBox)
         {
            _memberSearchBox.visible = false;
         }
      }
      
      private function __onSearchListItemClick(param1:ListItemEvent) : void
      {
         var _loc2_:ThaneInfo = param1.cellValue as ThaneInfo;
         if(_loc2_)
         {
            _nameInput.text = _loc2_.nickName;
         }
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         _memberSearchBox.setSearchString(_nameInput.text,2);
      }
      
      public function get nameText() : FilterFrameText
      {
         return _nameInput;
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         _memberBtn = null;
         _nameInput = null;
         _memberListView = null;
         _memberSearchBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

