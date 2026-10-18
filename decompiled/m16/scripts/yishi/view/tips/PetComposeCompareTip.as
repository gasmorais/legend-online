package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.pet.PetData;
   
   public class PetComposeCompareTip extends BaseTip
   {
      
      private var _intensifyIcon:Bitmap;
      
      private var _selfPetTip:PetTip;
      
      private var _currentTip:PetTip;
      
      public function PetComposeCompareTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _selfPetTip = new PetTip();
         _currentTip = new PetTip();
         _intensifyIcon = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:PetData = null;
         var _loc1_:PetData = null;
         if(_selfPetTip.parent)
         {
            _selfPetTip.parent.removeChild(_selfPetTip);
         }
         if(_currentTip.parent)
         {
            _currentTip.parent.removeChild(_currentTip);
         }
         if(_intensifyIcon.parent)
         {
            _intensifyIcon.parent.removeChild(_intensifyIcon);
         }
         if(tipData is Array || tipData is Vector.<PetData>)
         {
            _loc1_ = tipData[0] as PetData;
            _loc2_ = tipData[1] as PetData;
         }
         _selfPetTip.tipData = _loc1_;
         _currentTip.tipData = _loc2_;
         addChild(_selfPetTip);
         addChild(_currentTip);
         addChild(_intensifyIcon);
         _selfPetTip.x = 0;
         _currentTip.x = 313;
         _intensifyIcon.x = 270;
         _intensifyIcon.y = (_selfPetTip.height - _intensifyIcon.height) * 0.5;
      }
      
      override public function dispose() : void
      {
         if(_currentTip)
         {
            _currentTip.dispose();
         }
         _currentTip = null;
         if(_selfPetTip)
         {
            _selfPetTip.dispose();
         }
         _selfPetTip = null;
         ObjectUtils.disposeObject(_intensifyIcon);
         _intensifyIcon = null;
         super.dispose();
      }
   }
}

