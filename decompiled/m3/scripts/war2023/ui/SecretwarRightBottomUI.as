package war2023.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SecretwarRightBottomUI extends Sprite
   {
      
      protected var _rightbottom:Image;
      
      protected var _ft2:Bitmap;
      
      protected var _ft1:Bitmap;
      
      protected var _rightRankBtn:BaseButton;
      
      protected var _rightCampTxt:FilterFrameText;
      
      protected var _rightScoreTxt:FilterFrameText;
      
      protected var _trackBtn:BaseButton;
      
      public function SecretwarRightBottomUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rightbottom = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.rightbottom");
         _ft2 = ComponentFactory.Instance.creatBitmap("asset.secretwar.right.ft2");
         _ft1 = ComponentFactory.Instance.creatBitmap("asset.secretwar.right.ft1");
         _rightRankBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.rightRankBtn");
         _rightCampTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.rightCampTxt");
         _rightScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.rightScoreTxt");
         _trackBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.trackBtn");
         addChild(_rightbottom);
         addChild(_ft2);
         addChild(_ft1);
         addChild(_rightRankBtn);
         addChild(_rightCampTxt);
         addChild(_rightScoreTxt);
         addChild(_trackBtn);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rightbottom);
         _rightbottom = null;
         ObjectUtils.disposeObject(_ft2);
         _ft2 = null;
         ObjectUtils.disposeObject(_ft1);
         _ft1 = null;
         ObjectUtils.disposeObject(_rightRankBtn);
         _rightRankBtn = null;
         ObjectUtils.disposeObject(_rightCampTxt);
         _rightCampTxt = null;
         ObjectUtils.disposeObject(_rightScoreTxt);
         _rightScoreTxt = null;
         ObjectUtils.disposeObject(_trackBtn);
         _trackBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

