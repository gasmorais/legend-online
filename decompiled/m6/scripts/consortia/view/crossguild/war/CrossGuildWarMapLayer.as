package consortia.view.crossguild.war
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import yishi.manager.PathManager;
   
   public class CrossGuildWarMapLayer extends Component
   {
      
      private static const CELL_SIZE:int = 300;
      
      private var mapContiner:Component;
      
      private var mapWidth:int;
      
      private var mapHeight:int;
      
      private var row:int;
      
      private var col:int;
      
      private var centerX:int;
      
      private var centerY:int;
      
      public function CrossGuildWarMapLayer(param1:int, param2:int)
      {
         super();
         mapWidth = param1;
         mapHeight = param2;
         initView();
         loadTitleMap();
      }
      
      private function initView() : void
      {
         col = Math.ceil(mapWidth / 300);
         row = Math.ceil(mapHeight / 300);
         centerX = Math.ceil(StageReferance.stageWidth / 2 / 300);
         centerY = Math.ceil(StageReferance.stageHeight / 2 / 300);
         mapContiner = new Component();
         addChild(mapContiner);
      }
      
      private function loadTitleMap() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < col)
         {
            _loc4_ = 0;
            while(_loc4_ < row)
            {
               loadTitle(_loc2_ + "_" + _loc4_,_loc3_);
               _loc4_++;
            }
            _loc2_++;
         }
         var _loc1_:int = int(_loc3_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc5_ = _loc3_[_loc2_];
            _loc6_ = PathManager.getCrossGuildMapPath() + "tile_" + _loc5_ + ".jpg";
            LoaderManagerII.instance.load(_loc6_,2,9,tileLoadComplete,null,null,_loc5_);
            _loc2_++;
         }
      }
      
      private function loadTitle(param1:String, param2:Array) : void
      {
         if(param2.indexOf(param1) == -1)
         {
            param2.push(param1);
         }
      }
      
      private function tileLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:String = param1.args as String;
         var _loc3_:Bitmap = param2 as Bitmap;
         var _loc4_:Array = _loc5_.split("_");
         _loc3_.x = int(_loc4_[0]) * 300;
         _loc3_.y = int(_loc4_[1]) * 300;
         mapContiner.addChild(_loc3_);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(mapContiner);
         mapContiner = null;
         super.dispose();
      }
   }
}

