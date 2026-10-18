package yishi.scene
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.TipsBar;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.view.community.LoadingSceneView;
   
   public class EmptyScene extends BaseSceneView
   {
      
      private var _bitmap:Bitmap;
      
      public function EmptyScene()
      {
         super();
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         SceneManager.instance.lockScene = true;
         super.preLoadingStart(param1);
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         var _loc5_:Boolean = LoadingSceneView.instance.parent ? true : false;
         LoadingSceneView.instance.hide();
         var _loc6_:BaseSceneView = SceneManager.instance.currentScene;
         var _loc3_:int = _loc6_.width > 1500 ? 1500 : _loc6_.width;
         var _loc4_:int = _loc6_.height > 900 ? 900 : _loc6_.height;
         _loc3_ = int(_loc3_ <= 0 ? 1500 : _loc3_);
         _loc4_ = int(_loc4_ <= 0 ? 900 : _loc3_);
         _bitmap = new Bitmap(new BitmapData(_loc3_,_loc4_,true,0));
         _bitmap.bitmapData.draw(_loc6_.parent);
         addChild(_bitmap);
         if(_loc5_)
         {
            LoadingSceneView.instance.show();
         }
      }
      
      override public function enterOver() : void
      {
         TopToolsBar.instance;
         MainToolBar.instance.show();
         MainToolBar.instance.mouseChildren = false;
         TipsBar.instance.show();
         FullBar.instance.show();
         ChatBar.instance.show();
         ResourcesBar.instance.show();
      }
      
      override public function leaving() : void
      {
         FullBar.instance.hide();
         MainToolBar.instance.hide();
         MainToolBar.instance.mouseChildren = true;
         TipsBar.instance.hide();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         if(_bitmap)
         {
            if(_bitmap.bitmapData)
            {
               _bitmap.bitmapData.dispose();
            }
            if(_bitmap.parent)
            {
               _bitmap.parent.removeChild(_bitmap);
            }
         }
         _bitmap = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         SceneManager.instance.lockScene = false;
      }
      
      override public function get SceneName() : String
      {
         return "EMPTY_SCENE";
      }
   }
}

