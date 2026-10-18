package kingcontract
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class KingContractPresentFrame extends Frame implements Disposeable
   {
      
      private var _friendNameBg:Bitmap;
      
      private var _friendNameBack:ScaleBitmapImage;
      
      private var _friendRepeatBg:Bitmap;
      
      private var _friendRepeatBack:ScaleBitmapImage;
      
      private var _presentCombox:PresentComboxBox;
      
      private var _repeatName:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _diamondCount:int = 338;
      
      private var _tempStr1:String = "";
      
      private var _tempStr2:String = "";
      
      private var _selectIndex:int;
      
      private var _currentSelected:ThaneInfo;
      
      private var _friendList:Array = [];
      
      public function KingContractPresentFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("kingcontract.KingContractPresentFrame.title");
         _friendNameBg = ComponentFactory.Instance.creatBitmap("asset.kingcontract.friend.FriendNameBg");
         _friendNameBack = ComponentFactory.Instance.creatComponentByStylename("kingcontract.KingContractPresentFrame.friendNameBack");
         _friendRepeatBg = ComponentFactory.Instance.creatBitmap("asset.kingcontract.friend.RepeatNameBg");
         _friendRepeatBack = ComponentFactory.Instance.creatComponentByStylename("kingcontract.KingContractPresentFrame.friendNameBack");
         _presentCombox = ComponentFactory.Instance.creatComponentByStylename("kingcontract.KingContractPresentFrame.PresentComboxBox");
         _repeatName = ComponentFactory.Instance.creatComponentByStylename("kingcontract.KingContractPresentFrame.Combox_TextStyle");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("kingcontract.KingContractPresentFrame.BuyBtn");
         addToContent(_friendNameBg);
         addToContent(_friendNameBack);
         addToContent(_friendRepeatBg);
         addToContent(_friendRepeatBack);
         addToContent(_repeatName);
         addToContent(_buyBtn);
         addToContent(_presentCombox);
         _friendRepeatBack.y = 59;
         _repeatName.x = 131;
         _repeatName.y = 66;
         _presentCombox.textValue = "";
         _presentCombox.consortiaBtn.text = LanguageMgr.GetTranslation("public.consortia");
         _presentCombox.friendBtn.text = LanguageMgr.GetTranslation("public.friend");
         _presentCombox.consortiaBtn.enable = PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID != 0;
         (_presentCombox.button as SelectedCheckButton).text = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.Friendlist");
         _presentCombox.textField.tabIndex = 1;
         _repeatName.tabIndex = 2;
         initComboBox(getFriendNameList);
      }
      
      private function initComboBox(param1:Array) : void
      {
         var _loc3_:int = 0;
         _presentCombox.beginChanges();
         _presentCombox.selctedPropName = "text";
         var _loc2_:VectorListModel = _presentCombox.listPanel.vectorListModel;
         _loc2_.clear();
         while(_loc3_ < param1.length)
         {
            _loc2_.append(param1[_loc3_]);
            _loc3_++;
         }
         _presentCombox.listPanel.list.updateListView();
         _presentCombox.listPanel.list.addEventListener("listItemClick",__itemClick);
         _presentCombox.commitChanges();
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         _selectIndex = param1.index;
         _currentSelected = param1.cellValue;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__responseHandler);
         _presentCombox.button.addEventListener("click",_comboHandler);
         _presentCombox.addEventListener("friend_selected",_comboFriend);
         _presentCombox.addEventListener("consortia_selected",_comConsortia);
         _presentCombox.addEventListener("select_textField",_selectField);
         _presentCombox.textField.addEventListener("keyDown",__focusInHandler);
         _presentCombox.textField.addEventListener("change",__inputNickNameHandler);
         _repeatName.addEventListener("keyDown",__focusInHandler);
         _repeatName.addEventListener("change",__inputRepeatNameHandler);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         NotificationManager.instance.addEventListener("KING_CONTRACT",_closeSwitchHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         if(_presentCombox)
         {
            _presentCombox.removeEventListener("friend_selected",_comboFriend);
            _presentCombox.removeEventListener("consortia_selected",_comConsortia);
            _presentCombox.removeEventListener("select_textField",_selectField);
            if(_presentCombox.button)
            {
               _presentCombox.button.removeEventListener("click",_comboHandler);
            }
            if(_presentCombox.textField)
            {
               _presentCombox.textField.removeEventListener("keyDown",__focusInHandler);
            }
            if(_presentCombox.textField)
            {
               _presentCombox.textField.removeEventListener("change",__inputNickNameHandler);
            }
            if(_presentCombox.listPanel && _presentCombox.listPanel.list)
            {
               _presentCombox.listPanel.list.removeEventListener("listItemClick",__itemClick);
            }
         }
         if(_repeatName)
         {
            _repeatName.removeEventListener("keyDown",__focusInHandler);
         }
         if(_repeatName)
         {
            _repeatName.removeEventListener("change",__inputRepeatNameHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         }
         NotificationManager.instance.removeEventListener("KING_CONTRACT",_closeSwitchHandler);
      }
      
      private function _closeSwitchHandler(param1:NotificationEvent) : void
      {
         if(!VersionSwitch.KING_CONTRACT)
         {
            dispose();
         }
      }
      
      private function _comboHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function _comboFriend(param1:Event) : void
      {
         if(!_presentCombox.friendBtn.selected)
         {
            _selectIndex = 0;
            initComboBox(getFriendNameList);
         }
      }
      
      private function _comConsortia(param1:Event) : void
      {
         if(!_presentCombox.consortiaBtn.selected)
         {
            _selectIndex = 0;
            initComboBox(ConsortiaManager.instance.model.consortiaMemberList.getList());
         }
      }
      
      private function _selectField(param1:Event) : void
      {
         _selectIndex = 0;
         _currentSelected = null;
      }
      
      private function __focusInHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __inputNickNameHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_presentCombox.textValue) > 12)
         {
            _presentCombox.textValue = _tempStr1;
         }
         _tempStr1 = _presentCombox.textValue;
      }
      
      private function __inputRepeatNameHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_repeatName.text) > 12)
         {
            _repeatName.text = _tempStr2;
         }
         _tempStr2 = _repeatName.text;
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_repeatName.text == "" || _presentCombox.textField.text == "")
         {
            _loc2_ = LanguageMgr.GetTranslation("vip.view.OpenSelfView.OpenFriendView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_repeatName.text.toLowerCase() == _presentCombox.textField.text.toLowerCase())
         {
            if(playerInfo.point < point)
            {
               RechargeAlertMannager.show();
               return;
            }
            presentKingContract();
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("vip.view.OpenSelfView.OpenFriendView.command02");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function presentKingContract() : void
      {
         var _loc1_:Array = [1,2,3,4,5,6];
         if(_currentSelected && _currentSelected.nickName.toLowerCase() == _repeatName.text.toLowerCase())
         {
            KingContractManager.Instance.presentKingContract(_loc1_,_currentSelected.userId,_repeatName.text);
         }
         else
         {
            KingContractManager.Instance.presentKingContract(_loc1_,0,_repeatName.text);
         }
         _repeatName.text = "";
         _presentCombox.textValue = "";
      }
      
      private function get getFriendNameList() : Array
      {
         _friendList.splice(0,_friendList.length);
         var _loc1_:Dictionary = FriendManager.getInstance().friendList;
         for each(var _loc2_:ThaneInfo in _loc1_)
         {
            if(_loc2_.relation == 1 || _loc2_.relation == 3)
            {
               _friendList.push(_loc2_);
            }
         }
         return _friendList;
      }
      
      private function get point() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("All_KingContract").ConfigValue);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_friendNameBg);
         _friendNameBg = null;
         ObjectUtils.disposeObject(_friendNameBack);
         _friendNameBack = null;
         ObjectUtils.disposeObject(_friendRepeatBg);
         _friendRepeatBg = null;
         ObjectUtils.disposeObject(_friendRepeatBack);
         _friendRepeatBack = null;
         ObjectUtils.disposeObject(_presentCombox);
         _presentCombox = null;
         ObjectUtils.disposeObject(_repeatName);
         _repeatName = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

