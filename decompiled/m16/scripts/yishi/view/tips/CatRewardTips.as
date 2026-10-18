package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.templates.CatHouseTemplateInfo;
   
   public class CatRewardTips extends BaseTip
   {
      
      private var _rewardTxt:FilterFrameText;
      
      private var _icon:ScaleFrameImage;
      
      private var _numBg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      public function CatRewardTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 182;
         _bg.height = 75;
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("tips.catHouseRewardTxt");
         _numBg = ComponentFactory.Instance.creatBitmap("asset.tips.numBg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("tips.catHouseMaterialIcon");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("tips.catHouseMaterialTxt");
         addChild(_rewardTxt);
         addChild(_numBg);
         addChild(_icon);
         addChild(_countTxt);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:CatHouseTemplateInfo = null;
         if(tipData)
         {
            clean();
            _loc1_ = tipData as CatHouseTemplateInfo;
            _icon.setFrame(goodsIdToImageId(_loc1_.OutTempId) + 1);
            _countTxt.text = String(_loc1_.OutTempCount);
            _rewardTxt.text = LanguageMgr.GetTranslation("catHouse.CatRewardTips.rewardTxt");
         }
      }
      
      private function goodsIdToImageId(param1:int) : int
      {
         var _loc2_:int = param1;
         if(param1 == -100)
         {
            _loc2_ = 7;
         }
         else if(param1 < 0)
         {
            _loc2_ = -(_loc2_ + 2000) / 100;
         }
         return _loc2_;
      }
      
      private function clean() : void
      {
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

