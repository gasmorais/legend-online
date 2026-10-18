package yishi.view.frame.pvpleague
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.gvgcross.GvgCrossSortData;
   
   public class PVPLeagueRankItem extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _topIcon:ScaleFrameImage;
      
      private var _topText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _serverNameText:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _fightCapacityText:FilterFrameText;
      
      private var _data:GvgCrossSortData;
      
      public function PVPLeagueRankItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("sort.league.ItemBg");
         _topIcon = ComponentFactory.Instance.creatComponentByStylename("sort.league.TopIcon");
         _topText = ComponentFactory.Instance.creatComponentByStylename("sort.league.TopText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("sort.league.NameText");
         _serverNameText = ComponentFactory.Instance.creatComponentByStylename("sort.league.ServerNameText");
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("sort.league.ScoreText");
         _fightCapacityText = ComponentFactory.Instance.creatComponentByStylename("sort.league.FightCapacityText");
         _bg.visible = false;
         addChild(_bg);
         addChild(_topIcon);
         addChild(_topText);
         addChild(_nameText);
         addChild(_serverNameText);
         addChild(_scoreText);
         addChild(_fightCapacityText);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__mouseOverHandler);
         addEventListener("rollOut",__mouseOutHandler);
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__mouseOverHandler);
         removeEventListener("rollOut",__mouseOutHandler);
         removeEventListener("click",__clickHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.visible = true;
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _bg.visible = false;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
      }
      
      public function get data() : GvgCrossSortData
      {
         return _data;
      }
      
      public function set data(param1:GvgCrossSortData) : void
      {
         _data = param1;
         if(_data)
         {
            _topText.text = _data.guildInfo.crossOrder.toString();
            _nameText.text = _data.guildInfo.consortiaName;
            _serverNameText.text = _data.guildInfo.serverName;
            _scoreText.text = _data.guildInfo.totalScore.toString();
            _fightCapacityText.text = _data.guildInfo.fightPower.toString();
            if(_data.guildInfo.crossOrder >= 1 && _data.guildInfo.crossOrder <= 3)
            {
               _topIcon.setFrame(_data.guildInfo.crossOrder);
               _topIcon.visible = true;
               _topText.visible = false;
            }
            else
            {
               _topIcon.visible = false;
               _topText.visible = true;
            }
         }
         else
         {
            _topText.text = "";
            _nameText.text = "";
            _serverNameText.text = "";
            _scoreText.text = "";
            _fightCapacityText.text = "";
            _topIcon.visible = false;
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

