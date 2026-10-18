package battle.effect
{
   import battle.BattleManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class TransSceneEffectContext
   {
      
      public static var testType:int = 1;
      
      private var _container:Sprite;
      
      private var _callback:Function;
      
      private var _cellBmd:BitmapData;
      
      private var _cellSize:int;
      
      private var _cells:Array;
      
      private var _row:int;
      
      private var _col:int;
      
      private var _cellsContainer:Sprite;
      
      public function TransSceneEffectContext(param1:Sprite, param2:Function = null)
      {
         super();
         _container = param1;
         _callback = param2;
      }
      
      public function start() : void
      {
         if(!_container)
         {
            completeFun();
            return;
         }
         var _loc1_:ITransSceneEffect = createRandomEffect();
         if(_loc1_)
         {
            _loc1_.start(completeFun);
         }
         else
         {
            completeFun();
         }
      }
      
      private function createRandomEffect() : ITransSceneEffect
      {
         var _loc1_:ITransSceneEffect = null;
         if(!initCells())
         {
            return null;
         }
         var _loc2_:int = Math.ceil(Math.random() * 9);
         switch(_loc2_ - 1)
         {
            case 0:
               _loc1_ = new TransSceneEffect1(_cells,_cellSize);
               break;
            case 1:
               _loc1_ = new TransSceneEffect2(_cells,_row,_col,_cellSize);
               break;
            case 2:
               _loc1_ = new TransSceneEffect2_1(_cells,_row,_col,_cellSize);
               break;
            case 3:
               _loc1_ = new TransSceneEffect2_2(_cells,_row,_col,_cellSize);
               break;
            case 4:
               _loc1_ = new TransSceneEffect2_3(_cells,_row,_col,_cellSize);
               break;
            case 5:
               _loc1_ = new TransSceneEffect2_4(_cells,_row,_col,_cellSize);
               break;
            case 6:
               _loc1_ = new TransSceneEffect2_5(_cells,_row,_col,_cellSize);
               break;
            case 7:
               _loc1_ = new TransSceneEffect2_6(_cells,_row,_col,_cellSize);
               break;
            case 8:
               _loc1_ = new TransSceneEffect2_7(_cells,_row,_col,_cellSize);
               break;
            default:
               _loc1_ = new TransSceneEffect1(_cells,_cellSize);
         }
         return _loc1_;
      }
      
      private function initCells() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Bitmap = null;
         _cellSize = 50;
         _cellBmd = new BitmapData(_cellSize,_cellSize,false,4278190080);
         if(!BattleManager.getInstance().mainViewContainer || !BattleManager.getInstance().mainViewContainer.view)
         {
            completeFun();
            return false;
         }
         var _loc6_:Number = BattleManager.getInstance().mainViewContainer.view.sceneWidth / 1500;
         _loc1_ = (BattleManager.getInstance().mainViewContainer.view.sceneWidth - 1500) * 0.5;
         _loc2_ = (BattleManager.getInstance().mainViewContainer.view.sceneHeight - 900) * 0.5;
         if(_loc1_ > -1)
         {
            _loc1_ = -1;
         }
         if(_loc2_ > -1)
         {
            _loc2_ = -1;
         }
         _row = Math.ceil(910 / _cellSize);
         _col = Math.ceil(1510 / _cellSize);
         _cells = [];
         _cellsContainer = new Sprite();
         _container.addChild(_cellsContainer);
         _cellsContainer.x = BattleManager.getInstance().mainViewContainer.view.x;
         _cellsContainer.y = BattleManager.getInstance().mainViewContainer.view.y;
         while(_loc4_ < _row)
         {
            _loc3_ = 0;
            while(_loc3_ < _col)
            {
               _loc5_ = new Bitmap(_cellBmd);
               _loc5_.x = _loc3_ * _cellSize + _loc1_;
               _loc5_.y = _loc4_ * _cellSize + _loc2_;
               _cellsContainer.addChild(_loc5_);
               _cells.push(_loc5_);
               _loc3_++;
            }
            _loc4_++;
         }
         return true;
      }
      
      private function completeFun() : void
      {
         clean();
         if(_callback != null)
         {
            _callback();
         }
      }
      
      private function clean() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         ObjectUtils.disposeObject(_cellBmd);
         _cellBmd = null;
         if(_cellsContainer)
         {
            if(_cellsContainer.parent)
            {
               _cellsContainer.parent.removeChild(_cellsContainer);
            }
            ObjectUtils.disposeAllChildren(_cellsContainer);
            _cellsContainer = null;
         }
         if(!_cells)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _cells.length)
         {
            _loc1_ = _cells[_loc2_];
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc2_++;
         }
         _cells = [];
      }
   }
}

