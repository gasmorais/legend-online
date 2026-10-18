package consortia.view.minos.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.MinosManager;
   import mvc.module.minos.MinosNodeInfo;
   import yishi.filter.UIFilter;
   
   public class MinosRwardNodeUI extends Sprite
   {
      
      protected var _guai2:Bitmap;
      
      protected var _rwardNodeproBg:Bitmap;
      
      protected var _rwardNodeproBar1:Bitmap;
      
      protected var _nodeRewardBtn:IconButton;
      
      protected var _nodeRwardProTxt:FilterFrameText;
      
      protected var _nodeHasGet:Image;
      
      private var _proContainer:Sprite;
      
      private var _proMask:Shape;
      
      private var _data:MinosNodeInfo;
      
      private var _idx:int;
      
      private var _gray:Array = [];
      
      private var _hasGet:Boolean;
      
      public function MinosRwardNodeUI(param1:int)
      {
         super();
         _idx = param1;
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         if(_idx < 5)
         {
            _guai2 = ComponentFactory.Instance.creatBitmap("asset.minos.guai2");
            _rwardNodeproBar1 = ComponentFactory.Instance.creatBitmap("asset.minos.rwardNodeproBar1");
            _guai2.x = 0;
            _guai2.y = 0;
         }
         else
         {
            _guai2 = ComponentFactory.Instance.creatBitmap("asset.minos.guai3");
            _rwardNodeproBar1 = ComponentFactory.Instance.creatBitmap("asset.minos.rwardNodeproBar2");
            _guai2.x = -2;
            _guai2.y = 1;
         }
         _rwardNodeproBg = ComponentFactory.Instance.creatBitmap("asset.minos.rwardNodeproBg");
         _nodeRewardBtn = ComponentFactory.Instance.creatComponentByStylename("ui.minos.nodeRewardBtn");
         _nodeRwardProTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.nodeRwardProTxt");
         _nodeHasGet = ComponentFactory.Instance.creatComponentByStylename("ui.minos.nodeHasGet");
         _proMask = new Shape();
         _proContainer = new Sprite();
         addChild(_guai2);
         addChild(_proContainer);
         _proContainer.addChild(_rwardNodeproBg);
         _proContainer.addChild(_rwardNodeproBar1);
         _proContainer.addChild(_proMask);
         _proContainer.addChild(_nodeRwardProTxt);
         addChild(_nodeRewardBtn);
         addChild(_nodeHasGet);
         _proMask.x = _rwardNodeproBar1.x;
         _proMask.y = _rwardNodeproBar1.y;
         _rwardNodeproBar1.mask = _proMask;
         _nodeRewardBtn.visible = false;
         _nodeHasGet.visible = false;
         _proContainer.visible = false;
         _nodeRwardProTxt.text = "0%";
      }
      
      public function get data() : MinosNodeInfo
      {
         return _data;
      }
      
      public function set data(param1:MinosNodeInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_data)
         {
            _loc1_ = _rwardNodeproBar1.width * _data.progress / _data.nodeTemp.NodeValueMax;
            _proMask.graphics.clear();
            _proMask.graphics.beginFill(16711680);
            _proMask.graphics.drawRect(0,0,_loc1_,_rwardNodeproBar1.height);
            _proMask.graphics.endFill();
            _loc2_ = 100 * _data.progress / _data.nodeTemp.NodeValueMax;
            _nodeRwardProTxt.text = _loc2_ + "%";
            if(_data.progress >= _data.nodeTemp.NodeValueMax && !_hasGet)
            {
               _nodeRewardBtn.visible = true;
            }
            if(_data.isOpen)
            {
               if(!_nodeRewardBtn.visible)
               {
                  _proContainer.visible = true;
               }
               else
               {
                  _proContainer.visible = false;
               }
               _guai2.filters = null;
            }
            else
            {
               _proContainer.visible = false;
               _guai2.filters = _gray;
            }
         }
      }
      
      public function hasRewardState() : void
      {
         _hasGet = true;
         _nodeHasGet.visible = true;
         if(_data && _data.isOpen)
         {
            _proContainer.visible = true;
         }
         _nodeRewardBtn.visible = false;
      }
      
      private function initEvent() : void
      {
         _nodeRewardBtn.addEventListener("click",clickhandler);
      }
      
      private function removeEvent() : void
      {
         _nodeRewardBtn.removeEventListener("click",clickhandler);
      }
      
      private function clickhandler(param1:MouseEvent) : void
      {
         MinosManager.ins.doSomething(6,_data.lv,_idx);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_guai2);
         _guai2 = null;
         ObjectUtils.disposeObject(_rwardNodeproBg);
         _rwardNodeproBg = null;
         ObjectUtils.disposeObject(_rwardNodeproBar1);
         _rwardNodeproBar1 = null;
         ObjectUtils.disposeObject(_nodeRewardBtn);
         _nodeRewardBtn = null;
         ObjectUtils.disposeObject(_nodeRwardProTxt);
         _nodeRwardProTxt = null;
         ObjectUtils.disposeObject(_nodeHasGet);
         _nodeHasGet = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _gray = null;
      }
   }
}

