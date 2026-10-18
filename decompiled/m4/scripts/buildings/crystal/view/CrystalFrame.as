package buildings.crystal.view
{
   import buildings.BaseBuildFrame;
   
   public class CrystalFrame extends BaseBuildFrame
   {
      
      public function CrystalFrame()
      {
         super();
         resetSize(630);
      }
      
      override protected function initView() : void
      {
         super.initView();
         if(_lineBg.parent)
         {
            _lineBg.parent.removeChild(_lineBg);
         }
      }
   }
}

