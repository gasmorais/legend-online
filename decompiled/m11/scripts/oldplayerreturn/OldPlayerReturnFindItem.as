package oldplayerreturn
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.allianceregression.RelationData;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OldPlayerReturnManager;
   
   public class OldPlayerReturnFindItem extends Component
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _revokeBtn:TextButton;
      
      private var _applyBtn:TextButton;
      
      private var _agreeBtn:TextButton;
      
      private var _line:Bitmap;
      
      private var _data:RelationData;
      
      private var _index:int;
      
      public function OldPlayerReturnFindItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnFindItem.nameTxt");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnFindItem.fightTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnFindItem.numTxt");
         _revokeBtn = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnFindItem.revokeBtn");
         _applyBtn = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnFindItem.applyBtn");
         _agreeBtn = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnFindItem.agreeBtn");
         _line = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnAllianceView.line");
         addChild(_nameTxt);
         addChild(_fightTxt);
         addChild(_numTxt);
         addChild(_revokeBtn);
         addChild(_applyBtn);
         addChild(_agreeBtn);
         addChild(_line);
         _revokeBtn.text = LanguageMgr.GetTranslation("OldPlayerReturnFindItem.revokeBtn.text");
         _applyBtn.text = LanguageMgr.GetTranslation("OldPlayerReturnFindItem.applyBtn.text");
         _agreeBtn.text = LanguageMgr.GetTranslation("OldPlayerReturnFindItem.agreeBtn.text");
         _revokeBtn.visible = false;
         _applyBtn.visible = false;
         _agreeBtn.visible = false;
         _line.x = 5;
         _line.y = 30;
      }
      
      private function addEvent() : void
      {
         _revokeBtn.addEventListener("click",__revokeBtnClickHandler);
         _applyBtn.addEventListener("click",__applyBtnClickHandler);
         _agreeBtn.addEventListener("click",__agreeBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _revokeBtn.removeEventListener("click",__revokeBtnClickHandler);
         _applyBtn.removeEventListener("click",__applyBtnClickHandler);
         _agreeBtn.removeEventListener("click",__agreeBtnClickHandler);
      }
      
      private function __revokeBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         OldPlayerReturnManager.instance.send(4,_data.playerId);
         NotificationManager.instance.addEventListener("INVITES_DATA_EVENT",__invitesDataUpdateHandler);
      }
      
      private function __applyBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         OldPlayerReturnManager.instance.send(3,_data.playerId);
         NotificationManager.instance.addEventListener("INVITES_DATA_EVENT",__invitesDataUpdateHandler);
      }
      
      private function __agreeBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         OldPlayerReturnManager.instance.sendApprove(_data.playerId);
      }
      
      private function __invitesDataUpdateHandler(param1:NotificationEvent) : void
      {
         NotificationManager.instance.removeEventListener("INVITES_DATA_EVENT",__invitesDataUpdateHandler);
         if(param1.data && param1.data.userId == _data.playerId)
         {
            if(param1.data.result == 0)
            {
               return;
            }
            _applyBtn.visible = false;
            _revokeBtn.visible = true;
         }
      }
      
      public function set data(param1:RelationData) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         _nameTxt.text = _data.nickName;
         _fightTxt.text = _data.fightingCapacity.toString();
         _numTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnFindItem.numTxt.text",_data.allianceNum);
         if(_index == 0)
         {
            _applyBtn.visible = _data.status == 0;
            _revokeBtn.visible = _data.status == 1;
         }
         else if(_index == 1)
         {
            _agreeBtn.visible = true;
         }
         else
         {
            _revokeBtn.visible = true;
         }
         if(model.isReturnPlayer)
         {
            _numTxt.visible = true;
            _fightTxt.x = 150;
         }
         else
         {
            _numTxt.visible = false;
            _fightTxt.x = 203;
         }
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_revokeBtn);
         _revokeBtn = null;
         ObjectUtils.disposeObject(_applyBtn);
         _applyBtn = null;
         ObjectUtils.disposeObject(_agreeBtn);
         _agreeBtn = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

