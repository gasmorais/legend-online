package childpatrol
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ChildPatrolEvent;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.ChildPatrolManager;
   import managers.IMManager;
   import managers.MagicSpringManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import mvc.module.children.ChildModel;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.SwitchPageHelp;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ChildPatrolHallFrame extends Frame implements IManualSize
   {
      
      private var back:MutipleImage;
      
      private var headBack:Bitmap;
      
      private var _iconMask:Shape;
      
      private var headIcon:BaseIconView;
      
      private var childCountBack:MutipleImage;
      
      private var nameText:FilterFrameText;
      
      private var freeChildText:FilterFrameText;
      
      private var allChildText:FilterFrameText;
      
      private var arrow:Bitmap;
      
      private var friendBtn:IconButton;
      
      private var returnBtn:IconButton;
      
      private var friendListView:ChildPatrolFriendsListView;
      
      private var towerContiner:Component;
      
      private var _helpBtn:BaseButton;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      private var _chuzhenBtn:IconButton;
      
      public function ChildPatrolHallFrame()
      {
         super();
         ChildPatrolManager.instance.sendChildPatrolOperate(1,playerModel.playerInfo.userId);
         initView();
         initBufferView();
         initTowerListView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,880,610);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.back");
         headBack = ComponentFactory.Instance.creatBitmap("asset.ChildPatrolHallFrame.headBack");
         headIcon = ComponentFactory.Instance.creatCustomObject("ChildPatrolHallFrame.headIcon");
         nameText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.nameText");
         childCountBack = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.childCountBack");
         freeChildText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.freeChildText");
         allChildText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.allChildText");
         arrow = ComponentFactory.Instance.creatBitmap("asset.ChildPatrol.FriendListArrow");
         friendBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.friendBtn");
         returnBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.returnBtn");
         towerContiner = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.towerContiner");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.HelpBtn");
         _chuzhenBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolBottomView.chuzhenBtn");
         friendListView = new ChildPatrolFriendsListView();
         addToContent(back);
         addToContent(headBack);
         addToContent(headIcon);
         addToContent(childCountBack);
         addToContent(nameText);
         addToContent(freeChildText);
         addToContent(allChildText);
         addToContent(returnBtn);
         returnBtn.visible = false;
         addToContent(towerContiner);
         addToContent(friendBtn);
         addToContent(friendListView);
         addToContent(_helpBtn);
         addToContent(_chuzhenBtn);
         friendBtn.addChild(arrow);
         _iconMask = createIconMask();
         addToContent(_iconMask);
         _iconMask.x = _iconMask.y = 4;
         headIcon.mask = _iconMask;
         _helpBtn.tipData = LanguageMgr.GetTranslation("ChildPatrolHallFrame.helpBtn.TipData");
         friendListView.x = 815;
         friendListView.y = 50;
         _chuzhenBtn.visible = VersionSwitch.YL_EXPEDTION;
      }
      
      private function initBufferView() : void
      {
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(13);
         if(_loc1_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc1_);
            _bufferView.setDescText(_loc1_.tempInfo.Desc);
            _bufferView.x = 10;
            _bufferView.y = 460;
            addToContent(_bufferView);
         }
      }
      
      private function createIconMask() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawCircle(32,34,30);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function initTowerListView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ChildPatrolHallTowerView = null;
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ChildPatrolHallFrame.towerView" + _loc1_);
            towerContiner.addChild(_loc2_);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         friendBtn.addEventListener("click",__friendClickHandler);
         returnBtn.addEventListener("click",__returnClickHandler);
         _helpBtn.addEventListener("click",__helpClick);
         ChildPatrolManager.instance.addEventListener("UPDATE_HEADQUARTERS_CHILDPATROL",__refreshHeadQuartersView);
         ChildPatrolManager.instance.addEventListener("UPDATE_TOWERINFO_CHILDPATROL",__refreshTowerView);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateChildPatrolTowerStateHandler);
         _chuzhenBtn.addEventListener("click",__chuzhenClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         friendBtn.removeEventListener("click",__friendClickHandler);
         returnBtn.removeEventListener("click",__returnClickHandler);
         _helpBtn.removeEventListener("click",__helpClick);
         ChildPatrolManager.instance.removeEventListener("UPDATE_HEADQUARTERS_CHILDPATROL",__refreshHeadQuartersView);
         ChildPatrolManager.instance.removeEventListener("UPDATE_TOWERINFO_CHILDPATROL",__refreshTowerView);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateChildPatrolTowerStateHandler);
         _chuzhenBtn.removeEventListener("click",__chuzhenClickHandler);
      }
      
      private function __updateChildPatrolTowerStateHandler(param1:PlayerEvent) : void
      {
         var _loc2_:Boolean = false;
         if(model.curUserId != playerModel.playerInfo.userId)
         {
            return;
         }
         if(model.headQuartersInfo.onGarrison && model.headQuartersInfo.garrisonEndTime <= playerModel.sysSecond && model.headQuartersInfo.garrisonEndTime != 0)
         {
            ChildPatrolManager.instance.sendChildPatrolOperate(2,0,0,model.headQuartersInfo.towerId);
         }
         for each(var _loc3_:ChildPatrolTowerInfo in model.towerInfoList)
         {
            _loc2_ = false;
            if(_loc3_.onGarrison && _loc3_.garrisonEndTime <= playerModel.sysSecond && _loc3_.garrisonEndTime != 0)
            {
               _loc2_ = true;
            }
            if(_loc3_.state != 0 && _loc3_.state != 3 && _loc3_.patrolEndTime <= playerModel.sysSecond && _loc3_.patrolEndTime != 0)
            {
               _loc2_ = true;
            }
            if(_loc2_)
            {
               ChildPatrolManager.instance.sendChildPatrolOperate(2,0,0,_loc3_.towerId);
            }
         }
      }
      
      private function __chuzhenClickHandler(param1:MouseEvent) : void
      {
         SwitchPageHelp.openYLExpeditionFrame();
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ChildPatrol.ChildPatrolHallFrame");
         _loc2_.show();
      }
      
      private function __refreshHeadQuartersView(param1:ChildPatrolEvent) : void
      {
         var _loc2_:ChildPatrolHallTowerView = towerContiner.getChildAt(0) as ChildPatrolHallTowerView;
         _loc2_.data = model.headQuartersInfo;
         refreshHeadData();
      }
      
      private function __refreshTowerView(param1:ChildPatrolEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ChildPatrolHallTowerView = null;
         _loc2_ = 1;
         while(_loc2_ < 10)
         {
            _loc3_ = towerContiner.getChildAt(_loc2_) as ChildPatrolHallTowerView;
            _loc3_.data = model.towerInfoList[_loc2_ - 1];
            _loc2_++;
         }
         refreshHeadData();
      }
      
      private function refreshHeadData() : void
      {
         var _loc1_:ThaneInfo = null;
         returnBtn.visible = false;
         childCountBack.visible = false;
         freeChildText.text = "";
         allChildText.text = "";
         if(model.curUserId == playerModel.playerInfo.userId)
         {
            childCountBack.visible = true;
            headIcon.icon = IconFactory.getPlayerIcon(ArmyManager.instance.thane.snsInfo.headId,"head");
            freeChildText.text = (childModel.childList.length - model.getNoFreeChildCount()).toString();
            allChildText.text = childModel.childList.length.toString();
            nameText.text = playerModel.playerInfo.nickName;
         }
         else
         {
            returnBtn.visible = true;
            _loc1_ = IMManager.instance.getFriendInfo(model.curUserId);
            if(_loc1_)
            {
               headIcon.icon = IconFactory.getPlayerIcon(_loc1_.snsInfo.headId,"head");
               nameText.text = _loc1_.nickName;
            }
         }
      }
      
      private function __friendClickHandler(param1:MouseEvent) : void
      {
         friendListView.showState = !friendListView.showState;
         if(friendListView.showState)
         {
            arrow.scaleX = -1;
            arrow.x = 24;
            TweenMax.killTweensOf(friendBtn);
            TweenMax.to(friendBtn,0.5,{"x":620});
         }
         else
         {
            arrow.scaleX = 1;
            arrow.x = 6;
            TweenMax.killTweensOf(friendBtn);
            TweenMax.to(friendBtn,0.5,{"x":815});
         }
      }
      
      private function __returnClickHandler(param1:MouseEvent) : void
      {
         if(model.curUserId != playerModel.playerInfo.userId)
         {
            ChildPatrolManager.instance.sendChildPatrolOperate(1,playerModel.playerInfo.userId);
            friendListView.resetSelectView();
         }
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
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("childpatrol.ChildPatrolHallFrame.titleText");
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(arrow)
         {
            ObjectUtils.disposeObject(arrow);
         }
         arrow = null;
         if(friendBtn)
         {
            ObjectUtils.disposeObject(friendBtn);
         }
         friendBtn = null;
         if(returnBtn)
         {
            ObjectUtils.disposeObject(returnBtn);
         }
         returnBtn = null;
         if(friendListView)
         {
            ObjectUtils.disposeObject(friendListView);
         }
         friendListView = null;
         if(headBack)
         {
            ObjectUtils.disposeObject(headBack);
         }
         headBack = null;
         if(headIcon)
         {
            ObjectUtils.disposeObject(headIcon);
         }
         headIcon = null;
         if(freeChildText)
         {
            ObjectUtils.disposeObject(freeChildText);
         }
         freeChildText = null;
         if(allChildText)
         {
            ObjectUtils.disposeObject(allChildText);
         }
         allChildText = null;
         if(nameText)
         {
            ObjectUtils.disposeObject(nameText);
         }
         nameText = null;
         if(childCountBack)
         {
            ObjectUtils.disposeObject(childCountBack);
         }
         childCountBack = null;
         if(_iconMask)
         {
            ObjectUtils.disposeObject(_iconMask);
         }
         _iconMask = null;
         if(towerContiner)
         {
            ObjectUtils.disposeObject(towerContiner);
         }
         towerContiner = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         ObjectUtils.disposeObject(_chuzhenBtn);
         _chuzhenBtn = null;
         model.selfIdDic = null;
         super.dispose();
      }
   }
}

