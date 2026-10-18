package braveleg.signup
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.braveleg.BraveLegPlayerInfo;
   import yishi.manager.BraveLegManager;
   
   public class BraveLegTeamItem extends Component implements IListCell
   {
      
      private var _nameTf:FilterFrameText;
      
      private var _memberTf:FilterFrameText;
      
      private var _bg:Image;
      
      private var _joinBtn:IconButton;
      
      private var _data:BraveLegPlayerInfo;
      
      private var _isOver:Boolean;
      
      public function BraveLegTeamItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nameTf = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamItemNameTxt");
         _memberTf = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamItemMemberTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamItemBg");
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeamItemJoinBtn");
         addChild(_nameTf);
         addChild(_memberTf);
         addChild(_bg);
         addChild(_joinBtn);
         _bg.visible = false;
         _joinBtn.visible = false;
      }
      
      private function addEvent() : void
      {
         _joinBtn.addEventListener("click",__joinBtnClickHandler);
         this.addEventListener("rollOver",__onRollOverHandler);
         this.addEventListener("rollOut",__onRollOutHandler);
      }
      
      private function removeEvent() : void
      {
         _joinBtn.removeEventListener("click",__joinBtnClickHandler);
         this.removeEventListener("rollOver",__onRollOverHandler);
         this.removeEventListener("rollOut",__onRollOutHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nameTf);
         _nameTf = null;
         ObjectUtils.disposeObject(_memberTf);
         _memberTf = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_joinBtn);
         _joinBtn = null;
         _data = null;
         super.dispose();
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1;
         if(param1)
         {
            _nameTf.text = LanguageMgr.GetTranslation("braveleg.teamname",param1.nickName);
            _memberTf.text = param1.teammateNum + "/4";
         }
         else
         {
            _nameTf.text = "";
            _memberTf.text = "";
         }
         isOver = _isOver;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      private function __infoBtnClickHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            SoundManager.instance.play("016",true);
         }
      }
      
      private function __joinBtnClickHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            SoundManager.instance.play("016",true);
            _joinBtn.enable = false;
            BraveLegManager.instance.requestCreateTeam(_data.uid);
         }
      }
      
      private function __onRollOverHandler(param1:MouseEvent) : void
      {
         isOver = true;
      }
      
      private function __onRollOutHandler(param1:MouseEvent) : void
      {
         isOver = false;
      }
      
      private function set isOver(param1:Boolean) : void
      {
         _isOver = param1;
         if(_data && _isOver)
         {
            _joinBtn.visible = true;
            _bg.visible = true;
         }
         else
         {
            _joinBtn.visible = false;
            _bg.visible = false;
         }
      }
   }
}

