package gemmaze.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import mvc.module.gemmaze.GemMazeModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GemMazeManager;
   import yishi.view.community.BaseItemView;
   
   public class GemMazeIntergalBoxView extends BaseItemView implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _getedBitmap:Bitmap;
      
      private var _boxIndex:int;
      
      private var _light:MovieClip;
      
      private var SORT_INDEX_ARRAY:Array = [];
      
      public function GemMazeIntergalBoxView()
      {
         super();
         initView();
      }
      
      public function get boxIndex() : int
      {
         return _boxIndex;
      }
      
      public function set boxIndex(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         _boxIndex = param1;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = GemMazeManager.Instance.model.boxTempleteIdArr[param1 - 1];
         var _loc7_:int = int(model.scoreArr[_boxIndex - 1]);
         var _loc6_:Array = GemMazeManager.Instance.model.dropDict[_loc7_] as Array;
         if(_loc6_ && _loc6_.length > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("gemMaze.OpenToGet");
            _loc4_ = 0;
            while(_loc4_ < _loc6_.length)
            {
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _loc6_[_loc4_].tempId;
               _loc5_.count = _loc6_[_loc4_].count;
               _loc2_ += _loc5_.templateInfo.TemplateName + "*" + _loc5_.count + ",";
               _loc4_++;
            }
            _loc3_.templateInfo.Description = _loc2_.substr(0,_loc2_.length - 1);
         }
         this.data = _loc3_;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.IntergalBoxBg");
         _getedBitmap = ComponentFactory.Instance.creatBitmap("asset.GemMaze.IntergalBoxGeted");
         _light = ComponentFactory.Instance.creatCustomObject("GemMaze.GemBoxLight");
         _light.effect_01.stop();
         _light.mouseChildren = _light.mouseEnabled = false;
         addChild(_bg);
      }
      
      public function removeCanGet() : void
      {
         if(this.contains(_light))
         {
            removeChild(_light);
            _light.effect_01.stop();
         }
      }
      
      public function setCanGet() : void
      {
         addChild(_light);
         _light.effect_01.play();
      }
      
      public function setGetStatus() : void
      {
         addChild(_getedBitmap);
         if(this.contains(_light))
         {
            removeChild(_light);
            _light.effect_01.stop();
         }
      }
      
      public function removeGetStatus() : void
      {
         if(this.contains(_getedBitmap))
         {
            removeChild(_getedBitmap);
         }
      }
      
      public function get model() : GemMazeModel
      {
         return GemMazeManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_getedBitmap);
         _getedBitmap = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

