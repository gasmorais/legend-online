package consortia.view.minos.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.minos.MinosBitDataUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.MinosManager;
   import mvc.module.minos.MinosModel;
   import mvc.module.minos.MinosNodeInfo;
   import yishi.manager.NotificationManager;
   
   public class MinosNodeItem extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _proBar:Bitmap;
      
      private var _proMask:Shape;
      
      private var _proTxt:FilterFrameText;
      
      private var _chooseFlg:Bitmap;
      
      private var _evtSp:Sprite;
      
      private var _isCreate:Boolean;
      
      private var _data:MinosNodeInfo;
      
      private var _state:int = -1;
      
      private var _isChoose:Boolean;
      
      private const STATE_LOCK:int = 1;
      
      private const STATE_OPEN:int = 2;
      
      public function MinosNodeItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = new Bitmap();
         _evtSp = new Sprite();
         addChild(_evtSp);
         _evtSp.addChild(_bg);
      }
      
      private function creatOtherView() : void
      {
         if(_isCreate)
         {
            return;
         }
         _isCreate = true;
         _proBar = new Bitmap();
         _proMask = new Shape();
         _chooseFlg = new Bitmap();
         _proTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.cardpronTxt");
         addChild(_proBar);
         addChild(_proMask);
         addChild(_chooseFlg);
         addChild(_proTxt);
         _proBar.mask = _proMask;
         _chooseFlg.visible = false;
         _proTxt.width = 0;
         _chooseFlg.x = -3;
         _chooseFlg.y = -2;
      }
      
      public function set data(param1:MinosNodeInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _data = param1;
         if(_data)
         {
            creatOtherView();
            state = _data.isOpen ? 2 : 1;
            if(_data.isOpen && _data.nodeTemp.NodeType != 1)
            {
               _loc2_ = _proBar.width * (_data.progress / _data.nodeTemp.NodeValueMax);
               _proMask.graphics.clear();
               _proMask.graphics.beginFill(16711680);
               _proMask.graphics.drawRect(0,0,_loc2_,_proBar.height);
               _proMask.graphics.endFill();
               _loc3_ = _data.progress / _data.nodeTemp.NodeValueMax * 100;
               _proTxt.width = _proBar.width;
               _proTxt.text = _loc3_ + "%";
            }
            else
            {
               _proTxt.width = 0;
            }
         }
         else
         {
            _bg.bitmapData = MinosBitDataUtils.Ins.empety;
         }
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         var _loc3_:int = getNodeIdxBy(_data.nodeTemp.NodeType);
         var _loc2_:Array = [[7,69],[7,161],[7,160]];
         switch(_state - 1)
         {
            case 0:
               removeEvent();
               _bg.bitmapData = MinosBitDataUtils.Ins.lockTypes[_loc3_];
               break;
            case 1:
               _bg.bitmapData = MinosBitDataUtils.Ins.openTypes[_loc3_];
               if(_data.nodeTemp.NodeType == 1)
               {
                  _proBar.bitmapData = null;
                  _chooseFlg.bitmapData = null;
                  removeEvent();
                  break;
               }
               _proBar.bitmapData = MinosBitDataUtils.Ins.probarTypes[_loc3_];
               _chooseFlg.bitmapData = MinosBitDataUtils.Ins.chooseTypes[_loc3_];
               initEvent();
               _proBar.x = _loc2_[_loc3_][0];
               _proBar.y = _loc2_[_loc3_][1];
               _proMask.x = _proBar.x;
               _proMask.y = _proBar.y;
               _proTxt.x = _proBar.x;
               _proTxt.y = _proBar.y;
               _proTxt.width = _proBar.width;
         }
      }
      
      private function getNodeIdxBy(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = 3;
               break;
            case 2:
            case 3:
               _loc2_ = 1;
               break;
            case 4:
               _loc2_ = 2;
         }
         return _loc2_;
      }
      
      private function initEvent() : void
      {
         _evtSp.addEventListener("click",clickHandler);
         _evtSp.buttonMode = true;
      }
      
      private function removeEvent() : void
      {
         _evtSp.buttonMode = false;
         _evtSp.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(model.selectedNode == _data)
         {
            return;
         }
         var _loc2_:MinosNodeInfo = model.selectedNode;
         model.selectedNode = _data;
         _chooseFlg.visible = true;
         NotificationManager.instance.sendNotification("minos_EVENT_CHOOSE_NODE",[_loc2_,_data]);
      }
      
      private function get model() : MinosModel
      {
         return MinosManager.ins.model;
      }
      
      public function set isChoose(param1:Boolean) : void
      {
         _isChoose = param1;
         _chooseFlg.visible = _isChoose;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_proTxt);
         _proTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _bg = null;
         _proBar = null;
         _proMask = null;
         _chooseFlg = null;
         _evtSp = null;
         _data = null;
      }
   }
}

