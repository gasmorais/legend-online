package vehicle.room.view
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PathManager;
   
   public class VehicleShowAvatar extends ShowAvatar
   {
      
      private var _data:ThaneInfo;
      
      private var _figure:Bitmap;
      
      private var _gapTop:int = 0;
      
      private var _callBack:Function;
      
      public function VehicleShowAvatar(param1:Boolean = false, param2:Function = null)
      {
         super();
         _callBack = param2;
      }
      
      override public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         clear();
         if(!_data)
         {
            return;
         }
         var _loc2_:int = int(param1.vehicleTempId);
         var _loc3_:String = PathManager.getVehicleShowAvatarPath(param1.vehicleTemplate.Avatar);
         LoaderManagerII.instance.load(_loc3_,2,8,__onCompleteHandler);
      }
      
      private function __onCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Rectangle = null;
         if(!_data)
         {
            return;
         }
         if(_figure && _figure.bitmapData)
         {
            _figure.bitmapData.dispose();
         }
         _figure = param2 as Bitmap;
         if(_figure && _figure.bitmapData)
         {
            addChild(_figure);
            _figure.x = -(_figure.width >> 1);
            _figure.y = -(_figure.height - 70);
            _loc3_ = _figure.bitmapData.getColorBoundsRect(4294967295,0,false);
            _gapTop = _loc3_.y;
         }
         if(_callBack != null)
         {
            _callBack();
         }
      }
      
      public function getPosDown() : Point
      {
         var _loc1_:Point = new Point(0,-150);
         if(_figure)
         {
            _loc1_.y = _figure.y + _gapTop - 5;
         }
         return _loc1_;
      }
      
      public function clear() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onCompleteHandler);
         if(_figure)
         {
            if(_figure.parent)
            {
               _figure.parent.removeChild(_figure);
            }
            if(_figure.bitmapData)
            {
               _figure.bitmapData.dispose();
            }
         }
         _figure = null;
      }
      
      override public function dispose() : void
      {
         clear();
         _callBack = null;
         _data = null;
      }
   }
}

