package consortia.view.myConsortia.recruit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class ApplyPlayerItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _colorBg:ScaleFrameImage;
      
      private var _checkBtn:SelectedButton;
      
      private var _isCheck:Boolean;
      
      private var _selected:Boolean;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _apTxt:FilterFrameText;
      
      private var _acceptBtn:SelectedCheckButton;
      
      private var _rejectBtn:SelectedCheckButton;
      
      private var _lineImg:MutipleImage;
      
      private var _data:ThaneInfo;
      
      private var _vocationIcon:ScaleFrameImage;
      
      public function ApplyPlayerItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _colorBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerItemBg");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrameCheckBtn");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerItemNameTextStyle");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerItemGradeTextStyle");
         _apTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerItemAPTextStyle");
         _acceptBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerItemAcceptBtn");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerItemRejectBtn");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("consortia.itemLine");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayer.VocationIcon");
         _colorBg.setFrame(1);
         _nameTxt.text = "";
         _gradeTxt.text = "";
         _apTxt.text = "";
         _acceptBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.accept");
         _rejectBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.reject");
         _vocationIcon.visible = false;
         addChild(_colorBg);
         addChild(_checkBtn);
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_apTxt);
         addChild(_acceptBtn);
         addChild(_rejectBtn);
         addChild(_lineImg);
         addChild(_vocationIcon);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeAllChildren(this);
         _checkBtn = null;
         _acceptBtn = null;
         _rejectBtn = null;
      }
      
      private function addEvent() : void
      {
         _checkBtn.addEventListener("click",__onCheckBtnClickHandler);
         _acceptBtn.addEventListener("click",__onAcceptHandler);
         _rejectBtn.addEventListener("click",__onRejectHandler);
      }
      
      private function removeEvent() : void
      {
         _checkBtn.removeEventListener("click",__onCheckBtnClickHandler);
         _acceptBtn.removeEventListener("click",__onAcceptHandler);
         _rejectBtn.removeEventListener("click",__onRejectHandler);
      }
      
      private function __onCheckBtnClickHandler(param1:Event) : void
      {
         if(_data)
         {
            _isCheck = !_isCheck;
            NotificationManager.instance.dispatchEvent(new ConsortiaEvent("APPLY_PLAYER_ITEM_CLICK"));
         }
      }
      
      private function __onAcceptHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _acceptBtn.enable = false;
         _rejectBtn.enable = false;
         var _loc2_:Array = [];
         _loc2_.push(_data);
         FrameControllerManager.instance.consortiaController.consortiaAcceptOrRejectApply(_loc2_,true);
      }
      
      private function __onRejectHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _acceptBtn.enable = false;
         _rejectBtn.enable = false;
         var _loc2_:Array = [];
         _loc2_.push(_data);
         FrameControllerManager.instance.consortiaController.consortiaAcceptOrRejectApply(_loc2_,false);
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
         _selected = param1;
         if(_selected && _data)
         {
            _colorBg.setFrame(2);
         }
         else
         {
            _colorBg.setFrame(1);
         }
      }
      
      public function get isCheck() : Boolean
      {
         return _isCheck;
      }
      
      public function set isCheck(param1:Boolean) : void
      {
         _isCheck = param1;
         if(_isCheck)
         {
            _checkBtn.selected = true;
         }
         else
         {
            _checkBtn.selected = false;
         }
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _nameTxt.text = _data.nickName;
            _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_data.grades);
            _apTxt.text = _data.fightingCapacity.toString();
            _acceptBtn.enable = true;
            _rejectBtn.enable = true;
            _acceptBtn.visible = true;
            _rejectBtn.visible = true;
            _checkBtn.visible = true;
         }
         else
         {
            _nameTxt.text = "";
            _gradeTxt.text = "";
            _apTxt.text = "";
            _colorBg.setFrame(1);
            _acceptBtn.visible = false;
            _rejectBtn.visible = false;
            _checkBtn.visible = false;
         }
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
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

