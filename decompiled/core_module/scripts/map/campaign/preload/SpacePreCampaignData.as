package map.campaign.preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import map.internals.MapData;
   import map.internals.data.MapInfo;
   import yishi.manager.PathManager;
   import yishi.view.community.LoadingSceneView;
   
   public class SpacePreCampaignData extends PreCampaignData
   {
      
      public function SpacePreCampaignData(param1:MapInfo, param2:Boolean = false)
      {
         super(param1,param2);
      }
      
      override protected function loadAvatarCall() : void
      {
         _avatarCount = _avatarCount + 1;
         LoadingSceneView.instance.update(_avatarCount * 1 + 90);
         if(_avatarCount >= _avatarMaxCount)
         {
            loadThunmbnail();
         }
      }
      
      private function loadThunmbnail() : void
      {
         var _loc2_:Loader = new Loader();
         var _loc1_:String = PathManager.getMapBackPaths(_model.mapTempInfo.Id) + "small.jpg";
         "?sdf=" + Math.random();
         var _loc3_:String = LoaderManagerII.instance.getMd5PathByUrl(_loc1_);
         _loc2_.contentLoaderInfo.addEventListener("complete",__loadCompleteHandler);
         _loc2_.contentLoaderInfo.addEventListener("ioError",__ioErrorHandler);
         _loc2_.load(new URLRequest(_loc3_));
      }
      
      private function __loadCompleteHandler(param1:Event) : void
      {
         __ioErrorHandler(param1);
         var _loc2_:Bitmap = param1.currentTarget["content"] as Bitmap;
         _loc2_.width = _model.mapTempInfo.Width;
         _loc2_.height = _model.mapTempInfo.Height;
         MapData.thumbnail = _loc2_;
         backCall();
      }
      
      private function __ioErrorHandler(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("complete",__loadCompleteHandler);
         param1.currentTarget.removeEventListener("ioError",__ioErrorHandler);
      }
   }
}

