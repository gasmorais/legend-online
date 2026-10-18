package friends.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.FriendGroupEvent;
   import events.FriendUpdateEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import im.IMFrame;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.FriendSocketOutManager;
   import managers.IMManager;
   import managers.MarryManager;
   import mvc.module.friends.BaseIMInfo;
   import mvc.module.friends.FriendGroupInfo;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.friends.FriendModel;
   import mvc.module.friends.IMEvent;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.FriendManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.view.community.PlayerMenu;
   import yishi.view.tips.MessageTipManager;
   
   public class FridendsListView extends Sprite implements Disposeable
   {
      
      private var _listPanel:ListPanel;
      
      private var _group:SimpleDictionary;
      
      private var _friendsInfo:FriendItemCellInfo;
      
      private var _strangerInfo:FriendItemCellInfo;
      
      private var _blackInfo:FriendItemCellInfo;
      
      private var _recentInfo:FriendItemCellInfo;
      
      private var _addGroupInfo:FriendItemCellInfo;
      
      private var _crossFriendsInfo:FriendItemCellInfo;
      
      private var _crossBlankInfo:FriendItemCellInfo;
      
      private var _crossStrangerInfo:FriendItemCellInfo;
      
      private var _mateInfo:FriendItemCellInfo;
      
      private var _inputGroupNameTxt:FilterFrameText;
      
      private var _inputGroupNameBg:ScaleBitmapImage;
      
      private var _scrollValue:int;
      
      private var _tempStr:String = "";
      
      private var _menu:PlayerMenu;
      
      private var _curSelectedGroup:FriendItemCellInfo;
      
      public function FridendsListView()
      {
         super();
         init();
         initData();
         initEvent();
         updateList();
      }
      
      private function init() : void
      {
         _group = new SimpleDictionary();
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("friends.FriendListPanel");
         _inputGroupNameBg = ComponentFactory.Instance.creatComponentByStylename("friends.InputGroupNameBg");
         _inputGroupNameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.InputGroupNameTxt");
         addChild(_listPanel);
      }
      
      private function initData() : void
      {
         var _loc17_:FriendItemCellInfo = null;
         var _loc9_:Array = null;
         var _loc6_:Array = null;
         var _loc18_:int = 0;
         var _loc1_:Array = FriendManager.getInstance().onlineBlacks;
         var _loc2_:Array = FriendManager.getInstance().offlineBlacks;
         _mateInfo = friendManager.getFriendById(MarryManager.instance.model.selfMarryInfo.userId) as FriendItemCellInfo;
         if(MarryManager.instance.model.isMarry && _mateInfo)
         {
            _mateInfo.type = 0;
            _mateInfo.groupId = -2;
            _listPanel.vectorListModel.append(_mateInfo);
            _group.add(_mateInfo.groupId,_mateInfo);
         }
         _recentInfo = new FriendItemCellInfo();
         _recentInfo.type = 1;
         _recentInfo.groupId = 1;
         var _loc14_:int = int(FriendManager.getInstance().privatePerson.length);
         _recentInfo.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.recent",_loc14_);
         _listPanel.vectorListModel.append(_recentInfo);
         _group.add(_recentInfo.groupId,_recentInfo);
         var _loc7_:Array = friendManager.groupDic.getList();
         _loc7_.sortOn("groupId",16);
         for each(var _loc22_:FriendGroupInfo in _loc7_)
         {
            if(_loc22_.groupId != -2)
            {
               _loc17_ = new FriendItemCellInfo();
               _loc9_ = friendManager.getListByGroupIdAndState(_loc22_.groupId,-1);
               _loc6_ = friendManager.getOfflineList(_loc9_);
               _loc18_ = _loc9_.length - _loc6_.length;
               _loc17_.type = 1;
               _loc17_.groupId = _loc22_.groupId;
               _loc17_.title = _loc22_.groupName + "[" + toArialBold(_loc18_ + " / " + _loc9_.length) + "]";
               _listPanel.vectorListModel.append(_loc17_);
               _group.add(_loc17_.groupId,_loc17_);
               if(_loc17_.groupId == 2)
               {
                  _friendsInfo = _loc17_;
               }
            }
         }
         _strangerInfo = new FriendItemCellInfo();
         _strangerInfo.type = 1;
         _strangerInfo.groupId = -1;
         var _loc3_:Array = friendManager.getListByGroupIdAndState(-1,-1);
         var _loc12_:Array = friendManager.getOnlineList(_loc3_);
         var _loc8_:String = toArialBold(_loc12_.length + " / " + _loc3_.length);
         _strangerInfo.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.stranger",_loc8_);
         _listPanel.vectorListModel.append(_strangerInfo);
         _group.add(_strangerInfo.groupId,_strangerInfo);
         _blackInfo = new FriendItemCellInfo();
         _blackInfo.type = 1;
         _blackInfo.groupId = 3;
         var _loc20_:String = toArialBold(_loc1_.length + " / " + (_loc1_.length + _loc2_.length));
         _blackInfo.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.black",_loc20_);
         _listPanel.vectorListModel.append(_blackInfo);
         _group.add(_blackInfo.groupId,_blackInfo);
         _crossFriendsInfo = new FriendItemCellInfo();
         _crossFriendsInfo.type = 1;
         _crossFriendsInfo.groupId = 1001;
         var _loc5_:int = int(FriendManager.getInstance().getCrossFriendsRelationByType(1,true).length);
         var _loc21_:int = int(FriendManager.getInstance().crossFriendList.getList().length);
         var _loc10_:String = toArialBold(_loc5_ + " / " + _loc21_);
         _crossFriendsInfo.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.crossFriendsTitle",_loc10_);
         _listPanel.vectorListModel.append(_crossFriendsInfo);
         _group.add(_crossFriendsInfo.groupId,_crossFriendsInfo);
         _crossStrangerInfo = new FriendItemCellInfo();
         _crossStrangerInfo.type = 1;
         _crossStrangerInfo.groupId = 1002;
         var _loc13_:int = int(FriendManager.getInstance().getCrossFriendsRelationByType(2,true).length);
         var _loc11_:int = int(FriendManager.getInstance().crossStrangerList.getList().length);
         var _loc4_:String = toArialBold(_loc13_ + " / " + _loc11_);
         _crossStrangerInfo.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.crossStrangerTitle",_loc4_);
         _listPanel.vectorListModel.append(_crossStrangerInfo);
         _group.add(_crossStrangerInfo.groupId,_crossStrangerInfo);
         _crossBlankInfo = new FriendItemCellInfo();
         _crossBlankInfo.type = 1;
         _crossBlankInfo.groupId = 1003;
         var _loc15_:int = int(FriendManager.getInstance().getCrossFriendsRelationByType(3,true).length);
         var _loc16_:int = int(FriendManager.getInstance().crossBlackList.getList().length);
         var _loc19_:String = toArialBold(_loc15_ + " / " + _loc16_);
         _crossBlankInfo.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.crossBlankTitle",_loc19_);
         _listPanel.vectorListModel.append(_crossBlankInfo);
         _group.add(_crossBlankInfo.groupId,_crossBlankInfo);
         _addGroupInfo = new FriendItemCellInfo();
         _addGroupInfo.type = -1;
         _addGroupInfo.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.addGroup");
         _curSelectedGroup = friendManager.model.curSelectedGroup;
         if(_curSelectedGroup && _group[_curSelectedGroup.groupId])
         {
            (_group[_curSelectedGroup.groupId] as FriendItemCellInfo).selected = true;
         }
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      private function uninit() : void
      {
         if(_listPanel)
         {
            _listPanel.dispose();
         }
         _listPanel = null;
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
         if(_group)
         {
            _group.clear();
         }
         _group = null;
         _recentInfo = null;
         _friendsInfo = null;
         _strangerInfo = null;
         _blackInfo = null;
         _crossFriendsInfo = null;
         _crossBlankInfo = null;
         _crossStrangerInfo = null;
         _addGroupInfo = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initEvent() : void
      {
         friendManager.addEventListener("FRIEND_ITEM_SELECTED",__itemClickHandler);
         FriendManager.getInstance().addEventListener("FRIEND_UPDATE",__updateList);
         FriendManager.getInstance().addEventListener("friendchange",__updateList);
         FriendManager.getInstance().addEventListener("ADD_RECENT_CONTACT",__updateList);
         imManager.addEventListener("RECEIVE_MSG",__receiveIMMsgHandler);
         imManager.addEventListener("MSG_LIST_DEL",__updateList);
         _inputGroupNameTxt.addEventListener("focusOut",__inputGroupNameHandler);
         _inputGroupNameTxt.addEventListener("change",__groupTxtInputHandler);
         friendManager.addEventListener("ADD_GROUP",__addGroupHandler);
         friendManager.addEventListener("DEL_GROUP",__delGroupHandler);
         friendManager.addEventListener("RENAME_GROUP",__renameGroupHandler);
         friendManager.addEventListener("MOVE_FRIEND",__updateList);
         friendManager.addEventListener("RECENT_CONTACT_UPDATE",__recentContactUpdateHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_MINUTE",__systimeUpdateHandler);
         MsgMan.addObserver("CROSS_FRIENDS_UPDATE",this,__updateCrossList);
      }
      
      private function removeEvent() : void
      {
         friendManager.removeEventListener("FRIEND_ITEM_SELECTED",__itemClickHandler);
         FriendManager.getInstance().removeEventListener("FRIEND_UPDATE",__updateList);
         FriendManager.getInstance().removeEventListener("friendchange",__updateList);
         FriendManager.getInstance().removeEventListener("ADD_RECENT_CONTACT",__updateList);
         imManager.removeEventListener("RECEIVE_MSG",__receiveIMMsgHandler);
         imManager.removeEventListener("MSG_LIST_DEL",__updateList);
         _inputGroupNameTxt.removeEventListener("focusOut",__inputGroupNameHandler);
         _inputGroupNameTxt.removeEventListener("change",__groupTxtInputHandler);
         friendManager.removeEventListener("ADD_GROUP",__addGroupHandler);
         friendManager.removeEventListener("DEL_GROUP",__delGroupHandler);
         friendManager.removeEventListener("RENAME_GROUP",__renameGroupHandler);
         friendManager.removeEventListener("MOVE_FRIEND",__updateList);
         friendManager.removeEventListener("RECENT_CONTACT_UPDATE",__recentContactUpdateHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_MINUTE",__systimeUpdateHandler);
         MsgMan.removeObserver("CROSS_FRIENDS_UPDATE",this,__updateCrossList);
      }
      
      private function __updateCrossList(param1:String, param2:Object) : void
      {
         updateList();
      }
      
      private function __systimeUpdateHandler(param1:PlayerEvent) : void
      {
         if(playerModel.sysCurTimeBySecond - friendManager.model.lastReqRecentsTime > 1800)
         {
            if(friendManager.privatePerson.length > 0)
            {
               FriendSocketOutManager.sendReqChatState(friendManager.privatePerson);
               friendManager.model.lastReqRecentsTime = playerModel.sysCurTimeBySecond;
            }
         }
      }
      
      private function __addGroupHandler(param1:FriendGroupEvent) : void
      {
         var _loc2_:FriendItemCellInfo = null;
         var _loc3_:FriendGroupInfo = param1.data as FriendGroupInfo;
         if(_loc3_)
         {
            _loc2_ = new FriendItemCellInfo();
            _loc2_.type = 1;
            _loc2_.groupId = _loc3_.groupId;
            _group.add(_loc2_.groupId,_loc2_);
            updateList();
         }
      }
      
      private function __delGroupHandler(param1:FriendGroupEvent) : void
      {
         var _loc2_:FriendGroupInfo = param1.data as FriendGroupInfo;
         if(_loc2_)
         {
            _group.del(_loc2_.groupId);
            updateList();
         }
      }
      
      private function __renameGroupHandler(param1:FriendGroupEvent) : void
      {
         var _loc2_:FriendGroupInfo = param1.data as FriendGroupInfo;
         if(_loc2_)
         {
            updateList();
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
      
      private function __groupTxtKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            param1.stopPropagation();
            StageReferance.stage.focus = null;
            __inputGroupNameHandler(null);
         }
      }
      
      private function __inputGroupNameHandler(param1:FocusEvent) : void
      {
         _inputGroupNameTxt.removeEventListener("keyDown",__groupTxtKeyDownHandler);
         if(_inputGroupNameTxt && _inputGroupNameTxt.parent)
         {
            if(!StringHelper.isNullOrEmpty(StringHelper.trimAll(_inputGroupNameTxt.text)))
            {
               if(FilterWordManager.containSpecificChar(_inputGroupNameTxt.text,",|%"))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.view.FridendsListView.InputAgain"));
               }
               else
               {
                  FriendSocketOutManager.sendAddGroup(_inputGroupNameTxt.text);
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
      
      private function __receiveIMMsgHandler(param1:IMEvent) : void
      {
         var _loc5_:FriendItemCellInfo = null;
         var _loc4_:Boolean = false;
         var _loc7_:String = null;
         var _loc6_:* = undefined;
         var _loc3_:FriendItemCell = null;
         var _loc8_:IMFrame = null;
         var _loc2_:BaseIMInfo = param1.msg;
         if(_loc2_.imThane)
         {
            _loc5_ = friendManager.getCrossThaneInfoByUuid(_loc2_.imThane.uuid) as FriendItemCellInfo;
         }
         else
         {
            _loc5_ = imManager.getFriendInfo(param1.msg.userId);
         }
         if(_loc5_)
         {
            _loc4_ = _loc5_.serviceName != "" && _loc5_.serviceName != null && _loc5_.serviceName != playerModel.playerInfo.serviceName;
            _loc7_ = _loc4_ ? _loc5_.serviceName + "_" + _loc5_.userId : _loc5_.userId + "";
            if(_curSelectedGroup && _curSelectedGroup.groupId == _loc5_.groupId)
            {
               _loc6_ = imManager.model.unreadMsgDic[_loc7_];
               if(!_loc6_ || _loc6_.length > 1)
               {
                  return;
               }
               updateList();
            }
            else
            {
               _loc3_ = _listPanel.list.getItemByValue(_group[_loc5_.groupId]) as FriendItemCell;
               _loc8_ = imManager.model.openIMFrameDic[_loc7_];
               if(_loc3_ && (!_loc8_ || !_loc8_.parent))
               {
                  _loc3_.shining = true;
               }
            }
         }
      }
      
      private function __recentContactUpdateHandler(param1:FriendUpdateEvent) : void
      {
         if(_curSelectedGroup && _curSelectedGroup.groupId == 1)
         {
            updateList();
         }
      }
      
      private function __updateList(param1:Event) : void
      {
         updateList();
      }
      
      private function showMenu(param1:IListCell, param2:Boolean = false) : void
      {
         var _loc6_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         var _loc3_:FriendItemCellInfo = param1.getCellValue() as FriendItemCellInfo;
         if(_loc3_ && !_loc3_.isCross)
         {
            if(_loc3_.userId == _loc6_)
            {
               return;
            }
            playerManager.sendRequestSimpleAndSnsInfo((param1.getCellValue() as FriendItemCellInfo).userId,3);
         }
         var _loc5_:Point = param1.parent.localToGlobal(new Point(param1.x,param1.y));
         var _loc4_:Boolean = Boolean(FreedomTeamManager.instance.canInviteMember(_loc3_.userId,_loc3_.grades));
         if(_loc3_ && _loc3_.isCross)
         {
            _loc4_ = false;
         }
         _menu = new PlayerMenu(false,false,_loc3_.isCross,false,_loc4_);
         _menu.setData(_loc3_,param2);
         _menu.x = _loc5_.x - _menu.width;
         _menu.y = _loc5_.y - _menu.height > 0 ? _loc5_.y - _menu.height : 0;
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      private function __itemClickHandler(param1:FriendGroupEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:FriendItemCell = null;
         var _loc3_:FriendItemCell = null;
         if(!param1.item || !param1.data)
         {
            return;
         }
         var _loc5_:FriendItemCellInfo = param1.data as FriendItemCellInfo;
         if(_loc5_.type == 0)
         {
            if(_curSelectedGroup && _curSelectedGroup.groupId == 1 && _loc5_.userId != MarryManager.instance.model.selfMarryInfo.userId)
            {
               showMenu(param1.item as IListCell,true);
            }
            else
            {
               showMenu(param1.item as IListCell);
            }
            return;
         }
         if(_loc5_.type == -1)
         {
            if(friendManager.groupDic.getList().length >= 4)
            {
               _loc2_ = LanguageMgr.GetTranslation("friends.view.FridendsListView.command01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            _loc4_ = _listPanel.list.getItemByValue(_addGroupInfo) as FriendItemCell;
            if(_loc4_)
            {
               _loc4_.addChild(_inputGroupNameBg);
               _loc4_.addChild(_inputGroupNameTxt);
               _inputGroupNameTxt.addEventListener("keyDown",__groupTxtKeyDownHandler);
               _inputGroupNameTxt.setFocus();
            }
            return;
         }
         if(_loc5_.selected)
         {
            _loc5_.selected = false;
            friendModel.curSelectedGroup = _curSelectedGroup = null;
            updateList();
         }
         else
         {
            _loc3_ = _listPanel.list.getItemByValue(_loc5_) as FriendItemCell;
            if(_loc3_)
            {
               _loc3_.shining = false;
            }
            if(_curSelectedGroup)
            {
               _curSelectedGroup.selected = false;
            }
            friendModel.curSelectedGroup = _curSelectedGroup = _loc5_;
            updateList();
            _loc5_.selected = true;
         }
         _listPanel.beginChanges();
         _listPanel.list.updateListView();
         _listPanel.commitChanges();
      }
      
      private function updateList() : void
      {
         _scrollValue = _listPanel.vScrollbar ? _listPanel.vScrollbar.scrollValue : 0;
         refreshGroupTitle();
         _group.getList().sortOn("groupId",16);
         if(!_curSelectedGroup)
         {
            _listPanel.vectorListModel.clear();
            for each(var _loc1_:FriendItemCellInfo in _group.getList())
            {
               if(_loc1_.groupId != -1 && _loc1_.groupId != 3 && _loc1_.groupId != 1001 && _loc1_.groupId != 1002 && _loc1_.groupId != 1003)
               {
                  _listPanel.vectorListModel.append(_loc1_);
               }
            }
         }
         else
         {
            _listPanel.vectorListModel.clear();
            for each(var _loc2_:FriendItemCellInfo in _group.getList())
            {
               if(!(_loc2_.groupId == -1 || _loc2_.groupId == 3 || _loc2_.groupId == 1001 || _loc2_.groupId == 1002 || _loc2_.groupId == 1003))
               {
                  _listPanel.vectorListModel.append(_loc2_);
                  if(_curSelectedGroup.groupId == _loc2_.groupId)
                  {
                     _listPanel.vectorListModel.appendAll(getListByGroupId(_curSelectedGroup.groupId));
                  }
               }
            }
         }
         _listPanel.vectorListModel.append(_strangerInfo);
         if(_curSelectedGroup && _curSelectedGroup.groupId == -1)
         {
            _listPanel.vectorListModel.appendAll(getListByGroupId(_curSelectedGroup.groupId));
         }
         _listPanel.vectorListModel.append(_blackInfo);
         if(_curSelectedGroup && _curSelectedGroup.groupId == 3)
         {
            _listPanel.vectorListModel.appendAll(getListByGroupId(_curSelectedGroup.groupId));
         }
         _listPanel.vectorListModel.append(_crossFriendsInfo);
         if(_curSelectedGroup && _curSelectedGroup.groupId == 1001)
         {
            _listPanel.vectorListModel.appendAll(getListByGroupId(_curSelectedGroup.groupId));
         }
         _listPanel.vectorListModel.append(_crossStrangerInfo);
         if(_curSelectedGroup && _curSelectedGroup.groupId == 1002)
         {
            _listPanel.vectorListModel.appendAll(getListByGroupId(_curSelectedGroup.groupId));
         }
         _listPanel.vectorListModel.append(_crossBlankInfo);
         if(_curSelectedGroup && _curSelectedGroup.groupId == 1003)
         {
            _listPanel.vectorListModel.appendAll(getListByGroupId(_curSelectedGroup.groupId));
         }
         _listPanel.vectorListModel.append(_addGroupInfo);
         _listPanel.list.updateListView();
         if(_scrollValue > 0 && _listPanel.vScrollbar)
         {
            _listPanel.vScrollbar.scrollValue = _scrollValue;
         }
      }
      
      private function refreshGroupTitle() : void
      {
         var _loc11_:int = 0;
         var _loc17_:String = null;
         var _loc4_:int = 0;
         var _loc18_:int = 0;
         var _loc7_:String = null;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:String = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc16_:String = null;
         var _loc8_:Array = null;
         var _loc5_:Array = null;
         var _loc15_:int = 0;
         var _loc6_:String = null;
         var _loc1_:Array = FriendManager.getInstance().onlineBlacks;
         var _loc2_:Array = FriendManager.getInstance().offlineBlacks;
         for each(var _loc14_:FriendItemCellInfo in _group)
         {
            if(_loc14_.groupId == -2)
            {
               continue;
            }
            switch(_loc14_.groupId)
            {
               case 1:
                  _loc11_ = int(FriendManager.getInstance().privatePerson.length);
                  _loc14_.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.recent",_loc11_);
                  break;
               case 3:
                  _loc17_ = toArialBold(_loc1_.length + " / " + (_loc1_.length + _loc2_.length));
                  _loc14_.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.black",_loc17_);
                  break;
               case 1001:
                  _loc4_ = int(FriendManager.getInstance().getCrossFriendsRelationByType(1,true).length);
                  _loc18_ = int(FriendManager.getInstance().crossFriendList.getList().length);
                  _loc7_ = toArialBold(_loc4_ + " / " + _loc18_);
                  _loc14_.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.crossFriendsTitle",_loc7_);
                  break;
               case 1002:
                  _loc10_ = int(FriendManager.getInstance().getCrossFriendsRelationByType(2,true).length);
                  _loc9_ = int(FriendManager.getInstance().crossStrangerList.getList().length);
                  _loc3_ = toArialBold(_loc10_ + " / " + _loc9_);
                  _loc14_.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.crossStrangerTitle",_loc3_);
                  break;
               case 1003:
                  _loc12_ = int(FriendManager.getInstance().getCrossFriendsRelationByType(3,true).length);
                  _loc13_ = int(FriendManager.getInstance().crossBlackList.getList().length);
                  _loc16_ = toArialBold(_loc12_ + " / " + _loc13_);
                  _loc14_.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.crossBlankTitle",_loc16_);
                  break;
               default:
                  _loc8_ = friendManager.getListByGroupIdAndState(_loc14_.groupId,-1);
                  _loc5_ = friendManager.getOfflineList(_loc8_);
                  _loc15_ = _loc8_.length - _loc5_.length;
                  if(_loc14_.groupId == -1)
                  {
                     _loc6_ = toArialBold(_loc15_ + " / " + _loc8_.length);
                     _loc14_.title = LanguageMgr.GetTranslation("friends.view.FridendsListView.stranger",_loc6_);
                  }
                  else
                  {
                     _loc14_.title = friendManager.groupDic[_loc14_.groupId].groupName + "[" + toArialBold(_loc15_ + " / " + _loc8_.length) + "]";
                  }
            }
         }
      }
      
      private function getListByGroupId(param1:int) : Array
      {
         var _loc2_:Array = [];
         switch(param1)
         {
            case 1:
               return FriendManager.getInstance().privatePerson;
            case 3:
               _loc2_ = FriendManager.getInstance().onlineBlacks;
               _loc2_ = _loc2_.concat(FriendManager.getInstance().offlineBlacks);
               break;
            case -1:
               _loc2_ = friendManager.getListByGroupIdAndState(-1,-1);
               break;
            case 1001:
               _loc2_ = FriendManager.getInstance().crossFriendList.getList();
               break;
            case 1002:
               _loc2_ = FriendManager.getInstance().crossStrangerList.getList();
               break;
            case 1003:
               _loc2_ = FriendManager.getInstance().crossBlackList.getList();
               break;
            default:
               _loc2_ = friendManager.getListByGroupIdAndState(param1,-1);
         }
         _loc2_.sortOn(["isShine","state","friendGrade","friendGp","grades","nickName"],[2,0x10 | 2,0x10 | 2,0x10 | 2,0x10 | 2,1]);
         return _loc2_;
      }
      
      private function get friendManager() : FriendManager
      {
         return FriendManager.getInstance();
      }
      
      private function get friendModel() : FriendModel
      {
         return FriendManager.getInstance().model;
      }
      
      private function get imManager() : IMManager
      {
         return IMManager.instance;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get playerManager() : PlayerManager
      {
         return PlayerManager.instance;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

