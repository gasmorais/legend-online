package buildings.residence.view
{
   import buildings.BaseBuildFrame;
   import com.pickgliss.ui.LayerManager;
   
   public class ResidenceFrame extends BaseBuildFrame
   {
      
      public function ResidenceFrame()
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
      
      override public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
   }
}

