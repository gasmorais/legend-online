package steel.view.ranklists
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.data.SteelTeamInfo;
   
   public class SteelRankItem extends Sprite implements Disposeable
   {
      
      private var _gap:ScaleLeftRightImage;
      
      private var _rankImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _teamNameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _winCountTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _data:SteelTeamInfo;
      
      public function SteelRankItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _gap = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankItem.ItemGap");
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankItem.RankImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankItem.RankTxt");
         _teamNameTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankItem.TeamNameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankItem.ServerNameTxt");
         _winCountTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankItem.WinCountTxt");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankItem.FightPowerTxt");
         addChild(_gap);
         addChild(_rankImg);
         addChild(_rankTxt);
         addChild(_teamNameTxt);
         addChild(_serverNameTxt);
         addChild(_winCountTxt);
         addChild(_fightPowerTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
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
      
      public function set data(param1:SteelTeamInfo) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            if(_data.crossOrder <= 3)
            {
               _rankImg.setFrame(_data.crossOrder);
               _rankImg.visible = true;
            }
            else
            {
               _rankImg.visible = false;
               _rankTxt.text = _data.crossOrder.toString();
            }
            _teamNameTxt.text = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.TeamName",_data.teamName);
            _serverNameTxt.text = _data.serverName;
            _winCountTxt.text = _data.succCount.toString();
            _fightPowerTxt.text = _data.fightPower.toString();
         }
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

