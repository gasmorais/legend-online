package friends.view
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import events.FriendGroupEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import mainBar.StripView;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import managers.FriendSocketOutManager;
   import managers.IMManager;
   import managers.MarryManager;
   import mvc.module.friends.FriendGroupInfo;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.marry.MarryTipData;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.HeadIconCell;
   import yishi.view.tips.MessageTipManager;
   
   public class FriendItemCell extends Sprite implements IListCell, Disposeable
   {
      
      private var _titleBack:ScaleFrameImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _itemBack:ScaleFrameImage;
      
      private var _itemBigBack:ScaleBitmapImage;
      
      private var _icon:HeadIconCell;
      
      private var _stateImg:ScaleFrameImage;
      
      private var _privateChatBtn:BaseButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _mateStripView1:StripView;
      
      private var _mateBG1:Image;
      
      private var _mateTxt1:FilterFrameText;
      
      private var _mateStripView2:StripView;
      
      private var _mateRing:BaseIconView;
      
      private var _mateRingTxt:FilterFrameText;
      
      private var _mateBuff:BaseIconView;
      
      private var _groupShiningMC:MovieClip;
      
      private var _friendShiningMC:MovieClip;
      
      private var _shiningMC:MovieClip;
      
      private var _delGroupBtn:BaseButton;
      
      private var _renameGroupBtn:BaseButton;
      
      private var _inputGroupNameBg:ScaleBitmapImage;
      
      private var _inputGroupNameTxt:FilterFrameText;
      
      private var _alert:BaseAlerFrame;
      
      private var _tempStr:String = "";
      
      private var _vipText:GradientText;
      
      private var _timer:Timer;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _info:FriendItemCellInfo;
      
      private var _headId:int;
      
      public function FriendItemCell()
      {
         super();
         buttonMode = true;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("friends.TitleBack");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("friends.TitleTxt");
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsItemGroupCellBg");
         _itemBigBack = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsItemCellBg");
         _icon = ComponentFactory.Instance.creatCustomObject("friends.FriendItemCellHeadCell");
         _stateImg = ComponentFactory.Instance.creatComponentByStylename("friends.FriendItemCellStateImg");
         _privateChatBtn = ComponentFactory.Instance.creatComponentByStylename("friends.FriendItemCellChatBtn");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("FriendItemCellNameText");
         _level = ComponentFactory.Instance.creatComponentByStylename("FriendItemCellLevelText");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("FriendItemCellLevelText2");
         _groupShiningMC = ComponentFactory.Instance.creatCustomObject("friends.IMGroupShiningMC");
         _friendShiningMC = ComponentFactory.Instance.creatCustomObject("friends.IMFriendShiningMC");
         _mateStripView1 = ComponentFactory.Instance.creatCustomObject("Friends.FriendItemCellmateStripView1");
         _mateStripView2 = ComponentFactory.Instance.creatCustomObject("Friends.FriendItemCellmateStripView2");
         _mateBG1 = ComponentFactory.Instance.creatComponentByStylename("friends.CellMateBG");
         _mateTxt1 = ComponentFactory.Instance.creatComponentByStylename("friends.CellMateTxt");
         _mateRing = ComponentFactory.Instance.creatCustomObject("friends.CellMateRing");
         _mateRingTxt = ComponentFactory.Instance.creatComponentByStylename("friends.CellMateRingTxt");
         _mateBuff = ComponentFactory.Instance.creatCustomObject("friends.CellMateRing");
         _delGroupBtn = ComponentFactory.Instance.creatComponentByStylename("friends.DelGroupBtn");
         _renameGroupBtn = ComponentFactory.Instance.creatComponentByStylename("friends.RenameGroupBtn");
         _delGroupBtn.tipData = LanguageMgr.GetTranslation("emailII.EmailFrame.delete");
         _renameGroupBtn.tipData = LanguageMgr.GetTranslation("friends.view.FriendItemCell.renameGroup");
         _delGroupBtn.visible = _renameGroupBtn.visible = false;
         _inputGroupNameBg = ComponentFactory.Instance.creatComponentByStylename("friends.InputGroupNameBg");
         _inputGroupNameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.InputGroupNameTxt");
         _vipText = ComponentFactory.Instance.creatComponentByStylename("FriendCellNameGradientText");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("friends.FriendCell.VocationIcon");
         _timer = new Timer(300,1);
         _groupShiningMC.gotoAndStop(1);
         _friendShiningMC.gotoAndStop(1);
         _mateStripView1.addChild(_mateBG1);
         _mateStripView1.addChild(_mateTxt1);
         _mateStripView2.addChild(_mateRing);
         _mateStripView2.addChild(_mateRingTxt);
         _titleBack.setFrame(1);
         _titleTxt.setFrame(1);
         _itemBack.setFrame(1);
         _stateImg.setFrame(7);
         var _loc1_:String = LanguageMgr.GetTranslation("public.privateChat");
         _privateChatBtn.tipData = _loc1_;
         _privateChatBtn.visible = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
         addEventListener("interactive_double_click",__onDoubleClick);
         addEventListener("click",__onClick);
         _privateChatBtn.addEventListener("click",__chatHandler);
         _privateChatBtn.addEventListener("mouseDown",__chatDownHandler);
         _delGroupBtn.addEventListener("mouseDown",__chatDownHandler);
         _renameGroupBtn.addEventListener("mouseDown",__chatDownHandler);
         _delGroupBtn.addEventListener("click",__onDelGroupClick);
         _renameGroupBtn.addEventListener("click",__onRenameGroupClick);
         _inputGroupNameTxt.addEventListener("focusOut",__inputGroupNameHandler);
         _inputGroupNameTxt.addEventListener("change",__groupTxtInputHandler);
         _timer.addEventListener("timerComplete",__timerCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
         removeEventListener("interactive_double_click",__onDoubleClick);
         removeEventListener("click",__onClick);
         _privateChatBtn.removeEventListener("click",__chatHandler);
         _privateChatBtn.removeEventListener("mouseDown",__chatDownHandler);
         _delGroupBtn.removeEventListener("mouseDown",__chatDownHandler);
         _delGroupBtn.removeEventListener("click",__onDelGroupClick);
         _renameGroupBtn.removeEventListener("mouseDown",__chatDownHandler);
         _renameGroupBtn.removeEventListener("click",__onRenameGroupClick);
         _inputGroupNameTxt.removeEventListener("focusOut",__inputGroupNameHandler);
         _inputGroupNameTxt.removeEventListener("change",__groupTxtInputHandler);
         _timer.removeEventListener("timerComplete",__timerCompleteHandler);
      }
      
      private function addFriendListener() : void
      {
         if(_info)
         {
            _info.addEventListener("PLAYER_STATE_CHANGE",__friendBaseInfoChangeHandler);
         }
      }
      
      private function removeFriendListener() : void
      {
         if(_info)
         {
            _info.removeEventListener("PLAYER_STATE_CHANGE",__friendBaseInfoChangeHandler);
         }
      }
      
      private function __friendBaseInfoChangeHandler(param1:PlayerEvent) : void
      {
         refreshBaseView();
      }
      
      private function __onDelGroupClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SimpleAlertHelper.instance.data = [delGroupResponseHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("friends.view.FriendItemCell.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
      }
      
      private function delGroupResponseHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1 && _info)
         {
            FriendSocketOutManager.sendDelGroup(_info.groupId);
         }
      }
      
      private function __onRenameGroupClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:Point = localToGlobal(new Point(20,-3));
         var _loc3_:Point = localToGlobal(new Point(26,1));
         _inputGroupNameBg.x = _loc2_.x;
         _inputGroupNameBg.y = _loc2_.y;
         _inputGroupNameTxt.x = _loc3_.x;
         _inputGroupNameTxt.y = _loc3_.y;
         LayerManager.Instance.addToLayer(_inputGroupNameBg,3,false,false);
         LayerManager.Instance.addToLayer(_inputGroupNameTxt,3,false,false);
         _inputGroupNameTxt.addEventListener("keyDown",__groupTxtKeyDownHandler);
         _inputGroupNameTxt.setFocus();
      }
      
      private function __groupTxtKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            param1.stopPropagation();
            StageReferance.stage.focus = null;
            __inputGroupNameHandler(null);
         }
      }
      
      private function __groupTxtInputHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_inputGroupNameTxt.text) > 12)
         {
            _inputGroupNameTxt.text = _tempStr;
         }
         _tempStr = _inputGroupNameTxt.text;
      }
      
      private function __inputGroupNameHandler(param1:FocusEvent) : void
      {
         _inputGroupNameTxt.removeEventListener("keyDown",__groupTxtKeyDownHandler);
         if(_inputGroupNameTxt && _inputGroupNameTxt.parent)
         {
            if(!StringHelper.isNullOrEmpty(StringHelper.trimAll(_inputGroupNameTxt.text)) && _info)
            {
               if(FilterWordManager.containSpecificChar(_inputGroupNameTxt.text,",|%"))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.view.FriendItemCell.InputAgain"));
               }
               else
               {
                  FriendSocketOutManager.sendRenameGroup(_info.groupId,_inputGroupNameTxt.text);
               }
            }
            _inputGroupNameTxt.text = "";
            _inputGroupNameTxt.parent.removeChild(_inputGroupNameTxt);
         }
         if(_inputGroupNameBg && _inputGroupNameBg.parent)
         {
            _inputGroupNameBg.parent.removeChild(_inputGroupNameBg);
         }
      }
      
      private function __chatDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __chatHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         shining = false;
         IMManager.instance.createIMFrame(_info);
         StageReferance.stage.dispatchEvent(new MouseEvent("mouseDown"));
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_info && checkIsCustomGroup(_info.groupId))
         {
            _delGroupBtn.visible = _renameGroupBtn.visible = true;
         }
         if(!_info || Boolean(_info.selected))
         {
            return;
         }
         if(_info.type == 1)
         {
            _itemBack.setFrame(2);
         }
         else if(_info.type == 0)
         {
            _privateChatBtn.visible = true;
            _itemBigBack.visible = true;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_delGroupBtn && _renameGroupBtn)
         {
            _delGroupBtn.visible = _renameGroupBtn.visible = false;
         }
         if(!_info || Boolean(_info.selected))
         {
            return;
         }
         if(_info.type == 1)
         {
            _itemBack.setFrame(1);
         }
         else if(_info.type == 0)
         {
            _privateChatBtn.visible = false;
            _itemBigBack.visible = false;
         }
      }
      
      private function __onDoubleClick(param1:InteractiveEvent) : void
      {
         if(!_info)
         {
            return;
         }
         if(_info.type != 0)
         {
            return;
         }
         shining = false;
         IMManager.instance.createIMFrame(_info);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         FriendManager.getInstance().dispatchEvent(new FriendGroupEvent("FRIEND_ITEM_SELECTED",_info,this));
      }
      
      private function __timerCompleteHandler(param1:TimerEvent) : void
      {
         _icon.headId = _headId;
      }
      
      private function refreshBaseView() : void
      {
         if(_info)
         {
            _stateImg.setFrame(_info.state);
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(param1:*) : void
      {
         var _loc2_:Boolean = false;
         if(_info)
         {
            removeFriendListener();
            filters = null;
            _info = null;
            shining = false;
            if(_titleBack.parent)
            {
               _titleBack.parent.removeChild(_titleBack);
            }
            if(_titleTxt.parent)
            {
               _titleTxt.parent.removeChild(_titleTxt);
            }
            if(_itemBack.parent)
            {
               _itemBack.parent.removeChild(_itemBack);
            }
            if(_itemBigBack.parent)
            {
               _itemBigBack.parent.removeChild(_itemBigBack);
            }
            if(_icon.parent)
            {
               _icon.parent.removeChild(_icon);
            }
            if(_stateImg.parent)
            {
               _stateImg.parent.removeChild(_stateImg);
            }
            if(_privateChatBtn.parent)
            {
               _privateChatBtn.parent.removeChild(_privateChatBtn);
            }
            if(_nameTxt.parent)
            {
               _nameTxt.parent.removeChild(_nameTxt);
            }
            if(_level.parent)
            {
               _level.parent.removeChild(_level);
            }
            if(_levelTxt.parent)
            {
               _levelTxt.parent.removeChild(_levelTxt);
            }
            if(_mateStripView1.parent)
            {
               _mateStripView1.parent.removeChild(_mateStripView1);
            }
            if(_mateStripView2.parent)
            {
               _mateStripView2.parent.removeChild(_mateStripView2);
            }
            if(_shiningMC.parent)
            {
               _shiningMC.parent.removeChild(_shiningMC);
            }
            if(_delGroupBtn.parent)
            {
               _delGroupBtn.parent.removeChild(_delGroupBtn);
            }
            if(_renameGroupBtn.parent)
            {
               _renameGroupBtn.parent.removeChild(_renameGroupBtn);
            }
            if(_inputGroupNameTxt.parent)
            {
               _inputGroupNameTxt.parent.removeChild(_inputGroupNameTxt);
            }
            if(_vipText.parent)
            {
               _vipText.parent.removeChild(_vipText);
            }
            if(_vocationIcon.parent)
            {
               _vocationIcon.parent.removeChild(_vocationIcon);
            }
         }
         _info = param1 as FriendItemCellInfo;
         addFriendListener();
         if(!_info)
         {
            return;
         }
         if(_info.type != 0)
         {
            _shiningMC = _groupShiningMC;
            _shiningMC["content"].addChild(_titleBack);
            _shiningMC["content"].addChild(_titleTxt);
            _itemBack.setFrame(1);
            _titleTxt.htmlText = _info.title;
            addChildAt(_shiningMC,0);
            addChildAt(_itemBack,0);
            if(checkIsCustomGroup(_info.groupId))
            {
               addChild(_renameGroupBtn);
               addChild(_delGroupBtn);
            }
            checkGroupIsShine();
         }
         else
         {
            _shiningMC = _friendShiningMC;
            _shiningMC["content"].addChild(_icon);
            _shiningMC["content"].addChild(_stateImg);
            _nameTxt.text = _info.nickName;
            if(_info.isCross)
            {
               _nameTxt.text = _info.nickName + "(" + _info.serviceName + ")";
            }
            _level.text = LanguageMgr.GetTranslation("friends.view.FriendItemCell.levelTxt1");
            _levelTxt.text = String(_info.grades);
            if(_info.isCross)
            {
               if(_headId != _info.pics)
               {
                  _headId = _info.pics;
                  _timer.reset();
                  _timer.start();
               }
            }
            else if(_headId != _info.snsInfo.headId)
            {
               _headId = _info.snsInfo.headId;
               _timer.reset();
               _timer.start();
            }
            _stateImg.setFrame(_info.state);
            if(!_info.isOnline)
            {
               filters = [UIFilter.getGrayFilter()];
            }
            addChild(_itemBigBack);
            addChild(_privateChatBtn);
            addChild(_nameTxt);
            addChild(_vipText);
            addChild(_vocationIcon);
            addChild(_level);
            addChild(_levelTxt);
            addChild(_shiningMC);
            _loc2_ = _info.groupId == -2;
            setPositionByType(_loc2_);
            checkFriendIsShine();
         }
         update();
      }
      
      private function setPositionByType(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MarryTipData = null;
         if(param1)
         {
            _itemBigBack.height = 85;
            _shiningMC.y = 15;
            addChild(_mateStripView1);
            addChild(_mateStripView2);
            _mateStripView1.tipData = LanguageMgr.GetTranslation("friends.view.FriendItemCell.happies",MarryManager.instance.model.marriageData.happyInfo.happyGrade);
            _mateTxt1.text = "x" + MarryManager.instance.model.marriageData.happyInfo.happyGrade;
            _loc2_ = int(MarryManager.instance.model.marriageData.ringInfo.ringGrade);
            if(_loc2_ > 9)
            {
               _loc2_ = 9;
            }
            _mateRing.icon = IconFactory.getMarryRingIcon(_loc2_);
            _mateRingTxt.text = "" + MarryManager.instance.model.marriageData.ringInfo.ringGrade;
            _mateBuff.icon = IconFactory.getMarryBuffIconByHappies(MarryManager.instance.model.marriageData.happyInfo.happyGp);
            _loc3_ = new MarryTipData();
            _loc3_.type = 2;
            _loc3_.grades = MarryManager.instance.model.marriageData.ringInfo.ringGrade;
            _loc3_.nickNameB = ArmyManager.instance.thane.nickName;
            _mateStripView2.tipData = _loc3_;
            _loc3_ = new MarryTipData();
            _loc3_.type = 1;
         }
         else
         {
            _itemBigBack.height = 45;
            _privateChatBtn.y = 19;
            _nameTxt.y = 0;
            _vipText.y = 0;
            _vocationIcon.y = 18;
            _level.y = 22;
            _levelTxt.y = 22;
            _shiningMC.y = 2;
         }
      }
      
      private function update() : void
      {
         if(_info.IsVipAndNoExpirt)
         {
            _vipText.visible = true;
            _nameTxt.visible = false;
            _vipText.text = _nameTxt.text;
         }
         else
         {
            _vipText.visible = false;
            _nameTxt.visible = true;
         }
         if(_info.type == -1)
         {
            _titleBack.setFrame(3);
            _titleTxt.setFrame(4);
            return;
         }
         if(_info.selected)
         {
            _titleBack.setFrame(2);
            _titleTxt.setFrame(2);
            if(_info.type == 0)
            {
               _itemBigBack.visible = true;
            }
         }
         else
         {
            _titleBack.setFrame(1);
            _titleTxt.setFrame(1);
            if(_info.type == 0)
            {
               _itemBigBack.visible = false;
            }
         }
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         var _loc1_:int = 0;
         if(_info && _info.vocationGrades > 0)
         {
            _loc1_ = int(_info.isCross || !_info.templateInfo ? _info.job : int(_info.templateInfo.Job));
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_loc1_,_info.vocationStep,_info.vocationLevel);
            _vocationIcon.setFrame(_info.vocationLevel);
            _vocationIcon.visible = true;
            _levelTxt.x = 114;
         }
         else
         {
            _vocationIcon.visible = false;
            _levelTxt.x = 87;
         }
      }
      
      private function checkIsCustomGroup(param1:int) : Boolean
      {
         for each(var _loc2_:FriendGroupInfo in FriendManager.getInstance().groupDic)
         {
            if(param1 != 2 && param1 == _loc2_.groupId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkGroupIsShine() : void
      {
         var _loc1_:FriendItemCellInfo = null;
         var _loc2_:Array = imManager.model.unreadMsgDic.keys;
         for each(var _loc3_:int in _loc2_)
         {
            _loc1_ = imManager.getFriendInfo(_loc3_);
            if(_loc1_ && _info && _info.type == 1 && !_info.selected && _info.groupId == _loc1_.groupId)
            {
               shining = true;
            }
         }
      }
      
      private function checkFriendIsShine() : void
      {
         if(_info && _info.type == 0 && _info.isShine)
         {
            shining = true;
         }
      }
      
      public function set shining(param1:Boolean) : void
      {
         if(param1)
         {
            _shiningMC.gotoAndPlay(1);
         }
         else
         {
            _shiningMC.gotoAndStop(1);
         }
      }
      
      public function setTitleVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(_titleTxt)
            {
               addChild(_titleTxt);
            }
         }
         else if(_titleTxt && _titleTxt.parent)
         {
            _titleTxt.parent.removeChild(_titleTxt);
         }
         trace("setTitleVisible" + param1);
      }
      
      private function get imManager() : IMManager
      {
         return IMManager.instance;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_titleBack)
         {
            _titleBack.dispose();
         }
         _titleBack = null;
         if(_titleTxt)
         {
            _titleTxt.dispose();
         }
         _titleTxt = null;
         if(_itemBack)
         {
            _itemBack.dispose();
         }
         _itemBack = null;
         if(_itemBigBack)
         {
            _itemBigBack.dispose();
         }
         _itemBigBack = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_stateImg)
         {
            _stateImg.dispose();
         }
         _stateImg = null;
         if(_privateChatBtn)
         {
            _privateChatBtn.dispose();
         }
         _privateChatBtn = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_level)
         {
            _level.dispose();
         }
         _level = null;
         if(_levelTxt)
         {
            _levelTxt.dispose();
         }
         _levelTxt = null;
         if(_vocationIcon)
         {
            _vocationIcon.dispose();
         }
         _vocationIcon = null;
         if(_alert)
         {
            _alert.dispose();
         }
         _alert = null;
         if(_shiningMC)
         {
            _shiningMC.stop();
         }
         _shiningMC = null;
         if(_groupShiningMC)
         {
            _groupShiningMC.stop();
         }
         _groupShiningMC = null;
         if(_friendShiningMC)
         {
            _friendShiningMC.stop();
         }
         _friendShiningMC = null;
         if(_delGroupBtn)
         {
            _delGroupBtn.dispose();
         }
         _delGroupBtn = null;
         if(_renameGroupBtn)
         {
            _renameGroupBtn.dispose();
         }
         _renameGroupBtn = null;
         if(_inputGroupNameTxt)
         {
            _inputGroupNameTxt.dispose();
         }
         _inputGroupNameTxt = null;
         if(_inputGroupNameBg)
         {
            _inputGroupNameBg.dispose();
         }
         _inputGroupNameBg = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         if(_timer)
         {
            _timer.stop();
         }
         _timer = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

