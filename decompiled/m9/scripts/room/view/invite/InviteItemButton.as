package room.view.invite
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import managers.GroupfbManager;
   import managers.IMManager;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import mvc.module.groupfb.GroupfbSender;
   import mvc.module.marry.MarrySender;
   import mvc.module.room.RoomInfo;
   import room.net.RoomSocketOuterManager;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.PlayerMenu;
   import yishi.view.tips.MessageTipManager;
   
   public class InviteItemButton extends Sprite implements Disposeable, ISelectable
   {
      
      private var _selected:Boolean;
      
      private var _info:ThaneInfo;
      
      private var _bg:ScaleFrameImage;
      
      private var _sexBG:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _inviteBtn:BaseButton;
      
      private var _inviteOKimg:Bitmap;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _vipText:GradientText;
      
      public function InviteItemButton()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         buttonMode = true;
         _bg = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemBg");
         _sexBG = ComponentFactory.Instance.creatComponentByStylename("roomInvite.sexIconBG");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemNameTextStyle");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemJobTextStyle");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemLevelTextStyle");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteBtnBtn");
         _inviteOKimg = ComponentFactory.Instance.creatBitmap("asset.core.checkstyle_2.SelectedImg");
         addChild(_bg);
         addChild(_sexBG);
         addChild(_nameTxt);
         addChild(_jobTxt);
         addChild(_levelTxt);
         addChild(_inviteBtn);
         addChild(_inviteOKimg);
         _bg.setFrame(1);
         _bg.mouseChildren = false;
         _bg.mouseEnabled = false;
         _inviteOKimg.visible = false;
         setVipIcon();
      }
      
      private function uninit() : void
      {
         _info = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sexBG);
         _sexBG = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_jobTxt);
         _jobTxt = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function initEvent() : void
      {
         DoubleClickManager.Instance.enableDoubleClick(this);
         addEventListener("interactive_click",__onMouseClick);
         addEventListener("interactive_double_click",__onDoubleClick);
         addEventListener("rollOver",__onMouseRollover);
         addEventListener("rollOut",__onMouseRollout);
         _inviteBtn.addEventListener("click",__inviteClick);
         _inviteBtn.addEventListener("mouseDown",__chatDownHandler);
      }
      
      private function removeEvent() : void
      {
         DoubleClickManager.Instance.disableDoubleClick(this);
         removeEventListener("interactive_click",__onMouseClick);
         removeEventListener("interactive_double_click",__onDoubleClick);
         removeEventListener("rollOver",__onMouseRollover);
         removeEventListener("rollOut",__onMouseRollout);
         _inviteBtn.removeEventListener("click",__inviteClick);
         _inviteBtn.removeEventListener("mouseDown",__chatDownHandler);
      }
      
      private function __inviteClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         _inviteBtn.enable = false;
         _inviteBtn.visible = false;
         _inviteOKimg.visible = true;
         _info.invited = true;
         if(inWedding)
         {
            MarrySender.invite(_info.userId);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("INVITE_SUCCESS"));
            return;
         }
         if(GroupfbManager.instance.model.isCaptain)
         {
            if(_info.vocationGrades <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("room.view.invite.InviteItem.command02"));
            }
            else
            {
               GroupfbSender.inviteGroup(_info.userId);
            }
            return;
         }
         if(GameHallManager.instance.model.selfTeam)
         {
            GameHallManager.instance.teamInvite(_info.userId);
            return;
         }
         var _loc3_:RoomInfo = RoomManager.instance.roomInfo;
         if(_loc3_)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.invite.InviteItem.command01");
            if(_loc3_.selectedMapTemplate && _loc3_.selectedMapTemplate.MinLevel > _info.grades)
            {
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(_loc3_.mapTemplate && _loc3_.mapTemplate.MinLevel > _info.grades)
            {
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         RoomSocketOuterManager.sendRoomInvite(_info.userId);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("INVITE_SUCCESS"));
      }
      
      private function get inWedding() : Boolean
      {
         return WorldBossHelper.checkWedding(CampaignManager.instance.mapId);
      }
      
      private function __chatDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function privateChat() : void
      {
         IMManager.instance.createIMFrame(_info);
      }
      
      private function __onDoubleClick(param1:Event) : void
      {
         privateChat();
      }
      
      private function __onMouseClick(param1:Event) : void
      {
         if(_info is ThaneInfo && (_info as ThaneInfo).userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            return;
         }
         var _loc3_:Point = parent.localToGlobal(new Point(x,y + 20));
         var _loc2_:PlayerMenu = new PlayerMenu();
         _loc2_.setData(_info);
         _loc2_.x = _loc3_.x - _loc2_.width;
         _loc2_.y = _loc3_.y - _loc2_.height;
         if(_loc2_.y < 0)
         {
            _loc2_.y = 0;
         }
         LayerManager.Instance.addToLayer(_loc2_,7);
      }
      
      protected function __onMouseRollover(param1:MouseEvent) : void
      {
         if(!selected)
         {
            _bg.setFrame(2);
         }
      }
      
      protected function __onMouseRollout(param1:MouseEvent) : void
      {
         if(!selected)
         {
            _bg.setFrame(1);
         }
      }
      
      private function __resposeHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(_info.relation != 4)
               {
                  FriendManager.getInstance().sendRemoveFriendRequest(_info.userId);
                  break;
               }
               FriendManager.getInstance().removePrivatePerson(_info.userId);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         if(_selected)
         {
            _bg.setFrame(3);
            _nameTxt.setFrame(2);
            _levelTxt.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
            _nameTxt.setFrame(1);
            _levelTxt.setFrame(1);
         }
      }
      
      public function get data() : ThaneInfo
      {
         return _info;
      }
      
      private function setVipIcon() : void
      {
         if(!_vipIcon)
         {
            _vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon");
            addChild(_vipIcon);
         }
         if(!_vipText)
         {
            _vipText = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemNameGradientText");
            addChild(_vipText);
         }
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _info = param1;
         _nameTxt.text = _info.nickName;
         _jobTxt.text = JobType.getJobName(_info.templateInfo.Job);
         _levelTxt.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_info.grades);
         _sexBG.setFrame(_info.sexs + 1);
         _inviteBtn.enable = !_info.invited;
         _inviteBtn.visible = !_info.invited;
         _inviteOKimg.visible = _info.invited;
         setVipIcon();
         _info.vipType == 1 ? _vipIcon.setFrame(1) : _vipIcon.setFrame(2);
         if(isVip)
         {
            _nameTxt.visible = false;
            _vipIcon.visible = true;
            _vipText.visible = true;
            _vipText.text = _nameTxt.text;
            _vipIcon.x = _vipText.x + (_vipText.width - _vipText.textWidth) / 2 - _vipIcon.width - 2;
            _vipIcon.y = _vipText.y + 4;
         }
         else
         {
            _nameTxt.visible = true;
            _vipText.visible = false;
            _vipIcon.visible = false;
         }
      }
      
      private function get isVip() : Boolean
      {
         return _info.IsVipAndNoExpirt;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
      }
      
      override public function get height() : Number
      {
         return _bg.height - 5;
      }
   }
}

