package wholerebate
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.WholeRebateManager;
   import mvc.module.wholerebate.WholeRebateModel;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.NumberViewUtils;
   
   public class ChargeView extends Component
   {
      
      private var _Congratulation:Image;
      
      private var _chargeIconBtn:IconButton;
      
      private var _chargeBg:MutipleImage;
      
      private var _progressBar:MovieClip;
      
      private var _needCharge:FilterFrameText;
      
      private var _rebateDiamond:FilterFrameText;
      
      private var _DiamonTxtPic:Image;
      
      private var _diamonTextPic2:Image;
      
      private var _diamondPic:Image;
      
      private var _numImg:Sprite;
      
      private var _numBmp:BitmapData;
      
      private var _percentImg:Image;
      
      private var _progressTxt:FilterFrameText;
      
      public function ChargeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _Congratulation = ComponentFactory.Instance.creatComponentByStylename("wholerebate.ChargeView.Congratulation");
         _chargeIconBtn = ComponentFactory.Instance.creatComponentByStylename("wholerebate.ChargeView.chargeIconBtn");
         _chargeBg = ComponentFactory.Instance.creatComponentByStylename("wholerebate.ChargeView.chargeBg");
         _progressBar = ComponentFactory.Instance.creatCustomObject("wholerebate.ProgressView");
         _needCharge = ComponentFactory.Instance.creatComponentByStylename("wholerebate.ChargeView.needCharge");
         _rebateDiamond = ComponentFactory.Instance.creatComponentByStylename("wholerebate.ChargeView.rebateDiamond");
         _DiamonTxtPic = ComponentFactory.Instance.creatComponentByStylename("wholerebate.ChargeView.DiamonTxtPic");
         _diamondPic = ComponentFactory.Instance.creatComponentByStylename("wholerebate.ChargeView.diamondPic");
         _numBmp = ComponentFactory.Instance.creatBitmapData("asset.wholerebate.chargeView.num");
         _percentImg = ComponentFactory.Instance.creatComponentByStylename("wholerebate.chargeView.percent");
         _diamonTextPic2 = ComponentFactory.Instance.creatComponentByStylename("wholerebate.chrageBG.n2");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("wholerebate.ChargeView.progresstxt");
         _progressBar.gotoAndStop(1);
         addChild(_chargeBg);
         addChild(_Congratulation);
         addChild(_chargeIconBtn);
         addChild(_progressBar);
         addChild(_rebateDiamond);
         addChild(_needCharge);
         addChild(_DiamonTxtPic);
         addChild(_percentImg);
         _numImg = new Sprite();
         _numImg.x = 350;
         _numImg.y = 42;
         addChild(_numImg);
         addChild(_diamonTextPic2);
         addChild(_progressTxt);
         setData();
      }
      
      private function addEvent() : void
      {
         _chargeIconBtn.addEventListener("click",_chargeIconBtnClickHandler);
      }
      
      private function _chargeIconBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      public function setData() : void
      {
         var _loc1_:WholeRebateModel = WholeRebateManager.instance.model;
         NumberViewUtils.refreshValue(_loc1_.percent,_numImg,_numBmp,16,22,15,16,"0123456789");
         _rebateDiamond.text = _loc1_.leftDiamond + "";
         _needCharge.text = _loc1_.needCharge + "";
         _progressBar.gotoAndStop(_loc1_.progress);
         if(_loc1_.total != 0)
         {
            _progressTxt.text = _loc1_.total - _loc1_.leftDiamond + "/" + _loc1_.total;
         }
      }
      
      private function removeEvent() : void
      {
         if(_chargeIconBtn)
         {
            _chargeIconBtn.removeEventListener("click",_chargeIconBtnClickHandler);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_needCharge);
         _needCharge = null;
         ObjectUtils.disposeObject(_rebateDiamond);
         _rebateDiamond = null;
         ObjectUtils.disposeObject(_Congratulation);
         _Congratulation = null;
         ObjectUtils.disposeObject(_chargeIconBtn);
         _chargeIconBtn = null;
         ObjectUtils.disposeObject(_chargeBg);
         _chargeBg = null;
         ObjectUtils.disposeObject(_percentImg);
         _percentImg = null;
         ObjectUtils.disposeObject(_DiamonTxtPic);
         _DiamonTxtPic = null;
         ObjectUtils.disposeObject(_diamondPic);
         _diamondPic = null;
         ObjectUtils.disposeObject(_numBmp);
         _numBmp = null;
         ObjectUtils.disposeObject(_numImg);
         _numImg = null;
         ObjectUtils.disposeObject(_diamonTextPic2);
         _diamonTextPic2 = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeViolentMc(_progressBar);
         _progressBar = null;
         super.dispose();
      }
   }
}

