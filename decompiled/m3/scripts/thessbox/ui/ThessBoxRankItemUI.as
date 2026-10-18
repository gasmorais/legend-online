package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class ThessBoxRankItemUI extends Sprite
   {
      
      protected var _rankitemBg:ScaleBitmapImage;
      
      protected var _rankRhBox:HBox;
      
      protected var _rkNameTxt:FilterFrameText;
      
      protected var _rkPassTxt:FilterFrameText;
      
      public function ThessBoxRankItemUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _rankitemBg = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.rankitemBg");
         _rankRhBox = ComponentFactory.Instance.creatCustomObject("ui.thessbox.rankRhBox");
         _rkNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.rkNameTxt");
         _rkPassTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.rkPassTxt");
         addChild(_rankitemBg);
         addChild(_rankRhBox);
         addChild(_rkNameTxt);
         addChild(_rkPassTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankitemBg);
         _rankitemBg = null;
         ObjectUtils.disposeObject(_rankRhBox);
         _rankRhBox = null;
         ObjectUtils.disposeObject(_rkNameTxt);
         _rkNameTxt = null;
         ObjectUtils.disposeObject(_rkPassTxt);
         _rkPassTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

