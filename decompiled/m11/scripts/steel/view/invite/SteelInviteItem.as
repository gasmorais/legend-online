package steel.view.invite
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import mvc.module.marry.MarrySender;
   import mvc.module.room.RoomInfo;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SteelInviteItem extends Sprite implements IListCell, Disposeable
   {
      
      private var _selected:Boolean;
      
      private var _info:ThaneInfo;
      
      private var _bg:ScaleFrameImage;
      
      private var _sexBG:ScaleFrameImage;
      
      private var _line:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _inviteBtn:BaseButton;
      
      private var _inviteOKimg:Bitmap;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      public function SteelInviteItem()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemBg");
         _sexBG = ComponentFactory.Instance.creatComponentByStylename("roomInvite.sexIconBG");
         _line = ComponentFactory.Instance.creatBitmap("asset.invite.inviteItemHLINE");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemNameTextStyle");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemJobTextStyle");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemLevelTextStyle");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteBtnBtn");
         _inviteOKimg = ComponentFactory.Instance.creatBitmap("asset.core.checkstyle_2.SelectedImg");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("roomInvite.VocationIcon");
         addChild(_bg);
         addChild(_sexBG);
         addChild(_line);
         addChild(_nameTxt);
         addChild(_jobTxt);
         addChild(_levelTxt);
         addChild(_inviteBtn);
         addChild(_inviteOKimg);
         addChild(_vocationIcon);
         _bg.setFrame(1);
         _bg.visible = false;
         _inviteOKimg.visible = false;
         _vocationIcon.visible = false;
      }
      
      private function initEvents() : void
      {
         _inviteBtn.addEventListener("click",__inviteClick);
         MsgMan.addObserver("MarryEventType.ONE_KEY_INVITE",this,__oneKeyInviteHandler);
      }
      
      private function removeEvents() : void
      {
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",__inviteClick);
         }
         MsgMan.removeObserver("MarryEventType.ONE_KEY_INVITE",this,__oneKeyInviteHandler);
      }
      
      private function __oneKeyInviteHandler(param1:String, param2:Object) : void
      {
         _inviteBtn.enable = false;
         _inviteBtn.visible = false;
         _inviteOKimg.visible = true;
         _info.invited = true;
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
         FrameControllerManager.instance.steelController.sendSteelInvitePlayer(_info.userId);
      }
      
      private function get inWedding() : Boolean
      {
         return WorldBossHelper.checkWedding(CampaignManager.instance.mapId);
      }
      
      public function setWeddingInvite() : void
      {
         _levelTxt.visible = false;
         _vocationIcon.visible = false;
         _jobTxt.x = 152;
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
         _info = param1;
         _nameTxt.text = _info.nickName;
         _jobTxt.text = JobType.getJobName(_info.templateInfo.Job);
         _levelTxt.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_info.grades);
         _sexBG.setFrame(_info.sexs + 1);
         _inviteBtn.enable = !_info.invited;
         _inviteBtn.visible = !_info.invited;
         _inviteOKimg.visible = _info.invited;
         setVipIcon();
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
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         if(_info && _info.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_info.templateInfo.Job,_info.vocationStep,_info.vocationLevel);
            _vocationIcon.setFrame(_info.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      private function setVipIcon() : void
      {
         if(!_vipIcon)
         {
            _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
            addChild(_vipIcon);
         }
         if(!_vipText)
         {
            _vipText = ComponentFactory.Instance.creatComponentByStylename("roomInvite.inviteItemNameGradientText");
            addChild(_vipText);
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
         removeEvents();
         _info = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sexBG);
         _sexBG = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
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
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

