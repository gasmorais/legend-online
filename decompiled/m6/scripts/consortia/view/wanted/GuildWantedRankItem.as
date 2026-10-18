package consortia.view.wanted
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.guildwanted.GuildWantedRankInfo;
   
   public class GuildWantedRankItem extends Sprite
   {
      
      public var _rankTxt:FilterFrameText;
      
      public var _nameTxt:FilterFrameText;
      
      public var _scoreTxt:FilterFrameText;
      
      public function GuildWantedRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.rankTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.nameTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildwanted.scoreTxt");
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_scoreTxt);
      }
      
      public function set data(param1:GuildWantedRankInfo) : void
      {
         _rankTxt.text = param1.rank.toString();
         _nameTxt.text = param1.nickName;
         _scoreTxt.text = param1.score.toString();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

