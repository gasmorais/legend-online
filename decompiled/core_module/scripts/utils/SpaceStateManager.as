package utils
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.text.TextField;
   
   public class SpaceStateManager
   {
      
      private static var _instance:SpaceStateManager;
      
      private var _renderStateField:TextField;
      
      private var _syncStateField:TextField;
      
      public function SpaceStateManager()
      {
         super();
         _renderStateField = new TextField();
         _renderStateField.x = 50;
         _renderStateField.y = 300;
         _renderStateField.width = 200;
         _renderStateField.selectable = false;
         _renderStateField.mouseEnabled = false;
         _syncStateField = new TextField();
         _syncStateField.x = 50;
         _syncStateField.y = 400;
         _syncStateField.width = 200;
         _syncStateField.selectable = false;
         _syncStateField.mouseEnabled = false;
      }
      
      public static function get instance() : SpaceStateManager
      {
         if(!_instance)
         {
            _instance = new SpaceStateManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         StageReferance.stage.addChild(_renderStateField);
         StageReferance.stage.addChild(_syncStateField);
      }
      
      public function unload() : void
      {
         if(_renderStateField.parent == StageReferance.stage)
         {
            StageReferance.stage.removeChild(_renderStateField);
         }
         if(_syncStateField.parent == StageReferance.stage)
         {
            StageReferance.stage.removeChild(_syncStateField);
         }
      }
      
      public function setRenderState(param1:String) : void
      {
         _renderStateField.htmlText = param1;
      }
      
      public function setSyncState(param1:String) : void
      {
         _syncStateField.htmlText = param1;
      }
   }
}

