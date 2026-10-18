package yishi.scene
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class BaseSceneView extends Sprite
   {
      
      protected var _prepared:Boolean;
      
      public function BaseSceneView()
      {
         super();
      }
      
      public function get sceneView() : DisplayObject
      {
         return null;
      }
      
      public function get prepared() : Boolean
      {
         return _prepared;
      }
      
      public function preLoadingStart(param1:Object = null) : void
      {
         preLoadingOver();
      }
      
      protected function preLoadingOver() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_ENTER_SCENE"));
         SceneManager.instance.preLoadingBack();
      }
      
      public function prepare() : void
      {
         _prepared = true;
      }
      
      public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
      }
      
      public function enterOver() : void
      {
      }
      
      public function leaving() : void
      {
      }
      
      public function onScale() : void
      {
      }
      
      public function addSceneChild(param1:DisplayObject) : DisplayObject
      {
         addChild(param1);
         return param1;
      }
      
      public function get SceneName() : String
      {
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.scene.BaseSceneView.ReWrite");
         throw new Error(_loc1_ + "SceneName()");
      }
      
      public function get backSceneName() : String
      {
         return "CASTLE_SCENE";
      }
   }
}

