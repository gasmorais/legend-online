package armyII.viewII.stone.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class ArmyStoneGetViewUI extends Sprite
   {
      
      protected var _allbg:Bitmap;
      
      protected var _power:FilterFrameText;
      
      protected var _backTime:FilterFrameText;
      
      protected var _bagBtn:BaseButton;
      
      protected var _oneBtn:IconButton;
      
      protected var _lfbg:ScaleBitmapImage;
      
      protected var _nlbg:Image;
      
      protected var _sbbg:Image;
      
      protected var _lefttime:FilterFrameText;
      
      protected var _nlicon:Image;
      
      protected var _sbicon:Image;
      
      protected var _cqnli:Image;
      
      protected var _nlprice:FilterFrameText;
      
      protected var _ft2:Bitmap;
      
      protected var _ft1:Bitmap;
      
      protected var _tenBtn:IconButton;
      
      protected var _cqpi:Image;
      
      protected var _ptprice:FilterFrameText;
      
      protected var _runeChipTxt:FilterFrameText;
      
      protected var _runePointTxt:FilterFrameText;
      
      protected var _taEff:MovieClip;
      
      protected var _powEff:MovieClip;
      
      protected var _mShape:Shape;
      
      public function ArmyStoneGetViewUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _allbg = ComponentFactory.Instance.creatBitmap("asset.army.stone.allbg");
         _power = ComponentFactory.Instance.creatComponentByStylename("ui.army.power");
         _backTime = ComponentFactory.Instance.creatComponentByStylename("ui.army.backTime");
         _bagBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.bagBtn");
         _oneBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.oneBtn");
         _lfbg = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.tenTxtBg");
         _nlbg = ComponentFactory.Instance.creatComponentByStylename("ui.army.nlbg");
         _sbbg = ComponentFactory.Instance.creatComponentByStylename("ui.army.sbbg");
         _lefttime = ComponentFactory.Instance.creatComponentByStylename("ui.army.lefttime");
         _nlicon = ComponentFactory.Instance.creatComponentByStylename("ui.army.nlicon");
         _sbicon = ComponentFactory.Instance.creatComponentByStylename("ui.army.sbicon");
         _cqnli = ComponentFactory.Instance.creatComponentByStylename("ui.army.cqnli");
         _nlprice = ComponentFactory.Instance.creatComponentByStylename("ui.army.nlprice");
         _ft2 = ComponentFactory.Instance.creatBitmap("asset.army.stone.ft2");
         _ft1 = ComponentFactory.Instance.creatBitmap("asset.army.stone.ft1");
         _tenBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.tenBtn");
         _cqpi = ComponentFactory.Instance.creatComponentByStylename("ui.army.cqpi");
         _ptprice = ComponentFactory.Instance.creatComponentByStylename("ui.army.ptprice");
         _runeChipTxt = ComponentFactory.Instance.creatComponentByStylename("army.stone.getChipnumtxt");
         _runePointTxt = ComponentFactory.Instance.creatComponentByStylename("army.stone.getPointnumtxt");
         _taEff = ComponentFactory.Instance.creatCustomObject("asset.army.taEff");
         _powEff = ComponentFactory.Instance.creatCustomObject("asset.army.powerEff");
         _mShape = new Shape();
         _mShape.graphics.beginFill(16711680);
         _mShape.graphics.drawCircle(0,0,25);
         _mShape.graphics.endFill();
         _mShape.x = 300;
         _mShape.y = 92;
         addChild(_allbg);
         addChild(_powEff);
         addChild(_mShape);
         addChild(_taEff);
         addChild(_power);
         addChild(_backTime);
         addChild(_bagBtn);
         addChild(_oneBtn);
         addChild(_lfbg);
         addChild(_nlbg);
         addChild(_sbbg);
         addChild(_lefttime);
         addChild(_nlicon);
         addChild(_sbicon);
         addChild(_cqnli);
         addChild(_nlprice);
         addChild(_ft2);
         addChild(_ft1);
         addChild(_tenBtn);
         addChild(_cqpi);
         addChild(_ptprice);
         addChild(_runeChipTxt);
         addChild(_runePointTxt);
         _taEff.gotoAndStop(_taEff.totalFrames);
         _powEff.mask = _mShape;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_allbg);
         _allbg = null;
         ObjectUtils.disposeObject(_power);
         _power = null;
         ObjectUtils.disposeObject(_backTime);
         _backTime = null;
         ObjectUtils.disposeObject(_bagBtn);
         _bagBtn = null;
         ObjectUtils.disposeObject(_oneBtn);
         _oneBtn = null;
         ObjectUtils.disposeObject(_lfbg);
         _lfbg = null;
         ObjectUtils.disposeObject(_nlbg);
         _nlbg = null;
         ObjectUtils.disposeObject(_sbbg);
         _sbbg = null;
         ObjectUtils.disposeObject(_lefttime);
         _lefttime = null;
         ObjectUtils.disposeObject(_nlicon);
         _nlicon = null;
         ObjectUtils.disposeObject(_sbicon);
         _sbicon = null;
         ObjectUtils.disposeObject(_cqnli);
         _cqnli = null;
         ObjectUtils.disposeObject(_nlprice);
         _nlprice = null;
         ObjectUtils.disposeObject(_ft2);
         _ft2 = null;
         ObjectUtils.disposeObject(_ft1);
         _ft1 = null;
         ObjectUtils.disposeObject(_tenBtn);
         _tenBtn = null;
         ObjectUtils.disposeObject(_cqpi);
         _cqpi = null;
         ObjectUtils.disposeObject(_ptprice);
         _ptprice = null;
         ObjectUtils.disposeObject(_runeChipTxt);
         _runeChipTxt = null;
         ObjectUtils.disposeObject(_runePointTxt);
         _runePointTxt = null;
         ObjectUtils.disposeObject(_mShape);
         _mShape = null;
         ObjectUtils.disposeViolentMc(_powEff);
         _powEff = null;
         ObjectUtils.disposeViolentMc(_taEff);
         _taEff = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

