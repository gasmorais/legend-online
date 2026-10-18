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
   
   public class YearActiveEggViewUI extends Sprite
   {
      
      protected var _eggBigBg:MovieClip;
      
      protected var _block:Bitmap;
      
      protected var _chargeBg:Bitmap;
      
      protected var _chargeFt:Bitmap;
      
      protected var _eggRechargeBtn:BaseButton;
      
      protected var _eggPreBtn:BaseButton;
      
      protected var _eggBtn1:IconButton;
      
      protected var _eggBtn10:IconButton;
      
      protected var _eggPlayMc:MovieClip;
      
      protected var _proBarBg:Bitmap;
      
      protected var _proBar:Bitmap;
      
      protected var _eggnum2:FilterFrameText;
      
      protected var _eggnum2_2:FilterFrameText;
      
      protected var _eggTimeTxt:FilterFrameText;
      
      protected var _eggNbk1:Image;
      
      protected var _eggft1:FilterFrameText;
      
      protected var _eggNum1:FilterFrameText;
      
      protected var _eggnum3:FilterFrameText;
      
      protected var _eggicon1:Image;
      
      protected var _eggicon1_2:Image;
      
      protected var _eggicon2:Image;
      
      public function YearActiveEggViewUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _eggBigBg = ComponentFactory.Instance.creatCustomObject("ui.yearactive.eggBigBg");
         _block = ComponentFactory.Instance.creatBitmap("asset.yearactive.egg.block");
         _chargeBg = ComponentFactory.Instance.creatBitmap("asset.yearactive.egg.chargeBg");
         _chargeFt = ComponentFactory.Instance.creatBitmap("asset.yearactive.egg.chargeFt");
         _eggRechargeBtn = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggRechargeBtn");
         _eggPreBtn = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggPreBtn");
         _eggBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggBtn1");
         _eggBtn10 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggBtn10");
         _eggPlayMc = ComponentFactory.Instance.creatCustomObject("ui.yearactive.eggPlayMc");
         _proBarBg = ComponentFactory.Instance.creatBitmap("asset.yearactive.egg.proBarBg");
         _proBar = ComponentFactory.Instance.creatBitmap("asset.yearactive.egg.proBar");
         _eggnum2 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggnum2");
         _eggnum2_2 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggnum2_2");
         _eggTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggTimeTxt");
         _eggNbk1 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggNbk1");
         _eggft1 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggft1");
         _eggNum1 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggNum1");
         _eggnum3 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggnum3");
         _eggicon1 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggicon1");
         _eggicon1_2 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggicon1_2");
         _eggicon2 = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggicon2");
         addChild(_eggBigBg);
         addChild(_block);
         addChild(_chargeBg);
         addChild(_chargeFt);
         addChild(_eggRechargeBtn);
         addChild(_eggPreBtn);
         addChild(_eggBtn1);
         addChild(_eggBtn10);
         addChild(_eggPlayMc);
         addChild(_proBarBg);
         addChild(_proBar);
         addChild(_eggnum2);
         addChild(_eggnum2_2);
         addChild(_eggTimeTxt);
         addChild(_eggNbk1);
         addChild(_eggft1);
         addChild(_eggNum1);
         addChild(_eggnum3);
         addChild(_eggicon1);
         addChild(_eggicon1_2);
         addChild(_eggicon2);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_eggBigBg);
         _eggBigBg = null;
         ObjectUtils.disposeObject(_block);
         _block = null;
         ObjectUtils.disposeObject(_chargeBg);
         _chargeBg = null;
         ObjectUtils.disposeObject(_chargeFt);
         _chargeFt = null;
         ObjectUtils.disposeObject(_eggRechargeBtn);
         _eggRechargeBtn = null;
         ObjectUtils.disposeObject(_eggPreBtn);
         _eggPreBtn = null;
         ObjectUtils.disposeObject(_eggBtn1);
         _eggBtn1 = null;
         ObjectUtils.disposeObject(_eggBtn10);
         _eggBtn10 = null;
         ObjectUtils.disposeViolentMc(_eggPlayMc);
         _eggPlayMc = null;
         ObjectUtils.disposeObject(_proBarBg);
         _proBarBg = null;
         ObjectUtils.disposeObject(_proBar);
         _proBar = null;
         ObjectUtils.disposeObject(_eggnum2);
         _eggnum2 = null;
         ObjectUtils.disposeObject(_eggTimeTxt);
         _eggTimeTxt = null;
         ObjectUtils.disposeObject(_eggNbk1);
         _eggNbk1 = null;
         ObjectUtils.disposeObject(_eggft1);
         _eggft1 = null;
         ObjectUtils.disposeObject(_eggNum1);
         _eggNum1 = null;
         ObjectUtils.disposeObject(_eggnum3);
         _eggnum3 = null;
         ObjectUtils.disposeObject(_eggicon1);
         _eggicon1 = null;
         ObjectUtils.disposeObject(_eggicon2);
         _eggicon2 = null;
         ObjectUtils.disposeObject(_eggnum2_2);
         _eggnum2_2 = null;
         ObjectUtils.disposeObject(_eggicon1_2);
         _eggicon1_2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

