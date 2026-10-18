package armyII.viewII.stone.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.view.community.BaseIconView;
   
   public class StoneOpViewUI extends Sprite
   {
      
      protected var _dkbg:Bitmap;
      
      protected var _dkBtn:IconButton;
      
      protected var _fwIcon:BaseIconView;
      
      protected var _fwnameTxt:FilterFrameText;
      
      protected var _opbagspanel:ScrollPanel;
      
      protected var _dkhbox:HBox;
      
      protected var _opBtn0:SelectedButton;
      
      protected var _opBtn1:SelectedButton;
      
      protected var _opBtn2:SelectedButton;
      
      protected var _opBtn3:SelectedButton;
      
      protected var _opBtn4:SelectedButton;
      
      protected var _opBtn5:SelectedButton;
      
      protected var _combox:ComboBox;
      
      protected var _bit:ScaleBitmapImage;
      
      public function StoneOpViewUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _dkbg = ComponentFactory.Instance.creatBitmap("asset.army.stone.dkbg");
         _bit = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.ggTxtBg");
         _dkBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.dkBtn");
         _fwIcon = ComponentFactory.Instance.creatCustomObject("ui.army.fwIcon");
         _fwnameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.fwnameTxt");
         _opbagspanel = ComponentFactory.Instance.creatComponentByStylename("ui.army.opbagspanel");
         _dkhbox = ComponentFactory.Instance.creatCustomObject("ui.army.dkhbox");
         _opBtn0 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn0");
         _opBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn1");
         _opBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn2");
         _opBtn3 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn3");
         _opBtn4 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn4");
         _opBtn5 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn5");
         _combox = ComponentFactory.Instance.creatComponentByStylename("army.stone.dkComBox");
         addChild(_dkbg);
         addChild(_bit);
         addChild(_dkBtn);
         addChild(_fwIcon);
         addChild(_fwnameTxt);
         addChild(_opbagspanel);
         addChild(_dkhbox);
         addChild(_combox);
         _bit.x = 13;
         _bit.y = 180;
         _bit.width = 284;
         _bit.height = 139;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_dkbg);
         _dkbg = null;
         ObjectUtils.disposeObject(_dkBtn);
         _dkBtn = null;
         ObjectUtils.disposeObject(_fwIcon);
         _fwIcon = null;
         ObjectUtils.disposeObject(_fwnameTxt);
         _fwnameTxt = null;
         ObjectUtils.disposeObject(_opbagspanel);
         _opbagspanel = null;
         ObjectUtils.disposeObject(_dkhbox);
         _dkhbox = null;
         ObjectUtils.disposeObject(_opBtn0);
         _opBtn0 = null;
         ObjectUtils.disposeObject(_opBtn1);
         _opBtn1 = null;
         ObjectUtils.disposeObject(_opBtn2);
         _opBtn2 = null;
         ObjectUtils.disposeObject(_opBtn3);
         _opBtn3 = null;
         ObjectUtils.disposeObject(_opBtn4);
         _opBtn4 = null;
         ObjectUtils.disposeObject(_opBtn5);
         _opBtn5 = null;
         ObjectUtils.disposeObject(_bit);
         _bit = null;
         ObjectUtils.disposeObject(_combox);
         _combox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

