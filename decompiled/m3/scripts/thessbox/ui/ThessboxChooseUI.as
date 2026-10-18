package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class ThessboxChooseUI extends Sprite
   {
      
      protected var _addMianBg:MutipleImage;
      
      protected var _addNSK1:ThessBoxAddNUI;
      
      protected var _addNSK2:ThessBoxAddNUI;
      
      protected var _addNSK3:ThessBoxAddNUI;
      
      protected var _comfrimBtn:IconButton;
      
      protected var _desTxt:FilterFrameText;
      
      public function ThessboxChooseUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _addMianBg = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.addMianBg");
         _addNSK1 = ComponentFactory.Instance.creatCustomObject("ui.thessbox.addNSK1");
         _addNSK2 = ComponentFactory.Instance.creatCustomObject("ui.thessbox.addNSK2");
         _addNSK3 = ComponentFactory.Instance.creatCustomObject("ui.thessbox.addNSK3");
         _comfrimBtn = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.chooseBtn");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.threeOfTxt");
         addChild(_addMianBg);
         addChild(_addNSK1);
         addChild(_addNSK2);
         addChild(_addNSK3);
         addChild(_comfrimBtn);
         addChild(_desTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_addMianBg);
         _addMianBg = null;
         ObjectUtils.disposeObject(_addNSK1);
         _addNSK1 = null;
         ObjectUtils.disposeObject(_addNSK2);
         _addNSK2 = null;
         ObjectUtils.disposeObject(_addNSK3);
         _addNSK3 = null;
         ObjectUtils.disposeObject(_comfrimBtn);
         _comfrimBtn = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

