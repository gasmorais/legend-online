package war2023.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarResultView extends Sprite
   {
      
      private var _getRewardImg:Bitmap;
      
      private var _rewardImgC:Bitmap;
      
      private var _rewardTxtC:FilterFrameText;
      
      public function SecretwarResultView()
      {
         super();
         initView();
         updateView();
      }
      
      private function initView() : void
      {
         _getRewardImg = ComponentFactory.Instance.creatBitmap("asset.secretwar.getRewardTxtImg");
         _rewardImgC = ComponentFactory.Instance.creatBitmap("asset.secretwar.RewardImgC");
         _rewardTxtC = ComponentFactory.Instance.creatComponentByStylename("secretwar.DuskAreaAccountFrame.RewardTxtC");
         addChild(_getRewardImg);
         addChild(_rewardImgC);
         addChild(_rewardTxtC);
         _rewardTxtC.text = "×0";
      }
      
      public function updateView() : void
      {
         var _loc1_:Array = null;
         var _loc2_:String = SecretWarManager.Instance.rewardShow;
         if(_loc2_.length > 1)
         {
            _loc1_ = SecretWarManager.Instance.rewardShow.split(",");
            _rewardTxtC.text = "× " + int(_loc1_[1]);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_getRewardImg);
         _getRewardImg = null;
         ObjectUtils.disposeObject(_rewardImgC);
         _rewardImgC = null;
         ObjectUtils.disposeObject(_rewardTxtC);
         _rewardTxtC = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

