package yishi.actions.hero
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.events.Event;
   import ui.gameroll.HeroFightingUpdateView;
   import yishi.actions.map.MapBaseAction;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.interfaces.IAction;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.CheckUIModuleUtil;
   
   public class HeroFightingUpdateAction extends MapBaseAction
   {
      
      private var _preFight:int;
      
      private var _simpleInfo:SimplePlayerInfo;
      
      private var _process:int;
      
      private var _count:int;
      
      private var _speed:int;
      
      private var _view:HeroFightingUpdateView;
      
      public function HeroFightingUpdateAction(param1:int, param2:SimplePlayerInfo)
      {
         super();
         _preFight = param1;
         _simpleInfo = param2;
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(finished || SceneManager.instance.currentType == "BATTLE_SCENE" || PlayerManager.instance.isExistNewbieMask)
         {
            dispose();
            return;
         }
         if(_preFight > _simpleInfo.fightingCapacity || _count > 130 || _preFight == _simpleInfo.fightingCapacity && _count == 0)
         {
            dispose();
            return;
         }
         if(_count == 0)
         {
            CheckUIModuleUtil.instance.tryCall("fightingup",fightUpCallback);
            _process = _preFight;
         }
         else if(_process < _simpleInfo.fightingCapacity && _view && _view.parent)
         {
            if(_view)
            {
               _view.setNumberView(_process);
            }
         }
         if(_process >= _simpleInfo.fightingCapacity)
         {
            if(_view)
            {
               _view.setNumberView(_simpleInfo.fightingCapacity);
            }
         }
         else
         {
            _process += speed;
         }
         _count = _count + 1;
         _preFight = _simpleInfo.fightingCapacity;
      }
      
      private function get speed() : int
      {
         if(_speed == 0)
         {
            _speed = Math.ceil((_simpleInfo.fightingCapacity - _preFight) / 50);
            _speed = int(String(_speed).replace("0","1"));
         }
         return _speed;
      }
      
      private function fightUpCallback() : void
      {
         if(finished)
         {
            dispose();
            return;
         }
         showView();
      }
      
      private function showView() : void
      {
         _view = ComponentFactory.Instance.creat("core.HeroFightingUpdateView");
         _view.setNumberView(_preFight);
         _view.show();
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         if(!_view)
         {
            return;
         }
         _view.x = (StageReferance.gameStageWidth - _view.width) / 2;
         _view.y = StageReferance.gameStageHeight - 200;
      }
      
      override public function replace(param1:IAction) : Boolean
      {
         if(param1 is HeroFightingUpdateAction)
         {
            return true;
         }
         return false;
      }
      
      override public function cancel() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
         _simpleInfo = null;
      }
   }
}

