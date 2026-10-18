package braveleg.team
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.braveleg.BraveLegModel;
   import mvc.module.braveleg.BraveLegPlayerInfo;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.RequestInfoEvent;
   import yishi.manager.BraveLegManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.HeadIconCell;
   import yishi.view.tips.MessageTipManager;
   
   public class BraveLegTeammateItem extends Component implements IListCell
   {
      
      private var _head:HeadIconCell;
      
      private var _pos:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      private var _masterBg:Image;
      
      private var _maskBg:Image;
      
      private var _infoBtn:IconButton;
      
      private var _kickBtn:IconButton;
      
      private var _data:BraveLegPlayerInfo;
      
      private var _isOver:Boolean;
      
      private var _model:BraveLegModel = BraveLegManager.instance.model;
      
      public function BraveLegTeammateItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _head = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateItemHead");
         _pos = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammatePos");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateItemNameTxt");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateItemJobTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateItemScoreTxt");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateItemFightTxt");
         _masterBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateItemMasterBg");
         _maskBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateItemMaskBg");
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateItemInfoBtn");
         _kickBtn = ComponentFactory.Instance.creatComponentByStylename("braveleg.TeammateItemKickBtn");
         addChild(_head);
         addChild(_pos);
         addChild(_nameTxt);
         addChild(_jobTxt);
         addChild(_scoreTxt);
         addChild(_fightTxt);
         addChild(_masterBg);
         addChild(_maskBg);
         addChild(_infoBtn);
         addChild(_kickBtn);
         isOver = false;
      }
      
      private function addEvent() : void
      {
         _infoBtn.addEventListener("click",__infoBtnClickHandler);
         _kickBtn.addEventListener("click",__kickBtnClickHandler);
         this.addEventListener("rollOver",__onRollOverHandler);
         this.addEventListener("rollOut",__onRollOutHandler);
      }
      
      private function removeEvent() : void
      {
         _infoBtn.removeEventListener("click",__infoBtnClickHandler);
         _kickBtn.removeEventListener("click",__kickBtnClickHandler);
         this.removeEventListener("rollOver",__onRollOverHandler);
         this.removeEventListener("rollOut",__onRollOutHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_head);
         _head = null;
         ObjectUtils.disposeObject(_pos);
         _pos = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_jobTxt);
         _jobTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_masterBg);
         _masterBg = null;
         ObjectUtils.disposeObject(_maskBg);
         _maskBg = null;
         ObjectUtils.disposeObject(_infoBtn);
         _infoBtn = null;
         ObjectUtils.disposeObject(_kickBtn);
         _kickBtn = null;
         _data = null;
         _model = null;
         super.dispose();
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1;
         if(_data)
         {
            _pos.setFrame(param1.pos);
            _pos.visible = true;
            _head.headId = _data.headId > 0 ? _data.headId : int(_data.sexJob);
            _nameTxt.htmlText = LanguageMgr.GetTranslation("braveleg.Team.TeammateName",_data.nickName + "");
            _jobTxt.htmlText = LanguageMgr.GetTranslation("braveleg.Team.TeammateJob",JobType.getJobName(_data.sexJob));
            _scoreTxt.htmlText = LanguageMgr.GetTranslation("braveleg.Team.TeammateScore",_data.totalScore + "");
            _fightTxt.htmlText = LanguageMgr.GetTranslation("braveleg.Team.TeammateFight",_data.fightPower + "");
            _masterBg.visible = _data.isMaster;
         }
         else
         {
            _pos.visible = false;
            _head.headId = 0;
            _nameTxt.text = "";
            _jobTxt.text = "";
            _scoreTxt.text = "";
            _fightTxt.text = "";
            _masterBg.visible = false;
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
            PlayerManager.instance.addEventListener("REQUEST_SIMPLEINFO",__recentContactHandler);
            if(_data.serverName && _data.serverName != PlayerManager.instance.currentPlayerModel.playerInfo.serviceName)
            {
               PlayerInfoManager.instance.sendRequestSimpleInfoCross(_data.userId,_data.serverName);
            }
            else
            {
               PlayerInfoManager.instance.sendRequestSimpleInfo(_data.userId);
            }
         }
      }
      
      private function __recentContactHandler(param1:RequestInfoEvent) : void
      {
         PlayerManager.instance.removeEventListener("REQUEST_SIMPLEINFO",__recentContactHandler);
         var _loc2_:ThaneInfo = param1.data;
         if(!(_loc2_ && _loc2_.nickName))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChatItemMenu.cannotSearchPlayerInfo"));
            return;
         }
         if(param1.orientation == 10000)
         {
            PlayerInfoManager.instance.show(_loc2_,10000);
         }
         else
         {
            PlayerInfoManager.instance.show(_loc2_);
         }
      }
      
      private function __kickBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(_data && _model.teamInfo.isMaster)
         {
            SoundManager.instance.play("022");
            SimpleAlertHelper.instance.data = [conformKick];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("braveleg.Dialog.kick",_data.nickName);
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
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
         var _loc2_:Boolean = _isOver = param1;
         if(_isOver)
         {
            if(_data == null || PlayerManager.instance.currentPlayerModel.playerInfo.userId == _data.userId)
            {
               _loc2_ = false;
            }
         }
         if(_data && _loc2_)
         {
            if(_model.teamInfo.isMaster)
            {
               _kickBtn.visible = true;
               _kickBtn.enable = true;
               _infoBtn.x = 150;
            }
            else
            {
               _kickBtn.visible = false;
               _infoBtn.x = 87;
            }
            _infoBtn.visible = true;
            _maskBg.visible = true;
         }
         else
         {
            _infoBtn.visible = false;
            _kickBtn.visible = false;
            _maskBg.visible = false;
         }
      }
      
      private function conformKick(param1:Boolean, param2:Boolean) : void
      {
         if(param1 && _data)
         {
            BraveLegManager.instance.requestKillTeammate(_data.userId);
         }
      }
   }
}

