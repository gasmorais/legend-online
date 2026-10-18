package com.speedEngine.components.ui2D
{
   import com.speedEngine.components.ui2D.controls.ComboHead;
   import com.speedEngine.components.ui2D.controls.ComboItem;
   import com.speedEngine.game.Director;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class ComboBox extends TinyUI
   {
      
      private var _stylename:String = "styleCombox";
      
      private var _head:ComboHead;
      
      private var _data:Object;
      
      private var _selectItem:Object;
      
      private var _label:String = "label";
      
      private var _textFormat:TextFormat;
      
      private var _length:int;
      
      private var _itemList:SimpleList;
      
      private var _itemCountMax:int = 10;
      
      private var _itemOut:BitmapData;
      
      private var _itemOver:BitmapData;
      
      private var _isVisibleTextField:Boolean = true;
      
      private var _onChangeCallBack:Function = null;
      
      private var _isFollow:Boolean = false;
      
      private var _itemWidth:int = 100;
      
      private var _itemHeight:int = 25;
      
      private var _itemScaleGridLeft:int = 0;
      
      private var _itemScaleGridRight:int = 0;
      
      private var _itemScaleGridTop:int = 0;
      
      private var _itemScaleGridBottom:int = 0;
      
      private var _scaleGridBottom:int = 0;
      
      private var _scaleGridRight:int = 0;
      
      private var _scaleGridTop:int = 0;
      
      private var _scaleGridLeft:int = 0;
      
      private var _selectIndex:int = 0;
      
      private var _barXmlPath:String;
      
      public function ComboBox()
      {
         super();
         _head = new ComboHead();
         _head.label = "combox";
         _head.addEventListener("click",onClickHead);
         this.addChild(_head);
         _itemList = new SimpleList();
         _itemList.y = 30;
         _itemList.hCount = 1;
         _itemList.vSpace = 1;
         _itemList.visible = false;
         _itemList.addEventListener("click",onDownHead);
         addChild(_itemList);
      }
      
      protected function onDownHead(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      protected function onClickHead(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(_isFollow)
         {
            _itemList.x = param1.localX;
            _itemList.y = param1.localY;
         }
         _itemList.visible = _itemList.visible ? false : true;
         if(_itemList.visible && Director.instance.stage2d)
         {
            Director.instance.stage2d.addEventListener("click",onStageClick);
         }
      }
      
      protected function onStageClick(param1:MouseEvent) : void
      {
         if(Director.instance.stage2d.hasEventListener("click"))
         {
            Director.instance.stage2d.removeEventListener("click",onStageClick);
         }
         _itemList.visible = false;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:ComboItem = null;
         _data = param1;
         for each(var _loc3_:Object in _data)
         {
            _loc2_ = new ComboItem();
            if(_itemOut)
            {
               _loc2_.texture = _itemOut.clone();
               _loc2_.scaleGridBottom = _itemScaleGridBottom;
               _loc2_.scaleGridTop = _itemScaleGridTop;
               _loc2_.scaleGridLeft = _itemScaleGridLeft;
               _loc2_.scaleGridRight = _itemScaleGridRight;
            }
            _loc2_.width = _itemWidth;
            _loc2_.height = _itemHeight;
            if(_itemOver)
            {
               _loc2_.overTexture = _itemOver.clone();
            }
            _loc2_.itemData = _loc3_;
            _loc2_.textFormat = _textFormat;
            if(_loc3_.hasOwnProperty(_label))
            {
               _loc2_.label = _loc3_[_label];
            }
            else
            {
               _loc2_.label = _loc3_.toString();
            }
            _loc2_.addEventListener("change",onClickItemHandle);
            _itemList.addChild(_loc2_);
         }
         if(_itemList.length > 0)
         {
            _selectIndex = 0;
            _selectItem = (_itemList.childs[0] as ComboItem).itemData;
            _head.label = (_itemList.childs[0] as ComboItem).label;
         }
      }
      
      protected function onClickItemHandle(param1:Event) : void
      {
         if(_selectItem != param1.target.itemData)
         {
            _selectItem = param1.target.itemData;
            _head.label = param1.target.label;
            if(_onChangeCallBack != null)
            {
               _onChangeCallBack.call();
            }
         }
         _itemList.visible = false;
      }
      
      public function set scaleGridBottom(param1:int) : void
      {
         _scaleGridBottom = param1;
         _head.scaleGridBottom = param1;
      }
      
      public function get scaleGridBottom() : int
      {
         return _scaleGridBottom;
      }
      
      public function set scaleGridRight(param1:int) : void
      {
         _scaleGridRight = param1;
         _head.scaleGridRight = param1;
      }
      
      public function get scaleGridRight() : int
      {
         return _scaleGridRight;
      }
      
      public function set scaleGridTop(param1:int) : void
      {
         _scaleGridTop = param1;
         _head.scaleGridTop = param1;
      }
      
      public function get scaleGridTop() : int
      {
         return _scaleGridTop;
      }
      
      public function set scaleGridLeft(param1:int) : void
      {
         _scaleGridLeft = param1;
         _head.scaleGridLeft = param1;
      }
      
      public function get scaleGridLeft() : int
      {
         return _scaleGridLeft;
      }
      
      public function set itemScaleGridBottom(param1:int) : void
      {
         _itemScaleGridBottom = param1;
      }
      
      public function get itemScaleGridBottom() : int
      {
         return _itemScaleGridBottom;
      }
      
      public function set itemScaleGridRight(param1:int) : void
      {
         _itemScaleGridRight = param1;
      }
      
      public function get itemScaleGridRight() : int
      {
         return _itemScaleGridRight;
      }
      
      public function set itemScaleGridTop(param1:int) : void
      {
         _itemScaleGridTop = param1;
      }
      
      public function get itemScaleGridTop() : int
      {
         return _itemScaleGridTop;
      }
      
      public function set itemScaleGridLeft(param1:int) : void
      {
         _itemScaleGridLeft = param1;
      }
      
      public function get itemScaleGridLeft() : int
      {
         return _itemScaleGridLeft;
      }
      
      public function get value() : String
      {
         return _head.label;
      }
      
      public function set value(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = int(_itemList.childs.length);
         var _loc3_:* = -1;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(param1 == (_itemList.childs[_loc4_] as ComboItem).label)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         _selectIndex = _loc3_;
         _head.label = param1;
      }
      
      public function get selectIndex() : int
      {
         return _selectIndex;
      }
      
      public function set selectIndex(param1:int) : void
      {
         if(param1 >= _itemList.length || param1 < 0)
         {
            return;
         }
         if(_selectIndex != param1)
         {
            _selectIndex = param1;
            if(_itemList.childs[_selectIndex] is ComboItem)
            {
               _head.label = (_itemList.childs[_selectIndex] as ComboItem).label;
               _selectItem = (_itemList.childs[_selectIndex] as ComboItem).itemData;
            }
         }
      }
      
      public function get selectItem() : Object
      {
         return _selectItem;
      }
      
      override public function render() : void
      {
         var _loc1_:ComboItem = null;
         var _loc2_:int = 0;
         _itemList.showWidth = _head.width;
         _itemList.showHeight = _itemCountMax * _itemHeight;
         _itemList.y = _head.height;
         if(_textFormat)
         {
            _head.textFormat = _textFormat;
            _loc2_ = 0;
            while(_loc2_ < _itemList.length)
            {
               _loc1_ = _itemList.childs[_loc2_];
               _loc1_.textFormat = _textFormat;
               _loc2_++;
            }
         }
         _head.isVisibleTextField = _isVisibleTextField;
      }
      
      public function set texture(param1:BitmapData) : void
      {
         _head.texture = param1;
         _itemList.y = param1.height;
         _itemList.showWidth = _head.width;
         validate(STYLE);
      }
      
      public function get texture() : BitmapData
      {
         return _head.texture;
      }
      
      public function set overTexture(param1:BitmapData) : void
      {
         _head.overTexture = param1;
         validate(STYLE);
      }
      
      public function get overTexture() : BitmapData
      {
         return _head.overTexture;
      }
      
      public function set downTexture(param1:BitmapData) : void
      {
         _head.downTexture = param1;
      }
      
      public function get downTexture() : BitmapData
      {
         return _head.downTexture;
      }
      
      public function set background(param1:BitmapData) : void
      {
         _head.background = param1;
         validate(STYLE);
      }
      
      public function get background() : BitmapData
      {
         return _head.background;
      }
      
      override public function get height() : Number
      {
         return _head.height;
      }
      
      override public function get width() : Number
      {
         return _head.width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(_head.width != param1)
         {
            _head.width = param1;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(_head.height != param1)
         {
            _head.height = param1;
         }
      }
      
      public function set itemTexture(param1:BitmapData) : void
      {
         if(param1)
         {
            _itemOut = param1;
            _itemHeight = param1.height;
            _itemWidth = param1.width;
            pushDisposeBitmap(param1);
            _itemList.showWidth = _itemWidth;
            _itemList.showHeight = _itemCountMax * _itemHeight;
            validate(STYLE);
         }
      }
      
      public function set itemOverTexture(param1:BitmapData) : void
      {
         _itemOver = param1;
         pushDisposeBitmap(param1);
      }
      
      public function set font(param1:String) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.font = param1;
         validate(STYLE);
      }
      
      public function set size(param1:Object) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.size = param1;
         validate(STYLE);
      }
      
      public function set color(param1:Object) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.color = param1;
         validate(STYLE);
      }
      
      public function set bold(param1:Object) : void
      {
         if(!_textFormat)
         {
            _textFormat = new TextFormat();
         }
         _textFormat.bold = param1;
         validate(STYLE);
      }
      
      override public function dispose() : void
      {
         _itemWidth = -1;
         _itemHeight = -1;
         if(_head)
         {
            _head.dispose();
            if(_head.parent == this)
            {
               removeChild(_head);
            }
         }
         if(_itemList)
         {
            _itemList.removeEventListener("click",onDownHead);
            _itemList.dispose();
            if(_itemList.parent == this)
            {
               removeChild(_itemList);
            }
         }
         _head = null;
         _itemList = null;
         _onChangeCallBack = null;
         Director.instance.stage2d.removeEventListener("click",onStageClick);
         super.dispose();
      }
      
      public function get itemCountMax() : int
      {
         return _itemCountMax;
      }
      
      public function set itemCountMax(param1:int) : void
      {
         _itemCountMax = param1;
         validate(STYLE);
      }
      
      public function get isVisibleTextField() : Boolean
      {
         return _isVisibleTextField;
      }
      
      public function set isVisibleTextField(param1:Boolean) : void
      {
         _isVisibleTextField = param1;
         validate(STYLE);
      }
      
      public function get onChangeCallBack() : Function
      {
         return _onChangeCallBack;
      }
      
      public function set onChangeCallBack(param1:Function) : void
      {
         _onChangeCallBack = param1;
      }
      
      public function get isFollow() : Boolean
      {
         return _isFollow;
      }
      
      public function set isFollow(param1:Boolean) : void
      {
         _isFollow = param1;
      }
      
      public function get itemWidth() : int
      {
         return _itemWidth;
      }
      
      public function set itemWidth(param1:int) : void
      {
         if(param1 != -1)
         {
            _itemWidth = param1;
            _itemList.showWidth = _itemWidth;
            _itemList.showHeight = _itemCountMax * _itemHeight;
         }
      }
      
      public function get itemHeight() : int
      {
         return _itemHeight;
      }
      
      public function set itemHeight(param1:int) : void
      {
         if(param1 != -1)
         {
            _itemHeight = param1;
            _itemList.showHeight = _itemCountMax * _itemHeight;
         }
      }
      
      public function get barXmlPath() : String
      {
         return _barXmlPath;
      }
      
      public function set barXmlPath(param1:String) : void
      {
         _barXmlPath = param1;
         _itemList.barViewPath = _barXmlPath;
      }
      
      public function get listBG() : SimpleImage
      {
         return _itemList.bg;
      }
      
      public function set listBG(param1:SimpleImage) : void
      {
         _itemList.bg = param1;
      }
      
      public function get listBackground() : BitmapData
      {
         return _itemList.backGround;
      }
      
      public function set listBackground(param1:BitmapData) : void
      {
         _itemList.backGround = param1;
      }
      
      public function get labelField() : String
      {
         return _label;
      }
      
      public function set labelField(param1:String) : void
      {
         _label = param1;
      }
   }
}

