package simplegame.handlsel
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.StringHelper;
   import yishi.view.component.WriteMailComboxBox;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class HandlselFrame extends Frame
   {
      
      public static const CARD_ID:int = 2220001;
      
      private var _bg:MutipleImage;
      
      private var _inputBg:ScaleBitmapImage;
      
      private var _inputComBox:WriteMailComboxBox;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _tempStr:String = "";
      
      private var _friendList:Dictionary;
      
      private var _data:GoodsInfo;
      
      public function HandlselFrame()
      {
         super();
         initFriendList();
         initView();
         initEvent();
      }
      
      private function initFriendList() : void
      {
         _friendList = new Dictionary();
         var _loc1_:Dictionary = FriendManager.getInstance().friendList;
         for each(var _loc2_:ThaneInfo in _loc1_)
         {
            if(_loc2_.relation == 1 && _loc2_.isOnline)
            {
               _friendList[_loc2_.nickName] = _loc2_;
            }
         }
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("friends.view.RosePresentView.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("newYearAct.handlselBg");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("newYearAct.inputBg");
         _inputComBox = ComponentFactory.Instance.creatComponentByStylename("newYearAct.handlselInputComBox");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("newYearAct.handlselConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("newYearAct.handlselCancleBtn");
         addToContent(_bg);
         addToContent(_inputBg);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
         addToContent(_inputComBox);
         _inputComBox.textValue = "";
         _inputComBox.searchRange = 1;
         (_inputComBox.button as TextButton).text = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.Friendlist");
         initComboBox(_friendList);
      }
      
      private function initComboBox(param1:Dictionary) : void
      {
         _inputComBox.beginChanges();
         _inputComBox.selctedPropName = "text";
         var _loc2_:VectorListModel = _inputComBox.listPanel.vectorListModel;
         _loc2_.clear();
         for each(var _loc3_:ThaneInfo in param1)
         {
            if(_loc3_.userId != thane.userId)
            {
               _loc2_.append(_loc3_);
            }
         }
         _inputComBox.listPanel.list.updateListView();
         _inputComBox.commitChanges();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_respose);
         _inputComBox.textField.addEventListener("keyDown",__focusInHandler);
         _inputComBox.textField.addEventListener("change",__inputNickNameHandler);
         _confirmBtn.addEventListener("click",__onConfirmClick);
         _cancelBtn.addEventListener("click",__onCancleClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_respose);
         if(_inputComBox)
         {
            if(_inputComBox.textField)
            {
               _inputComBox.textField.removeEventListener("keyDown",__focusInHandler);
            }
            if(_inputComBox.textField)
            {
               _inputComBox.textField.removeEventListener("change",__inputNickNameHandler);
            }
         }
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__onConfirmClick);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__onCancleClick);
         }
      }
      
      private function __focusInHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __inputNickNameHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_inputComBox.textValue) > 12)
         {
            _inputComBox.textValue = _tempStr;
         }
         _tempStr = _inputComBox.textValue;
      }
      
      private function _respose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1 && param1.frameData)
         {
            if(param1.frameData is String)
            {
               _inputComBox.textValue = String(param1.frameData);
            }
            else if(param1.frameData is GoodsInfo)
            {
               _data = param1.frameData as GoodsInfo;
            }
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function __onConfirmClick(param1:MouseEvent) : void
      {
         var _loc3_:ThaneInfo = null;
         var _loc4_:Array = null;
         if(!_inputComBox || !_inputComBox.textField)
         {
            return;
         }
         var _loc2_:String = _inputComBox.textValue;
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.view.RosePresentView.inputTip"));
            return;
         }
         if(_friendList[_loc2_])
         {
            _loc3_ = _friendList[_loc2_] as ThaneInfo;
            if(_loc3_)
            {
               if(_loc3_.isOnline == false)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("simplegame.handlsel.HandlselFrame.offLine"));
                  return;
               }
               if(_data)
               {
                  SocketSendManager.instance.sendUseItem(_data.pos,1,1,"",_loc3_.userId);
                  dispose();
               }
               else
               {
                  _loc4_ = GoodsManager.instance.getBagGoodsByTemplateId(2220001);
                  if(_loc4_.length == 0)
                  {
                     CheckUIModuleUtil.instance.tryCall("quickbuy",showBuyFrameCall,[2220001]);
                  }
                  else
                  {
                     _loc4_.sortOn("isBinds",2);
                     SocketSendManager.instance.sendUseItem(_loc4_[0].pos,1,1,"",_loc3_.userId);
                     dispose();
                  }
               }
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("simplegame.handlsel.HandlselFrame.noThisFriend"));
         }
      }
      
      private function showBuyFrameCall(param1:Array) : void
      {
         var _loc2_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         _loc2_.data(TempleteManager.instance.getShopTempInfoByItemId(param1[0]));
         _loc2_.show();
      }
      
      private function __onCancleClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         super.dispose();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_inputBg)
         {
            ObjectUtils.disposeObject(_inputBg);
         }
         _inputBg = null;
         if(_confirmBtn)
         {
            ObjectUtils.disposeObject(_confirmBtn);
         }
         _confirmBtn = null;
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
         }
         _cancelBtn = null;
         if(_inputComBox && _inputComBox.textField)
         {
            _inputComBox.dispose();
         }
         _inputComBox = null;
         _data = null;
         _friendList = null;
      }
   }
}

