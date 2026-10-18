package buildings.casern.view
{
   import buildings.BaseBuildFrame;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import mvc.module.armyII.UserArmy;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.PawnTileList;
   
   public class CasernFrame extends BaseBuildFrame implements IManualSize
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _pawnTileList:PawnTileList;
      
      private var _info:UserArmy;
      
      public function CasernFrame()
      {
         super();
         addEvent();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _headContain.x = -20;
         _lineBg.x = 20;
         _upgradeBtn.x = 538;
         _bg = ComponentFactory.Instance.creatComponentByStylename("casern.ListBackground");
         addToContent(_bg);
         _pawnTileList = ComponentFactory.Instance.creatCustomObject("casern.PawnTileList");
         addToContent(_pawnTileList);
         resetSize(_bg.displayWidth);
      }
      
      protected function addEvent() : void
      {
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
      }
      
      override protected function resetSize(param1:int) : void
      {
         _describeBackground.width = 502;
         _lineBg.width = param1;
      }
      
      override protected function refreshView() : void
      {
         super.refreshView();
         _pawnTileList.refreshView();
      }
      
      override public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,620,460);
      }
      
      public function get pawnTileList() : PawnTileList
      {
         return _pawnTileList;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         FrameControllerManager.instance.armyController.autoAllocate();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_pawnTileList);
         _pawnTileList = null;
         _info = null;
         super.dispose();
      }
   }
}

