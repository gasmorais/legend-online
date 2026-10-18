package gemmaze.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GemMazeManager;
   import yishi.utils.NumberViewUtils;
   
   public class GemMazeInvideMaskFrame extends Frame
   {
      
      private static const TIME_ID:String = "gemMaze.view.GemMazeInvideMaskFrame";
      
      private var bgLeft:Bitmap;
      
      private var bgRight:Bitmap;
      
      private var invideingTxtImg:Bitmap;
      
      private var _cdContent:Sprite;
      
      private var _cdNumBitmapData:BitmapData;
      
      private var CD_TIME:uint = 10;
      
      private var _timer:Timer;
      
      public function GemMazeInvideMaskFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         bgLeft = ComponentFactory.Instance.creatBitmap("asset.GemMaze.BlueBg");
         bgRight = ComponentFactory.Instance.creatBitmap("asset.GemMaze.BlueBg");
         bgRight.scaleX = -1;
         bgRight.x = 410;
         invideingTxtImg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.InvideingTxtImg");
         addToContent(bgLeft);
         addToContent(bgRight);
         addToContent(invideingTxtImg);
         _cdContent = new Sprite();
         _cdContent.x = 175;
         _cdContent.y = 70;
         addToContent(_cdContent);
         _cdNumBitmapData = ComponentFactory.Instance.creatBitmapData("asset.GemMaze.BuyTimesNum").clone();
         NumberViewUtils.refreshValue(CD_TIME,_cdContent,_cdNumBitmapData,30,39,36,30,"0123456789");
         _timer = new Timer(1000,11);
         _timer.addEventListener("timer",__onCDHandler);
         _timer.addEventListener("timerComplete",__completeCDHandler);
         _timer.start();
      }
      
      private function __onCDHandler(param1:TimerEvent) : void
      {
         CD_TIME -= 1;
         NumberViewUtils.refreshValue(CD_TIME,_cdContent,_cdNumBitmapData,30,39,36,30,"0123456789");
      }
      
      private function __completeCDHandler(param1:TimerEvent) : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__onCDHandler);
            _timer.removeEventListener("timerComplete",__completeCDHandler);
            _timer.stop();
            _timer = null;
         }
         GemMazeManager.Instance.model.canMoveGemByUser = true;
         dispose();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,365,175);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__onCDHandler);
            _timer.removeEventListener("timerComplete",__completeCDHandler);
            _timer.stop();
            _timer = null;
         }
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

