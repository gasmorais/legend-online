package godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.godsevening.GERankItemPersonData;
   
   public class GERankPersonalItem extends Component
   {
      
      private var _rankImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _data:GERankItemPersonData;
      
      public function GERankPersonalItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.RankNum");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.Rank");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.NickName");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.ServerName");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.FightPower");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("GERankPersonalItem.Score");
         addChild(_rankImg);
         addChild(_rankTxt);
         addChild(_nickNameTxt);
         addChild(_serverNameTxt);
         addChild(_fightPowerTxt);
         addChild(_scoreTxt);
         clean();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_rankImg);
         _rankImg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
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
         _nickNameTxt.text = "";
         _serverNameTxt.text = "";
         _fightPowerTxt.text = "";
         _scoreTxt.text = "";
      }
      
      public function set data(param1:GERankItemPersonData) : void
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
            _nickNameTxt.text = _data.nickName;
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

