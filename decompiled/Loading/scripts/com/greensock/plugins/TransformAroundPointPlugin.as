package com.greensock.plugins
{
   import com.greensock.*;
   import com.greensock.core.*;
   import flash.display.*;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class TransformAroundPointPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      private static var _classInitted:Boolean;
      
      private static var _isFlex:Boolean;
      
      protected var _target:DisplayObject;
      
      protected var _local:Point;
      
      protected var _point:Point;
      
      protected var _shortRotation:ShortRotationPlugin;
      
      protected var _proxy:DisplayObject;
      
      protected var _proxySizeData:Object;
      
      public function TransformAroundPointPlugin()
      {
         super();
         this.propName = "transformAroundPoint";
         this.overwriteProps = ["x","y"];
         this.priority = -1;
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc6_:Matrix = null;
         var _loc7_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc11_:Sprite = null;
         var _loc4_:Sprite = null;
         var _loc12_:* = null;
         var _loc14_:String = null;
         var _loc8_:String = null;
         var _loc13_:Object = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(!(param2.point is Point))
         {
            return false;
         }
         _target = param1 as DisplayObject;
         _point = param2.point.clone();
         _local = _target.globalToLocal(_target.parent.localToGlobal(_point));
         if(!_classInitted)
         {
            try
            {
               _isFlex = Boolean(getDefinitionByName("mx.managers.SystemManager"));
            }
            catch(e:Error)
            {
               _isFlex = false;
            }
            _classInitted = true;
         }
         if((!isNaN(param2.width) || !isNaN(param2.height)) && _target.parent != null)
         {
            _loc6_ = _target.transform.matrix;
            _loc7_ = _target.parent.globalToLocal(_target.localToGlobal(new Point(100,100)));
            _target.width *= 2;
            if(_loc7_.x == _target.parent.globalToLocal(_target.localToGlobal(new Point(100,100))).x)
            {
               _proxy = _target;
               _target.rotation = 0;
               _proxySizeData = {};
               if(!isNaN(param2.width))
               {
                  addTween(_proxySizeData,"width",_target.width / 2,param2.width,"width");
               }
               if(!isNaN(param2.height))
               {
                  addTween(_proxySizeData,"height",_target.height,param2.height,"height");
               }
               _loc5_ = _target.getBounds(_target);
               _loc11_ = new Sprite();
               _loc4_ = _isFlex ? new (getDefinitionByName("mx.core.UIComponent"))() : new Sprite();
               _loc4_.addChild(_loc11_);
               _loc4_.visible = false;
               _proxy.parent.addChild(_loc4_);
               _target = _loc11_;
               _loc11_.graphics.beginFill(255,0.4);
               _loc11_.graphics.drawRect(_loc5_.x,_loc5_.y,_loc5_.width,_loc5_.height);
               _loc11_.graphics.endFill();
               _loc11_.transform.matrix = _target.transform.matrix = _loc6_;
            }
            else
            {
               _target.transform.matrix = _loc6_;
            }
         }
         for(_loc8_ in param2)
         {
            if(_loc8_ != "point")
            {
               if(_loc8_ == "shortRotation")
               {
                  _shortRotation = new ShortRotationPlugin();
                  _shortRotation.onInitTween(_target,param2[_loc8_],param3);
                  addTween(_shortRotation,"changeFactor",0,1,"shortRotation");
                  for(_loc14_ in param2[_loc8_])
                  {
                     this.overwriteProps[this.overwriteProps.length] = _loc14_;
                  }
               }
               else if(_loc8_ == "x" || _loc8_ == "y")
               {
                  addTween(_point,_loc8_,_point[_loc8_],param2[_loc8_],_loc8_);
                  this.overwriteProps[this.overwriteProps.length] = _loc8_;
               }
               else if(_loc8_ == "scale")
               {
                  addTween(_target,"scaleX",_target.scaleX,param2.scale,"scaleX");
                  addTween(_target,"scaleY",_target.scaleY,param2.scale,"scaleY");
                  this.overwriteProps[this.overwriteProps.length] = "scaleX";
                  this.overwriteProps[this.overwriteProps.length] = "scaleY";
               }
               else if(!((_loc8_ == "width" || _loc8_ == "height") && _proxy != null))
               {
                  addTween(_target,_loc8_,_target[_loc8_],param2[_loc8_],_loc8_);
                  this.overwriteProps[this.overwriteProps.length] = _loc8_;
               }
            }
         }
         if(param3 != null)
         {
            _loc13_ = param3.vars;
            if("x" in _loc13_ || "y" in _loc13_)
            {
               if("x" in _loc13_)
               {
                  _loc10_ = Number(typeof _loc13_.x == "number" ? _loc13_.x : _target.x + Number(_loc13_.x));
               }
               if("y" in _loc13_)
               {
                  _loc9_ = Number(typeof _loc13_.y == "number" ? _loc13_.y : _target.y + Number(_loc13_.y));
               }
               param3.killVars({
                  "x":true,
                  "y":true
               },false);
               this.changeFactor = 1;
               if(!isNaN(_loc10_))
               {
                  addTween(_point,"x",_point.x,_point.x + (_loc10_ - _target.x),"x");
               }
               if(!isNaN(_loc9_))
               {
                  addTween(_point,"y",_point.y,_point.y + (_loc9_ - _target.y),"y");
               }
               this.changeFactor = 0;
            }
         }
         return true;
      }
      
      override public function killProps(param1:Object) : void
      {
         if(_shortRotation != null)
         {
            _shortRotation.killProps(param1);
            if(_shortRotation.overwriteProps.length == 0)
            {
               param1.shortRotation = true;
            }
         }
         super.killProps(param1);
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:PropTween = null;
         var _loc3_:Point = null;
         var _loc4_:Number = NaN;
         if(_proxy != null && _proxy.parent != null)
         {
            _proxy.parent.addChild(_target.parent);
         }
         if(_target.parent)
         {
            var _loc8_:int = int(_tweens.length);
            if(this.round)
            {
               while(--_loc8_ > -1)
               {
                  _loc5_ = _tweens[_loc8_];
                  _loc2_ = _loc5_.start + _loc5_.change * param1;
                  _loc5_.target[_loc5_.property] = _loc2_ > 0 ? int(_loc2_ + 0.5) : int(_loc2_ - 0.5);
               }
               _loc3_ = _target.parent.globalToLocal(_target.localToGlobal(_local));
               _loc6_ = _target.x + _point.x - _loc3_.x;
               _loc7_ = _target.y + _point.y - _loc3_.y;
               _target.x = _loc6_ > 0 ? int(_loc6_ + 0.5) : int(_loc6_ - 0.5);
               _target.y = _loc7_ > 0 ? int(_loc7_ + 0.5) : int(_loc7_ - 0.5);
            }
            else
            {
               while(--_loc8_ > -1)
               {
                  _loc5_ = _tweens[_loc8_];
                  _loc5_.target[_loc5_.property] = _loc5_.start + _loc5_.change * param1;
               }
               _loc3_ = _target.parent.globalToLocal(_target.localToGlobal(_local));
               _target.x += _point.x - _loc3_.x;
               _target.y += _point.y - _loc3_.y;
            }
         }
         _changeFactor = param1;
         if(_proxy != null && _proxy.parent != null)
         {
            _loc4_ = _target.rotation;
            _proxy.rotation = _target.rotation = 0;
            if(_proxySizeData.width != undefined)
            {
               _proxy.width = _target.width = _proxySizeData.width;
            }
            if(_proxySizeData.height != undefined)
            {
               _proxy.height = _target.height = _proxySizeData.height;
            }
            _proxy.rotation = _target.rotation = _loc4_;
            _loc3_ = _target.parent.globalToLocal(_target.localToGlobal(_local));
            _loc6_ = _target.x + _point.x - _loc3_.x;
            _loc7_ = _target.y + _point.y - _loc3_.y;
            if(this.round)
            {
               _proxy.x = _loc6_ > 0 ? int(_loc6_ + 0.5) : int(_loc6_ - 0.5);
               _proxy.y = _loc7_ > 0 ? int(_loc7_ + 0.5) : int(_loc7_ - 0.5);
            }
            else
            {
               _proxy.x = _loc6_;
               _proxy.y = _loc7_;
            }
            _proxy.parent.removeChild(_target.parent);
         }
      }
   }
}

