package skytreasure.reward
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class SkymyrankItem extends Sprite
   {
      
      protected var _RankItemBg2:Bitmap;
      
      protected var _lunMycoin:FilterFrameText;
      
      protected var _lunMyrank:FilterFrameText;
      
      public function SkymyrankItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _RankItemBg2 = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.RankItemBg2");
         _lunMycoin = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.lunMycoin");
         _lunMyrank = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.lunMyrank");
         _RankItemBg2.width = 727;
         addChild(_RankItemBg2);
         addChild(_lunMycoin);
         addChild(_lunMyrank);
         _lunMyrank.text = LanguageMgr.GetTranslation("skyTreasure.myRank");
         _lunMycoin.text = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle9") + 0;
      }
      
      public function update(param1:int, param2:int) : void
      {
         _lunMyrank.text = param1 == 0 ? LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle8") + LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle10") : LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle8") + param1;
         _lunMycoin.text = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle9") + param2;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_RankItemBg2);
         _RankItemBg2 = null;
         ObjectUtils.disposeObject(_lunMycoin);
         _lunMycoin = null;
         ObjectUtils.disposeObject(_lunMyrank);
         _lunMyrank = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

