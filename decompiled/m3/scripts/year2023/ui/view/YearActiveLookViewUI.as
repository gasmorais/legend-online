package year2023.ui.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.view.community.BaseItemView;
   
   public class YearActiveLookViewUI extends Sprite
   {
      
      protected var _lookbigbg:MovieClip;
      
      protected var _cbg:Bitmap;
      
      protected var _lookNextBtn:IconButton;
      
      protected var _boxPreBg:Bitmap;
      
      protected var _lookPreIcon:BaseItemView;
      
      protected var _boxBg:Bitmap;
      
      protected var _ftbg:Bitmap;
      
      protected var _xLv:Bitmap;
      
      protected var _xKeyBtnBg:BaseButton;
      
      protected var _lookTimeTxt:FilterFrameText;
      
      protected var _lookTitle:FilterFrameText;
      
      protected var _lookxLv:FilterFrameText;
      
      protected var _lookxFt:FilterFrameText;
      
      protected var _lookPassbg:Image;
      
      protected var _lookPassFt:FilterFrameText;
      
      protected var _lookkeynum:FilterFrameText;
      
      protected var _lookBuybg:Image;
      
      protected var _loobuysicon:Image;
      
      protected var _lookBuykeynum:FilterFrameText;
      
      protected var _lookbuyBtn:BaseButton;
      
      protected var _lookRdwTitle:FilterFrameText;
      
      public function YearActiveLookViewUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _lookbigbg = ComponentFactory.Instance.creatCustomObject("ui.yearactive.lookbigbg");
         _cbg = ComponentFactory.Instance.creatBitmap("asset.yearactive.bao.cbg");
         _lookNextBtn = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookNextBtn");
         _boxPreBg = ComponentFactory.Instance.creatBitmap("asset.yearactive.bao.boxPreBg");
         _lookPreIcon = ComponentFactory.Instance.creatCustomObject("ui.yearactive.lookPreIcon");
         _boxBg = ComponentFactory.Instance.creatBitmap("asset.yearactive.bao.boxBg");
         _ftbg = ComponentFactory.Instance.creatBitmap("asset.yearactive.bao.ftbg");
         _xLv = ComponentFactory.Instance.creatBitmap("asset.yearactive.bao.xLv");
         _xKeyBtnBg = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.xKeyBtn");
         _lookTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookTimeTxt");
         _lookTitle = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookTitle");
         _lookxLv = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookxLv");
         _lookxFt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookxFt");
         _lookPassbg = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookPassbg");
         _lookPassFt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookPassFt");
         _lookkeynum = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookkeynum");
         _lookBuybg = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookBuybg");
         _loobuysicon = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.loobuysicon");
         _lookBuykeynum = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookBuykeynum");
         _lookbuyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookbuyBtn");
         _lookRdwTitle = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.lookRdwTitle");
         addChild(_lookbigbg);
         addChild(_cbg);
         addChild(_lookNextBtn);
         addChild(_boxPreBg);
         addChild(_lookPreIcon);
         addChild(_boxBg);
         addChild(_ftbg);
         addChild(_xLv);
         addChild(_xKeyBtnBg);
         addChild(_lookTimeTxt);
         addChild(_lookTitle);
         addChild(_lookxLv);
         addChild(_lookxFt);
         addChild(_lookPassbg);
         addChild(_lookPassFt);
         addChild(_lookkeynum);
         addChild(_lookBuybg);
         addChild(_loobuysicon);
         addChild(_lookBuykeynum);
         addChild(_lookbuyBtn);
         addChild(_lookRdwTitle);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_lookbigbg);
         _lookbigbg = null;
         ObjectUtils.disposeObject(_cbg);
         _cbg = null;
         ObjectUtils.disposeObject(_lookNextBtn);
         _lookNextBtn = null;
         ObjectUtils.disposeObject(_boxPreBg);
         _boxPreBg = null;
         ObjectUtils.disposeObject(_lookPreIcon);
         _lookPreIcon = null;
         ObjectUtils.disposeObject(_boxBg);
         _boxBg = null;
         ObjectUtils.disposeObject(_ftbg);
         _ftbg = null;
         ObjectUtils.disposeObject(_xLv);
         _xLv = null;
         ObjectUtils.disposeObject(_xKeyBtnBg);
         _xKeyBtnBg = null;
         ObjectUtils.disposeObject(_lookTimeTxt);
         _lookTimeTxt = null;
         ObjectUtils.disposeObject(_lookTitle);
         _lookTitle = null;
         ObjectUtils.disposeObject(_lookxLv);
         _lookxLv = null;
         ObjectUtils.disposeObject(_lookxFt);
         _lookxFt = null;
         ObjectUtils.disposeObject(_lookPassbg);
         _lookPassbg = null;
         ObjectUtils.disposeObject(_lookPassFt);
         _lookPassFt = null;
         ObjectUtils.disposeObject(_lookkeynum);
         _lookkeynum = null;
         ObjectUtils.disposeObject(_lookBuybg);
         _lookBuybg = null;
         ObjectUtils.disposeObject(_loobuysicon);
         _loobuysicon = null;
         ObjectUtils.disposeObject(_lookBuykeynum);
         _lookBuykeynum = null;
         ObjectUtils.disposeObject(_lookbuyBtn);
         _lookbuyBtn = null;
         ObjectUtils.disposeObject(_lookRdwTitle);
         _lookRdwTitle = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

