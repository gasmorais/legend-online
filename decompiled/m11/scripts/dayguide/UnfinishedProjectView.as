package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.dayGuide.LeedInfo;
   
   public class UnfinishedProjectView extends Sprite implements Disposeable
   {
      
      protected var _title:Bitmap;
      
      protected var _numTxt:FilterFrameText;
      
      protected var _vBox:VBox;
      
      private var _limitedItemsView0:LimitedItemsView;
      
      private var _limitedItemsView1:LimitedItemsView;
      
      private var _limitedItemsView2:LimitedItemsView;
      
      private var _limitedItemsView3:LimitedItemsView;
      
      public function UnfinishedProjectView()
      {
         super();
         initView();
         initTypeItems();
      }
      
      protected function initView() : void
      {
         _title = ComponentFactory.Instance.creatBitmap("asset.dayGuide.UncompleteImg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.ProjectNum");
         _numTxt.x = 113;
         addChild(_title);
         addChild(_numTxt);
         _vBox = new VBox();
         _vBox.spacing = 6;
         _vBox.x = 7;
         _vBox.y = 36;
         addChild(_vBox);
      }
      
      protected function initTypeItems() : void
      {
         _limitedItemsView0 = new LimitedItemsView(100);
         _limitedItemsView1 = new LimitedItemsView(200);
         _limitedItemsView2 = new LimitedItemsView(300);
         _limitedItemsView3 = new LimitedItemsView(400);
         _vBox.addChild(_limitedItemsView0);
         _vBox.addChild(_limitedItemsView1);
         _vBox.addChild(_limitedItemsView2);
         _vBox.addChild(_limitedItemsView3);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_limitedItemsView0);
         _limitedItemsView0 = null;
         ObjectUtils.disposeObject(_limitedItemsView1);
         _limitedItemsView1 = null;
         ObjectUtils.disposeObject(_limitedItemsView2);
         _limitedItemsView2 = null;
         ObjectUtils.disposeObject(_limitedItemsView3);
         _limitedItemsView3 = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function set data(param1:Vector.<LeedInfo>) : void
      {
         _numTxt.text = param1.length.toString();
         _limitedItemsView0.data = param1;
         _limitedItemsView1.data = param1;
         _limitedItemsView2.data = param1;
         _limitedItemsView3.data = param1;
         _vBox.refreshChildPos();
      }
      
      public function dispose() : void
      {
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

