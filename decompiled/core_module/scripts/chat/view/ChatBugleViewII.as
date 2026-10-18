package chat.view
{
   import chat.ChatManager;
   import chat.datas.ChatData;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectPool;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mainBar.ChatBar;
   import managers.MarryManager;
   import yishi.utils.MsgMan;
   
   public class ChatBugleViewII extends Sprite implements Disposeable, IManualSize
   {
      
      private var _icon1:Bitmap;
      
      private var _text1:ChatNotic;
      
      private var _flower:MutipleImage;
      
      private var _flowerMc:MovieClip;
      
      private var _crossSprite:Sprite;
      
      private var _crossMovie:MovieClip;
      
      private var _icon2:Bitmap;
      
      private var _text2:ChatNotic;
      
      private var _time:Timer;
      
      private var _preTime:Number = 0;
      
      public var mouseEventObject:DisplayObject;
      
      private var _rect:Rectangle;
      
      private var _vScrollPanel1:ScrollPanel;
      
      private var _vScaollPanel2:ScrollPanel;
      
      public function ChatBugleViewII()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,278,80);
         }
         return _rect;
      }
      
      private function initView() : void
      {
         try
         {
            _icon1 = ComponentFactory.Instance.creatBitmap("asset.chatII.BigBugleIcon");
            _vScrollPanel1 = ComponentFactory.Instance.creatComponentByStylename("chatII.panel1");
            _icon1.x = 8;
            _icon1.y = 4;
            _text1 = ObjectPool.getObject(ChatNotic) as ChatNotic;
            _text1.x = 30;
            _text1.y = 2;
            _text1.lineWidth = 278;
            addChild(_icon1);
            addChild(_vScrollPanel1);
            _vScrollPanel1.setView(_text1);
            _vScrollPanel1.vScrollbar.visible = false;
            _rect = new Rectangle(0,0,278,85);
            this.mouseEnabled = false;
         }
         catch(e:Error)
         {
         }
      }
      
      private function initData() : void
      {
         var _loc1_:ChatData = null;
         var _loc2_:ChatData = null;
         if(ChatManager.instance.model.currentBigBugleData)
         {
            _loc1_ = ChatManager.instance.model.currentBigBugleData;
            _preTime = _time.currentCount;
            _text1.data = _loc1_;
            if(_preTime == 0)
            {
               _preTime = 1;
            }
         }
         if(ChatManager.instance.model.currentCrossBugleData)
         {
            _loc2_ = ChatManager.instance.model.currentCrossBugleData;
            _text2.data = _loc2_;
         }
      }
      
      private function initEvent() : void
      {
         _time = new Timer(1000);
         _time.addEventListener("timer",__timeUpdateHandler);
         if(_text1)
         {
            _text1.addEventListener("mouseOver",_mouseOverHandler1);
         }
         _time.start();
         this.addEventListener("click",__s);
      }
      
      private function _mouseOverHandler1(param1:MouseEvent) : void
      {
         if(_vScrollPanel1)
         {
            _vScrollPanel1.vScrollbar.visible = true;
            _vScrollPanel1.invalidateViewport();
         }
      }
      
      private function _mouseOverHandler2(param1:MouseEvent) : void
      {
         if(_vScaollPanel2)
         {
            _vScaollPanel2.vScrollbar.visible = true;
            _vScaollPanel2.invalidateViewport();
         }
      }
      
      private function __s(param1:MouseEvent) : void
      {
      }
      
      private function removeEvent() : void
      {
         if(_time)
         {
            _time.removeEventListener("timer",__timeUpdateHandler);
            _time.stop();
         }
         if(_text1)
         {
            _text1.removeEventListener("mouseOver",_mouseOverHandler1);
         }
         if(_text2)
         {
            _text2.removeEventListener("mouseOver",_mouseOverHandler2);
         }
      }
      
      private function get bigBugleBuffer() : Vector.<ChatData>
      {
         return ChatManager.instance.model.bigBugleList;
      }
      
      private function get crossBugleBuffer() : Vector.<ChatData>
      {
         return ChatManager.instance.model.crossBugleList;
      }
      
      private function isMarryBugleType(param1:int) : Boolean
      {
         return param1 == 6 || param1 == 7 || param1 == 8 || param1 == 9;
      }
      
      private function __timeUpdateHandler(param1:TimerEvent) : void
      {
         var _loc3_:ChatData = null;
         _text1.lineWidth = 278;
         var _loc2_:Number = 0;
         if(bigBugleBuffer.length > 0)
         {
            _vScrollPanel1.vScrollbar.scrollValue = 0;
            if(_preTime == 0)
            {
               _loc3_ = bigBugleBuffer.shift();
               if(_loc3_.bigBugleType != 0 && _loc3_.bigBugleType != 4 && !isMarryBugleType(_loc3_.bigBugleType))
               {
                  return;
               }
               if(ChatBar.inBattleFlag)
               {
                  _loc2_ = 5;
                  _rect.height = 80;
               }
               else if(MarryManager.instance.model.lockScreen)
               {
                  _loc2_ = StageReferance.stageHeight - ChatBar.instance.chatOutPutView.viewRectangle.height - this.viewRectangle.height - 150;
                  _rect.height = 80;
               }
               else
               {
                  _loc2_ = 0;
                  _rect.height = 80;
               }
               if(isMarryBugleType(_loc3_.bigBugleType))
               {
                  if(_flower == null)
                  {
                     _flower = ComponentFactory.Instance.creatComponentByStylename("chatII.flower.Image");
                  }
                  if(!_flower.parent)
                  {
                     addChildAt(_flower,0);
                  }
                  _flower.mouseChildren = _flower.mouseEnabled = false;
                  if(_flowerMc == null)
                  {
                     _flowerMc = ComponentFactory.Instance.creat("asset.chatII.marrySmallBackMc1");
                  }
                  if(!_flowerMc.parent)
                  {
                     addChild(_flowerMc);
                  }
                  _flowerMc.x = 25;
                  _flowerMc.y = -14;
                  _flowerMc.mouseChildren = _flowerMc.mouseEnabled = false;
                  _loc2_ -= 34;
                  _rect.height = 80;
                  _text1.lineWidth = 278;
               }
               else
               {
                  if(_flower && _flower.parent)
                  {
                     _flower.parent.removeChild(_flower);
                  }
                  if(_flowerMc && _flowerMc.parent)
                  {
                     _flowerMc.parent.removeChild(_flowerMc);
                  }
               }
               _preTime = _time.currentCount;
               _text1.data = _loc3_;
               ChatManager.instance.model.currentBigBugleData = _loc3_;
            }
            else if(_time.currentCount - _preTime >= 5)
            {
               _loc3_ = bigBugleBuffer.shift();
               if(_loc3_.bigBugleType != 0 && _loc3_.bigBugleType != 4 && !isMarryBugleType(_loc3_.bigBugleType))
               {
                  return;
               }
               if(ChatBar.inBattleFlag)
               {
                  _loc2_ = 5;
                  _rect.height = 80;
               }
               else if(MarryManager.instance.model.lockScreen)
               {
                  _loc2_ = StageReferance.stageHeight - ChatBar.instance.chatOutPutView.viewRectangle.height - this.viewRectangle.height - 150;
                  _rect.height = 80;
               }
               else
               {
                  _loc2_ = 0;
                  _rect.height = 80;
               }
               if(isMarryBugleType(_loc3_.bigBugleType))
               {
                  if(_flower == null)
                  {
                     _flower = ComponentFactory.Instance.creatComponentByStylename("chatII.flower.Image");
                  }
                  if(!_flower.parent)
                  {
                     addChildAt(_flower,0);
                  }
                  _flower.mouseChildren = _flower.mouseEnabled = false;
                  if(_flowerMc == null)
                  {
                     _flowerMc = ComponentFactory.Instance.creat("asset.chatII.marrySmallBackMc1");
                  }
                  if(!_flowerMc.parent)
                  {
                     addChild(_flowerMc);
                  }
                  _flowerMc.x = 25;
                  _flowerMc.y = -14;
                  _flowerMc.mouseChildren = _flowerMc.mouseEnabled = false;
                  _loc2_ -= 34;
                  _rect.height = 80;
                  _text1.lineWidth = 278;
               }
               else
               {
                  if(_flower && _flower.parent)
                  {
                     _flower.parent.removeChild(_flower);
                  }
                  if(_flowerMc && _flowerMc.parent)
                  {
                     _flowerMc.parent.removeChild(_flowerMc);
                  }
               }
               _preTime = _time.currentCount;
               _text1.data = _loc3_;
               ChatManager.instance.model.currentBigBugleData = _loc3_;
            }
            this.y = _loc2_;
            MsgMan.notifyObserver("yishi.datas.consant.BIG_BUGLE_EVENT");
         }
         if(crossBugleBuffer.length > 0)
         {
            if(_icon2 == null)
            {
               _icon2 = ComponentFactory.Instance.creatBitmap("asset.chatII.CrossBugleIcon1");
               _icon2.x = 8;
               _icon2.y = -75;
               addChild(_icon2);
            }
            if(_text2 == null)
            {
               _text2 = ObjectPool.getObject(ChatNotic) as ChatNotic;
               _text2.x = 30;
               _text2.y = -62;
               _text2.lineWidth = 278;
            }
            if(_vScaollPanel2 == null)
            {
               _vScaollPanel2 = ComponentFactory.Instance.creatComponentByStylename("chatII.panel2");
               addChild(_vScaollPanel2);
               _vScaollPanel2.setView(_text2);
               _vScaollPanel2.vScrollbar.visible = false;
               if(_text2)
               {
                  _text2.addEventListener("mouseOver",_mouseOverHandler2);
               }
            }
            else if(_vScaollPanel2.vScrollbar.visible)
            {
               _vScaollPanel2.vScrollbar.scrollValue = 0;
            }
            if(_crossMovie == null)
            {
               _crossMovie = ComponentFactory.Instance.creat("asset.chatII.CrossRoseMovie");
               _crossMovie.x = 32;
               _crossMovie.y = -88;
               _crossMovie.gotoAndPlay(1);
               addChildAt(_crossMovie,0);
            }
            if(_preTime == 0)
            {
               _loc3_ = crossBugleBuffer.shift();
               _text2.data = _loc3_;
               _preTime = _time.currentCount;
               ChatManager.instance.model.currentCrossBugleData = _loc3_;
            }
            else if(_time.currentCount - _preTime >= 5)
            {
               _loc3_ = crossBugleBuffer.shift();
               _text2.data = _loc3_;
               _preTime = _time.currentCount;
               ChatManager.instance.model.currentCrossBugleData = _loc3_;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _time = null;
         if(_text1)
         {
            if(_text1.parent)
            {
               _text1.parent.removeChild(_text1);
            }
            _text1 = null;
         }
         if(_text2)
         {
            if(_text2.parent)
            {
               _text2.parent.removeChild(_text2);
            }
            _text2 = null;
         }
      }
      
      public function stop() : void
      {
         _time.stop();
      }
      
      public function start() : void
      {
         _time.start();
      }
      
      public function activate() : void
      {
         if(_time && !_time.running)
         {
            _time.start();
         }
         initData();
      }
      
      public function inactive() : void
      {
         if(_time && _time.running)
         {
            _time.stop();
         }
      }
   }
}

