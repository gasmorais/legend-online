package map.internals.findPath
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.*;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import mvc.module.home.HomeModel;
   import yishi.utils.WorldBossHelper;
   
   public class FindPath8 implements IFindPath, Disposeable
   {
      
      private var _map:Array;
      
      private var _w:int;
      
      private var _h:int;
      
      private var _open:Array;
      
      private var _starPoint:Object;
      
      private var _endPoint:Object;
      
      protected var _path:Array;
      
      private var _isInit:Boolean = false;
      
      private var _initTimeId:int;
      
      private var _para1:Object;
      
      private var _isVehicle:Boolean;
      
      private var _isFly:Boolean;
      
      private var _isHouse:Boolean;
      
      private var _houseDic:Dictionary;
      
      private var _updateNodes:Array = [];
      
      private var _count:int;
      
      public function FindPath8(param1:int, param2:int, param3:Object, param4:Boolean = false, param5:Boolean = false)
      {
         super();
         this._path = [];
         this._map = [];
         this._w = param1;
         this._h = param2;
         _para1 = param3;
         _isVehicle = param4;
         _isFly = param5;
         _initTimeId = setInterval(initData,500);
      }
      
      public function dispose() : void
      {
         var _loc3_:Object = null;
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(_map)
         {
            _loc5_ = _map.length - 1;
            while(_loc5_ >= 0)
            {
               _loc1_ = _map[_loc5_];
               _loc2_ = int(_loc1_.length);
               _loc4_ = _loc2_ - 1;
               while(_loc4_ >= 0)
               {
                  _loc3_ = _loc1_[_loc4_];
                  ObjectUtils.disposeObject(_loc3_);
                  _loc3_ = null;
                  _loc1_.splice(_loc4_,1);
                  _loc4_--;
               }
               _map.splice(_loc4_,1);
               _map[_loc5_] = null;
               _loc5_--;
            }
         }
         if(_open)
         {
            _loc5_ = _open.length - 1;
            while(_loc5_ >= 0)
            {
               _loc3_ = _open[_loc5_];
               ObjectUtils.disposeObject(_loc3_);
               _open.splice(_loc4_,1);
               _open[_loc5_] = null;
               _loc5_--;
            }
         }
         if(_path)
         {
            _loc5_ = _path.length - 1;
            while(_loc5_ >= 0)
            {
               _loc3_ = _path[_loc5_];
               ObjectUtils.disposeObject(_loc3_);
               _path.splice(_loc4_,1);
               _path[_loc5_] = null;
               _loc5_--;
            }
         }
         if(_houseDic)
         {
            for(var _loc6_:String in _houseDic)
            {
               delete _houseDic[_loc6_];
            }
         }
         if(_initTimeId > 0)
         {
            clearInterval(_initTimeId);
         }
         _initTimeId = 0;
         _path = null;
         _map = null;
         _open = null;
         _starPoint = null;
         _endPoint = null;
         _para1 = null;
      }
      
      public function refreshData(param1:Dictionary) : void
      {
         _isInit = false;
         _isHouse = true;
         _houseDic = param1;
         initData();
      }
      
      private function initData() : void
      {
         if(_initTimeId > 0)
         {
            clearInterval(_initTimeId);
         }
         _initTimeId = 0;
         if(_isInit)
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         _isInit = true;
         if(_isVehicle)
         {
            while(_loc3_ < this._h)
            {
               if(this._map[_loc3_] == undefined)
               {
                  this._map[_loc3_] = [];
               }
               _loc1_ = 0;
               while(_loc1_ < _w)
               {
                  if(_para1[_loc1_ + "_" + _loc3_] && _para1[_loc1_ + "_" + _loc3_] != 2)
                  {
                     _loc2_ = 0;
                  }
                  else
                  {
                     _loc2_ = 1;
                  }
                  _map[_loc3_][_loc1_] = {
                     "x":_loc1_,
                     "y":_loc3_,
                     "value":_loc2_,
                     "block":false,
                     "open":false,
                     "value_g":0,
                     "value_h":0,
                     "value_f":0,
                     "nodeparent":null
                  };
                  _loc1_++;
               }
               _loc3_++;
            }
         }
         else if(_isFly)
         {
            while(_loc3_ < this._h)
            {
               if(this._map[_loc3_] == undefined)
               {
                  this._map[_loc3_] = [];
               }
               _loc1_ = 0;
               while(_loc1_ < _w)
               {
                  _loc2_ = 0;
                  _map[_loc3_][_loc1_] = {
                     "x":_loc1_,
                     "y":_loc3_,
                     "value":_loc2_,
                     "block":false,
                     "open":false,
                     "value_g":0,
                     "value_h":0,
                     "value_f":0,
                     "nodeparent":null
                  };
                  _loc1_++;
               }
               _loc3_++;
            }
         }
         else
         {
            while(_loc3_ < this._h)
            {
               if(this._map[_loc3_] == undefined)
               {
                  this._map[_loc3_] = [];
               }
               _loc1_ = 0;
               while(_loc1_ < _w)
               {
                  if(_isHouse && _houseDic[_loc1_ + "_" + _loc3_])
                  {
                     _loc2_ = _houseDic[_loc1_ + "_" + _loc3_] == 0 ? 0 : 1;
                     _map[_loc3_][_loc1_] = {
                        "x":_loc1_,
                        "y":_loc3_,
                        "value":_loc2_,
                        "block":false,
                        "open":false,
                        "value_g":0,
                        "value_h":0,
                        "value_f":0,
                        "nodeparent":null
                     };
                  }
                  else
                  {
                     _loc2_ = _para1[_loc1_ + "_" + _loc3_] ? 0 : 1;
                     _map[_loc3_][_loc1_] = {
                        "x":_loc1_,
                        "y":_loc3_,
                        "value":_loc2_,
                        "block":false,
                        "open":false,
                        "value_g":0,
                        "value_h":0,
                        "value_f":0,
                        "nodeparent":null
                     };
                  }
                  _loc1_++;
               }
               _loc3_++;
            }
         }
         if(inHome == false && inHouse == false && inSteel == false)
         {
            _para1 = null;
         }
      }
      
      public function canFix(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 > 10 && param1 < _w - 5 && param2 > 30 && param2 < _h - 5 && inHome)
         {
            _loc3_ = param1;
            loop0:
            while(_loc3_ <= param1 + 3)
            {
               _loc4_ = param2;
               while(true)
               {
                  if(_loc4_ > param2 + 1)
                  {
                     _loc3_++;
                     continue loop0;
                  }
                  if(_para1.hasOwnProperty(param1 + "_" + param2) && _para1[param1 + "_" + param2] == 3)
                  {
                     break;
                  }
                  _loc4_++;
               }
               return true;
            }
         }
         return false;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
      
      private function get inSteel() : Boolean
      {
         return WorldBossHelper.checkSteel(CampaignManager.instance.mapId);
      }
      
      private function get homeModel() : HomeModel
      {
         return HomeManager.instance.model;
      }
      
      private function get inUnrealShooting() : Boolean
      {
         return WorldBossHelper.checkUnrealShooting(CampaignManager.instance.mapId);
      }
      
      public function get map() : Array
      {
         return _map;
      }
      
      public function get path() : Array
      {
         return this._path;
      }
      
      public function find(param1:Point, param2:Point) : Array
      {
         if(!_isInit)
         {
            initData();
         }
         var _loc4_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:Object = null;
         this._path = [];
         this._starPoint = this._map[param1.y][param1.x];
         this._endPoint = this._map[param2.y][param2.x];
         if(this._endPoint == null || this._endPoint.value == 1)
         {
            return null;
         }
         if(this._endPoint.x == this._starPoint.x && this._endPoint.y == this._starPoint.y)
         {
            return null;
         }
         var _loc5_:Boolean = false;
         this.initBlock();
         var _loc3_:* = this._starPoint;
         while(!_loc5_)
         {
            _loc3_.block = true;
            _updateNodes.push(_loc3_);
            _loc4_ = [];
            if(_loc3_.y > 0)
            {
               _loc4_.push(this._map[_loc3_.y - 1][_loc3_.x]);
            }
            if(_loc3_.x > 0)
            {
               _loc4_.push(this._map[_loc3_.y][_loc3_.x - 1]);
            }
            if(_loc3_.x < this._w - 1)
            {
               _loc4_.push(this._map[_loc3_.y][_loc3_.x + 1]);
            }
            if(_loc3_.y < this._h - 1)
            {
               _loc4_.push(this._map[_loc3_.y + 1][_loc3_.x]);
            }
            if(_loc3_.y > 0 && _loc3_.x > 0)
            {
               _loc4_.push(this._map[_loc3_.y - 1][_loc3_.x - 1]);
            }
            if(_loc3_.y < this._h - 1 && _loc3_.x > 0)
            {
               _loc4_.push(this._map[_loc3_.y + 1][_loc3_.x - 1]);
            }
            if(_loc3_.y > 0 && _loc3_.x < this._w - 1)
            {
               _loc4_.push(this._map[_loc3_.y - 1][_loc3_.x + 1]);
            }
            if(_loc3_.y < this._h - 1 && _loc3_.x < this._w - 1)
            {
               _loc4_.push(this._map[_loc3_.y + 1][_loc3_.x + 1]);
            }
            _loc7_ = int(_loc4_.length);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc6_ = _loc4_[_loc8_];
               if(_loc6_ == this._endPoint && Math.abs((_loc6_.y - _loc3_.y) / (_loc6_.x - _loc3_.x)) != 1)
               {
                  _loc6_.nodeparent = _loc3_;
                  _updateNodes.push(_loc6_);
                  _loc5_ = true;
                  break;
               }
               if(_loc6_.value == 0)
               {
                  this.count(_loc6_,_loc3_);
               }
               _loc8_++;
            }
            if(!_loc5_)
            {
               if(this._open.length <= 0)
               {
                  return [];
               }
               _loc3_ = this._open.splice(this.getMin(),1)[0];
            }
         }
         this.drawPath();
         return this._path;
      }
      
      public function optimizePath() : Array
      {
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:uint = this._path.length;
         if(_loc1_ == 0)
         {
            return [];
         }
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc3_:Boolean = true;
         var _loc8_:* = this._path[0];
         _loc4_.push(this._path[0]);
         var _loc9_:int = 0;
         var _loc6_:int = 1;
         while(_loc6_ < _loc1_)
         {
            _loc9_++;
            _loc5_ = Diagonal.eachObj(_loc8_,this._path[_loc6_]);
            _loc2_ = int(_loc5_.length);
            _loc3_ = true;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               if(this._map[_loc5_[_loc7_].y][_loc5_[_loc7_].x].value == 1)
               {
                  _loc3_ = false;
                  break;
               }
               _loc7_++;
            }
            if(_loc9_ > 1)
            {
               _loc3_ = false;
            }
            if(!_loc3_)
            {
               if(_loc6_ > 1)
               {
                  _loc8_ = this._path[_loc6_ - 1];
                  _loc4_.push(this._path[_loc6_ - 1]);
                  _loc9_ = 0;
               }
            }
            _loc6_++;
         }
         _loc4_.push(this._path[_loc1_ - 1]);
         return _loc4_;
      }
      
      private function initBlock() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Object = null;
         var _loc2_:int = int(_updateNodes.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _updateNodes.pop();
            this._map[_loc1_.y][_loc1_.x].open = false;
            this._map[_loc1_.y][_loc1_.x].block = false;
            this._map[_loc1_.y][_loc1_.x].value_g = 0;
            this._map[_loc1_.y][_loc1_.x].value_h = 0;
            this._map[_loc1_.y][_loc1_.x].value_f = 0;
            this._map[_loc1_.y][_loc1_.x].nodeparent = null;
            _loc3_++;
         }
         this._open = [];
      }
      
      private function count(param1:Object, param2:Object) : void
      {
         var _loc3_:Number = NaN;
         if(!param1.block)
         {
            _loc3_ = param2.value_g + 10;
            if(Math.abs(param1.x - param2.x) == 1 && Math.abs(param1.y - param2.y) == 1)
            {
               _loc3_ = param2.value_g + 14;
            }
            else
            {
               _loc3_ = param2.value_g + 10;
            }
            if(param1.x > param2.x && param1.y < param2.y)
            {
               if(this._map[param1.y][param1.x - 1].value == 1 && this._map[param1.y + 1][param1.x].value == 1)
               {
                  _loc3_ += 10000;
               }
            }
            else if(param1.x > param2.x && param1.y > param2.y)
            {
               if(this._map[param1.y][param1.x - 1].value == 1 && this._map[param1.y - 1][param1.x].value == 1)
               {
                  _loc3_ += 10000;
               }
            }
            else if(param1.x < param2.x && param1.y > param2.y)
            {
               if(this._map[param1.y][param1.x + 1].value == 1 && this._map[param1.y - 1][param1.x].value == 1)
               {
                  _loc3_ += 10000;
               }
            }
            else if(param1.x < param2.x && param1.y < param2.y)
            {
               if(this._map[param1.y + 1][param1.x].value == 1 && this._map[param1.y][param1.x + 1].value == 1)
               {
                  _loc3_ += 10000;
               }
            }
            if(param1.open)
            {
               if(param1.value_g >= _loc3_)
               {
                  param1.value_g = _loc3_;
                  this.ghf(param1);
                  param1.nodeparent = param2;
               }
            }
            else
            {
               this.addToOpen(param1);
               param1.value_g = _loc3_;
               this.ghf(param1);
               param1.nodeparent = param2;
            }
            _updateNodes.push(param1);
         }
      }
      
      private function drawPath() : void
      {
         _count = 0;
         var _loc1_:* = this._endPoint;
         while(_loc1_ != this._starPoint)
         {
            _count = _count + 1;
            if(_count > 1000)
            {
               _path.splice(0,_path.length);
               break;
            }
            this._path.unshift(new Point(_loc1_.x,_loc1_.y));
            _loc1_ = _loc1_.nodeparent;
         }
         this._path.unshift(new Point(_loc1_.x,_loc1_.y));
      }
      
      private function addToOpen(param1:Object) : void
      {
         this._open.push(param1);
         param1.open = true;
      }
      
      private function ghf(param1:Object) : void
      {
         var _loc2_:Number = Math.abs(param1.x - this._endPoint.x);
         var _loc3_:Number = Math.abs(param1.y - this._endPoint.y);
         param1.value_h = 10 * (_loc2_ + _loc3_);
         param1.value_f = param1.value_g + param1.value_h;
      }
      
      private function getMin() : int
      {
         var _loc1_:uint = this._open.length;
         var _loc3_:Number = 100000;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc3_ > this._open[_loc2_].value_f)
            {
               _loc3_ = Number(this._open[_loc2_].value_f);
               _loc4_ = _loc2_;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      private function find_ex(param1:Object, param2:Object) : void
      {
         var _loc4_:* = param1.x;
         var _loc3_:* = param1.y;
         if(param1.x == param2.x)
         {
            while(_loc3_ != param2.y)
            {
               if(this._map[_loc3_][_loc4_].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               if(param1.y < param2.y)
               {
                  _loc3_++;
               }
               else
               {
                  _loc3_ -= 1;
               }
            }
         }
         else if(param1.y == param2.y)
         {
            while(_loc4_ != param2.x)
            {
               if(this._map[_loc3_][_loc4_].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               if(param1.x < param2.x)
               {
                  _loc4_++;
               }
               else
               {
                  _loc4_ -= 1;
               }
            }
         }
         else if(Math.abs((param1.y - param2.y) / (param1.x - param2.x)) == 1)
         {
            while(_loc4_ != param2.x && _loc3_ != param2.y)
            {
               if(this._map[_loc3_][_loc4_].value == 1 || this._map[_loc3_ - 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ + 1].value == 1 || this._map[_loc3_ + 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ + 1].value == 1 || this._map[_loc3_ - 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ - 1].value == 1 || this._map[_loc3_ + 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ - 1].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               if(param2.x < param1.x && param2.y < param1.y)
               {
                  _loc4_ -= 1;
                  _loc3_ -= 1;
               }
               else if(param2.x < param1.x && param2.y > param1.y)
               {
                  _loc4_ -= 1;
                  _loc3_++;
               }
               else if(param2.x > param1.x && param2.y < param1.y)
               {
                  _loc4_++;
                  _loc3_ -= 1;
               }
               else
               {
                  _loc4_++;
                  _loc3_++;
               }
            }
         }
         else if(param2.x > param1.x && param2.y > param1.y)
         {
            if(param2.y <= param2.x - param1.x + param1.y)
            {
               while(_loc3_ <= param2.y)
               {
                  if(this._map[_loc3_][_loc4_].value == 1 || this._map[_loc3_ + 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ + 1].value == 1)
                  {
                     this._path = [];
                     return;
                  }
                  this._path.push(new Point(_loc4_,_loc3_));
                  _loc4_++;
                  _loc3_++;
               }
               _loc4_ -= 1;
               _loc3_ -= 1;
               while(true)
               {
                  if(_loc4_ <= param2.x)
                  {
                     if(this._map[_loc3_][_loc4_].value == 1)
                     {
                        break;
                     }
                     this._path.push(new Point(_loc4_,_loc3_));
                     _loc4_++;
                     continue;
                  }
               }
               this._path = [];
               return;
            }
            while(_loc4_ <= param2.x)
            {
               if(this._map[_loc3_][_loc4_].value == 1 || this._map[_loc3_ + 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ + 1].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               _loc4_++;
               _loc3_++;
            }
            _loc4_ -= 1;
            _loc3_ -= 1;
            while(_loc3_ <= param2.y)
            {
               if(this._map[_loc3_][_loc4_].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               _loc3_++;
            }
         }
         else if(param2.x > param1.x && param2.y < param1.y)
         {
            if(param2.y <= param1.x + param1.y - param2.x)
            {
               while(_loc4_ <= param2.x)
               {
                  if(this._map[_loc3_][_loc4_].value == 1 || this._map[_loc3_ - 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ + 1].value == 1)
                  {
                     this._path = [];
                     return;
                  }
                  this._path.push(new Point(_loc4_,_loc3_));
                  _loc4_++;
                  _loc3_ -= 1;
               }
               _loc4_ -= 1;
               _loc3_++;
               while(true)
               {
                  if(_loc3_ >= param2.y)
                  {
                     if(this._map[_loc3_][_loc4_].value == 1)
                     {
                        break;
                     }
                     this._path.push(new Point(_loc4_,_loc3_));
                     _loc3_ -= 1;
                     continue;
                  }
               }
               this._path = [];
               return;
            }
            while(_loc3_ >= param2.y)
            {
               if(this._map[_loc3_][_loc4_].value == 1 || this._map[_loc3_ - 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ + 1].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               _loc4_++;
               _loc3_ -= 1;
            }
            _loc4_ -= 1;
            _loc3_++;
            while(_loc4_ <= param2.x)
            {
               if(this._map[_loc3_][_loc4_].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               _loc4_++;
            }
         }
         else if(param2.x < param1.x && param2.y < param1.y)
         {
            if(param2.y >= param2.x - param1.x + param1.y)
            {
               while(_loc3_ >= param2.y)
               {
                  if(this._map[_loc3_][_loc4_].value == 1 || this._map[_loc3_ - 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ - 1].value == 1)
                  {
                     this._path = [];
                     return;
                  }
                  this._path.push(new Point(_loc4_,_loc3_));
                  _loc3_ -= 1;
                  _loc4_ -= 1;
               }
               _loc3_++;
               _loc4_++;
               while(true)
               {
                  if(_loc4_ >= param2.x)
                  {
                     if(this._map[_loc3_][_loc4_].value == 1)
                     {
                        break;
                     }
                     this._path.push(new Point(_loc4_,_loc3_));
                     _loc4_ -= 1;
                     continue;
                  }
               }
               this._path = [];
               return;
            }
            while(_loc4_ >= param2.x)
            {
               if(this._map[_loc3_][_loc4_].value == 1 || this._map[_loc3_ - 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ - 1].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               _loc4_ -= 1;
               _loc3_ -= 1;
            }
            _loc4_++;
            _loc3_++;
            while(_loc3_ >= param2.y)
            {
               if(this._map[_loc3_][_loc4_].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               _loc3_ -= 1;
            }
         }
         else
         {
            if(param2.y >= param1.x + param1.y - param2.x)
            {
               while(_loc4_ >= param2.x)
               {
                  if(this._map[_loc3_][_loc4_].value == 1 || this._map[_loc3_ + 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ - 1].value == 1)
                  {
                     this._path = [];
                     return;
                  }
                  this._path.push(new Point(_loc4_,_loc3_));
                  _loc4_ -= 1;
                  _loc3_++;
               }
               _loc4_++;
               _loc3_ -= 1;
               while(true)
               {
                  if(_loc3_ <= param2.y)
                  {
                     if(this._map[_loc3_][_loc4_].value == 1)
                     {
                        break;
                     }
                     this._path.push(new Point(_loc4_,_loc3_));
                     _loc3_++;
                     continue;
                  }
               }
               this._path = [];
               return;
            }
            while(_loc3_ <= param2.y)
            {
               if(this._map[_loc3_][_loc4_].value == 1 || this._map[_loc3_ + 1][_loc4_].value == 1 && this._map[_loc3_][_loc4_ - 1].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               _loc4_ -= 1;
               _loc3_++;
            }
            _loc4_++;
            _loc3_ -= 1;
            while(_loc4_ >= param2.x)
            {
               if(this._map[_loc3_][_loc4_].value == 1)
               {
                  this._path = [];
                  return;
               }
               this._path.push(new Point(_loc4_,_loc3_));
               _loc4_ -= 1;
            }
         }
      }
   }
}

