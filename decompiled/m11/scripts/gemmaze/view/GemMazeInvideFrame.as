package gemmaze.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GemMazeManager;
   import yishi.utils.StringHelper;
   import yishi.view.component.WriteMailComboxBox;
   import yishi.view.tips.MessageTipManager;
   
   public class GemMazeInvideFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _tipsTxtImg:Bitmap;
      
      private var _inputBg:Bitmap;
      
      private var _bottomTxt:FilterFrameText;
      
      private var _okBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _inputComBox:WriteMailComboxBox;
      
      private var _tempStr:String = "";
      
      private var _friendList:Array;
      
      private var _arrFriendList:Array;
      
      private var _selectIndex:int;
      
      private var _currentSelected:ThaneInfo;
      
      public function GemMazeInvideFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.InvideBg");
         _tipsTxtImg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.TipsTxtImg");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.FriendInputBg");
         _bottomTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.InvideBottomTxt");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("gemMaze.InvideViewConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("gemMaze.InvideViewCancleBtn");
         _inputComBox = ComponentFactory.Instance.creatComponentByStylename("gemmaze.InvideViewInputComBox");
         _friendList = [];
         _arrFriendList = [];
         _inputComBox.textValue = "";
         _inputComBox.searchRange = 1;
         (_inputComBox.button as TextButton).text = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.Friendlist");
         initComboBox(getFriendNameList());
         StageReferance.stage.focus = _inputComBox.textField;
         addToContent(_bg);
         addToContent(_tipsTxtImg);
         addToContent(_inputBg);
         addToContent(_bottomTxt);
         addToContent(_okBtn);
         addToContent(_cancelBtn);
         addToContent(_inputComBox);
         _bottomTxt.text = LanguageMgr.GetTranslation("gemMaze.GemMazeInvideFrame.TipsTxt");
      }
      
      private function initComboBox(param1:Array) : void
      {
         var _loc4_:int = 0;
         _inputComBox.beginChanges();
         _inputComBox.selctedPropName = "text";
         var _loc3_:VectorListModel = _inputComBox.listPanel.vectorListModel;
         var _loc2_:int = int(param1.length);
         _loc3_.clear();
         while(_loc4_ < _loc2_)
         {
            _loc3_.append(param1[_loc4_]);
            _loc4_++;
         }
         _inputComBox.listPanel.list.updateListView();
         _inputComBox.listPanel.list.addEventListener("listItemClick",__itemClick);
         _inputComBox.commitChanges();
      }
      
      private function getFriendNameList() : Array
      {
         _friendList.splice(0,_friendList.length);
         _arrFriendList.splice(0,_arrFriendList.length);
         var _loc1_:Dictionary = FriendManager.getInstance().friendList;
         for each(var _loc2_:ThaneInfo in _loc1_)
         {
            if(_loc2_.relation == 1 && Boolean(_loc2_.isOnline))
            {
               _friendList.push(_loc2_);
            }
            if(_loc2_.relation == 1)
            {
               _arrFriendList.push(_loc2_);
            }
         }
         _friendList.sortOn(["isShine","state","friendGrade","friendGp","grades","nickName"],[2,0x10 | 2,0x10 | 2,0x10 | 2,0x10 | 2,1]);
         return _friendList;
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         _selectIndex = param1.index;
         _currentSelected = param1.cellValue;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,365,175);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function onOkBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = StringHelper.trimAll(_inputComBox.textValue).toLowerCase();
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.view.RosePresentView.inputTip"));
            return;
         }
         if(_loc2_ == thane.nickName.toLowerCase())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaRecruitFrame.command02"));
            dispose();
            return;
         }
         var _loc3_:ThaneInfo = getFriendInfoByName(_loc2_);
         if(_loc3_)
         {
            if(!_loc3_.isOnline)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("gemMaze.GemMazeInvide.FriendOffLine"));
            }
            else
            {
               GemMazeManager.Instance.invideFriendHelp(_loc3_.userId);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.view.RosePresentView.notFriends"));
         }
         dispose();
      }
      
      private function getFriendInfoByName(param1:String) : ThaneInfo
      {
         for each(var _loc2_:ThaneInfo in _arrFriendList)
         {
            if(_loc2_.nickName.toLowerCase() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __inputNickNameHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_inputComBox.textValue) > 12)
         {
            _inputComBox.textValue = _tempStr;
         }
         _tempStr = _inputComBox.textValue;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _cancelBtn.addEventListener("click",__onCancleClick);
         _okBtn.addEventListener("click",onOkBtnClick);
         _inputComBox.textField.removeEventListener("change",__inputNickNameHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _cancelBtn.removeEventListener("click",__onCancleClick);
         _okBtn.removeEventListener("click",onOkBtnClick);
         _inputComBox.textField.removeEventListener("change",__inputNickNameHandler);
      }
      
      private function __onCancleClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _currentSelected = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

