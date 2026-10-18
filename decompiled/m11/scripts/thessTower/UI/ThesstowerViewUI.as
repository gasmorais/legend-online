package thessTower.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ThesstowerViewUI extends Sprite
   {
      
      protected var _bg:Bitmap;
      
      protected var _big:ScaleBitmapImage;
      
      protected var _normalBg:MutipleImage;
      
      protected var _advanceBg:MutipleImage;
      
      protected var _cardItemBox:VBox;
      
      protected var _pupBtn:IconButton;
      
      protected var _normalHbox:HBox;
      
      protected var _advanceBox:HBox;
      
      protected var _fightBtn:IconButton;
      
      protected var _buyTxt:FilterFrameText;
      
      protected var _buyBtn:BaseButton;
      
      protected var _icon:Image;
      
      protected var _buyTxt1:FilterFrameText;
      
      public function ThesstowerViewUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.thessTower.bg");
         _big = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.big");
         _normalBg = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.normalBg");
         _advanceBg = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.advanceBg");
         _cardItemBox = ComponentFactory.Instance.creatCustomObject("ui.thesstower.cardItemBox");
         _pupBtn = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.pupBtn");
         _normalHbox = ComponentFactory.Instance.creatCustomObject("ui.thesstower.normalHbox");
         _advanceBox = ComponentFactory.Instance.creatCustomObject("ui.thesstower.advanceBox");
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.fightBtn");
         _buyTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.buyTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.buyBtn");
         _icon = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.icon");
         _buyTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.buyTxt1");
         addChild(_bg);
         addChild(_big);
         addChild(_normalBg);
         addChild(_advanceBg);
         addChild(_cardItemBox);
         addChild(_pupBtn);
         addChild(_normalHbox);
         addChild(_advanceBox);
         addChild(_fightBtn);
         addChild(_buyTxt);
         addChild(_buyBtn);
         addChild(_icon);
         addChild(_buyTxt1);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_big);
         _big = null;
         ObjectUtils.disposeObject(_normalBg);
         _normalBg = null;
         ObjectUtils.disposeObject(_advanceBg);
         _advanceBg = null;
         ObjectUtils.disposeObject(_cardItemBox);
         _cardItemBox = null;
         ObjectUtils.disposeObject(_pupBtn);
         _pupBtn = null;
         ObjectUtils.disposeObject(_normalHbox);
         _normalHbox = null;
         ObjectUtils.disposeObject(_advanceBox);
         _advanceBox = null;
         ObjectUtils.disposeObject(_fightBtn);
         _fightBtn = null;
         ObjectUtils.disposeObject(_buyTxt);
         _buyTxt = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_buyTxt1);
         _buyTxt1 = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

