package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class StarGroupView extends Component
   {
      
      private var _greyStarStyle:String;
      
      private var _brightStarStyle:String;
      
      private var _greyList:Vector.<DisplayObject>;
      
      private var _brightList:Vector.<DisplayObject>;
      
      private var _greySpace:Number;
      
      private var _brightSpace:Number;
      
      private var _maxStar:int;
      
      private var _currStar:int;
      
      private var _overStar:int;
      
      private var _centerW:int;
      
      private var _rollOverCall:Function;
      
      private var _rollOutCall:Function;
      
      private var _xPos:Number = 0;
      
      private var _yPos:Number = 0;
      
      public function StarGroupView()
      {
         super();
         _greyList = new Vector.<DisplayObject>();
         _brightList = new Vector.<DisplayObject>();
         mouseEnabled = mouseChildren = false;
      }
      
      public function beforeInitParam(param1:Function, param2:Function) : void
      {
         _rollOverCall = param1;
         _rollOutCall = param2;
         buttonMode = mouseEnabled = mouseChildren = true;
      }
      
      public function initParams(param1:String, param2:Number, param3:String, param4:Number, param5:int, param6:int = 0) : void
      {
         var _loc7_:DisplayObject = null;
         var _loc9_:Sprite = null;
         var _loc8_:int = 0;
         _greyStarStyle = param1;
         _brightStarStyle = param3;
         _maxStar = param5;
         _greySpace = param2;
         _brightSpace = param4;
         _centerW = param6;
         if(_greyStarStyle != "" && _greyStarStyle != null)
         {
            _loc8_ = 0;
            while(_loc8_ < param5)
            {
               _loc7_ = ComponentFactory.Instance.creat(_greyStarStyle);
               _loc7_.x = _loc8_ * param2;
               if(_rollOverCall != null)
               {
                  _loc9_ = new Sprite();
                  _loc9_.addChild(_loc7_);
                  _loc9_.addEventListener("rollOver",overHandler);
                  _loc9_.addEventListener("rollOut",outHandler);
                  _greyList.push(_loc9_);
                  addChild(_loc9_);
               }
               else
               {
                  _greyList.push(_loc7_);
                  addChild(_loc7_);
               }
               _loc8_++;
            }
         }
         if(_centerW > 0)
         {
            this.x = (_centerW - this.width) / 2;
         }
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         _overStar = _greyList.indexOf(param1.currentTarget);
         setStars(_overStar + 1,false);
         if(_rollOverCall != null)
         {
            _rollOverCall();
         }
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         setStars(_currStar,false);
         if(_rollOutCall != null)
         {
            _rollOutCall();
         }
      }
      
      public function get currStar() : int
      {
         return _currStar;
      }
      
      public function get overStar() : int
      {
         return _overStar;
      }
      
      public function initLightPostion(param1:Number, param2:Number) : void
      {
         _xPos = param1;
         _yPos = param2;
      }
      
      public function setStars(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc3_:int = 0;
         disposeList(_brightList);
         if(param1 > _maxStar)
         {
            param1 = _maxStar;
         }
         if(param2)
         {
            _currStar = param1;
         }
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = ComponentFactory.Instance.creat(_brightStarStyle);
            _loc4_.x = _loc3_ * _brightSpace + _xPos;
            _loc4_.y = _yPos;
            _brightList.push(_loc4_);
            addChild(_loc4_);
            _loc3_++;
         }
         if(_centerW > 0)
         {
            this.x = (_centerW - this.width) / 2;
         }
      }
      
      private function disposeList(param1:Vector.<DisplayObject>) : void
      {
         if(param1)
         {
            for each(var _loc2_:DisplayObject in param1)
            {
               if(_loc2_ && _loc2_.hasEventListener("rollOut"))
               {
                  _loc2_.removeEventListener("rollOut",outHandler);
               }
               if(_loc2_ && _loc2_.hasEventListener("rollOver"))
               {
                  _loc2_.removeEventListener("rollOver",overHandler);
               }
               ObjectUtils.disposeObject(_loc2_);
            }
            param1.length = 0;
         }
      }
      
      override public function dispose() : void
      {
         disposeList(_greyList);
         _greyList = null;
         disposeList(_brightList);
         _brightList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _rollOverCall = null;
         _rollOutCall = null;
         super.dispose();
      }
   }
}

