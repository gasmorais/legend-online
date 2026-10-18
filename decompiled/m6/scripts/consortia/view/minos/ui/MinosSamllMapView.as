package consortia.view.minos.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import managers.MinosManager;
   import mvc.module.minos.MinosModel;
   import mvc.module.minos.MinosNodeInfo;
   
   public class MinosSamllMapView extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private const ITEM_SIZE:int = 16;
      
      private var _nodeDic:Dictionary = new Dictionary();
      
      private var _nodeContainer:Sprite;
      
      private var _bdSize1:BitmapData;
      
      private var _bdSize4:BitmapData;
      
      private var _bdCSize1:BitmapData;
      
      private var _bdCSize4:BitmapData;
      
      private var _rect:Bitmap;
      
      public function MinosSamllMapView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:Bitmap = null;
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("asset.minos.smallbg");
         _rect = ComponentFactory.Instance.creatBitmap("asset.minos.small.selectbox");
         addChild(_bg);
         _bdSize1 = ComponentFactory.Instance.creatBitmap("asset.minos.small.type1").bitmapData;
         _bdSize4 = ComponentFactory.Instance.creatBitmap("asset.minos.small.type2").bitmapData;
         _bdCSize1 = ComponentFactory.Instance.creatBitmap("asset.minos.small.select1").bitmapData;
         _bdCSize4 = ComponentFactory.Instance.creatBitmap("asset.minos.small.select2").bitmapData;
         _nodeContainer = new Sprite();
         addChild(_nodeContainer);
         addChild(_rect);
         _nodeContainer.x = 4;
         _nodeContainer.y = 4;
         var _loc5_:int = 10;
         var _loc1_:int = 16;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc6_ = _loc4_ + "_" + _loc3_;
               _loc2_ = new Bitmap();
               _nodeDic[_loc6_] = _loc2_;
               _nodeContainer.addChild(_loc2_);
               _loc2_.x = _loc4_ * 16;
               _loc2_.y = _loc3_ * 16;
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function chooseNode(param1:MinosNodeInfo, param2:Boolean) : void
      {
         var _loc3_:BitmapData = null;
         var _loc5_:String = param1.x + "_" + param1.y;
         var _loc4_:Bitmap = _nodeDic[_loc5_];
         if(_loc4_)
         {
            if(param1.nodeTemp.size == 1)
            {
               if(param2)
               {
                  _loc3_ = _bdCSize1;
                  _loc4_.x = param1.x * 16 - 2;
                  _loc4_.y = param1.y * 16 - 2;
               }
               else
               {
                  _loc3_ = _bdSize1;
                  _loc4_.x = param1.x * 16;
                  _loc4_.y = param1.y * 16;
               }
            }
            else if(param1.nodeTemp.size == 4)
            {
               if(param2)
               {
                  _loc3_ = _bdCSize4;
                  _loc4_.x = param1.x * 16 - 2;
                  _loc4_.y = param1.y * 16 - 2;
               }
               else
               {
                  _loc3_ = _bdSize4;
                  _loc4_.x = param1.x * 16;
                  _loc4_.y = param1.y * 16;
               }
            }
            _loc4_.bitmapData = _loc3_;
         }
      }
      
      public function updateRect(param1:int, param2:int) : void
      {
         var _loc3_:Number = 0.174;
         var _loc4_:Number = 0.174;
         _rect.x = param1 * _loc3_;
         _rect.y = param2 * _loc4_;
      }
      
      private function get model() : MinosModel
      {
         return MinosManager.ins.model;
      }
      
      public function updateView(param1:Array) : void
      {
         var _loc4_:String = null;
         var _loc2_:Bitmap = null;
         var _loc3_:BitmapData = null;
         for each(var _loc5_:MinosNodeInfo in param1)
         {
            _loc4_ = _loc5_.x + "_" + _loc5_.y;
            _loc2_ = _nodeDic[_loc4_];
            if(_loc5_.nodeTemp.size == 1)
            {
               _loc3_ = _bdSize1;
            }
            else if(_loc5_.nodeTemp.size == 4)
            {
               _loc3_ = _bdSize4;
            }
            _loc2_.bitmapData = _loc3_;
            _loc2_.x = _loc5_.x * 16;
            _loc2_.y = _loc5_.y * 16;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bdSize1);
         _bdSize1 = null;
         ObjectUtils.disposeObject(_bdSize4);
         _bdSize4 = null;
         ObjectUtils.disposeObject(_bdCSize1);
         _bdCSize1 = null;
         ObjectUtils.disposeObject(_bdCSize4);
         _bdCSize4 = null;
         ObjectUtils.disposeObject(_rect);
         _rect = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _nodeDic = null;
      }
   }
}

