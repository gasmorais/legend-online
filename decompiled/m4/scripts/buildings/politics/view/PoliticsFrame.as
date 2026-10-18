package buildings.politics.view
{
   import buildings.BaseBuildFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   
   public class PoliticsFrame extends BaseBuildFrame
   {
      
      private var _background:Scale9CornerImage;
      
      private var _fieldList:PoliticsFieldView;
      
      private var _levyView:LevyView;
      
      private var _data:XML;
      
      public function PoliticsFrame()
      {
         super();
         addEvent();
      }
      
      override protected function initView() : void
      {
         super.initView();
         resetSize(630);
         _headContain.x = -20;
         _lineBg.x = 20;
         _upgradeBtn.x = 521;
         _levyView = ComponentFactory.Instance.creatCustomObject("politics.LevyView");
         addToContent(_levyView);
      }
      
      protected function addEvent() : void
      {
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
      }
      
      override protected function refreshView() : void
      {
         super.refreshView();
         _levyView.refreshView();
      }
      
      override protected function uninit() : void
      {
         super.uninit();
         removeEvent();
         ObjectUtils.disposeObject(_background);
         _background = null;
         ObjectUtils.disposeObject(_fieldList);
         _fieldList = null;
         ObjectUtils.disposeObject(_levyView);
         _levyView = null;
      }
      
      override public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      public function get levyView() : LevyView
      {
         return _levyView;
      }
   }
}

