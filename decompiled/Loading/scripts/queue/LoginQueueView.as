package queue
{
   import asset.queue.QueueAsset;
   import asset.queue.QueueNumberAsset;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import utils.CopyBitmapDataUtils;
   
   public class LoginQueueView extends Sprite
   {
      
      private var _queueView:QueueAsset;
      
      private var _stage:Stage;
      
      private var _numberAsset:QueueNumberAsset;
      
      private var _copy:CopyBitmapDataUtils;
      
      public function LoginQueueView(param1:Stage)
      {
         super();
         _stage = param1;
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _copy = new CopyBitmapDataUtils();
         _numberAsset = new QueueNumberAsset();
         _queueView = new QueueAsset();
         addChild(_queueView);
         _stage.addChild(this);
         __resizeHandler(null);
      }
      
      private function addEvent() : void
      {
         _stage.addEventListener("resize",__resizeHandler);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _queueView.x = _stage.stageWidth - _queueView.width >> 1;
         _queueView.y = _stage.stageHeight - _queueView.height >> 1;
      }
      
      public function update(param1:Number, param2:int, param3:int) : void
      {
         _queueView.countTxt.text = "" + String(param3);
         if(param1 == -2)
         {
            _queueView.timeTxt.text = "正在估算中";
         }
         else
         {
            _queueView.timeTxt.text = "" + String(param1) + "  分钟";
         }
         _copy.getNumberView(param2,_queueView.numberPos,_numberAsset,20,22,15,20);
      }
      
      public function dispose() : void
      {
         if(_stage)
         {
            _stage.removeEventListener("resize",__resizeHandler);
         }
         _stage = null;
         if(_queueView)
         {
            _queueView.stop();
            if(_queueView.parent)
            {
               _queueView.parent.removeChild(_queueView);
            }
            _queueView = null;
         }
         _copy = null;
         if(_numberAsset)
         {
            _numberAsset.dispose();
         }
         _numberAsset = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

