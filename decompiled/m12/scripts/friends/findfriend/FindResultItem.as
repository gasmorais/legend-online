package friends.findfriend
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.FriendUpdateEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.sns.BaseSnsInfo;
   import yishi.manager.FriendManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.view.community.HeadIconCell;
   import yishi.view.tips.MessageTipManager;
   
   public class FindResultItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _headCell:HeadIconCell;
      
      private var _nameTxt:FilterFrameText;
      
      private var _sexTxt:FilterFrameText;
      
      private var _horoscopeTxt:FilterFrameText;
      
      private var _bloodTxt:FilterFrameText;
      
      private var _areaTxt:FilterFrameText;
      
      private var _checkBtn:BaseButton;
      
      private var _addFriendBtn:BaseButton;
      
      private var _data:BaseSnsInfo;
      
      private var _province:String;
      
      private var _city:String;
      
      public function FindResultItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultCellBg");
         _headCell = ComponentFactory.Instance.creatCustomObject("friends.FindResultCellHeadCell");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultCellNameTxt");
         _sexTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultCellSexTxt");
         _horoscopeTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultCellHoroscopeTxt");
         _bloodTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultCellBloodTxt");
         _areaTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultCellAreaTxt");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultCellCheckBtn");
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultCellAddFriendBtn");
         _areaTxt.isAutoFitLength = true;
         _checkBtn.tipData = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.info");
         _addFriendBtn.tipData = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.addFriend");
         addChild(_bg);
         addChild(_headCell);
         addChild(_nameTxt);
         addChild(_sexTxt);
         addChild(_horoscopeTxt);
         addChild(_bloodTxt);
         addChild(_areaTxt);
         addChild(_checkBtn);
         addChild(_addFriendBtn);
      }
      
      private function addEvent() : void
      {
         _checkBtn.addEventListener("click",__onCheckClick);
         _addFriendBtn.addEventListener("click",__onAddFriendClick);
         FriendManager.getInstance().addEventListener("ADD_FRIEND",__addFriendHandler);
         FriendManager.getInstance().addEventListener("REMOVE_FRIEND",__removeFriendHandler);
      }
      
      private function removeEvent() : void
      {
         _checkBtn.removeEventListener("click",__onCheckClick);
         _addFriendBtn.removeEventListener("click",__onAddFriendClick);
         FriendManager.getInstance().removeEventListener("ADD_FRIEND",__addFriendHandler);
         FriendManager.getInstance().removeEventListener("REMOVE_FRIEND",__removeFriendHandler);
      }
      
      private function __addFriendHandler(param1:FriendUpdateEvent) : void
      {
         if(_data && _data.userId == int(param1.object))
         {
            _addFriendBtn.enable = false;
         }
      }
      
      private function __removeFriendHandler(param1:FriendUpdateEvent) : void
      {
         if(_data && _data.userId == int(param1.data))
         {
            _addFriendBtn.enable = true;
         }
      }
      
      private function __onCheckClick(param1:MouseEvent) : void
      {
         if(_data)
         {
            PlayerInfoManager.instance.show(_data.userId);
         }
      }
      
      private function __onAddFriendClick(param1:MouseEvent) : void
      {
         if(_data)
         {
            if(FriendManager.getInstance().checkIsExistRelation(_data.userId,1))
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.FriendManager.command05"));
               _addFriendBtn.enable = false;
               return;
            }
            FriendManager.getInstance().sendAddFriendRequest(_data.nickName,1);
         }
      }
      
      private function checkAddFriend(param1:int) : Boolean
      {
         var _loc2_:Array = FriendManager.getInstance().friendList.getList();
         for each(var _loc3_:FriendItemCellInfo in _loc2_)
         {
            if(_loc3_.userId == param1 && (_loc3_.relation == 1 || _loc3_.relation == 3))
            {
               return false;
            }
         }
         return true;
      }
      
      public function set data(param1:*) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1 as BaseSnsInfo;
         if(_data)
         {
            _sexTxt.text = _data.sexName;
            _horoscopeTxt.text = _data.horoscopeName;
            _bloodTxt.text = _data.bloodName;
            _province = _data.provinceName != "" ? _data.provinceName : LanguageMgr.GetTranslation("friends.findfriend.FindResultItem.unknown");
            _city = _data.cityName;
            _headCell.headId = _data.headId;
            _nameTxt.text = _data.nickName;
            _areaTxt.text = _province + "   " + _city;
            _addFriendBtn.enable = checkAddFriend(_data.userId);
         }
      }
      
      public function setFrame(param1:int) : void
      {
         if(_bg)
         {
            _bg.setFrame(param1);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_headCell)
         {
            _headCell.dispose();
         }
         _headCell = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_sexTxt)
         {
            _sexTxt.dispose();
         }
         _sexTxt = null;
         if(_horoscopeTxt)
         {
            _horoscopeTxt.dispose();
         }
         _horoscopeTxt = null;
         if(_bloodTxt)
         {
            _bloodTxt.dispose();
         }
         _bloodTxt = null;
         if(_areaTxt)
         {
            _areaTxt.dispose();
         }
         _areaTxt = null;
         if(_checkBtn)
         {
            _checkBtn.dispose();
         }
         _checkBtn = null;
         if(_addFriendBtn)
         {
            _addFriendBtn.dispose();
         }
         _addFriendBtn = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

