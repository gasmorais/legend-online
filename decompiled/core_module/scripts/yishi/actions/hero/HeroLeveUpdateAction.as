package yishi.actions.hero
{
   import com.pickgliss.ui.ComponentFactory;
   import dialog.DialogManager;
   import flash.events.Event;
   import yishi.actions.map.MapBaseAction;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.LevelUpViewII;
   
   public class HeroLeveUpdateAction extends MapBaseAction
   {
      
      private var _count:int;
      
      private var _view:LevelUpViewII;
      
      private var _isVocation:Boolean;
      
      public function HeroLeveUpdateAction(param1:Boolean = false)
      {
         _isVocation = param1;
         level = 3;
         super();
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || PlayerManager.instance.isExistNewbieMask || DialogManager.isExistDialog)
         {
            __closeHandler(null);
            return;
         }
         if(_count == 20)
         {
            CheckUIModuleUtil.instance.tryCall("playerlevelup",showLevelUpCallback);
         }
         else if(_count > 200 && _view && !_view.parent)
         {
            __closeHandler(null);
         }
         else if(_count > 1000)
         {
            __closeHandler(null);
         }
         _count = _count + 1;
      }
      
      private function showLevelUpCallback() : void
      {
         _view = ComponentFactory.Instance.creatCustomObject("core.LevelupViewII",[_isVocation]);
         _view.addEventListener("dispose",__closeHandler);
         _view.show();
         _view.x = _isVocation ? 620 : 485;
         _view.y = 210;
      }
      
      public function get view() : LevelUpViewII
      {
         return _view;
      }
      
      private function __closeHandler(param1:Event) : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         if(_view)
         {
            _view.removeEventListener("dispose",__closeHandler);
            _view = null;
         }
         dispose();
      }
   }
}

