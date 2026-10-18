package yishi.manager
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.UISpriteLayer;
   import flash.display.Sprite;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.campaign.CampaignManager;
   import yishi.events.NotificationEvent;
   import yishi.utils.WorldBossHelper;
   
   public class GameUiManager
   {
      
      private static var _instance:GameUiManager;
      
      private var _uiLayer:UISpriteLayer;
      
      private var _upContainer:Sprite;
      
      private var _rightContainer:Sprite;
      
      private var _downContainer:Sprite;
      
      private var _leftContainer:Sprite;
      
      private var _isUpdate:Boolean;
      
      private var _resetTimeId:int;
      
      public function GameUiManager()
      {
         super();
      }
      
      public static function get instance() : GameUiManager
      {
         if(!_instance)
         {
            _instance = new GameUiManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         NotificationManager.instance.addEventListener("UI_OUT_SCENE",__uiOutSceneHandler);
         NotificationManager.instance.addEventListener("UI_ENTER_SCENE",__uiEnterSceneHandler);
         _uiLayer = LayerManager.Instance.getLayerByType(4) as UISpriteLayer;
         _upContainer = _uiLayer.getContainerByType(0);
         _rightContainer = _uiLayer.getContainerByType(1);
         _downContainer = _uiLayer.getContainerByType(2);
         _leftContainer = _uiLayer.getContainerByType(3);
      }
      
      private function __uiOutSceneHandler(param1:NotificationEvent) : void
      {
         _isUpdate = true;
         TweenLite.to(_upContainer,1,{
            "y":-_upContainer.height,
            "alpha":0
         });
         TweenLite.to(_rightContainer,1,{
            "x":_rightContainer.width,
            "alpha":0
         });
         TweenLite.to(_downContainer,1,{
            "y":_downContainer.height,
            "alpha":0
         });
         TweenLite.to(_leftContainer,1,{
            "x":-_leftContainer.width,
            "alpha":0
         });
      }
      
      private function __uiEnterSceneHandler(param1:NotificationEvent) : void
      {
         if(WorldBossHelper.checkIsNoviceMap(CampaignManager.instance.mapId))
         {
            return;
         }
         TweenLite.killTweensOf(_upContainer);
         TweenLite.killTweensOf(_rightContainer);
         TweenLite.killTweensOf(_downContainer);
         TweenLite.killTweensOf(_leftContainer);
         if(_isUpdate)
         {
            _isUpdate = false;
            TweenLite.to(_upContainer,1,{
               "y":0,
               "alpha":1
            });
            TweenLite.to(_rightContainer,1,{
               "x":0,
               "alpha":1
            });
            TweenLite.to(_downContainer,1,{
               "y":0,
               "alpha":1
            });
            TweenLite.to(_leftContainer,1,{
               "x":0,
               "alpha":1
            });
            if(_resetTimeId > 0)
            {
               clearInterval(_resetTimeId);
            }
            _resetTimeId = 0;
            _resetTimeId = setInterval(resetUiCall,1000);
         }
      }
      
      private function resetUiCall() : void
      {
         if(_resetTimeId > 0)
         {
            clearInterval(_resetTimeId);
         }
         _resetTimeId = 0;
         if(_isUpdate)
         {
            return;
         }
         _upContainer.y = 0;
         _rightContainer.x = 0;
         _downContainer.y = 0;
         _leftContainer.x = 0;
         _upContainer.alpha = 1;
         _rightContainer.alpha = 1;
         _downContainer.alpha = 1;
         _leftContainer.alpha = 1;
      }
   }
}

