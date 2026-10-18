package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ThessBoxMainUI extends Sprite
   {
      
      protected var _mainBg:Bitmap;
      
      protected var _sortBtn:BaseButton;
      
      protected var _numTxt:FilterFrameText;
      
      protected var _gotoBg:Bitmap;
      
      protected var _gotoBtn:IconButton;
      
      public function ThessBoxMainUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _mainBg = ComponentFactory.Instance.creatBitmap("asset.thessbox.mainBg");
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.sortBtn");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.numTxt");
         _gotoBg = ComponentFactory.Instance.creatBitmap("asset.thessbox.gotoBg");
         _gotoBtn = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.gotoBtn");
         addChild(_mainBg);
         addChild(_sortBtn);
         addChild(_numTxt);
         addChild(_gotoBg);
         addChild(_gotoBtn);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_mainBg);
         _mainBg = null;
         ObjectUtils.disposeObject(_sortBtn);
         _sortBtn = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_gotoBg);
         _gotoBg = null;
         ObjectUtils.disposeObject(_gotoBtn);
         _gotoBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

