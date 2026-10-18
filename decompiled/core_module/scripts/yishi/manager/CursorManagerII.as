package yishi.manager
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import managers.HomeManager;
   import mvc.module.home.FurnitureInfo;
   import yishi.utils.StringHelper;
   
   public class CursorManagerII
   {
      
      private static var _instance:CursorManagerII;
      
      public static const DRAG_CURSOR:String = "DRAG_CURSOR";
      
      public static const WATER_CURSOR:String = "WATER_CURSOR";
      
      public static const PICK_CURSOR:String = "PICK_CURSOR";
      
      public static const SPLITE_CURSOR:String = "SPLITE_CURSOR";
      
      public static const SELL_CIRSOR:String = "SELL_CIRSOR";
      
      public static const NO_WALK_CURSOR:String = "NO_WALK_CURSOR";
      
      public static const DEFAULT_CURSOR:String = "DEFAULT_CURSOR";
      
      public static const EMPTY_CURSOR:String = "EMPTY_CURSOR";
      
      public static const COLLECT_CURSOR:String = "COLLECT_CURSOR";
      
      public static const REMOVE_CURSOR_UP:String = "REMOVE_CURSOR_UP";
      
      public static const ATTACK_CURSOR:String = "ATTACK_CURSOR";
      
      public static const PVP_ATTACT_CURSOR:String = "PVP_ATTACT_CURSOR";
      
      public static const REMOVE_CURSOR_DOWN:String = "REMOVE_CURSOR_DOWN";
      
      public static const FARM_PLANT_CURSOR:String = "FARM_PLANT_CURSOR";
      
      public static const FARM_PICK_CURSOR:String = "FARM_PICK_CURSOR";
      
      public static const FARM_WEED_CURSOR:String = "FARM_WEED_CURSOR";
      
      public static const FARM_WORM_CURSOR:String = "FARM_WORM_CURSOR";
      
      public static const FARM_CLEAR_CURSOR:String = "FARM_CLEAR_CURSOR";
      
      public static const FARM_REVIVE_CURSOR:String = "FARM_REVIVE_CURSOR";
      
      public static const FARM_ANIMAL_HUNGER:String = "FARM_ANIMAL_HUNGER";
      
      public static const FARM_ANIMAL_ILL:String = "FARM_ANIMAL_ILL";
      
      public static const FARM_ANIMAL_ANXIET:String = "FARM_ANIMAL_ANXIET";
      
      public static const FARM_ANIMAL_HARVEST:String = "FARM_ANIMAL_HARVEST";
      
      public static const FARM_BONFIRE:String = "FARM_BONFIRE";
      
      public static const FARM_FEED:String = "FARM_FEED";
      
      public static const VEHICLE_SKILL:String = "VEHICLE_SKILL";
      
      public static const SPACE_NPC_CURSOR:String = "SPACE_NPC_CURSOR";
      
      public static const SPACE_PLAYER_CURSOR:String = "SPACE_PLAYER_CURSOR";
      
      public static const VICE_PASSWORD_LOCK:String = "VICE_PASSWORD_LOCK";
      
      private var currentCursor:MovieClip = null;
      
      private var _containter:Sprite;
      
      private var _currentState:String;
      
      private var _cursorDic:Dictionary;
      
      public function CursorManagerII()
      {
         super();
         _cursorDic = new Dictionary();
         _containter = new Sprite();
         _containter.mouseEnabled = false;
         _containter.mouseChildren = false;
         LayerManager.Instance.addToLayer(_containter,0);
         initCursor();
         initEvent();
      }
      
      public static function get instance() : CursorManagerII
      {
         if(!_instance)
         {
            _instance = new CursorManagerII();
         }
         return _instance;
      }
      
      public function hide() : void
      {
         Mouse.hide();
      }
      
      public function show() : void
      {
         Mouse.show();
      }
      
      private function initCursor() : void
      {
         _cursorDic["DRAG_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.DragIconAsset");
         _cursorDic["WATER_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.WaterIconAsset");
         _cursorDic["PICK_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.PickOverIconAsset");
         _cursorDic["COLLECT_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.CollectIconAsset");
         _cursorDic["ATTACK_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.AttackIconAsset");
         _cursorDic["PVP_ATTACT_CURSOR"] = _cursorDic["ATTACK_CURSOR"];
         _cursorDic["NO_WALK_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.NoWalkIconAsset");
         _cursorDic["SELL_CIRSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.SellIconAsset");
         _cursorDic["SPLITE_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.SpliteIconAsset");
         _cursorDic["REMOVE_CURSOR_UP"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.RemoveIconUpAsset");
         _cursorDic["REMOVE_CURSOR_DOWN"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.RemoveIconDownAsset");
         _cursorDic["FARM_CLEAR_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.ClearIconAsset");
         _cursorDic["FARM_PLANT_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.SeedIconAsset");
         _cursorDic["FARM_PICK_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.CollectIconAsset");
         _cursorDic["FARM_REVIVE_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.ReviveIconAsset");
         _cursorDic["FARM_WEED_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.WeedIconAsset");
         _cursorDic["FARM_WORM_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.WormIconAsset");
         _cursorDic["SPACE_NPC_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.SpaceNpcAsset");
         _cursorDic["SPACE_PLAYER_CURSOR"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.SpacePlayerAsset");
         _cursorDic["VICE_PASSWORD_LOCK"] = ComponentFactory.Instance.creatCustomObject("asset.common.vp.mouse");
         _cursorDic["FARM_ANIMAL_HUNGER"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.HungerAsset");
         _cursorDic["FARM_ANIMAL_ILL"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.IllIconAsset");
         _cursorDic["FARM_ANIMAL_ANXIET"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.AnxietIconAsset");
         _cursorDic["FARM_ANIMAL_HARVEST"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.HarvestIconAsset");
         _cursorDic["FARM_BONFIRE"] = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.BonFireIconAsset");
      }
      
      private function initEvent() : void
      {
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
      }
      
      public function resetCursor() : void
      {
         if(currentCursor && currentCursor.parent)
         {
            currentCursor.parent.removeChild(currentCursor);
         }
         currentCursor = null;
         _currentState = "";
         Mouse.show();
         Mouse.cursor = "auto";
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__iconLoadComplete);
      }
      
      public function showFurniture(param1:FurnitureInfo) : void
      {
         if(param1 == null || param1.rotation > 3 || param1.rotation < 1)
         {
            resetCursor();
            return;
         }
         var _loc2_:String = param1.templateInfo["Icon" + param1.rotation];
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            return;
         }
         var _loc3_:Array = _loc2_.split(",");
         if(_loc3_.length != 3)
         {
            return;
         }
         _currentState = PathManager.getFurniturePath(_loc3_[0]);
         if(StringHelper.isNullOrEmpty(_currentState))
         {
            return;
         }
         if(_cursorDic[_currentState])
         {
            showCursorByType(_currentState);
         }
         else
         {
            LoaderManagerII.instance.load(_currentState,2,8,__iconLoadComplete,null,null,_currentState);
         }
      }
      
      protected function __iconLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__iconLoadComplete);
         if(_currentState != param1.args)
         {
            return;
         }
         if(param2 is MovieClip)
         {
            _cursorDic[_currentState] = param2 as MovieClip;
            showCursorByType(_currentState);
         }
      }
      
      public function showCursorByType(param1:String) : void
      {
         resetCursor();
         _currentState = param1;
         var _loc2_:MovieClip = _cursorDic[_currentState] as MovieClip;
         if(_loc2_ == currentCursor)
         {
            return;
         }
         if(currentCursor && currentCursor.parent)
         {
            currentCursor.parent.removeChild(currentCursor);
         }
         if(!_loc2_)
         {
            currentCursor = null;
            Mouse.show();
            Mouse.cursor = "auto";
            return;
         }
         Mouse.hide();
         currentCursor = _loc2_;
         currentCursor.mouseEnabled = false;
         currentCursor.mouseChildren = false;
         _containter.addChild(currentCursor);
         StageReferance.stage.addEventListener("mouseMove",__moveHandler);
         __moveHandler(null);
      }
      
      private function __moveHandler(param1:MouseEvent) : void
      {
         if(HomeManager.instance.model.selectFurn && HomeManager.instance.model.inFixUp)
         {
            _containter.x = HomeManager.instance.model.selectFurn.x;
            _containter.y = HomeManager.instance.model.selectFurn.y;
         }
         else
         {
            _containter.x = StageReferance.stage.mouseX;
            _containter.y = StageReferance.stage.mouseY;
         }
      }
      
      public function get currentState() : String
      {
         return _currentState;
      }
      
      public function registerCursor(param1:String, param2:MovieClip) : void
      {
         _cursorDic[param1] = param2;
      }
      
      public function unregisterCursor(param1:String) : void
      {
         delete _cursorDic[param1];
      }
   }
}

