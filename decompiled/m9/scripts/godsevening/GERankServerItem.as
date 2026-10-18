package godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.godsevening.GERankItemServerData;
   
   public class GERankServerItem extends Component
   {
      
      private var _rankImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _data:GERankItemServerData;
      
      public function GERankServerItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.RankNum");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.Rank");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.ServerName");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.FightPower");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.Score");
         addChild(_rankImg);
         _rankImg.x = 25;
         addChild(_rankTxt);
         _rankTxt.x = 20;
         addChild(_serverNameTxt);
         _serverNameTxt.x = 160;
         addChild(_fightPowerTxt);
         _fightPowerTxt.x = 307;
         addChild(_scoreTxt);
         clean();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_rankImg);
         _rankImg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_serverNameTxt);
         _serverNameTxt = null;
         ObjectUtils.disposeObject(_fightPowerTxt);
         _fightPowerTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function clean() : void
      {
         _rankImg.visible = false;
         _rankTxt.text = "";
         _serverNameTxt.text = "";
         _fightPowerTxt.text = "";
         _scoreTxt.text = "";
      }
      
      public function set data(param1:GERankItemServerData) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            if(_data.rank <= 3)
            {
               _rankImg.setFrame(_data.rank);
               _rankImg.visible = true;
            }
            else
            {
               _rankImg.visible = false;
               _rankTxt.text = _data.rank.toString();
            }
            _serverNameTxt.text = _data.serverName;
            _fightPowerTxt.text = _data.fightPower.toString();
            _scoreTxt.text = _data.score.toString();
         }
      }
      
      override public function dispose() : void
      {
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

