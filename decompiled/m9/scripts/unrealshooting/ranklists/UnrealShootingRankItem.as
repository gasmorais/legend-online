package unrealshooting.ranklists
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingUserInfo;
   
   public class UnrealShootingRankItem extends Sprite implements Disposeable
   {
      
      private var _rankImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _teamNameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _winCountTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _data:UnrealShootingUserInfo;
      
      private var _isSelf:Boolean;
      
      public function UnrealShootingRankItem(param1:Boolean = false)
      {
         super();
         _isSelf = param1;
         initView();
      }
      
      private function initView() : void
      {
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankItem.RankImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankItem.RankTxt");
         _teamNameTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankItem.TeamNameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankItem.ServerNameTxt");
         _winCountTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankItem.WinCountTxt");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankItem.FightPowerTxt");
         addChild(_rankImg);
         addChild(_rankTxt);
         addChild(_teamNameTxt);
         addChild(_serverNameTxt);
         addChild(_winCountTxt);
         addChild(_fightPowerTxt);
         clean();
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
         ObjectUtils.disposeObject(_winCountTxt);
         _winCountTxt = null;
         ObjectUtils.disposeObject(_fightPowerTxt);
         _fightPowerTxt = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function clean() : void
      {
         _rankImg.visible = false;
         _rankTxt.text = "";
         _teamNameTxt.text = "";
         _serverNameTxt.text = "";
         _winCountTxt.text = "";
         _fightPowerTxt.text = "";
      }
      
      public function set data(param1:UnrealShootingUserInfo) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            if(_data.rank == 0 && _isSelf)
            {
               _rankImg.visible = false;
               _rankTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankItem.noRank");
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
            _winCountTxt.text = _data.score.toString();
            _fightPowerTxt.text = _data.fightPower.toString();
            if(_isSelf)
            {
               _rankTxt.setFrame(2);
               _teamNameTxt.setFrame(2);
               _serverNameTxt.setFrame(2);
               _winCountTxt.setFrame(2);
               _fightPowerTxt.setFrame(2);
            }
            else
            {
               _rankTxt.setFrame(1);
               _teamNameTxt.setFrame(1);
               _serverNameTxt.setFrame(1);
               _winCountTxt.setFrame(1);
               _fightPowerTxt.setFrame(1);
            }
         }
      }
      
      public function dispose() : void
      {
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

