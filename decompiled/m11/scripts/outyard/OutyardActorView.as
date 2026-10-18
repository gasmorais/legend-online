package outyard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.data.OutyardForceInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.OutyardManager;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardActorView extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _blessBtn:TextButton;
      
      private var _attackBtn:TextButton;
      
      private var _rankingBmp:ScaleFrameImage;
      
      private var _inputBg:ScaleBitmapImage;
      
      private var _data:OutyardForceInfo;
      
      private var _consortiaNameTxt:FilterFrameText;
      
      private var _leftArmyTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _clickTime:int = 0;
      
      public function OutyardActorView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("outyard.ActorViewBg");
         _blessBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.ActorBlessBtn");
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.ActorAttackBtn");
         _rankingBmp = ComponentFactory.Instance.creatComponentByStylename("outyard.ActorViewRanking");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("outyard.ActorView.inputBg");
         _consortiaNameTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardActorView.consortiaNameTxt");
         _leftArmyTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardActorView.leftArmyTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardActorView.scoreTxt");
         addChild(_bg);
         addChild(_blessBtn);
         addChild(_attackBtn);
         addChild(_rankingBmp);
         addChild(_inputBg);
         addChild(_consortiaNameTxt);
         addChild(_leftArmyTxt);
         addChild(_scoreTxt);
         _blessBtn.text = LanguageMgr.GetTranslation("outyard.OutyardActorView.blessBtn.text");
         _attackBtn.text = LanguageMgr.GetTranslation("outyard.OutyardActorView.attackBtn.text");
      }
      
      private function addEvent() : void
      {
         _blessBtn.addEventListener("click",onBlessClick);
         _attackBtn.addEventListener("click",onAttackClick);
      }
      
      private function removeEvent() : void
      {
         _blessBtn.removeEventListener("click",onBlessClick);
         _attackBtn.removeEventListener("click",onAttackClick);
      }
      
      public function set data(param1:OutyardForceInfo) : void
      {
         _data = param1;
         if(_data == null)
         {
            this.visible = false;
            return;
         }
         _rankingBmp.setFrame(_data.order);
         _bg.setFrame(_data.forceIndex);
         _consortiaNameTxt.text = LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.forceName",_data.forceIndex);
         _leftArmyTxt.htmlText = LanguageMgr.GetTranslation("outyard.OutyardActorView.leftArmyTxt.text",_data.defenceAliveCount);
         _scoreTxt.text = LanguageMgr.GetTranslation("outyard.OutyardActorView.scoreTxt.text",_data.score);
         _blessBtn.visible = OutyardManager.instance.model.myForcePos == _data.forceIndex;
         _attackBtn.visible = OutyardManager.instance.model.myForcePos != _data.forceIndex;
      }
      
      private function onBlessClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("outyard",2);
      }
      
      private function onAttackClick(param1:MouseEvent) : void
      {
         if(getTimer() - _clickTime < 1000)
         {
            return;
         }
         _clickTime = getTimer();
         SoundManager.instance.play("022");
         if(OutyardManager.instance.model.stateMsg.stackHeadState != 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardActorView.AttackClick.text"));
            return;
         }
         OutyardManager.instance.OperateOutyard(6,_data.forceIndex);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_blessBtn);
         _blessBtn = null;
         ObjectUtils.disposeObject(_attackBtn);
         _attackBtn = null;
         ObjectUtils.disposeObject(_rankingBmp);
         _rankingBmp = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_consortiaNameTxt);
         _consortiaNameTxt = null;
         ObjectUtils.disposeObject(_leftArmyTxt);
         _leftArmyTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         _data = null;
         super.dispose();
      }
   }
}

