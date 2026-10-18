package braveleg.invite
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.braveleg.BraveLegPlayerInfo;
   import yishi.datas.consant.JobType;
   import yishi.manager.BraveLegManager;
   
   public class BraveLegInviteItem extends Component implements IListCell
   {
      
      private var _selected:Boolean;
      
      private var _info:BraveLegPlayerInfo;
      
      private var _sexBG:ScaleFrameImage;
      
      private var _line:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _inviteBtn:BaseButton;
      
      private var _inviteOKimg:Bitmap;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      public function BraveLegInviteItem()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _sexBG = ComponentFactory.Instance.creatComponentByStylename("roomInvite.sexIconBG");
         _line = ComponentFactory.Instance.creatBitmap("asset.braveleg.InviteItemLine");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.InviteItemNameTxt");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.InviteItemJobTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.InviteItemLevelTxt");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.InviteItemInviteBtn");
         _inviteOKimg = ComponentFactory.Instance.creatBitmap("asset.core.checkstyle_2.SelectedImg");
         addChild(_sexBG);
         addChild(_line);
         addChild(_nameTxt);
         addChild(_jobTxt);
         addChild(_levelTxt);
         addChild(_inviteBtn);
         addChild(_inviteOKimg);
         _inviteOKimg.visible = false;
      }
      
      private function initEvents() : void
      {
         _inviteBtn.addEventListener("click",__inviteClick);
      }
      
      private function removeEvents() : void
      {
         _inviteBtn.removeEventListener("click",__inviteClick);
      }
      
      private function __inviteClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _inviteBtn.enable = false;
         _inviteBtn.visible = false;
         _inviteOKimg.visible = true;
         BraveLegManager.instance.requestInviteFriend(_info.userId);
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
         _jobTxt.text = JobType.getJobName(_info.sexJob);
         _levelTxt.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_info.grades);
         _sexBG.setFrame(_info.sexJob < 4 ? 1 : 2);
         _inviteBtn.enable = true;
         _inviteBtn.visible = true;
         _inviteOKimg.visible = false;
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
         return false;
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _info = null;
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
         ObjectUtils.disposeObject(_inviteOKimg);
         _inviteOKimg = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         super.dispose();
      }
   }
}

