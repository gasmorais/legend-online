package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.giftparty.GiftPartyMsg;
   import com.road.yishi.proto.giftparty.TeamMemberInfoMsg;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.controler.MagicPubControler;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.MagicPubManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   
   public class MagicPubGiftWillTeamInfoView extends Sprite implements Disposeable
   {
      
      private var _infoBack:MutipleImage;
      
      private var _goodsIcon:ScaleFrameImage;
      
      private var _refreshBtn:IconButton;
      
      private var _sellBtn:IconButton;
      
      private var _goodGradeName:MagicPubGiftWillGradeView;
      
      private var _createContainer:Component;
      
      private var _playerContainer:Component;
      
      private var _leaveBtn:IconButton;
      
      private var _createBtn:IconButton;
      
      private var _teamItem1:MagicPubGiftWillTeamInfoItem;
      
      private var _teamItem2:MagicPubGiftWillTeamInfoItem;
      
      private var _teamItem3:MagicPubGiftWillTeamInfoItem;
      
      private var _partyMsg:GiftPartyMsg;
      
      private var _numberAsset:BitmapData;
      
      private var _container:Component;
      
      private var _createNoteTxt:FilterFrameText;
      
      private var _returnBtn:IconButton;
      
      private var _openText:FilterFrameText;
      
      private var _refreshPoint:int;
      
      public function MagicPubGiftWillTeamInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _infoBack = ComponentFactory.Instance.creatComponentByStylename("xmlui.magi.infoBack");
         _goodsIcon = ComponentFactory.Instance.creatComponentByStylename("xmlui.magi.GoosIcon1");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.refreshBtn");
         _sellBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.sellBtn");
         _goodGradeName = new MagicPubGiftWillGradeView();
         _createContainer = ComponentFactory.Instance.creatCustomObject("magicpubEvent.createTeamContainer");
         _playerContainer = ComponentFactory.Instance.creatCustomObject("magicpubEvent.playerContainer");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.createBtn");
         _leaveBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.removeBtn");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.magicpub.giftWill.getNum");
         _container = new Component();
         _container.x = 263;
         _container.y = -261;
         _createNoteTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.createNoteTxt");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.returnBtn");
         _openText = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.openText");
         _teamItem1 = new MagicPubGiftWillTeamInfoItem();
         _teamItem2 = new MagicPubGiftWillTeamInfoItem();
         _teamItem3 = new MagicPubGiftWillTeamInfoItem();
         addChild(_infoBack);
         addChild(_goodsIcon);
         addChild(_refreshBtn);
         addChild(_sellBtn);
         addChild(_goodGradeName);
         addChild(_container);
         addChild(_createContainer);
         addChild(_playerContainer);
         addChild(_returnBtn);
         _createContainer.addChild(_createNoteTxt);
         _createContainer.addChild(_createBtn);
         _createContainer.addChild(_openText);
         _playerContainer.addChild(_teamItem1);
         _playerContainer.addChild(_teamItem2);
         _playerContainer.addChild(_teamItem3);
         _playerContainer.addChild(_leaveBtn);
         _goodGradeName.x = 117;
         _goodGradeName.y = -120;
         _teamItem1.y = 30;
         _teamItem2.y = 90;
         _teamItem3.y = 150;
         _createNoteTxt.text = LanguageMgr.GetTranslation("magicpub.MagicPubGiftWillTeamInfoView.createNote");
         _refreshPoint = ConfigInfoManager.instance.getFragPoint();
         _openText.text = LanguageMgr.GetTranslation("magicpub.giftWill.openText.text",getTimeStr(ConfigInfoManager.instance.getGiftWillTime2()));
      }
      
      private function getTimeStr(param1:Array) : String
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = String(param1[_loc3_]).replace(",","-").split("-");
            _loc4_ += _loc2_[0] + "~" + _loc2_[1] + "  ";
            _loc3_++;
         }
         return _loc4_;
      }
      
      private function initEvent() : void
      {
         _refreshBtn.addEventListener("click",__refreshHandler);
         _sellBtn.addEventListener("click",__sellHandler);
         _leaveBtn.addEventListener("click",__leaveHandler);
         _createBtn.addEventListener("click",__onCreateHandler);
         _returnBtn.addEventListener("click",__onReturnHandler);
         NotificationManager.instance.addEventListener("MAGICPUB_PLAYER_INFO",__playerInfoHandler);
      }
      
      private function removeEvent() : void
      {
         _refreshBtn.removeEventListener("click",__refreshHandler);
         _sellBtn.removeEventListener("click",__sellHandler);
         _leaveBtn.removeEventListener("click",__leaveHandler);
         _createBtn.removeEventListener("click",__onCreateHandler);
         _returnBtn.removeEventListener("click",__onReturnHandler);
         NotificationManager.instance.removeEventListener("MAGICPUB_PLAYER_INFO",__playerInfoHandler);
      }
      
      private function __playerInfoHandler(param1:NotificationEvent) : void
      {
         var _loc3_:TeamMemberInfoMsg = null;
         var _loc2_:int = 0;
         _partyMsg = MagicPubManager.instance.partyMsg;
         _goodsIcon.setFrame(_partyMsg.fragQuality);
         _goodGradeName.setDataGradeAndPos(_partyMsg.fragQuality,_partyMsg.fragLevel);
         NumberViewUtils.refreshValue(_partyMsg.partyCount,_container,_numberAsset,17,21,13,17,"0123456789");
         if(_partyMsg.teamInfo.length == 0)
         {
            _createContainer.visible = true;
            _playerContainer.visible = false;
            _refreshBtn.visible = _sellBtn.visible = true;
         }
         else
         {
            _createContainer.visible = false;
            _playerContainer.visible = true;
            _refreshBtn.visible = _sellBtn.visible = false;
            clearView();
            _loc2_ = 0;
            while(_loc2_ < _partyMsg.teamInfo[0].memberInfo.length)
            {
               _loc3_ = _partyMsg.teamInfo[0].memberInfo[_loc2_];
               if(_loc3_)
               {
                  this["_teamItem" + _loc3_.fragLevel].isMaster = _partyMsg.teamInfo[0].masterUserId == PlayerManager.instance.currentPlayerModel.playerInfo.userId;
                  this["_teamItem" + _loc3_.fragLevel].masterUserId = _partyMsg.teamInfo[0].masterUserId;
                  this["_teamItem" + _loc3_.fragLevel].teamId = _partyMsg.teamInfo[0].teamId;
                  this["_teamItem" + _loc3_.fragLevel].data = _loc3_;
               }
               _loc2_++;
            }
         }
         refreshPlayerList();
      }
      
      private function refreshPlayerList() : void
      {
         var _loc1_:GiftPartyMsg = null;
         if(MagicPubControler.needRefresh)
         {
            _loc1_ = MagicPubManager.instance.teamMsg;
            if(!_loc1_)
            {
               return;
            }
            MagicPubManager.instance.OperateGiftParty(9,0,0,0,_loc1_.pageIndex);
            MagicPubControler.needRefresh = false;
         }
      }
      
      private function __refreshHandler(param1:Event = null) : void
      {
         SoundManager.instance.play("022");
         showPromptAlert(_refreshPoint);
      }
      
      private function showPromptAlert(param1:int) : void
      {
         SimpleAlertHelper.instance.data = [showPromptAlertBack,param1];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("magicpub.MagicPubListView.isRefresh",param1);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function showPromptAlertBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc4_:int = 0;
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < param3)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               _loc4_ = param2 ? 0 : 1;
               MagicPubManager.instance.OperateGiftParty(6,0,0,0,0,_loc4_);
            }
         }
      }
      
      private function __sellHandler(param1:Event = null) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [sellOperate];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("magicpub.MagicPubListView.isSell");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
      }
      
      private function sellOperate(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MagicPubManager.instance.OperateGiftParty(7);
         }
      }
      
      private function __leaveHandler(param1:Event = null) : void
      {
         SoundManager.instance.play("022");
         MagicPubManager.instance.OperateGiftParty(2);
         MagicPubControler.needRefresh = true;
      }
      
      private function __onCreateHandler(param1:Event = null) : void
      {
         SoundManager.instance.play("022");
         MagicPubManager.instance.OperateGiftParty(1,0);
         MagicPubControler.needRefresh = true;
      }
      
      private function __onReturnHandler(param1:Event = null) : void
      {
         SoundManager.instance.play("022");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("MAGICPUB_GIFTWILL_OPEN",0));
         checkLeave();
      }
      
      private function checkLeave() : void
      {
         if(_partyMsg && _partyMsg.teamInfo[0] && _partyMsg.teamInfo[0].memberInfo.length > 0)
         {
            MagicPubManager.instance.OperateGiftParty(2);
         }
      }
      
      private function clearView() : void
      {
         _teamItem1.data = null;
         _teamItem2.data = null;
         _teamItem3.data = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_infoBack);
         _infoBack = null;
         ObjectUtils.disposeObject(_goodsIcon);
         _goodsIcon = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_sellBtn);
         _sellBtn = null;
         ObjectUtils.disposeObject(_goodGradeName);
         _goodGradeName = null;
         ObjectUtils.disposeObject(_leaveBtn);
         _leaveBtn = null;
         ObjectUtils.disposeObject(_createNoteTxt);
         _createNoteTxt = null;
         ObjectUtils.disposeObject(_createBtn);
         _createBtn = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         ObjectUtils.disposeObject(_teamItem1);
         _teamItem1 = null;
         ObjectUtils.disposeObject(_teamItem2);
         _teamItem2 = null;
         ObjectUtils.disposeObject(_teamItem3);
         _teamItem3 = null;
         ObjectUtils.disposeObject(_createContainer);
         _createContainer = null;
         ObjectUtils.disposeObject(_playerContainer);
         _playerContainer = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         _partyMsg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

