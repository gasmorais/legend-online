package monopoly.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MonopolySocketOutManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MonopolyFriendAssistItemView extends Sprite implements IListCell, Disposeable
   {
      
      private var _line:MutipleImage;
      
      private var _vipIcon:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _vipNameTxt:GradientText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _gradesTxt:FilterFrameText;
      
      private var _fightingCapacityTxt:FilterFrameText;
      
      private var _inviteBtn:TextButton;
      
      private var _data:ThaneInfo;
      
      public function MonopolyFriendAssistItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistItemView.NameTxt");
         _vipNameTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistItemView.VipNameGradientTxt");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistItemView.VocationIcon");
         _gradesTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistItemView.GradesTxt");
         _fightingCapacityTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistItemView.FightingCapacityTxt");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistItemView.InviteBtn");
         _line = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistItemView.ItemLine");
         addChild(_nameTxt);
         addChild(_vocationIcon);
         addChild(_gradesTxt);
         addChild(_fightingCapacityTxt);
         addChild(_inviteBtn);
         addChild(_line);
         _vipNameTxt.x = _nameTxt.x;
         _vipNameTxt.y = _nameTxt.y;
         _vipNameTxt.width = _nameTxt.width;
         _vocationIcon.visible = false;
         _inviteBtn.text = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.title");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_vipNameTxt);
         _vipNameTxt = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_gradesTxt);
         _gradesTxt = null;
         ObjectUtils.disposeObject(_fightingCapacityTxt);
         _fightingCapacityTxt = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
      
      private function addEvent() : void
      {
         if(_inviteBtn)
         {
            _inviteBtn.addEventListener("click",__inviteBtnClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",__inviteBtnClickHandler);
         }
      }
      
      private function __inviteBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!_data)
         {
            return;
         }
         if(_data.grades < 55)
         {
            _loc2_ = LanguageMgr.GetTranslation("monopoly.view.MonopolyFriendAssistItemView.InviteTip01",55);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         MonopolySocketOutManager.sendTriggerConfirm(_data.userId);
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         removeEvent();
         clean();
         if(_data)
         {
            addEvent();
            updateView();
         }
      }
      
      private function clean() : void
      {
         _vipIcon.visible = false;
         _nameTxt.visible = false;
         _vipNameTxt.visible = false;
         _vocationIcon.visible = false;
         _gradesTxt.visible = false;
         _fightingCapacityTxt.visible = false;
         _inviteBtn.visible = false;
      }
      
      private function updateView() : void
      {
         _vipIcon.visible = true;
         _nameTxt.visible = true;
         _vipNameTxt.visible = true;
         _vocationIcon.visible = true;
         _gradesTxt.visible = true;
         _fightingCapacityTxt.visible = true;
         _inviteBtn.visible = true;
         _nameTxt.parent && _nameTxt.parent.removeChild(_nameTxt);
         _vipNameTxt.parent && _vipNameTxt.parent.removeChild(_vipNameTxt);
         _vipIcon.parent && _vipIcon.parent.removeChild(_vipIcon);
         _vipNameTxt.text = _data.nickName;
         _nameTxt.text = _data.nickName;
         _vipIcon.x = 4;
         _vipIcon.y = _vipNameTxt.y + 2;
         if(_data.IsVipAndNoExpirt)
         {
            addChild(_vipNameTxt);
            addChild(_vipIcon);
         }
         else
         {
            addChild(_nameTxt);
         }
         _gradesTxt.text = String(_data.grades);
         _fightingCapacityTxt.text = String(_data.fightingCapacity);
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         if(_data && _data.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_data.templateInfo.Job,_data.vocationStep,_data.vocationLevel);
            _vocationIcon.setFrame(_data.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         data = param1 as ThaneInfo;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

