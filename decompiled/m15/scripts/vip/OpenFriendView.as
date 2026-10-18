package vip
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.NoviceBtnGlowEffect;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class OpenFriendView extends Sprite implements Disposeable
   {
      
      private var _friendNameBg:Bitmap;
      
      private var _friendNameBack:Bitmap;
      
      private var _friendRepeatBg:Bitmap;
      
      private var _friendRepeatBack:Bitmap;
      
      private var _framePromptPoint:FilterFrameText;
      
      private var _openVipBtn:IconButton;
      
      private var _currentPointTxtBg:Bitmap;
      
      private var _currentPointTxt:FilterFrameText;
      
      private var _vipCombox:VipComboxBox;
      
      private var _vipRepeatName:FilterFrameText;
      
      private var _smallPointImg:Bitmap;
      
      private var _itemList:Array;
      
      private var _currentItem:OpenVipItem;
      
      private var _disOpenEffect:NoviceBtnGlowEffect;
      
      private var _tempStr1:String = "";
      
      private var _tempStr2:String = "";
      
      private var _selectIndex:int;
      
      private var _currentSelected:ThaneInfo;
      
      private var _friendList:Array = [];
      
      public function OpenFriendView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:OpenVipItem = null;
         _friendNameBg = ComponentFactory.Instance.creatBitmap("asset.vip.friendNameBg");
         _friendNameBack = ComponentFactory.Instance.creatBitmap("asset.vip.friendNameBack");
         _friendRepeatBg = ComponentFactory.Instance.creatBitmap("asset.vip.friendRepeatBg");
         _friendRepeatBack = ComponentFactory.Instance.creatBitmap("asset.vip.friendNameBack");
         _framePromptPoint = ComponentFactory.Instance.creatComponentByStylename("vip.vipFramePromptPoint");
         _openVipBtn = ComponentFactory.Instance.creatComponentByStylename("vip.OpenVipBtn");
         _smallPointImg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _currentPointTxtBg = ComponentFactory.Instance.creatBitmap("asset.vip.CurrentPointtxtBg");
         _currentPointTxt = ComponentFactory.Instance.creatComponentByStylename("vip.currentPointTxt");
         _vipCombox = ComponentFactory.Instance.creatComponentByStylename("vip.Combox");
         _vipRepeatName = ComponentFactory.Instance.creatComponentByStylename("vip.Combox1_TextStyle");
         _disOpenEffect = new NoviceBtnGlowEffect(_openVipBtn);
         _disOpenEffect.play();
         addChild(_friendNameBg);
         addChild(_friendNameBack);
         addChild(_friendRepeatBg);
         addChild(_friendRepeatBack);
         addChild(_framePromptPoint);
         addChild(_smallPointImg);
         addChild(_openVipBtn);
         addChild(_currentPointTxt);
         addChild(_currentPointTxtBg);
         addChild(_vipRepeatName);
         initComboBox(getFriendNameList);
         addChild(_vipCombox);
         _friendRepeatBack.y = 165;
         _smallPointImg.x = 132;
         _smallPointImg.y = 205;
         _vipRepeatName.x = 132;
         _vipRepeatName.y = 172;
         _vipCombox.textValue = "";
         _currentPointTxt.text = playerInfo.point + "";
         _framePromptPoint.text = LanguageMgr.GetTranslation("vip.view.OpenSelfView.framePromptPoint",model.one_MonthPoint);
         _vipCombox.consortiaBtn.text = LanguageMgr.GetTranslation("public.consortia");
         _vipCombox.friendBtn.text = LanguageMgr.GetTranslation("public.friend");
         _vipCombox.consortiaBtn.enable = PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID != 0;
         (_vipCombox.button as SelectedCheckButton).text = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.Friendlist");
         _vipRepeatName.tabIndex = 2;
         _vipCombox.textField.tabIndex = 1;
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new OpenVipItem();
            addChild(_loc1_);
            _loc1_.y = 2;
            _loc1_.index = _loc2_;
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _itemList[0].x = 12;
         _itemList[1].x = 237;
         _itemList[2].x = 390;
      }
      
      private function initComboBox(param1:Array) : void
      {
         var _loc3_:int = 0;
         _vipCombox.beginChanges();
         _vipCombox.selctedPropName = "text";
         var _loc2_:VectorListModel = _vipCombox.listPanel.vectorListModel;
         _loc2_.clear();
         while(_loc3_ < param1.length)
         {
            _loc2_.append(param1[_loc3_]);
            _loc3_++;
         }
         _vipCombox.listPanel.list.updateListView();
         _vipCombox.listPanel.list.addEventListener("listItemClick",__itemClick);
         _vipCombox.commitChanges();
      }
      
      private function initEvent() : void
      {
         _vipCombox.button.addEventListener("click",_comboHandler);
         _vipCombox.addEventListener("friend_selected",_comboFriend);
         _vipCombox.addEventListener("consortia_selected",_comConsortia);
         _vipCombox.addEventListener("select_textField",_selectField);
         _vipCombox.textField.addEventListener("keyDown",__focusInHandler);
         _vipCombox.textField.addEventListener("change",__inputNickNameHandler);
         _vipRepeatName.addEventListener("keyDown",__focusInHandler);
         _vipRepeatName.addEventListener("change",__inputRepeatNameHandler);
         _openVipBtn.addEventListener("click",__openVipHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         _itemList[0].addEventListener("click",__clickHnadler);
         _itemList[1].addEventListener("click",__clickHnadler);
         _itemList[2].addEventListener("click",__clickHnadler);
         _itemList[0].dispatchEvent(new MouseEvent("click"));
      }
      
      private function __clickHnadler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _itemList[_loc2_].isSelect = param1.currentTarget == _itemList[_loc2_];
            _loc2_++;
         }
         _currentItem = param1.currentTarget as OpenVipItem;
      }
      
      private function __openVipHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_vipRepeatName.text == "" || _vipCombox.textField.text == "")
         {
            _loc2_ = LanguageMgr.GetTranslation("vip.view.OpenSelfView.OpenFriendView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_vipRepeatName.text.toLowerCase() == _vipCombox.textField.text.toLowerCase())
         {
            if(playerInfo.point < _currentItem.point)
            {
               RechargeAlertMannager.show();
               return;
            }
            __AlertVipHandler();
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("vip.view.OpenSelfView.OpenFriendView.command02");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function __AlertVipHandler() : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("vip.view.OpenFriendView.command02",_currentItem.index,_currentItem.point);
         SimpleAlertHelper.instance.data = [_confirmFun];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,false,true);
      }
      
      private function _confirmFun(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_currentSelected && _currentSelected.nickName == _vipRepeatName.text)
            {
               VIPManager.Instance.openVip(true,_currentSelected.userId,_currentSelected.nickName,_currentItem.index * 31);
            }
            else
            {
               VIPManager.Instance.openVip(true,0,_vipRepeatName.text,_currentItem.index * 31);
            }
            _vipRepeatName.text = "";
            _vipCombox.textValue = "";
         }
      }
      
      private function removeEvent() : void
      {
         _vipCombox.button.removeEventListener("click",_comboHandler);
         _vipCombox.removeEventListener("friend_selected",_comboFriend);
         _vipCombox.removeEventListener("consortia_selected",_comConsortia);
         _vipCombox.removeEventListener("select_textField",_selectField);
         _vipCombox.textField.removeEventListener("keyDown",__focusInHandler);
         _vipCombox.textField.removeEventListener("change",__inputNickNameHandler);
         _vipRepeatName.removeEventListener("keyDown",__focusInHandler);
         _vipRepeatName.removeEventListener("change",__inputRepeatNameHandler);
         _openVipBtn.removeEventListener("click",__openVipHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         _itemList[0].removeEventListener("click",__clickHnadler);
         _itemList[1].removeEventListener("click",__clickHnadler);
         _itemList[2].removeEventListener("click",__clickHnadler);
         if(_vipCombox)
         {
            _vipCombox.listPanel.list.removeEventListener("listItemClick",__itemClick);
         }
      }
      
      private function __refreshPlayerInfoHandler(param1:PlayerEvent) : void
      {
         _currentPointTxt.text = playerInfo.point + "";
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function _comboHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function _comboFriend(param1:Event) : void
      {
         if(!_vipCombox.friendBtn.selected)
         {
            _selectIndex = 0;
            initComboBox(getFriendNameList);
         }
      }
      
      private function _comConsortia(param1:Event) : void
      {
         if(!_vipCombox.consortiaBtn.selected)
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
      
      private function __inputNickNameHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_vipCombox.textValue) > 12)
         {
            _vipCombox.textValue = _tempStr1;
         }
         _tempStr1 = _vipCombox.textValue;
      }
      
      private function __inputRepeatNameHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_vipRepeatName.text) > 12)
         {
            _vipRepeatName.text = _tempStr2;
         }
         _tempStr2 = _vipRepeatName.text;
      }
      
      private function __focusInHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         _selectIndex = param1.index;
         _currentSelected = param1.cellValue;
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
      
      private function get model() : VIPModel
      {
         return FrameControllerManager.instance.vipController.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

