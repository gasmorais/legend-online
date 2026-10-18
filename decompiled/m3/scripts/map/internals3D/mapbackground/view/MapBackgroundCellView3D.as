package map.internals3D.mapbackground.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.speedEngine.components.bone.BoneImage;
   import com.speedEngine.speedBones.textures.AtfData;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import map.internals3D.mapbackground.MapBackgroundView3D;
   import map.internals3D.mapbackground.model.MapBackgroundCellInfo3D;
   import yishi.manager.NotificationManager;
   
   public class MapBackgroundCellView3D
   {
      
      private var _cellInfo:MapBackgroundCellInfo3D;
      
      private var _isDispose:Boolean = false;
      
      private var _parent:Object;
      
      private var _index:int = -1;
      
      public function MapBackgroundCellView3D()
      {
         super();
      }
      
      public function setParent(param1:Object, param2:int = 0) : void
      {
         removeView();
         _parent = param1;
         _index = -1;
         if(_parent)
         {
            _index = param2;
            addView();
         }
      }
      
      public function set cellInfo(param1:MapBackgroundCellInfo3D) : void
      {
         if(_cellInfo)
         {
            if(_cellInfo.view && _cellInfo.view.parent)
            {
               _cellInfo.view.parent.removeChild(_cellInfo.view);
            }
            _cellInfo = null;
         }
         _cellInfo = param1;
         if(_cellInfo.view)
         {
            updateView();
         }
         else if(MapBackgroundView3D.RENDER_MODE_3D)
         {
            LoaderManagerII.instance.load(param1.url,1,9,__completeHandler);
         }
         else
         {
            LoaderManagerII.instance.load(param1.url,2,9,__completeHandler);
         }
      }
      
      private function __completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(!param2 || _isDispose)
         {
            return;
         }
         updateView(param2);
      }
      
      protected function updateView(param1:Object = null) : void
      {
         var _loc2_:BoneImage = null;
         var _loc3_:Bitmap = null;
         var _loc4_:Bitmap = null;
         if(!_cellInfo.view)
         {
            if(!param1)
            {
               return;
            }
            if(MapBackgroundView3D.RENDER_MODE_3D)
            {
               _loc2_ = new BoneImage();
               _loc2_.texture = new AtfData(param1 as ByteArray);
               _cellInfo.view = _loc2_;
            }
            else
            {
               _loc3_ = param1 as Bitmap;
               _loc4_ = new Bitmap();
               _cellInfo.view = _loc4_;
               (_cellInfo.view as Bitmap).bitmapData = _loc3_.bitmapData;
            }
            NotificationManager.instance.dispatchEvent(new Event("updateScreenBackground"));
         }
         addView();
      }
      
      private function addView() : void
      {
         if(_cellInfo.view && _parent && _index > -1)
         {
            _cellInfo.view.x = _cellInfo.x * 512;
            _cellInfo.view.y = _cellInfo.y * 512;
            _index = Math.min(_parent.numChildren,_index);
            _parent.addChildAt(_cellInfo.view,_index);
         }
      }
      
      private function removeView() : void
      {
         if(_cellInfo)
         {
            if(_cellInfo.view && _cellInfo.view.parent)
            {
               _cellInfo.view.parent.removeChild(_cellInfo.view);
            }
         }
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__completeHandler);
         removeView();
         _cellInfo = null;
         _isDispose = true;
         _parent = null;
      }
   }
}

