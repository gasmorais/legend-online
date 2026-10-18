package map.campaign.view.ui.unrealshooting
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingUserInfo;
   
   public class UnrealShootingGameOverItem extends Component
   {
      
      private var _rankImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _teamNameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _isOnHookTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _killNumTxt:FilterFrameText;
      
      private var _data:UnrealShootingUserInfo;
      
      private var _isSelf:Boolean;
      
      public function UnrealShootingGameOverItem(param1:Boolean = false)
      {
         super();
         _isSelf = param1;
         initView();
      }
      
      private function initView() : void
      {
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverItem.RankImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverItem.RankTxt");
         _teamNameTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverItem.TeamNameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverItem.ServerNameTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverItem.ScoreTxt");
         _isOnHookTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverItem.IsOnHookTxt");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverItem.FightPowerTxt");
         _killNumTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverItem.KillNumTxt");
         addChild(_rankImg);
         addChild(_rankTxt);
         addChild(_teamNameTxt);
         addChild(_serverNameTxt);
         addChild(_scoreTxt);
         addChild(_isOnHookTxt);
         addChild(_fightPowerTxt);
         addChild(_killNumTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_rankImg);
         _rankImg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_teamNameTxt);
         _teamNameTxt = null;
         ObjectUtils.disposeObject(_serverNameTxt);
         _serverNameTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_fightPowerTxt);
         _fightPowerTxt = null;
         ObjectUtils.disposeObject(_killNumTxt);
         _killNumTxt = null;
         ObjectUtils.disposeObject(_isOnHookTxt);
         _isOnHookTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function clean() : void
      {
         _rankImg.visible = false;
         _rankTxt.text = "";
         _teamNameTxt.text = "";
         _serverNameTxt.text = "";
         _scoreTxt.text = "";
         _isOnHookTxt.text = "";
         _fightPowerTxt.text = "";
         _killNumTxt.text = "";
      }
      
      public function set data(param1:UnrealShootingUserInfo) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            if(_data.isAbend)
            {
               _rankImg.visible = false;
               _rankTxt.text = "--";
            }
            else if(_data.rank <= 3)
            {
               _rankImg.setFrame(_data.rank);
               _rankImg.visible = true;
            }
            else
            {
               _rankImg.visible = false;
               _rankTxt.text = _data.rank.toString();
            }
            _teamNameTxt.text = _data.nickName;
            _serverNameTxt.text = _data.serverName;
            _fightPowerTxt.text = _data.fightPower.toString();
            _killNumTxt.text = _data.killNum.toString();
            if(_data.isOnHook)
            {
               _isOnHookTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverItem.isOnHook");
               _scoreTxt.text = "";
            }
            else
            {
               _isOnHookTxt.text = "";
               _scoreTxt.text = _data.score.toString();
            }
            if(_isSelf)
            {
               _rankTxt.setFrame(2);
               _teamNameTxt.setFrame(2);
               _serverNameTxt.setFrame(2);
               _scoreTxt.setFrame(2);
               _fightPowerTxt.setFrame(2);
               _killNumTxt.setFrame(2);
            }
            else
            {
               _rankTxt.setFrame(1);
               _teamNameTxt.setFrame(1);
               _serverNameTxt.setFrame(1);
               _scoreTxt.setFrame(1);
               _fightPowerTxt.setFrame(1);
               _killNumTxt.setFrame(1);
            }
         }
      }
      
      override public function dispose() : void
      {
         uninitView();
         super.dispose();
      }
   }
}

