package consortiachess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.chesspvp.ChesspvpRankInfo;
   
   public class ChesspvpRankItem extends Sprite
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _powTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _data:ChesspvpRankInfo;
      
      public function ChesspvpRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyRankItem.rankTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.nameTxt");
         _powTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.spowTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.scoreTxt");
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_powTxt);
         addChild(_scoreTxt);
      }
      
      public function set data(param1:ChesspvpRankInfo) : void
      {
         _data = param1;
         _rankTxt.text = "" + _data.rank;
         _nameTxt.text = _data.name;
         _powTxt.text = "" + _data.fightPower;
         _scoreTxt.text = "" + _data.score;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_powTxt);
         _powTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

