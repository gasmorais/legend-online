package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import yishi.utils.NumberViewUtils;
   
   public class NumberBitmap extends Component
   {
      
      private var _back:DisplayObject;
      
      private var _numBitmap:Bitmap;
      
      private var _numData:BitmapData;
      
      private var _numW:Number;
      
      private var _numH:Number;
      
      private var _numBitX:int;
      
      private var _numEqualWidth:int;
      
      private var _numStr:String = null;
      
      private var _containX:int;
      
      private var _containY:int;
      
      private var _rotain:int;
      
      private var _centerW:int;
      
      private var _currNum:int;
      
      public function NumberBitmap()
      {
         super();
         mouseEnabled = mouseChildren = false;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_numData);
         _numData = null;
         ObjectUtils.disposeObject(_numBitmap);
         _numBitmap = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
      
      public function initParams(param1:String, param2:String, param3:Number, param4:Number, param5:int, param6:int, param7:String, param8:int = 0, param9:int = 0, param10:int = 0, param11:int = 0) : void
      {
         if(param1 != "" && param1 != null)
         {
            _back = ComponentFactory.Instance.creat(param1);
         }
         _numData = ComponentFactory.Instance.creatBitmap(param2).bitmapData;
         _numBitmap = new Bitmap();
         _numW = param3;
         _numH = param4;
         _numBitX = param5;
         _numEqualWidth = param6;
         _numStr = param7;
         _rotain = param10;
         _centerW = param11;
         if(_back != null)
         {
            addChild(_back);
         }
         addChild(_numBitmap);
         _numBitmap.x = param8;
         _numBitmap.y = param9;
         _containX = param8;
         _containY = param9;
      }
      
      public function set num(param1:Number) : void
      {
         if(_numStr == null)
         {
            throw new Error("没有初始化数据，请先调用initParams函数.");
         }
         this.visible = true;
         _currNum = param1;
         NumberViewUtils.refreshBitmap(param1.toString(),_numData,_numW,_numH,_numBitX,_numEqualWidth,_numStr,_numBitmap);
         _numBitmap.rotation = _rotain;
         if(_centerW > 0)
         {
            _numBitmap.x = _containX + (_centerW - _numBitmap.width) * 0.5;
         }
      }
      
      public function get numValue() : int
      {
         return _currNum;
      }
   }
}

