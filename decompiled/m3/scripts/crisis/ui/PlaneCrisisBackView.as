package crisis.ui
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import mvc.module.crisis.PlaneCrisisArmy;
   import mvc.module.crisis.PlaneCrisisModel;
   import yishi.datas.templates.PlaneCrisisTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.TempleteManager;
   
   public class PlaneCrisisBackView extends Sprite
   {
      
      private var _bg:Sprite;
      
      private var _mapBit:Bitmap;
      
      public function PlaneCrisisBackView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = new Sprite();
         _bg.graphics.beginFill(0);
         _bg.graphics.drawRect(0,0,model.width,model.height);
         _bg.graphics.endFill();
         _mapBit = new Bitmap();
         _mapBit.x = 305;
         _mapBit.y = 90;
         addChild(_bg);
         addChild(_mapBit);
         loadMapImg();
         loadTitleMap();
      }
      
      private function get model() : PlaneCrisisModel
      {
         return PlaneCrisisManager.Instance.model;
      }
      
      private function loadMapImg() : void
      {
         var _loc1_:String = PathManager.getPlaneCrisisBigMap(model.currMapId);
         LoaderManagerII.instance.load(_loc1_,2,0,onLoadComplete);
      }
      
      private function onLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:BitmapData = null;
         if(param2)
         {
            ObjectUtils.disposeObject(_mapBit.bitmapData);
            _loc3_ = (param2 as Bitmap).bitmapData;
            _mapBit.bitmapData = _loc3_;
         }
      }
      
      private function loadTitleMap() : void
      {
         var _loc19_:String = null;
         var _loc20_:Boolean = false;
         var _loc15_:int = 0;
         var _loc11_:String = null;
         var _loc1_:int = Math.ceil(model.width / 300);
         var _loc18_:int = Math.ceil(model.height / 300);
         var _loc10_:PlaneCrisisArmy = model.selfArmy;
         var _loc6_:PlaneCrisisTempInfo = TempleteManager.instance.planeCrisisTempCate.getNodeTempInfo(model.currMapId,_loc10_.standNodeId);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc5_:int = Math.ceil(_loc6_.X / 300);
         var _loc2_:int = Math.ceil(_loc6_.Y / 300);
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = _loc5_;
         var _loc12_:int = _loc5_;
         var _loc14_:int = _loc2_;
         var _loc3_:int = _loc2_;
         var _loc17_:Array = [];
         var _loc13_:int = _loc18_ * _loc1_;
         var _loc4_:int = Math.max(_loc1_,_loc18_);
         do
         {
            if(_loc12_ < _loc1_ && _loc3_ < _loc18_)
            {
               _loc8_ = _loc2_;
               while(_loc8_ <= _loc3_)
               {
                  _loc19_ = _loc12_ + "_" + _loc8_;
                  loadTitle(_loc19_,_loc17_);
                  _loc8_++;
               }
               _loc7_ = _loc12_;
               while(_loc7_ >= _loc5_)
               {
                  _loc19_ = _loc7_ + "_" + _loc3_;
                  loadTitle(_loc19_,_loc17_);
                  _loc7_--;
               }
            }
            if(_loc9_ >= 0 && _loc3_ < _loc18_)
            {
               if(--_loc9_ < 0)
               {
                  _loc9_ = 0;
               }
               _loc7_ = _loc5_;
               while(_loc7_ >= _loc9_)
               {
                  _loc19_ = _loc7_ + "_" + _loc3_;
                  loadTitle(_loc19_,_loc17_);
                  _loc7_--;
               }
               _loc8_ = _loc3_;
               while(_loc8_ >= _loc2_)
               {
                  _loc19_ = _loc9_ + "_" + _loc8_;
                  loadTitle(_loc19_,_loc17_);
                  _loc8_--;
               }
            }
            if(_loc14_ >= 0 && _loc9_ >= 0)
            {
               if(--_loc14_ < 0)
               {
                  _loc14_ = 0;
               }
               _loc8_ = _loc2_;
               while(_loc8_ >= _loc14_)
               {
                  _loc19_ = _loc9_ + "_" + _loc8_;
                  loadTitle(_loc19_,_loc17_);
                  _loc8_--;
               }
               _loc7_ = _loc9_;
               while(_loc7_ <= _loc5_)
               {
                  _loc19_ = _loc7_ + "_" + _loc14_;
                  loadTitle(_loc19_,_loc17_);
                  _loc7_++;
               }
            }
            if(_loc14_ >= 0 && _loc12_ < _loc1_)
            {
               _loc7_ = _loc5_;
               while(_loc7_ <= _loc12_)
               {
                  _loc19_ = _loc7_ + "_" + _loc14_;
                  loadTitle(_loc19_,_loc17_);
                  _loc7_++;
               }
               _loc8_ = _loc14_;
               while(_loc8_ <= _loc2_)
               {
                  _loc19_ = _loc12_ + "_" + _loc8_;
                  loadTitle(_loc19_,_loc17_);
                  _loc8_++;
               }
            }
            if(_loc12_ < _loc1_ - 1)
            {
               _loc12_++;
            }
            if(_loc3_ < _loc18_ - 1)
            {
               _loc3_++;
            }
            if(_loc17_.length >= _loc13_)
            {
               break;
            }
         }
         while(++_loc15_ < _loc4_);
         var _loc16_:Array = _loc17_.reverse();
         _loc13_ = int(_loc16_.length);
         _loc7_ = 0;
         while(_loc7_ < _loc13_)
         {
            _loc19_ = _loc16_[_loc7_];
            _loc11_ = PathManager.getPlaneCrisisBackPath() + "tile_" + _loc19_ + ".jpg";
            LoaderManagerII.instance.load(_loc11_,2,9,tileLoadComplete,null,null,_loc19_);
            _loc7_++;
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
         _bg.addChild(_loc3_);
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadComplete);
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(tileLoadComplete);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_mapBit);
         _mapBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

