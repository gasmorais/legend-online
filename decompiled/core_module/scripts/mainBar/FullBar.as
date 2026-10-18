package mainBar
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class FullBar
   {
      
      private static var _instance:FullBar;
      
      private var _topFullImage:Bitmap;
      
      private var _leftFullImage:Bitmap;
      
      private var _rightFullImage:Bitmap;
      
      private var _downFullImage:Bitmap;
      
      private var _topBitmapData:BitmapData;
      
      private var _rightBitmapData:BitmapData;
      
      private var _downBitmapData:BitmapData;
      
      private var _leftBitmapData:BitmapData;
      
      public function FullBar()
      {
         super();
         init();
         StageReferance.addEventListener("resize",__onResize);
         __onResize();
      }
      
      public static function get instance() : FullBar
      {
         if(!_instance)
         {
            _instance = new FullBar();
         }
         return _instance;
      }
      
      private function init() : void
      {
         _topBitmapData = ComponentFactory.Instance.creatBitmapData("resourcesBar.fullTopAsset");
         _rightBitmapData = ComponentFactory.Instance.creatBitmapData("resourcesBar.fullRightAsset");
         _downBitmapData = ComponentFactory.Instance.creatBitmapData("resourcesBar.fullDownAsset");
         _leftBitmapData = ComponentFactory.Instance.creatBitmapData("resourcesBar.fullLeftAsset");
         _topFullImage = new Bitmap(_topBitmapData);
         _leftFullImage = new Bitmap(_leftBitmapData);
         _rightFullImage = new Bitmap(_rightBitmapData);
         _downFullImage = new Bitmap(_downBitmapData);
         _topFullImage.scrollRect = _leftFullImage.scrollRect = null;
         _rightFullImage.scrollRect = _downFullImage.scrollRect = null;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(_topFullImage,5);
         LayerManager.Instance.addToLayer(_leftFullImage,5);
         LayerManager.Instance.addToLayer(_rightFullImage,5);
         LayerManager.Instance.addToLayer(_downFullImage,5);
      }
      
      public function hide() : void
      {
         if(_topFullImage.parent)
         {
            _topFullImage.parent.removeChild(_topFullImage);
         }
         if(_leftFullImage.parent)
         {
            _leftFullImage.parent.removeChild(_leftFullImage);
         }
         if(_rightFullImage.parent)
         {
            _rightFullImage.parent.removeChild(_rightFullImage);
         }
         if(_downFullImage.parent)
         {
            _downFullImage.parent.removeChild(_downFullImage);
         }
      }
      
      private function __onResize(param1:Event = null) : void
      {
         _topFullImage.width = StageReferance.stageWidth;
         _downFullImage.width = StageReferance.stageWidth;
         _rightFullImage.height = StageReferance.stageHeight;
         _leftFullImage.height = StageReferance.stageHeight;
         _rightFullImage.x = StageReferance.stageWidth - _rightFullImage.width + 2;
         _downFullImage.y = StageReferance.stageHeight - _downFullImage.height + 2;
      }
   }
}

