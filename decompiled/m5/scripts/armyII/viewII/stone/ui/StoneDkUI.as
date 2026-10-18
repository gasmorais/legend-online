package armyII.viewII.stone.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class StoneDkUI extends Sprite
   {
      
      protected var _gIcon:Image;
      
      protected var _dkDkBtn:IconButton;
      
      protected var _dkReplaceBtn:IconButton;
      
      protected var _dkFt1:MutipleImage;
      
      protected var _dkFt2:MutipleImage;
      
      protected var _dkrow:Image;
      
      protected var _dkNumTxt:FilterFrameText;
      
      public function StoneDkUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _gIcon = ComponentFactory.Instance.creatComponentByStylename("ui.army.gIcon");
         _dkDkBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.dkDkBtn");
         _dkReplaceBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.dkReplaceBtn");
         _dkFt1 = ComponentFactory.Instance.creatComponentByStylename("ui.army.dkFt1");
         _dkFt2 = ComponentFactory.Instance.creatComponentByStylename("ui.army.dkFt2");
         _dkrow = ComponentFactory.Instance.creatComponentByStylename("ui.army.dkrow");
         _dkNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.army.dk.neednumTxt");
         addChild(_gIcon);
         addChild(_dkDkBtn);
         addChild(_dkReplaceBtn);
         addChild(_dkFt1);
         addChild(_dkFt2);
         addChild(_dkrow);
         addChild(_dkNumTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_gIcon);
         _gIcon = null;
         ObjectUtils.disposeObject(_dkDkBtn);
         _dkDkBtn = null;
         ObjectUtils.disposeObject(_dkReplaceBtn);
         _dkReplaceBtn = null;
         ObjectUtils.disposeObject(_dkFt1);
         _dkFt1 = null;
         ObjectUtils.disposeObject(_dkFt2);
         _dkFt2 = null;
         ObjectUtils.disposeObject(_dkrow);
         _dkrow = null;
         ObjectUtils.disposeObject(_dkNumTxt);
         _dkNumTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

